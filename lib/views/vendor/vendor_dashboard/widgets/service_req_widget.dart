import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/vendor/vendor_services/vendor_request_details/vendor_request_details.dart';
import 'package:fap_properties/views/vendor/vendor_services/vendor_request_list/vendor_request_list_controller.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/error_text_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:fap_properties/views/widgets/common_widgets/status_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class ServiceReqWidget extends StatelessWidget {
  final Function(int)? manageServiceReqs;
  ServiceReqWidget({Key? key, this.manageServiceReqs}) : super(key: key);
  final getSRoWidgetController = Get.put(GetVendorServiceRequestsController());

  String gAmount = "";
  String dAmount = "";
  String nAmount = "";

  @override
  Widget build(BuildContext context) {
    getSRoWidgetController.getData();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 1.8.h, vertical: 1.0.h),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(1.0.h),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 0.5.h,
              spreadRadius: 0.4.h,
              offset: Offset(0.1.h, 0.1.h),
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.0.h, vertical: 2.0.h),
              child: Row(
                children: [
                  Text(
                    AppMetaLabels().serviceRequest,
                    style: AppTextStyle.semiBoldBlack13,
                  ),
                  const Spacer(),
                ],
              ),
            ),
            AppDivider(),
            Container(
              width: getSRoWidgetController.error.value != '' ? 90.w : 86.w,
              child: Obx(() {
                return getSRoWidgetController.loadingData.value == true
                    ? Padding(
                        padding:
                            EdgeInsets.only(left: 4.h, top: 4.w, bottom: 4.w),
                        child: Center(child: LoadingIndicatorBlue()),
                      )
                    : getSRoWidgetController.error.value != ''
                        ? Padding(
                            padding: EdgeInsets.all(4.h),
                            child: AppErrorWidget(
                              errorText: getSRoWidgetController.error.value,
                            ),
                          )
                        : ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemCount: getSRoWidgetController.svcReqs.length > 2
                                ? 2
                                : getSRoWidgetController.svcReqs.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  SessionController().setCaseNo(
                                    getSRoWidgetController
                                        .svcReqs[index].requestNo
                                        .toString(),
                                  );

                                  Get.to(
                                    () => VendorRequestDetails(
                                      caseNo: getSRoWidgetController
                                          .svcReqs[index].requestNo??0,
                                      status: getSRoWidgetController
                                                  .svcReqs[index].status!
                                                  .toLowerCase() ==
                                              "closed"
                                          ? true
                                          : false,
                                    ),
                                  );
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      width: 84.w,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 2.0.h,
                                                left: 2.0.h,
                                                right: 4.w),
                                            child: rowList(
                                              AppMetaLabels().requestno,
                                              getSRoWidgetController
                                                  .svcReqs[index].requestNo
                                                  .toString(),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              top: 1.h,
                                              left: 2.0.h,
                                              right: 2.0.h,
                                            ),
                                            child: rowList(
                                              AppMetaLabels().property,
                                              SessionController()
                                                          .getLanguage() ==
                                                      1
                                                  ? getSRoWidgetController
                                                          .svcReqs[index]
                                                          .propertyName ??
                                                      ""
                                                  : getSRoWidgetController
                                                          .svcReqs[index]
                                                          .propertyNameAR ??
                                                      "",
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              top: 1.h,
                                              left: 2.0.h,
                                              right: 2.0.h,
                                            ),
                                            child: rowList(
                                              AppMetaLabels().category,
                                              SessionController()
                                                          .getLanguage() ==
                                                      1
                                                  ? getSRoWidgetController
                                                          .svcReqs[index]
                                                          .category ??
                                                      '-'
                                                  : getSRoWidgetController
                                                          .svcReqs[index]
                                                          .categoryAR ??
                                                      '-',
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              top: 1.h,
                                              left: 2.0.h,
                                              right: 2.0.h,
                                            ),
                                            child: rowList(
                                              AppMetaLabels().subCategory,
                                              SessionController()
                                                          .getLanguage() ==
                                                      1
                                                  ? getSRoWidgetController
                                                          .svcReqs[index]
                                                          .subCategory ??
                                                      "-"
                                                  : getSRoWidgetController
                                                          .svcReqs[index]
                                                          .subcategoryAR ??
                                                      "-",
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              top: 1.h,
                                              left: 2.0.h,
                                              right: 2.0.h,
                                            ),
                                            child: rowList(
                                              AppMetaLabels().date,
                                              getSRoWidgetController
                                                  .svcReqs[index].date??"",
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              top: 1.h,
                                              bottom: 0.0.h,
                                              left: 2.0.h,
                                              right: 2.0.h,
                                            ),
                                            child: Row(
                                              children: [
                                                Text(
                                                  AppMetaLabels().status,
                                                  style: AppTextStyle
                                                      .normalBlack11,
                                                ),
                                                Spacer(),
                                                StatusWidgetVendor(
                                                  // text: 'Under Approval',
                                                  text: SessionController()
                                                              .getLanguage() ==
                                                          1
                                                      ? getSRoWidgetController
                                                              .svcReqs[index]
                                                              .status ??
                                                          ""
                                                      : getSRoWidgetController
                                                              .svcReqs[index]
                                                              .statusAR ??
                                                          "",
                                                  valueToCompare:
                                                      getSRoWidgetController
                                                          .svcReqs[index]
                                                          .status,
                                                ),
                                              ],
                                            ),
                                          ),
                                          AppDivider(),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 0.0.h),
                                      child: SizedBox(
                                        width: 0.15.w,
                                        child: Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          color: AppColors.grey1,
                                          size: 20,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          );
              }),
            ),
            SizedBox(
              height: getSRoWidgetController.svcReqs.length > 0 ? 2.0.h : 0,
            ),
            getSRoWidgetController.svcReqs.length > 0
                ? TextButton(
                    style: TextButton.styleFrom(
                      minimumSize: Size.zero,
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: () {
                      manageServiceReqs!(1);
                    },
                    child: Text(
                      AppMetaLabels().viewAllServiceReq,
                      style: AppTextStyle.semiBoldBlue10,
                    ),
                  )
                : SizedBox(),
            SizedBox(
              height: getSRoWidgetController.svcReqs.length > 0 ? 2.0.h : 0,
            ),
          ],
        ),
      ),
    );
  }

  Row rowList(String t1, String t2) {
    return Row(
      children: [
        Text(
          t1,
          style: AppTextStyle.normalBlack11,
        ),
        Spacer(),
        Container(
          alignment: Alignment.centerRight,
          width: Get.width * 0.5,
          child: Text(
            t2,
            style: AppTextStyle.normalBlack11,
            textAlign: TextAlign.right,
            maxLines: 2,
          ),
        ),
      ],
    );
  }
}
