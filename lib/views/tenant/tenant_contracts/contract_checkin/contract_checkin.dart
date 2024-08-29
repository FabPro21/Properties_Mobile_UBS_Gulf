import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:fap_properties/views/tenant/tenant_contracts/contract_checkin/checkin_contract_controller.dart';
import 'package:fap_properties/views/widgets/custom_app_bar2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ContractCheckin extends StatefulWidget {
  final String? contractNo;
  final int? contractId;
  final String? caller;
  final int? dueActionId;
  final int? caseId;
  const ContractCheckin(
      {Key? key,
      this.contractNo,
      this.contractId,
      this.caller,
      this.dueActionId,
      this.caseId})
      : super(key: key);

  @override
  _ContractCheckinState createState() => _ContractCheckinState();
}

class _ContractCheckinState extends State<ContractCheckin> {
  final controller = Get.put(CheckinContractController());
  bool? isDialogOpen;
  @override
  void initState() {
    isDialogOpen = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (isDialogOpen!) Get.back();
        return true;
      },
      child: Scaffold(
          backgroundColor: AppColors.greyBG,
          body: Column(children: [
            CustomAppBar2(
              title: AppMetaLabels().checkin,
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
                      widget.contractNo!,
                      style: AppTextStyle.semiBoldBlack12,
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 4.0.h, left: 6.0.w),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  AppMetaLabels().checkinReq,
                  style: AppTextStyle.semiBoldBlack12,
                ),
              ),
            ),
            Container(
                width: 89.0.w,
                margin: EdgeInsets.only(top: 3.h),
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
                child: Padding(
                    padding: EdgeInsets.only(
                        left: 4.0.w, top: 4.5.h, bottom: 2.5.h, right: 4.0.w),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(2.h),
                          decoration: BoxDecoration(
                              color: Colors.red[100],
                              borderRadius: BorderRadius.circular(5.h)),
                          child: Icon(
                            Icons.error_outline,
                            color: AppColors.redColor,
                            size: 5.h,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(4.w, 4.h, 4.w, 4.h),
                          child: Text(
                            AppMetaLabels().checkinReqMsg,
                            textAlign: TextAlign.center,
                            style: AppTextStyle.normalBlack12,
                          ),
                        ),
                        SizedBox(
                          height: 6.5.h,
                          width: 79.0.w,
                          child: Obx(() {
                            return controller.checkingIn.value
                                ? LoadingIndicatorBlue()
                                : ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(1.3.h),
                                      ), backgroundColor: Color.fromRGBO(0, 61, 166, 1),
                                    ),
                                    onPressed: () async {
                                      var resp;
                                      resp = await controller.checkinContract(
                                          widget.contractId!, widget.caller!);

                                      if (resp == 'ok')
                                        showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                  contentPadding:
                                                      EdgeInsets.zero,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  content: showDialogData());
                                            });
                                    },
                                    child: Text(
                                      AppMetaLabels().checkin,
                                      style: AppTextStyle.semiBoldWhite12,
                                    ),
                                  );
                          }),
                        ),
                      ],
                    ))),
            Spacer()
          ])),
    );
  }

  Widget showDialogData() {
    isDialogOpen = true;
    return Stack(children: <Widget>[
      Container(
          padding: EdgeInsets.all(3.0.w),
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
              mainAxisSize: MainAxisSize.min,
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
                  '${AppMetaLabels().yourCheckinAgainst}${widget.contractNo} ${AppMetaLabels().submitted}',
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
                          Get.back();
                          Get.back();
                        },
                        child: Text(
                          'Close',
                          style: AppTextStyle.semiBoldWhite12,
                        ),
                      ),
                    ),
                  ),
                ),
              ])),
    ]);
  }
}
