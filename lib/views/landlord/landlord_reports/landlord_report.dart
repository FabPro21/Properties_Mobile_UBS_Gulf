import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/landlord/landlord_reports/landlord_report_controller.dart';
import 'package:fap_properties/views/widgets/common_widgets/backbround_concave.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/error_text_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:fap_properties/views/widgets/srno_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'landlord_report_details/landlord_report_details.dart';
import 'dart:ui' as ui;

class LandLordReports extends StatefulWidget {
  const LandLordReports({Key? key}) : super(key: key);

  @override
  _LandLordReportsState createState() => _LandLordReportsState();
}

class _LandLordReportsState extends State<LandLordReports> {
  final searchController = TextEditingController();
  LandlordReportController lDreportController =
      Get.put(LandlordReportController());
  @override
  void initState() {
    lDreportController.makeLoading();
    lDreportController.errorLoadingReport.value = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: SessionController().getLanguage() == 1
          ? ui.TextDirection.ltr
          : ui.TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: Stack(children: [
          AppBackgroundConcave(),
          SafeArea(
            child: Column(children: [
              Container(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 3.h,
                      ),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                    Expanded(
                      child: Text(
                        AppMetaLabels().report,
                        style: AppTextStyle.semiBoldWhite14,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    SizedBox(
                      width: 5.h,
                    )
                  ])),
              Padding(
                padding: EdgeInsets.only(left: 2.0.h, right: 2.0.h, top: 2.0.h),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(1.0.h),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(0.3.h),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            // inputFormatters:
                            //     TextInputFormatter().searchPropertyNameContractNoIF,
                            controller: searchController,
                            onChanged: (value) {
                              print(value);
                              lDreportController.searchData(value.trim());
                              setState(() {});
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey.withOpacity(0.1),
                              prefixIcon: Icon(
                                Icons.search,
                                size: 2.0.h,
                                color: Colors.grey,
                              ),
                              contentPadding:
                                  EdgeInsets.only(left: 5.0.w, right: 5.0.w),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0.5.h),
                                borderSide: BorderSide(
                                    color: AppColors.whiteColor, width: 0.1.h),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0.5.h),
                                borderSide: BorderSide(
                                    color: AppColors.whiteColor, width: 0.1.h),
                              ),
                              hintText: AppMetaLabels().search +
                                  ' ' +
                                  AppMetaLabels().report,
                              hintStyle: AppTextStyle.normalBlack10
                                  .copyWith(color: Colors.grey),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            searchController.clear();
                            lDreportController.makeLoading();
                            lDreportController.errorLoadingReport.value = '';
                            setState(() {});
                          },
                          icon: Icon(
                            Icons.refresh,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.only(
                        top: 2.0.h,
                      ),
                      child: SingleChildScrollView(
                          child: ConstrainedBox(
                        constraints: BoxConstraints(minHeight: 50.h),
                        child: Container(
                          width: 92.0.w,
                          margin: EdgeInsets.all(1.5.h),
                          padding: EdgeInsets.only(top: 0.5.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(2.0.h),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 0.5.h,
                                spreadRadius: 0.8.h,
                                offset: Offset(0.1.h, 0.1.h),
                              ),
                            ],
                          ),
                          child: Obx(() {
                            return lDreportController.isLoading.value == true
                                ? LoadingIndicatorBlue()
                                : lDreportController.errorLoadingReport.value !=
                                        ''
                                    ? AppErrorWidget(
                                        errorText: lDreportController
                                            .errorLoadingReport.value,
                                        errorImage:
                                            AppImagesPath.noContractsFound,
                                      )
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        padding: EdgeInsets.zero,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount:
                                            SessionController().getLanguage() ==
                                                    1
                                                ? lDreportController
                                                    .reportsList.length
                                                : lDreportController
                                                    .reportsListAR.length,
                                        itemBuilder: (context, index) {
                                          return inkWell(index);
                                        },
                                      );
                          }),
                        ),
                      ))))
            ]),
          )
        ]),
      ),
    );
  }

  InkWell inkWell(int index) {
    return InkWell(
      onTap: () {
        Get.to(() => LandLordReportDetails(
              fileNmae: SessionController().getLanguage() == 1
                  ? lDreportController.reportsList[index]
                  : lDreportController.reportsListAR[index],
            ));
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 0.7.h),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SrNoWidget(text: index + 1, size: 4.h),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 1.0.h, right: 1.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 70.0.w,
                          child: Text(
                            SessionController().getLanguage() == 1
                                ? lDreportController.reportsList[index]
                                : lDreportController.reportsListAR[index],
                            style: AppTextStyle.semiBoldBlack12,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: SessionController().getLanguage() == 1
                      ? EdgeInsets.only(right: 1.8.h)
                      : EdgeInsets.only(left: 1.8.h),
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
            index == lDreportController.reportsList.length - 1
                ? Container()
                : AppDivider(),
          ],
        ),
      ),
    );
  }
}
