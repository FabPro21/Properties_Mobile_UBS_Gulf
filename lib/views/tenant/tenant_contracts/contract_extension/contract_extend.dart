// ignore_for_file: deprecated_member_use

import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/error_text_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:fap_properties/views/tenant/tenant_services_request/tenant_request_details/tenant_service_request_tab/tenant_service_request_tab.dart';
import 'package:fap_properties/views/widgets/custom_app_bar2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'dart:ui' as ui;
import 'extend_contract_controller.dart';

class ContractExtend extends StatefulWidget {
  final String? contractNo;
  final int? contractId;
  final String? caller;
  final int? dueActionId;
  const ContractExtend(
      {Key? key,
      this.contractNo,
      this.contractId,
      this.caller,
      this.dueActionId = 0})
      : super(key: key);

  @override
  _ContractExtendState createState() => _ContractExtendState();
}

class _ContractExtendState extends State<ContractExtend> {
  final controller = Get.put(ExtendContractController());

  bool? isDialogOpen;

  @override
  void initState() {
    controller.getExtensionPeriods(widget.contractId ?? 0);
    isDialogOpen = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: SessionController().getLanguage() == 1
          ? ui.TextDirection.ltr
          : ui.TextDirection.rtl,
      child: WillPopScope(
        onWillPop: () async {
          if (isDialogOpen!) Get.back();
          return true;
        },
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: AppColors.greyBG,
            body: Column(children: [
              CustomAppBar2(
                title: AppMetaLabels().extend,
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
                        widget.contractNo ?? "",
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
                    AppMetaLabels().extendcontrat,
                    style: AppTextStyle.semiBoldBlack12,
                  ),
                ),
              ),
              SizedBox(
                height: 4.0.h,
              ),
              Container(
                  width: 89.0.w,
                  height: 55.85.h,
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
                  child: Obx(() {
                    return controller.loadingPeriods.value
                        ? LoadingIndicatorBlue()
                        : controller.errorLoadingPeriods != ''
                            ? AppErrorWidget(
                                errorText: controller.errorLoadingPeriods,
                              )
                            : Padding(
                                padding: EdgeInsets.only(
                                    left: 4.0.w,
                                    top: 4.5.h,
                                    bottom: 2.5.h,
                                    right: 4.0.w),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppMetaLabels().slelctextendperiod,
                                      style: AppTextStyle.normalBlack11,
                                    ),
                                    SizedBox(
                                      height: 1.5.h,
                                    ),
                                    Container(
                                        height: 5.5.h,
                                        child: ElevatedButton(
                                          autofocus: true,
                                          onPressed: () {
                                            modalBottomSheetMenu();
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 1.0.w, right: 1.0.w),
                                            child: (Row(
                                              children: [
                                                Text(
                                                  SessionController()
                                                              .getLanguage() ==
                                                          1
                                                      ? controller
                                                              .extensionPeriods!
                                                              .extensionPeriod![
                                                                  controller
                                                                      .selectedPeriod
                                                                      .value]
                                                              .duration ??
                                                          ''
                                                      : controller
                                                              .extensionPeriods!
                                                              .extensionPeriod![
                                                                  controller
                                                                      .selectedPeriod
                                                                      .value]
                                                              .duration ??
                                                          "".replaceAll(
                                                              'Month', 'شهر'),
                                                  style:
                                                      AppTextStyle.normalGrey10,
                                                ),
                                                Spacer(),
                                                Icon(
                                                  Icons.arrow_drop_down_sharp,
                                                  size: 4.0.h,
                                                  color: AppColors.greyColor,
                                                )
                                              ],
                                            )),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: AppColors.greyBG,
                                              elevation: 0),
                                        )),
                                    Padding(
                                      padding: EdgeInsets.only(top: 2.5.h),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            AppMetaLabels().startDate,
                                            style: AppTextStyle.normalBlack10,
                                          ),
                                          Text(
                                            controller
                                                    .extensionPeriods!
                                                    .extensionPeriod![controller
                                                        .selectedPeriod.value]
                                                    .extensionDetail!
                                                    .addNewDate ??
                                                "",
                                            style: AppTextStyle.normalBlack10,
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 1.h),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            AppMetaLabels().endDate,
                                            style: AppTextStyle.normalBlack10,
                                          ),
                                          Text(
                                            controller
                                                    .extensionPeriods!
                                                    .extensionPeriod![controller
                                                        .selectedPeriod.value]
                                                    .extensionDetail!
                                                    .endNewDate ??
                                                '',
                                            style: AppTextStyle.normalBlack10,
                                          )
                                        ],
                                      ),
                                    ),
                                    if (controller
                                            .extensionPeriods!
                                            .extensionPeriod![
                                                controller.selectedPeriod.value]
                                            .amount !=
                                        '0.00')
                                      Padding(
                                        padding: EdgeInsets.only(top: 2.5.h),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              AppMetaLabels().contractAmount,
                                              style:
                                                  AppTextStyle.semiBoldBlack10,
                                            ),
                                            Obx(() {
                                              return Text(
                                                '${AppMetaLabels().aed} ${controller.extensionPeriods?.extensionPeriod?[controller.selectedPeriod.value].amount}',
                                                style: AppTextStyle
                                                    .semiBoldBlack10,
                                              );
                                            })
                                          ],
                                        ),
                                      ),
                                    Spacer(),
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
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            1.3.h),
                                                  ),
                                                  backgroundColor:
                                                      Color.fromRGBO(
                                                          0, 61, 166, 1),
                                                ),
                                                onPressed: () async {
                                                  FocusScope.of(context)
                                                      .unfocus();
                                                  String resp = await controller
                                                      .extendContract(
                                                          widget.contractId??0,
                                                          widget.caller??"",
                                                          widget.dueActionId??0);
                                                  if (resp == 'ok')
                                                    showDialog(
                                                        context: context,
                                                        barrierDismissible:
                                                            false,
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                              contentPadding:
                                                                  EdgeInsets
                                                                      .zero,
                                                              backgroundColor:
                                                                  Colors
                                                                      .transparent,
                                                              content:
                                                                  showDialogData());
                                                        });
                                                  else {
                                                    Get.snackbar(
                                                        AppMetaLabels().error,
                                                        resp,
                                                        backgroundColor:
                                                            Colors.white54);
                                                  }
                                                },
                                                child: Text(
                                                  AppMetaLabels().submit,
                                                  style: AppTextStyle
                                                      .semiBoldWhite12,
                                                ),
                                              ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 4.0.h,
                                    ),
                                  ],
                                ));
                  }))
            ])),
      ),
    );
  }

  Widget showDialogData() {
    isDialogOpen = true;
    return Container(
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
                '${AppMetaLabels().yourExtensionAgainst}${widget.contractNo}${AppMetaLabels().yourReqNoIs}${controller.caseNo}',
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
                        ),
                        backgroundColor: Color.fromRGBO(0, 61, 166, 1),
                      ),
                      onPressed: () {
                        SessionController()
                            .setCaseNo(controller.caseNo.toString());
                        Get.back();
                        Get.off(() => TenantServiceRequestTabs(
                              requestNo: controller.caseNo.toString(),
                              caller: widget.caller??"",
                              title: AppMetaLabels().extensionReq,
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
            ]));
  }

  void modalBottomSheetMenu() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Directionality(
            textDirection: SessionController().getLanguage() == 1
                ? ui.TextDirection.ltr
                : ui.TextDirection.rtl,
            child: Container(
                height: 35.0.h,
                color: Colors
                    .transparent, //could change this to Color(0xFF737373),
                //so you don't have to change MaterialApp canvasColor
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0))),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: ListView.builder(
                          padding: EdgeInsets.only(top: 2.0.h),
                          shrinkWrap: true,
                          itemCount: controller
                              .extensionPeriods?.extensionPeriod?.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              child: Column(
                                children: [
                                  Obx(() {
                                    return Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Transform.scale(
                                          scale: 0.7,
                                          child: Radio(
                                            activeColor: AppColors.blueColor,
                                            onChanged: (int? value) {
                                              controller.selectedPeriod.value =
                                                  value??0;
                                            },
                                            groupValue:
                                                controller.selectedPeriod.value,
                                            value: index,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5.0.w,
                                        ),
                                        Text(
                                            SessionController().getLanguage() ==
                                                    1
                                                ? controller
                                                        .extensionPeriods!
                                                        .extensionPeriod![index]
                                                        .duration ??
                                                    ""
                                                : controller
                                                    .extensionPeriods!
                                                    .extensionPeriod![index]
                                                    .duration??""
                                                    .replaceAll('Month', 'شهر'),
                                            style: AppTextStyle.normalBlack10),
                                        Spacer(),
                                        Text(
                                            '${controller.extensionPeriods?.extensionPeriod?[index].extensionDetail?.addNewDate} - ${controller.extensionPeriods?.extensionPeriod?[index].extensionDetail?.endNewDate}',
                                            style: AppTextStyle.normalBlack10),
                                        SizedBox(
                                          width: 3.0.w,
                                        ),
                                      ],
                                    );
                                  }),
                                  AppDivider(),
                                ],
                              ),
                              onTap: () {
                                controller.selectedPeriod.value = index;

                                Navigator.pop(context);
                              },
                            );
                          }),
                    ))),
          );
        });
  }
}
