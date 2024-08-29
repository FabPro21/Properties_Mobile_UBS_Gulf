import 'package:fap_properties/views/tenant/tenant_contracts/legal_settlement/legal_settlement_controller.dart';
import 'package:fap_properties/views/tenant/tenant_services_request/tenant_request_details/tenant_service_request_tab/tenant_service_request_tab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/helpers/session_controller.dart';
import '../../../../utils/constants/assets_path.dart';
import '../../../../utils/constants/meta_labels.dart';
import '../../../../utils/styles/colors.dart';
import '../../../../utils/styles/text_styles.dart';
import '../../../widgets/common_widgets/loading_indicator_blue.dart';
import '../../../widgets/custom_app_bar2.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class LegalSettlement extends GetView<LegalSettlementController> {
  final String? contractNo;
  final int? contractId;
  LegalSettlement({Key? key, this.contractId, this.contractNo})
      : super(key: key) {
    Get.put(LegalSettlementController());
  }
  final _descTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool isDialogOpen = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (isDialogOpen) Get.back();
        return true;
      },
      child: Scaffold(
          backgroundColor: AppColors.whiteColor,
          body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            CustomAppBar2(
              title: AppMetaLabels().legalSettlement,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 0.5.h,
                    spreadRadius: 0.3.h,
                    offset: Offset(0.1.h, 0.1.h),
                  ),
                ],
              ),
              height: 8.0.h,
              child: Padding(
                padding: EdgeInsets.only(left: 6.0.w, right: 6.0.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppMetaLabels().contractNo,
                      style: AppTextStyle.semiBoldBlack12,
                    ),
                    Text(
                      contractNo??'',
                      style: AppTextStyle.semiBoldBlack12,
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(4.0.w, 3.h, 4.w, 0),
              child: Text(
                AppMetaLabels().describeLegalSettlement,
                style: AppTextStyle.normalBlack12,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 2.0.h, horizontal: 4.0.w),
              child: Form(
                key: _formKey,
                child: TextFormField(
                  autofocus: true,
                  controller: _descTextController,
                  textAlign: TextAlign.start,
                  style: AppTextStyle.normalGrey12,
                  maxLines: 8,
                  validator: (value) {
                    if (value!.isEmpty)
                      return AppMetaLabels().requiredField;
                    else
                      return null;
                  },
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0.w),
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 1.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0.w),
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 1.0,
                      ),
                    ),
                    fillColor: AppColors.greyBG,
                    filled: true,
                    errorStyle: TextStyle(fontSize: 0),
                    contentPadding: EdgeInsets.only(top: 4.w, left: 4.0.w),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                height: 6.5.h,
                width: 79.0.w,
                child: controller.submitting.value
                    ? LoadingIndicatorBlue()
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(1.3.h),
                          ), backgroundColor: Color.fromRGBO(0, 61, 166, 1),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            FocusScope.of(context).unfocus();
                            String resp = await controller.submitRequest(
                                contractId??0, _descTextController.text);
                            if (resp == 'ok')
                              showSuccessDialog(context);
                            else {
                              Get.snackbar(AppMetaLabels().error, resp,
                                  backgroundColor: Colors.white54);
                            }
                          }
                        },
                        child: Text(
                          AppMetaLabels().submit,
                          style: AppTextStyle.semiBoldWhite12,
                        ),
                      ),
              ),
            ),
          ])),
    );
  }

  void showSuccessDialog(BuildContext context) {
    isDialogOpen = true;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
              contentPadding: EdgeInsets.zero,
              backgroundColor: Colors.transparent,
              content: Container(
                  padding: EdgeInsets.all(3.0.w),
                  height: 48.0.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(2.0.h),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 0.5.h,
                        spreadRadius: 0.3.h,
                        offset: Offset(0.1.h, 0.1.h),
                      ),
                    ],
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 4.0.h,
                        ),
                        Image.asset(
                          AppImagesPath.bluttickimg,
                          height: 9.0.h,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(
                          height: 3.0.h,
                        ),
                        Text(
                          AppMetaLabels().reqScuccesful,
                          style: AppTextStyle.semiBoldBlack13,
                        ),
                        SizedBox(
                          height: 3.0.h,
                        ),
                        Text(
                          '${AppMetaLabels().yourLegalReq}$contractNo${AppMetaLabels().yourReqNoIs}${controller.caseNo}',
                          style: AppTextStyle.normalBlack10
                              .copyWith(color: AppColors.renewelgreyclr1),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5.0.h, bottom: 2.0.h),
                          child: Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              height: 7.0.h,
                              width: 65.0.w,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(1.3.h),
                                  ), backgroundColor: Color.fromRGBO(0, 61, 166, 1),
                                ),
                                onPressed: () {
                                  SessionController()
                                      .setCaseNo(controller.caseNo.toString());
                                  Get.back();
                                  Get.off(() => TenantServiceRequestTabs(
                                        requestNo: controller.caseNo.toString(),
                                        caller: 'contract',
                                        title: AppMetaLabels().legalReq,
                                      ));
                                },
                                child: Text(
                                  AppMetaLabels().viewDetails,
                                  style: AppTextStyle.semiBoldWhite12,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ])));
        });
  }
}
