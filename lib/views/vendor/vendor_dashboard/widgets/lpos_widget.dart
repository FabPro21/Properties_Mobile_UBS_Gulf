import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/vendor/lpos/lpo_details/lpo_details.dart';
import 'package:fap_properties/views/widgets/common_widgets/custom_error_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:fap_properties/views/vendor/vendor_dashboard/widgets/lop_widget_controller.dart';
import 'package:fap_properties/views/widgets/common_widgets/status_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class LposWidget extends StatelessWidget {
  final Function(int)? manageLpos;
  LposWidget({Key? key, this.manageLpos}) : super(key: key);
  final getAllLpoWidgetController = Get.put(GetAllLpoWidgetController());

  String gAmount = "";
  String dAmount = "";
  String nAmount = "";

  @override
  Widget build(BuildContext context) {
    // getAllLpoWidgetController.getData();
    getAllLpoWidgetController.getDataPagination('1', '');
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
                    AppMetaLabels().lpos,
                    style: AppTextStyle.semiBoldBlack13,
                  ),
                  const Spacer(),
                ],
              ),
            ),
            AppDivider(),
            Container(
              width: getAllLpoWidgetController.error.value != '' ? 90.w : 86.w,
              child: Obx(() {
                return getAllLpoWidgetController.loadingData.value == true
                    ? Padding(
                        padding:
                            EdgeInsets.only(left: 4.h, top: 4.w, bottom: 4.w),
                        child: Center(child: LoadingIndicatorBlue()),
                      )
                    : getAllLpoWidgetController.error.value != ''
                        ? Padding(
                            padding: EdgeInsets.all(4.h),
                            child: CustomErrorWidget(
                              errorText: AppMetaLabels().noLPOFound + '',
                              errorImage: AppImagesPath.nolpos,
                            ))
                        : ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemCount:
                                getAllLpoWidgetController.lpoWidgetListLength,
                            itemBuilder: (context, index) {
                              double ga = getAllLpoWidgetController
                                  .getAllLposModel
                                  .value
                                  .lpos![index]
                                  .grossAmount;
                              final gaFormatter =
                                  NumberFormat('#,##0.00', 'AR');
                              gAmount = gaFormatter.format(ga);

                              double da = getAllLpoWidgetController
                                  .getAllLposModel
                                  .value
                                  .lpos![index]
                                  .discountAmount;
                              final daFormatter =
                                  NumberFormat('#,##0.00', 'AR');
                              dAmount = daFormatter.format(da);

                              double na = getAllLpoWidgetController
                                  .getAllLposModel.value.lpos![index].netAmount;
                              final naFormatter =
                                  NumberFormat('#,##0.00', 'AR');
                              nAmount = naFormatter.format(na);
                              return InkWell(
                                onTap: () {
                                  SessionController().setLpoId(
                                    getAllLpoWidgetController
                                        .getAllLposModel.value.lpos![index].lpoId
                                        .toString(),
                                  );
                                  SessionController().setLpoRefNo(
                                    getAllLpoWidgetController.getAllLposModel
                                        .value.lpos![index].lpoReference
                                        .toString(),
                                  );
                                  Get.to(
                                    () => LpoDetails(
                                      lpo: getAllLpoWidgetController
                                          .getAllLposModel.value.lpos![index],
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
                                              AppMetaLabels().refNo,
                                              getAllLpoWidgetController
                                                  .getAllLposModel
                                                  .value
                                                  .lpos![index]
                                                  .lpoReference??"",
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              top: 1.h,
                                              left: 2.0.h,
                                              right: 2.0.h,
                                            ),
                                            child: rowList(
                                              AppMetaLabels().docRefNo,
                                              getAllLpoWidgetController
                                                      .getAllLposModel
                                                      .value
                                                      .lpos![index]
                                                      .docReference ??
                                                  '',
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              top: 1.h,
                                              left: 2.0.h,
                                              right: 2.0.h,
                                            ),
                                            child: rowList(
                                              AppMetaLabels().lPOType,
                                              SessionController()
                                                          .getLanguage() ==
                                                      1
                                                  ? getAllLpoWidgetController
                                                          .getAllLposModel
                                                          .value
                                                          .lpos![index]
                                                          .lpoType ??
                                                      ""
                                                  : getAllLpoWidgetController
                                                          .getAllLposModel
                                                          .value
                                                          .lpos![index]
                                                          .lpoTypeAr ??
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
                                              AppMetaLabels().lpoDate,
                                              getAllLpoWidgetController
                                                  .getAllLposModel
                                                  .value
                                                  .lpos![index]
                                                  .lpoDate??"",
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              top: 1.h,
                                              left: 2.0.h,
                                              right: 2.0.h,
                                            ),
                                            child: rowList(
                                              AppMetaLabels().grossAmount,
                                              "${AppMetaLabels().aed} $gAmount",
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              top: 1.h,
                                              left: 2.0.h,
                                              right: 2.0.h,
                                            ),
                                            child: rowList(
                                              AppMetaLabels().discountAmount,
                                              "${AppMetaLabels().aed} $dAmount",
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
                                                  AppMetaLabels().lPOStatus,
                                                  style: AppTextStyle
                                                      .normalBlack11,
                                                ),
                                                Spacer(),
                                                StatusWidgetVendor(
                                                  // text: 'Under Approval',
                                                  text: SessionController()
                                                              .getLanguage() ==
                                                          1
                                                      ? getAllLpoWidgetController
                                                          .getAllLposModel
                                                          .value
                                                          .lpos![index]
                                                          .lpoStatus
                                                      : getAllLpoWidgetController
                                                          .getAllLposModel
                                                          .value
                                                          .lpos![index]
                                                          .lpoStatusAr,
                                                  valueToCompare:
                                                      // 'Under Approval'
                                                      getAllLpoWidgetController
                                                          .getAllLposModel
                                                          .value
                                                          .lpos![index]
                                                          .lpoStatus,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 1.h,
                                                left: 2.0.h,
                                                right: 2.0.h,
                                                bottom: 2.h),
                                            child: Row(
                                              children: [
                                                Text(
                                                  AppMetaLabels().netAmount,
                                                  style: AppTextStyle
                                                      .semiBoldBlack10,
                                                ),
                                                Spacer(),
                                                Text(
                                                  "${AppMetaLabels().aed} ${nAmount}",
                                                  style: AppTextStyle
                                                      .semiBoldBlack10,
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
              height:
                  getAllLpoWidgetController.lpoWidgetListLength > 0 ? 2.0.h : 0,
            ),
            getAllLpoWidgetController.lpoWidgetListLength > 0
                ? TextButton(
                    style: TextButton.styleFrom(
                      minimumSize: Size.zero,
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: () {
                      manageLpos!(2);
                    },
                    child: Text(
                      AppMetaLabels().viewAllLpos,
                      style: AppTextStyle.semiBoldBlue10,
                    ),
                  )
                : SizedBox(),
            SizedBox(
              height:
                  getAllLpoWidgetController.lpoWidgetListLength > 0 ? 2.0.h : 0,
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
        Text(
          t2,
          style: AppTextStyle.normalBlack11,
        ),
      ],
    );
  }
}
