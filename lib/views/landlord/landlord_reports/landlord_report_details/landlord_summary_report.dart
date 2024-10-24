import 'dart:convert';
import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/screen_disable.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:fap_properties/views/landlord/landlord_reports/landlord_report_details/landlord_report_controller.dart';
import 'package:fap_properties/views/widgets/common_widgets/custom_error_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:fap_properties/views/widgets/common_widgets/status_widget.dart';
import 'package:fap_properties/views/widgets/custom_app_bar2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:sizer/sizer.dart';

class LandLordSummaryReports extends StatefulWidget {
  final String? reportName;
  final Map? data;
  const LandLordSummaryReports({Key? key, this.reportName, this.data})
      : super(key: key);

  @override
  _LandLordSummaryReportsState createState() => _LandLordSummaryReportsState();
}

class _LandLordSummaryReportsState extends State<LandLordSummaryReports> {
  final LandLordReportPropController lDReportController = Get.find();

  bool isTapOnDownload = false;
  bool isDownloaded = false;

  bool isEnableScreen = true;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Column(children: [
              CustomAppBar2(
                  title:
                      widget.reportName ?? "" + ' ' + AppMetaLabels().summary),
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.only(
                        top: 1.0.h,
                      ),
                      child: SingleChildScrollView(
                          child: ConstrainedBox(
                        constraints: BoxConstraints(
                            minHeight: widget.reportName ==
                                    'Occupancy Vacancy Register Report'
                                ? 30.h
                                : 50.h),
                        child: Container(
                          width: 94.0.w,
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
                            return lDReportController.isLoadingSummary.value ==
                                    true
                                ? LoadingIndicatorBlue()
                                : lDReportController.errorSummaryReport.value !=
                                        ''
                                    ? SizedBox(
                                        height: Get.height * 0.8,
                                        child: CustomErrorWidget(
                                          errorText: lDReportController
                                              .errorSummaryReport.value,
                                          errorImage:
                                              AppImagesPath.noContractsFound,
                                        ),
                                      )
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        padding: EdgeInsets.zero,
                                        physics: NeverScrollableScrollPhysics(),
                                        // itemCount: 3,
                                        itemCount: widget.reportName ==
                                                'AMC Report'
                                            ? lDReportController.amcRepportModel
                                                .value.totalRecord
                                            : widget.reportName ==
                                                    'Building Status Report'
                                                ? lDReportController
                                                    .buildingStatusReportModel
                                                    .value
                                                    .totalRecord
                                                : widget.reportName ==
                                                        'Cheque Register Report'
                                                    ? lDReportController
                                                        .chequeRegisterReportModel
                                                        .value
                                                        .totalRecord
                                                    : widget.reportName ==
                                                            'Tenancy Contracts Report'
                                                        ? lDReportController
                                                            .contractReportModel
                                                            .value
                                                            .totalRecord
                                                        : widget.reportName ==
                                                                'Legal Case Report'
                                                            ? lDReportController
                                                                .legalCaseReportModel
                                                                .value
                                                                .totalRecord
                                                            : widget.reportName ==
                                                                    'Occupancy Vacancy Register Report'
                                                                ? lDReportController
                                                                    .occupanyReportModel
                                                                    .value
                                                                    .totalRecord
                                                                : widget.reportName ==
                                                                        'Receipt Register Report'
                                                                    ? lDReportController
                                                                        .receiptRegisterModel
                                                                        .value
                                                                        .totalRecord
                                                                    : widget.reportName ==
                                                                            'Unit Status Report'
                                                                        ? lDReportController
                                                                            .unitStatusReportModel
                                                                            .value
                                                                            .totalRecord
                                                                        : widget.reportName ==
                                                                                'VAT Report'
                                                                            ? lDReportController.vatReportSummaryModel.value.totalRecord
                                                                            : widget.reportName == 'LPO Report'
                                                                                ? lDReportController.lpoReportSummaryModel.value.totalRecord
                                                                                : 0,
                                        itemBuilder: (context, index) {
                                          return inkWell(
                                            index,
                                            widget.reportName ?? "",
                                          );
                                        },
                                      );
                          }),
                        ),
                      ))))
            ]),
            Obx(() {
              return lDReportController.isLoading.value
                  ? Container(
                      height: double.infinity,
                      width: double.infinity,
                      child: Center(child: LoadingIndicatorBlue()),
                    )
                  : SizedBox();
            }),
            isEnableScreen == false ? ScreenDisableWidget() : SizedBox(),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          child: Obx(() {
            return lDReportController.errorSummaryReport.value != ''
                ? SizedBox()
                : Container(
                    height: 8.h, //set your height here
                    width: double.maxFinite, //set your width here
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 0.9.h,
                        spreadRadius: 0.1.h,
                        offset: Offset(0.0.h, 0.1.h),
                      ),
                    ]),
                    child: Padding(
                        padding: EdgeInsets.only(
                            left: 5.0.w, right: 5.0.w, top: 0.5.h, bottom: 0.5),
                        child: Center(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 5.5.h,
                                      width: 80.0.w,
                                      child: isLoading
                                          ? LoadingIndicatorBlue()
                                          : ElevatedButton(
                                              onPressed: isTapOnDownload == true
                                                  ? null
                                                  : isDownloaded == true
                                                      ? null
                                                      : () async {
                                                          bool
                                                              _isInternetConnected =
                                                              await BaseClientClass
                                                                  .isInternetConnected();
                                                          if (!_isInternetConnected) {
                                                            await Get.to(
                                                                NoInternetScreen());
                                                          }
                                                          setState(() {
                                                            isLoading = true;
                                                          });
                                                          try {
                                                            setState(() {
                                                              isEnableScreen =
                                                                  false;
                                                            });
                                                            setState(() {
                                                              isLoading = false;
                                                            });
                                                            setState(() {
                                                              isTapOnDownload =
                                                                  true;
                                                            });
                                                            var res =
                                                                await lDReportController
                                                                    .downLoadReportFilebase64(
                                                              widget.reportName ??
                                                                  "",
                                                              widget.data ?? {},
                                                            );
                                                            if (res) {
                                                              var base64Decoded =
                                                                  base64Decode(lDReportController
                                                                      .downloadedFileModel!
                                                                      .base64!
                                                                      .replaceAll(
                                                                          '\n',
                                                                          ''));

                                                              var path = await lDReportController.createFile(
                                                                  base64Decoded,
                                                                  lDReportController
                                                                          .downloadedFileModel!
                                                                          .name! +
                                                                      '.' +
                                                                      lDReportController
                                                                          .downloadedFileModel!
                                                                          .extension!);
                                                              final result =
                                                                  await OpenFile
                                                                      .open(
                                                                          path);
                                                              if (result
                                                                      .message !=
                                                                  'done') {
                                                                Get.snackbar(
                                                                  AppMetaLabels()
                                                                      .error,
                                                                  result
                                                                      .message,
                                                                  backgroundColor:
                                                                      AppColors
                                                                          .white54,
                                                                );
                                                              }
                                                              setState(() {
                                                                isDownloaded =
                                                                    true;
                                                                isTapOnDownload =
                                                                    false;
                                                              });
                                                              setState(() {
                                                                isEnableScreen =
                                                                    true;
                                                              });
                                                            } else {
                                                              setState(() {
                                                                isDownloaded =
                                                                    false;
                                                                isTapOnDownload =
                                                                    false;
                                                              });
                                                              setState(() {
                                                                isEnableScreen =
                                                                    true;
                                                              });
                                                            }
                                                          } catch (e) {
                                                            print(
                                                                'Exception Inside the ::::: Class ${e.toString()}');
                                                            setState(() {
                                                              isDownloaded =
                                                                  false;
                                                              isTapOnDownload =
                                                                  false;
                                                            });
                                                          }

                                                          // download with pacakge
                                                          // var path =
                                                          //     await lDReportController
                                                          //         .downLoadReportFile(
                                                          //             widget
                                                          //                 .reportName,
                                                          //             data);
                                                          // print(
                                                          //     '**********************');
                                                          // print('Path ::::: $path');
                                                          // print(
                                                          //     '**********************');
                                                          // if (path != '') {
                                                          //   // before download get the permission
                                                          //   final status =
                                                          //       await Permission
                                                          //           .storage
                                                          //           .request();
                                                          //   if (status.isGranted) {
                                                          //     final externalDirectory =
                                                          //         Platform.isAndroid
                                                          //             ? await getExternalStorageDirectory()
                                                          //             : await getApplicationSupportDirectory();
                                                          //     setState(() {
                                                          //       isTapOnDownload =
                                                          //           true;
                                                          //     });
                                                          //     setState(() {
                                                          //       isEnableScreen =
                                                          //           false;
                                                          //     });
                                                          //     // download process
                                                          //     var id = await FlutterDownloader
                                                          //         .enqueue(
                                                          //             url: path,
                                                          //             // url:
                                                          //             //     'https://cdn.mos.cms.futurecdn.net/vChK6pTy3vN3KbYZ7UU7k3-320-80.jpg',
                                                          //             savedDir:
                                                          //                 externalDirectory
                                                          //                     .path,
                                                          //             fileName: widget
                                                          //                 .reportName,
                                                          //             // fileName:
                                                          //     AppMetaLabels()
                                                          //         .report,
                                                          //             showNotification:
                                                          //                 true,
                                                          //             openFileFromNotification:
                                                          //                 true,
                                                          //             requiresStorageNotLow:
                                                          //                 true,
                                                          //             saveInPublicStorage:
                                                          //                 true,
                                                          //             allowCellular:
                                                          //                 true);
                                                          //     setState(() {});
                                                          //     setState(() {
                                                          //       isEnableScreen =
                                                          //           true;
                                                          //     });
                                                          //   } else {
                                                          //     SnakBarWidget
                                                          //         .getSnackBarErrorBlue(
                                                          //       AppMetaLabels()
                                                          //           .alert,
                                                          //       AppMetaLabels()
                                                          //           .storagePermissions,
                                                          //     );
                                                          //     setState(() {
                                                          //       isEnableScreen =
                                                          //           true;
                                                          //     });
                                                          //   }
                                                          // } else {
                                                          //   SnakBarWidget
                                                          //       .getSnackBarError(
                                                          //           AppMetaLabels()
                                                          //               .error,
                                                          //           'File download failed');
                                                          //   setState(() {
                                                          //     isEnableScreen = true;
                                                          //   });
                                                          // }
                                                        },
                                              child: Text(
                                                isDownloaded == true
                                                    // ? 'Downloaded'
                                                    ? AppMetaLabels().downloaded
                                                    : isTapOnDownload == true
                                                        // ? 'Downloading ....'
                                                        ? AppMetaLabels()
                                                            .downloadingReport
                                                        // : 'Download',
                                                        : AppMetaLabels()
                                                            .downloadReport,
                                                style: isDownloaded ||
                                                        isTapOnDownload
                                                    ? AppTextStyle
                                                        .semiBoldBlack11
                                                    : AppTextStyle
                                                        .semiBoldWhite11,
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          2.0.w),
                                                ),
                                                backgroundColor:
                                                    AppColors.blueColor,
                                              ),
                                            ),
                                    ),
                                  ])
                            ]))));
          }),
        ));
  }

  InkWell inkWell(
    int index,
    String reportName,
  ) {
    return InkWell(
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.7.h, vertical: 0.7.h),
          child: reportName == 'AMC Report'
              ?
              // 1
              AMCReportSummaryWidget(
                  index: index,
                  lDReportController: lDReportController,
                )
              : reportName == 'Building Status Report'
                  ?
                  // 2
                  BuildingStatusReportSummaryWidget(
                      index: index,
                      lDReportController: lDReportController,
                    )
                  : reportName == 'Cheque Register Report'
                      ?
                      // 3
                      ChequeRegiterReportSummaryWidget(
                          index: index,
                          lDReportController: lDReportController,
                        )
                      : reportName == 'Tenancy Contracts Report'
                          ?
                          // 4
                          ContractReportSummaryWidget(
                              index: index,
                              lDReportController: lDReportController,
                            )
                          : reportName == 'Legal Case Report'
                              ?
                              // 5
                              LegalCasereportSummaryWidget(
                                  index: index,
                                  lDReportController: lDReportController,
                                )
                              : reportName ==
                                      'Occupancy Vacancy Register Report'
                                  ?
                                  // 6
                                  OccupancyVancaneyreportSummaryWidget(
                                      index: index,
                                      lDReportController: lDReportController)
                                  : reportName == 'Receipt Register Report'
                                      ?
                                      // 7
                                      ReceiptRegisterReportSummaryWidget(
                                          index: index,
                                          lDReportController:
                                              lDReportController,
                                        )
                                      : reportName == 'Unit Status Report'
                                          ?
                                          // 8
                                          UnitStatusSummaryReportWidget(
                                              index: index,
                                              lDReportController:
                                                  lDReportController,
                                            )
                                          : reportName == 'VAT Report'
                                              ?
                                              // 9
                                              VatReportSummaryWidget(
                                                  index: index,
                                                  lDReportController:
                                                      lDReportController,
                                                )
                                              : reportName == 'LPO Report'
                                                  ?
                                                  // 10
                                                  LPOReportSummaryWidget(
                                                      index: index,
                                                      lDReportController:
                                                          lDReportController,
                                                    )
                                                  : SizedBox(
                                                      child: Text(
                                                          '********Nothing******'))),
    );
  }
}

class LPOReportSummaryWidget extends StatefulWidget {
  final int? index;
  final LandLordReportPropController? lDReportController;
  const LPOReportSummaryWidget({Key? key, this.index, this.lDReportController})
      : super(key: key);

  @override
  State<LPOReportSummaryWidget> createState() => _LPOReportSummaryWidgetState();
}

class _LPOReportSummaryWidgetState extends State<LPOReportSummaryWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 1.0.h,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 4.w,
            ),
            Padding(
              padding: EdgeInsets.only(left: 1.0.h, bottom: 1.h, right: 1.0.h),
              child: Row(
                children: [
                  Container(
                    width: 78.0.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              width: 78.w,
                              child: Text(
                                SessionController().getLanguage() == 1
                                    ? widget
                                            .lDReportController!
                                            .lpoReportSummaryModel
                                            .value
                                            .serviceRequests![widget.index!]
                                            .propertyName ??
                                        "--"
                                    : widget
                                            .lDReportController!
                                            .lpoReportSummaryModel
                                            .value
                                            .serviceRequests![widget.index!]
                                            .propertyNameAR ??
                                        "--",
                                style: AppTextStyle.semiBoldBlack11,
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1.0.h,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            SessionController().getLanguage() == 1
                                ? widget
                                        .lDReportController!
                                        .lpoReportSummaryModel
                                        .value
                                        .serviceRequests![widget.index!]
                                        .landlordName ??
                                    '--'
                                : widget
                                        .lDReportController!
                                        .lpoReportSummaryModel
                                        .value
                                        .serviceRequests![widget.index!]
                                        .landlordNameAR ??
                                    "--",
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyle.normalGrey10,
                            maxLines: 2,
                          ),
                        ),
                        SizedBox(
                          height: 1.0.h,
                        ),
                        Row(
                          children: [
                            Text(
                              AppMetaLabels().emirate,
                              style: AppTextStyle.normalGrey11,
                            ),
                            Spacer(),
                            Container(
                              alignment: Alignment.centerRight,
                              width: 38.w,
                              child: Text(
                                SessionController().getLanguage() == 1
                                    ? widget
                                            .lDReportController!
                                            .lpoReportSummaryModel
                                            .value
                                            .serviceRequests![widget.index!]
                                            .emirateName ??
                                        "--"
                                    : widget
                                            .lDReportController!
                                            .lpoReportSummaryModel
                                            .value
                                            .serviceRequests![widget.index!]
                                            .emirateNameAR ??
                                        "--",
                                style: AppTextStyle.normalGrey10,
                                textAlign: TextAlign.end,
                                maxLines: 3,
                              ),
                            ),
                          ],
                        ),
                        widget
                                        .lDReportController!
                                        .lpoReportSummaryModel
                                        .value
                                        .serviceRequests![widget.index!]
                                        .tenantName ==
                                    '' ||
                                widget
                                        .lDReportController!
                                        .lpoReportSummaryModel
                                        .value
                                        .serviceRequests![widget.index!]
                                        .tenantName ==
                                    null ||
                                widget
                                        .lDReportController!
                                        .lpoReportSummaryModel
                                        .value
                                        .serviceRequests![widget.index!]
                                        .tenantNameAR ==
                                    '' ||
                                widget
                                        .lDReportController!
                                        .lpoReportSummaryModel
                                        .value
                                        .serviceRequests![widget.index!]
                                        .tenantNameAR ==
                                    null
                            ? SizedBox()
                            : SizedBox(
                                height: 1.2.h,
                              ),
                        widget
                                        .lDReportController!
                                        .lpoReportSummaryModel
                                        .value
                                        .serviceRequests![widget.index!]
                                        .tenantName ==
                                    '' ||
                                widget
                                        .lDReportController!
                                        .lpoReportSummaryModel
                                        .value
                                        .serviceRequests![widget.index!]
                                        .tenantName ==
                                    null ||
                                widget
                                        .lDReportController!
                                        .lpoReportSummaryModel
                                        .value
                                        .serviceRequests![widget.index!]
                                        .tenantNameAR ==
                                    '' ||
                                widget
                                        .lDReportController!
                                        .lpoReportSummaryModel
                                        .value
                                        .serviceRequests![widget.index!]
                                        .tenantNameAR ==
                                    null
                            ? SizedBox()
                            : Row(
                                children: [
                                  Text(
                                    AppMetaLabels().tenant +
                                        ' ' +
                                        AppMetaLabels().name,
                                    style: AppTextStyle.normalGrey11,
                                  ),
                                  Spacer(),
                                  Container(
                                    alignment: Alignment.centerRight,
                                    width: 38.w,
                                    child: Text(
                                      SessionController().getLanguage() == 1
                                          ? widget
                                              .lDReportController!
                                              .lpoReportSummaryModel
                                              .value
                                              .serviceRequests![widget.index!]
                                              .tenantName
                                              .toString()
                                          : widget
                                              .lDReportController!
                                              .lpoReportSummaryModel
                                              .value
                                              .serviceRequests![widget.index!]
                                              .tenantNameAR
                                              .toString(),
                                      textAlign: TextAlign.end,
                                      style: AppTextStyle.normalGrey10,
                                      maxLines: 3,
                                    ),
                                  ),
                                ],
                              ),
                        SizedBox(
                          height: 1.2.h,
                        ),
                        Row(
                          children: [
                            Text(
                              AppMetaLabels().contractor1,
                              style: AppTextStyle.normalGrey11,
                            ),
                            Spacer(),
                            Container(
                              alignment: Alignment.centerRight,
                              width: 38.w,
                              child: Text(
                                SessionController().getLanguage() == 1
                                    ? widget
                                            .lDReportController!
                                            .lpoReportSummaryModel
                                            .value
                                            .serviceRequests![widget.index!]
                                            .contractor ??
                                        ""
                                    : widget
                                            .lDReportController!
                                            .lpoReportSummaryModel
                                            .value
                                            .serviceRequests![widget.index!]
                                            .contractorAR ??
                                        "",
                                style: AppTextStyle.normalGrey10,
                                textAlign: TextAlign.end,
                                maxLines: 3,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1.2.h,
                        ),
                        Row(
                          children: [
                            Text(
                              AppMetaLabels().lPOType,
                              style: AppTextStyle.normalGrey11,
                            ),
                            Spacer(),
                            Container(
                              alignment: Alignment.centerRight,
                              width: 38.w,
                              child: Text(
                                SessionController().getLanguage() == 1
                                    ? widget
                                            .lDReportController!
                                            .lpoReportSummaryModel
                                            .value
                                            .serviceRequests![widget.index!]
                                            .lpoType ??
                                        "--"
                                    : widget
                                            .lDReportController!
                                            .lpoReportSummaryModel
                                            .value
                                            .serviceRequests![widget.index!]
                                            .lpoTypeAR ??
                                        "--",
                                style: AppTextStyle.normalGrey10,
                                textAlign: TextAlign.end,
                                maxLines: 3,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1.2.h,
                        ),
                        Row(
                          children: [
                            Text(
                              AppMetaLabels().lPOStatus,
                              style: AppTextStyle.normalGrey11,
                            ),
                            Spacer(),
                            ConstrainedBox(
                              constraints: BoxConstraints(maxWidth: 35.w),
                              child: FittedBox(
                                  child: StatusWidgetVendor(
                                text: SessionController().getLanguage() == 1
                                    ? widget
                                            .lDReportController!
                                            .lpoReportSummaryModel
                                            .value
                                            .serviceRequests![widget.index!]
                                            .lpoStatus ??
                                        ""
                                    : widget
                                            .lDReportController!
                                            .lpoReportSummaryModel
                                            .value
                                            .serviceRequests![widget.index!]
                                            .lpoStatusAR ??
                                        "",
                                valueToCompare: widget
                                        .lDReportController!
                                        .lpoReportSummaryModel
                                        .value
                                        .serviceRequests![widget.index!]
                                        .lpoStatus ??
                                    "",
                              )),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 1.2.h,
                        ),
                        Row(
                          children: [
                            Text(
                              AppMetaLabels().totalAmount,
                              style: AppTextStyle.normalGrey11,
                            ),
                            Spacer(),
                            Container(
                              alignment: Alignment.centerRight,
                              width: 30.w,
                              child: Text(
                                '${AppMetaLabels().aed} ${widget.lDReportController!.lpoReportSummaryModel.value.serviceRequests![widget.index!].totalAmount.toString()}',
                                textAlign: TextAlign.end,
                                style: AppTextStyle.normalGrey10,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1.2.h,
                        ),
                        Row(
                          children: [
                            Text(
                              AppMetaLabels().netAmount,
                              style: AppTextStyle.normalGrey11,
                            ),
                            Spacer(),
                            Container(
                              alignment: Alignment.centerRight,
                              width: 30.w,
                              child: Text(
                                '${AppMetaLabels().aed} ${widget.lDReportController!.lpoReportSummaryModel.value.serviceRequests![widget.index!].netAmount.toString()}',
                                textAlign: TextAlign.end,
                                style: AppTextStyle.normalGrey10,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1.2.h,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        widget.index ==
                widget.lDReportController!.lpoReportSummaryModel.value
                        .totalRecord! -
                    1
            ? SizedBox()
            : AppDivider(),
      ],
    );
  }
}

class VatReportSummaryWidget extends StatefulWidget {
  final int? index;
  final LandLordReportPropController? lDReportController;
  const VatReportSummaryWidget({Key? key, this.index, this.lDReportController})
      : super(key: key);

  @override
  State<VatReportSummaryWidget> createState() => _VatReportSummaryWidgetState();
}

class _VatReportSummaryWidgetState extends State<VatReportSummaryWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 1.0.h,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 4.w,
            ),
            Padding(
              padding: EdgeInsets.only(left: 1.0.h, bottom: 1.h, right: 1.0.h),
              child: Row(
                children: [
                  Container(
                    width: 78.0.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              width: 78.w,
                              child: Text(
                                SessionController().getLanguage() == 1
                                    ? widget
                                            .lDReportController!
                                            .vatReportSummaryModel
                                            .value
                                            .serviceRequests![widget.index!]
                                            .propertyName ??
                                        "--"
                                    : widget
                                            .lDReportController!
                                            .vatReportSummaryModel
                                            .value
                                            .serviceRequests![widget.index!]
                                            .propertyNameAR ??
                                        "--",
                                style: AppTextStyle.semiBoldBlack11,
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1.0.h,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            SessionController().getLanguage() == 1
                                ? widget
                                        .lDReportController!
                                        .vatReportSummaryModel
                                        .value
                                        .serviceRequests![widget.index!]
                                        .landlordName ??
                                    '--'
                                : widget
                                        .lDReportController!
                                        .vatReportSummaryModel
                                        .value
                                        .serviceRequests![widget.index!]
                                        .landlordNameAR ??
                                    "--",
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyle.normalGrey10,
                            maxLines: 2,
                          ),
                        ),
                        SizedBox(
                          height: 1.0.h,
                        ),
                        Row(
                          children: [
                            Text(
                              AppMetaLabels().emirate,
                              style: AppTextStyle.normalGrey11,
                            ),
                            Spacer(),
                            Container(
                              alignment: Alignment.centerRight,
                              width: 38.w,
                              child: Text(
                                SessionController().getLanguage() == 1
                                    ? widget
                                            .lDReportController!
                                            .vatReportSummaryModel
                                            .value
                                            .serviceRequests![widget.index!]
                                            .emirateName ??
                                        "--"
                                    : widget
                                            .lDReportController!
                                            .vatReportSummaryModel
                                            .value
                                            .serviceRequests![widget.index!]
                                            .emirateNameAR ??
                                        "--",
                                style: AppTextStyle.normalGrey10,
                                textAlign: TextAlign.end,
                                maxLines: 3,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1.2.h,
                        ),
                        Row(
                          children: [
                            Text(
                              AppMetaLabels().tenant +
                                  ' ' +
                                  AppMetaLabels().name,
                              style: AppTextStyle.normalGrey11,
                            ),
                            Spacer(),
                            Container(
                              alignment: Alignment.centerRight,
                              width: 38.w,
                              child: Text(
                                SessionController().getLanguage() == 1
                                    ? widget
                                        .lDReportController!
                                        .vatReportSummaryModel
                                        .value
                                        .serviceRequests![widget.index!]
                                        .tenantName
                                        .toString()
                                    : widget
                                        .lDReportController!
                                        .vatReportSummaryModel
                                        .value
                                        .serviceRequests![widget.index!]
                                        .tenantNameAR
                                        .toString(),
                                textAlign: TextAlign.end,
                                style: AppTextStyle.normalGrey10,
                                maxLines: 3,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1.2.h,
                        ),
                        Row(
                          children: [
                            Text(
                              AppMetaLabels().contract +
                                  ' ' +
                                  AppMetaLabels().type,
                              style: AppTextStyle.normalGrey11,
                            ),
                            Spacer(),
                            Container(
                              alignment: Alignment.centerRight,
                              width: 38.w,
                              child: Text(
                                SessionController().getLanguage() == 1
                                    ? widget
                                            .lDReportController!
                                            .vatReportSummaryModel
                                            .value
                                            .serviceRequests![widget.index!]
                                            .contractType ??
                                        "--"
                                    : widget
                                            .lDReportController!
                                            .vatReportSummaryModel
                                            .value
                                            .serviceRequests![widget.index!]
                                            .contractTypeAR ??
                                        "--",
                                style: AppTextStyle.normalGrey10,
                                textAlign: TextAlign.end,
                                maxLines: 3,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1.2.h,
                        ),
                        Row(
                          children: [
                            Text(
                              AppMetaLabels().vatCharges,
                              style: AppTextStyle.normalGrey11,
                            ),
                            Spacer(),
                            Container(
                              alignment: Alignment.centerRight,
                              width: 38.w,
                              child: Text(
                                '${AppMetaLabels().aed} ${widget.lDReportController!.vatReportSummaryModel.value.serviceRequests![widget.index!].vATCharges}',
                                style: AppTextStyle.normalGrey10,
                                textAlign: TextAlign.end,
                                maxLines: 3,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1.2.h,
                        ),
                        Row(
                          children: [
                            Text(
                              AppMetaLabels().invoiceAmount,
                              style: AppTextStyle.normalGrey11,
                            ),
                            Spacer(),
                            Container(
                              alignment: Alignment.centerRight,
                              width: 38.w,
                              child: Text(
                                '${AppMetaLabels().aed} ${widget.lDReportController!.vatReportSummaryModel.value.serviceRequests![widget.index!].invoicedAmount}',
                                textAlign: TextAlign.end,
                                style: AppTextStyle.normalGrey10,
                                maxLines: 3,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1.2.h,
                        ),
                        Row(
                          children: [
                            Text(
                              AppMetaLabels().vATPaidAmount,
                              style: AppTextStyle.normalGrey11,
                            ),
                            Spacer(),
                            Container(
                              alignment: Alignment.centerRight,
                              width: 30.w,
                              child: Text(
                                '${AppMetaLabels().aed} ${widget.lDReportController!.vatReportSummaryModel.value.serviceRequests![widget.index!].vATPaidAmt}',
                                textAlign: TextAlign.end,
                                style: AppTextStyle.normalGrey10,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1.2.h,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        widget.index ==
                widget.lDReportController!.vatReportSummaryModel.value
                        .totalRecord! -
                    1
            ? SizedBox()
            : AppDivider(),
      ],
    );
  }
}

class ReceiptRegisterReportSummaryWidget extends StatefulWidget {
  final int? index;
  final LandLordReportPropController? lDReportController;
  const ReceiptRegisterReportSummaryWidget(
      {Key? key, this.index, this.lDReportController})
      : super(key: key);

  @override
  State<ReceiptRegisterReportSummaryWidget> createState() =>
      _ReceiptRegisterReportSummaryWidgetState();
}

class _ReceiptRegisterReportSummaryWidgetState
    extends State<ReceiptRegisterReportSummaryWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 1.0.h,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 4.w,
            ),
            Padding(
              padding: EdgeInsets.only(left: 1.0.h, bottom: 1.h, right: 1.0.h),
              child: Row(
                children: [
                  Container(
                    width: 78.0.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              width: 78.w,
                              child: Text(
                                SessionController().getLanguage() == 1
                                    ? widget
                                            .lDReportController!
                                            .receiptRegisterModel
                                            .value
                                            .serviceRequests![widget.index!]
                                            .propertyName ??
                                        "--"
                                    : widget
                                            .lDReportController!
                                            .receiptRegisterModel
                                            .value
                                            .serviceRequests![widget.index!]
                                            .propertyNameAR ??
                                        "--",
                                style: AppTextStyle.semiBoldBlack11,
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1.0.h,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            SessionController().getLanguage() == 1
                                ? widget
                                        .lDReportController!
                                        .receiptRegisterModel
                                        .value
                                        .serviceRequests![widget.index!]
                                        .landlordName ??
                                    '--'
                                : widget
                                        .lDReportController!
                                        .receiptRegisterModel
                                        .value
                                        .serviceRequests![widget.index!]
                                        .landlordNameAR ??
                                    "--",
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyle.normalGrey10,
                            maxLines: 2,
                          ),
                        ),
                        SizedBox(
                          height: 1.0.h,
                        ),
                        Row(
                          children: [
                            Text(
                              AppMetaLabels().emirate,
                              style: AppTextStyle.normalGrey11,
                            ),
                            Spacer(),
                            Container(
                              alignment: Alignment.centerRight,
                              width: 38.w,
                              child: Text(
                                SessionController().getLanguage() == 1
                                    ? widget
                                            .lDReportController!
                                            .receiptRegisterModel
                                            .value
                                            .serviceRequests![widget.index!]
                                            .emirateName ??
                                        "--"
                                    : widget
                                            .lDReportController!
                                            .receiptRegisterModel
                                            .value
                                            .serviceRequests![widget.index!]
                                            .emirateNameAR ??
                                        "--",
                                style: AppTextStyle.normalGrey10,
                                textAlign: TextAlign.end,
                                maxLines: 3,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1.0.h,
                        ),
                        Row(
                          children: [
                            Text(
                              AppMetaLabels().tenant +
                                  ' ' +
                                  AppMetaLabels().name,
                              style: AppTextStyle.normalGrey11,
                            ),
                            Spacer(),
                            Container(
                              alignment: Alignment.centerRight,
                              width: 38.w,
                              child: Text(
                                SessionController().getLanguage() == 1
                                    ? widget
                                            .lDReportController!
                                            .receiptRegisterModel
                                            .value
                                            .serviceRequests![widget.index!]
                                            .tenantName ??
                                        "--"
                                    : widget
                                            .lDReportController!
                                            .receiptRegisterModel
                                            .value
                                            .serviceRequests![widget.index!]
                                            .tenantNameAR ??
                                        "--",
                                style: AppTextStyle.normalGrey10,
                                textAlign: TextAlign.end,
                                maxLines: 3,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1.2.h,
                        ),
                        Row(
                          children: [
                            Text(
                              AppMetaLabels().unitType,
                              style: AppTextStyle.normalGrey11,
                            ),
                            Spacer(),
                            Container(
                              alignment: Alignment.centerRight,
                              width: 38.w,
                              child: Text(
                                SessionController().getLanguage() == 1
                                    ? widget
                                            .lDReportController!
                                            .receiptRegisterModel
                                            .value
                                            .serviceRequests![widget.index!]
                                            .unitType ??
                                        "--"
                                    : widget
                                            .lDReportController!
                                            .receiptRegisterModel
                                            .value
                                            .serviceRequests![widget.index!]
                                            .unitTypeAR ??
                                        "--",
                                style: AppTextStyle.normalGrey10,
                                textAlign: TextAlign.end,
                                maxLines: 3,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1.2.h,
                        ),
                        Row(
                          children: [
                            Text(
                              AppMetaLabels().modeofPayment,
                              style: AppTextStyle.normalGrey11,
                            ),
                            Spacer(),
                            Container(
                              alignment: Alignment.centerRight,
                              width: 38.w,
                              child: Text(
                                SessionController().getLanguage() == 1
                                    ? widget
                                            .lDReportController!
                                            .receiptRegisterModel
                                            .value
                                            .serviceRequests![widget.index!]
                                            .modeofPayment ??
                                        "--"
                                    : widget
                                            .lDReportController!
                                            .receiptRegisterModel
                                            .value
                                            .serviceRequests![widget.index!]
                                            .modeofPaymentAR ??
                                        "--",
                                style: AppTextStyle.normalGrey10,
                                textAlign: TextAlign.end,
                                maxLines: 3,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1.2.h,
                        ),
                        Row(
                          children: [
                            Text(
                              AppMetaLabels().totalAmount,
                              style: AppTextStyle.normalGrey11,
                            ),
                            Spacer(),
                            Container(
                              alignment: Alignment.centerRight,
                              width: 38.w,
                              child: Text(
                                '${AppMetaLabels().aed} ${widget.lDReportController!.receiptRegisterModel.value.serviceRequests![widget.index!].totalAmount.toString()}',
                                textAlign: TextAlign.end,
                                style: AppTextStyle.normalGrey10,
                                maxLines: 3,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1.2.h,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        widget.index ==
                widget.lDReportController!.receiptRegisterModel.value
                        .totalRecord! -
                    1
            ? SizedBox()
            : AppDivider(),
      ],
    );
  }
}

class UnitStatusSummaryReportWidget extends StatefulWidget {
  final int? index;
  final LandLordReportPropController? lDReportController;
  const UnitStatusSummaryReportWidget(
      {Key? key, this.index, this.lDReportController})
      : super(key: key);

  @override
  State<UnitStatusSummaryReportWidget> createState() =>
      _UnitStatusSummaryReportWidgetState();
}

class _UnitStatusSummaryReportWidgetState
    extends State<UnitStatusSummaryReportWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 1.0.h,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 4.w,
            ),
            Padding(
              padding: EdgeInsets.only(left: 1.0.h, bottom: 1.h, right: 1.0.h),
              child: Row(
                children: [
                  Container(
                    width: 78.0.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              width: 78.w,
                              child: Text(
                                SessionController().getLanguage() == 1
                                    ? widget
                                            .lDReportController!
                                            .unitStatusReportModel
                                            .value
                                            .serviceRequests![widget.index!]
                                            .propertyName ??
                                        "--"
                                    : widget
                                            .lDReportController!
                                            .unitStatusReportModel
                                            .value
                                            .serviceRequests![widget.index!]
                                            .propertyNameAR ??
                                        "--",
                                style: AppTextStyle.semiBoldBlack11,
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1.0.h,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            SessionController().getLanguage() == 1
                                ? widget
                                        .lDReportController!
                                        .unitStatusReportModel
                                        .value
                                        .serviceRequests![widget.index!]
                                        .landlordName ??
                                    '--'
                                : widget
                                        .lDReportController!
                                        .unitStatusReportModel
                                        .value
                                        .serviceRequests![widget.index!]
                                        .landlordNameAR ??
                                    "--",
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyle.normalGrey10,
                            maxLines: 2,
                          ),
                        ),
                        SizedBox(
                          height: 1.0.h,
                        ),
                        Row(
                          children: [
                            Text(
                              AppMetaLabels().emirate,
                              style: AppTextStyle.normalGrey11,
                            ),
                            Spacer(),
                            Container(
                              alignment: Alignment.centerRight,
                              width: 38.w,
                              child: Text(
                                SessionController().getLanguage() == 1
                                    ? widget
                                            .lDReportController!
                                            .unitStatusReportModel
                                            .value
                                            .serviceRequests![widget.index!]
                                            .emirateName ??
                                        "--"
                                    : widget
                                            .lDReportController!
                                            .unitStatusReportModel
                                            .value
                                            .serviceRequests![widget.index!]
                                            .emirateNameAR ??
                                        "--",
                                style: AppTextStyle.normalGrey10,
                                textAlign: TextAlign.end,
                                maxLines: 3,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1.0.h,
                        ),
                        Row(
                          children: [
                            Text(
                              AppMetaLabels().tenant +
                                  ' ' +
                                  AppMetaLabels().name,
                              style: AppTextStyle.normalGrey11,
                            ),
                            Spacer(),
                            Container(
                              alignment: Alignment.centerRight,
                              width: 38.w,
                              child: Text(
                                SessionController().getLanguage() == 1
                                    ? widget
                                            .lDReportController!
                                            .unitStatusReportModel
                                            .value
                                            .serviceRequests![widget.index!]
                                            .tenantName ??
                                        "--"
                                    : widget
                                            .lDReportController!
                                            .unitStatusReportModel
                                            .value
                                            .serviceRequests![widget.index!]
                                            .tenantNameAR ??
                                        "--",
                                style: AppTextStyle.normalGrey10,
                                textAlign: TextAlign.end,
                                maxLines: 3,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1.2.h,
                        ),
                        Row(
                          children: [
                            Text(
                              AppMetaLabels().unitRefNo,
                              style: AppTextStyle.normalGrey11,
                            ),
                            Spacer(),
                            Container(
                              alignment: Alignment.centerRight,
                              width: 38.w,
                              child: Text(
                                widget
                                    .lDReportController!
                                    .unitStatusReportModel
                                    .value
                                    .serviceRequests![widget.index!]
                                    .unitRef
                                    .toString(),
                                style: AppTextStyle.normalGrey10,
                                textAlign: TextAlign.end,
                                maxLines: 3,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1.2.h,
                        ),
                        Row(
                          children: [
                            Text(
                              AppMetaLabels().unitType,
                              style: AppTextStyle.normalGrey11,
                            ),
                            Spacer(),
                            Container(
                              alignment: Alignment.centerRight,
                              width: 38.w,
                              child: Text(
                                SessionController().getLanguage() == 1
                                    ? widget
                                            .lDReportController!
                                            .unitStatusReportModel
                                            .value
                                            .serviceRequests![widget.index!]
                                            .unitType ??
                                        "--"
                                    : widget
                                            .lDReportController!
                                            .unitStatusReportModel
                                            .value
                                            .serviceRequests![widget.index!]
                                            .unitTypeAR ??
                                        "--",
                                style: AppTextStyle.normalGrey10,
                                textAlign: TextAlign.end,
                                maxLines: 3,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1.2.h,
                        ),
                        Row(
                          children: [
                            Text(
                              AppMetaLabels().unitCategory,
                              style: AppTextStyle.normalGrey11,
                            ),
                            Spacer(),
                            Container(
                              alignment: Alignment.centerRight,
                              width: 38.w,
                              child: Text(
                                SessionController().getLanguage() == 1
                                    ? widget
                                            .lDReportController!
                                            .unitStatusReportModel
                                            .value
                                            .serviceRequests![widget.index!]
                                            .unitCategory ??
                                        "--"
                                    : widget
                                            .lDReportController!
                                            .unitStatusReportModel
                                            .value
                                            .serviceRequests![widget.index!]
                                            .unitCategoryAR ??
                                        "--",
                                style: AppTextStyle.normalGrey10,
                                textAlign: TextAlign.end,
                                maxLines: 3,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1.2.h,
                        ),
                        Row(
                          children: [
                            Text(
                              AppMetaLabels().unit +
                                  ' ' +
                                  AppMetaLabels().status,
                              style: AppTextStyle.normalGrey11,
                            ),
                            Spacer(),
                            Container(
                              alignment: Alignment.centerRight,
                              width: 30.w,
                              child: StatusWidget(
                                  text: SessionController().getLanguage() == 1
                                      ? widget
                                              .lDReportController!
                                              .unitStatusReportModel
                                              .value
                                              .serviceRequests![widget.index!]
                                              .unitStatus ??
                                          ""
                                      : widget
                                              .lDReportController!
                                              .unitStatusReportModel
                                              .value
                                              .serviceRequests![widget.index!]
                                              .unitStatusAR ??
                                          "",
                                  valueToCompare: widget
                                          .lDReportController!
                                          .unitStatusReportModel
                                          .value
                                          .serviceRequests![widget.index!]
                                          .unitStatus ??
                                      ""),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 1.2.h,
                        ),
                        Row(
                          children: [
                            Text(
                              AppMetaLabels().currentRent,
                              style: AppTextStyle.normalGrey11,
                            ),
                            Spacer(),
                            Container(
                              alignment: Alignment.centerRight,
                              width: 38.w,
                              child: Text(
                                '${AppMetaLabels().aed} ${widget.lDReportController!.unitStatusReportModel.value.serviceRequests![widget.index!].rent}',
                                style: AppTextStyle.normalGrey10,
                                textAlign: TextAlign.end,
                                maxLines: 3,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1.2.h,
                        ),
                        Row(
                          children: [
                            Text(
                              AppMetaLabels().annualRent,
                              style: AppTextStyle.normalGrey11,
                            ),
                            Spacer(),
                            Container(
                              alignment: Alignment.centerRight,
                              width: 38.w,
                              child: Text(
                                '${AppMetaLabels().aed} ${widget.lDReportController!.unitStatusReportModel.value.serviceRequests![widget.index!].annualRent}',
                                textAlign: TextAlign.end,
                                style: AppTextStyle.normalGrey10,
                                maxLines: 3,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1.2.h,
                        ),
                        Row(
                          children: [
                            Text(
                              AppMetaLabels().lastContractAmount,
                              style: AppTextStyle.normalGrey11,
                            ),
                            Spacer(),
                            Container(
                              alignment: Alignment.centerRight,
                              width: 30.w,
                              child: Text(
                                '${AppMetaLabels().aed} ${widget.lDReportController!.unitStatusReportModel.value.serviceRequests![widget.index!].contractValue}',
                                textAlign: TextAlign.end,
                                style: AppTextStyle.normalGrey10,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1.2.h,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        widget.index ==
                widget.lDReportController!.unitStatusReportModel.value
                        .totalRecord! -
                    1
            ? SizedBox()
            : AppDivider(),
      ],
    );
  }
}

class OccupancyVancaneyreportSummaryWidget extends StatefulWidget {
  final int? index;
  final LandLordReportPropController? lDReportController;
  const OccupancyVancaneyreportSummaryWidget(
      {Key? key, @required this.index, @required this.lDReportController})
      : super(key: key);

  @override
  State<OccupancyVancaneyreportSummaryWidget> createState() =>
      _OccupancyVancaneyreportSummaryWidgetState();
}

class _OccupancyVancaneyreportSummaryWidgetState
    extends State<OccupancyVancaneyreportSummaryWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 1.0.h,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 4.w,
            ),
            Padding(
              padding: EdgeInsets.only(left: 1.0.h, bottom: 1.h, right: 1.0.h),
              child: Row(
                children: [
                  Container(
                    width: 78.0.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              width: 78.w,
                              child: Text(
                                SessionController().getLanguage() == 1
                                    ? widget
                                            .lDReportController!
                                            .occupanyReportModel
                                            .value
                                            .serviceRequests![widget.index!]
                                            .propertyName ??
                                        "--"
                                    : widget
                                            .lDReportController!
                                            .occupanyReportModel
                                            .value
                                            .serviceRequests![widget.index!]
                                            .propertyNameAR ??
                                        "--",
                                style: AppTextStyle.semiBoldBlack11,
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1.0.h,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            SessionController().getLanguage() == 1
                                ? widget
                                        .lDReportController!
                                        .occupanyReportModel
                                        .value
                                        .serviceRequests![widget.index!]
                                        .landlord ??
                                    '--'
                                : widget
                                        .lDReportController!
                                        .occupanyReportModel
                                        .value
                                        .serviceRequests![widget.index!]
                                        .landlordAR ??
                                    "--",
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyle.normalGrey10,
                            maxLines: 2,
                          ),
                        ),
                        SizedBox(
                          height: 1.0.h,
                        ),
                        Row(
                          children: [
                            Text(
                              AppMetaLabels().emirate,
                              style: AppTextStyle.normalGrey11,
                            ),
                            Spacer(),
                            Container(
                              alignment: Alignment.centerRight,
                              width: 38.w,
                              child: Text(
                                SessionController().getLanguage() == 1
                                    ? widget
                                            .lDReportController!
                                            .occupanyReportModel
                                            .value
                                            .serviceRequests![widget.index!]
                                            .emirateName ??
                                        "--"
                                    : widget
                                            .lDReportController!
                                            .occupanyReportModel
                                            .value
                                            .serviceRequests![widget.index!]
                                            .emirateNameAR ??
                                        "--",
                                style: AppTextStyle.normalGrey10,
                                textAlign: TextAlign.end,
                                maxLines: 3,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1.2.h,
                        ),
                        Row(
                          children: [
                            Text(
                              AppMetaLabels().totalUnits,
                              style: AppTextStyle.normalGrey11,
                            ),
                            Spacer(),
                            Container(
                              alignment: Alignment.centerRight,
                              width: 38.w,
                              child: Text(
                                widget
                                    .lDReportController!
                                    .occupanyReportModel
                                    .value
                                    .serviceRequests![widget.index!]
                                    .totalUnits
                                    .toString(),
                                textAlign: TextAlign.end,
                                style: AppTextStyle.normalGrey10,
                                maxLines: 3,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1.2.h,
                        ),
                        Row(
                          children: [
                            Text(
                              AppMetaLabels().occupiedUnits,
                              style: AppTextStyle.normalGrey11,
                            ),
                            Spacer(),
                            Container(
                              alignment: Alignment.centerRight,
                              width: 30.w,
                              child: Text(
                                widget
                                    .lDReportController!
                                    .occupanyReportModel
                                    .value
                                    .serviceRequests![widget.index!]
                                    .occupiedUnits
                                    .toString(),
                                textAlign: TextAlign.end,
                                style: AppTextStyle.normalGrey10,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1.2.h,
                        ),
                        Row(
                          children: [
                            Text(
                              AppMetaLabels().vacantUnits,
                              style: AppTextStyle.normalGrey11,
                            ),
                            Spacer(),
                            Container(
                              alignment: Alignment.centerRight,
                              width: 30.w,
                              child: Text(
                                widget
                                    .lDReportController!
                                    .occupanyReportModel
                                    .value
                                    .serviceRequests![widget.index!]
                                    .vacantUnits
                                    .toString(),
                                textAlign: TextAlign.end,
                                style: AppTextStyle.normalGrey10,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1.2.h,
                        ),
                        Row(
                          children: [
                            Text(
                              // AppMetaLabels().noOfOccupancy,
                              AppMetaLabels().occupancy + ' ( % )',
                              style: AppTextStyle.normalGrey11,
                            ),
                            Spacer(),
                            Container(
                              alignment: Alignment.centerRight,
                              width: 30.w,
                              child: Text(
                                widget
                                    .lDReportController!
                                    .occupanyReportModel
                                    .value
                                    .serviceRequests![widget.index!]
                                    .noOfOccupancy
                                    .toString(),
                                textAlign: TextAlign.end,
                                style: AppTextStyle.normalGrey10,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1.2.h,
                        ),
                        Row(
                          children: [
                            Text(
                              AppMetaLabels().vacancy + ' ( % )',
                              style: AppTextStyle.normalGrey11,
                            ),
                            Spacer(),
                            Container(
                              alignment: Alignment.centerRight,
                              width: 38.w,
                              child: Text(
                                widget
                                    .lDReportController!
                                    .occupanyReportModel
                                    .value
                                    .serviceRequests![widget.index!]
                                    .noOfVacancy
                                    .toString(),
                                textAlign: TextAlign.end,
                                style: AppTextStyle.normalGrey10,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1.2.h,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        widget.index ==
                widget.lDReportController!.occupanyReportModel.value
                        .totalRecord! -
                    1
            ? SizedBox()
            : AppDivider(),
      ],
    );
  }
}

class LegalCasereportSummaryWidget extends StatefulWidget {
  final int? index;
  final LandLordReportPropController? lDReportController;
  const LegalCasereportSummaryWidget(
      {Key? key, @required this.index, @required this.lDReportController})
      : super(key: key);

  @override
  State<LegalCasereportSummaryWidget> createState() =>
      _LegalCasereportSummaryWidgetState();
}

class _LegalCasereportSummaryWidgetState
    extends State<LegalCasereportSummaryWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 1.0.h,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 4.w,
            ),
            Padding(
              padding: EdgeInsets.only(left: 1.0.h, bottom: 1.h, right: 1.0.h),
              child: Row(
                children: [
                  Container(
                    width: 78.0.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              width: 78.w,
                              child: Text(
                                SessionController().getLanguage() == 1
                                    ? widget
                                            .lDReportController!
                                            .legalCaseReportModel
                                            .value
                                            .serviceRequests![widget.index!]
                                            .propertyName ??
                                        "--"
                                    : widget
                                            .lDReportController!
                                            .legalCaseReportModel
                                            .value
                                            .serviceRequests![widget.index!]
                                            .propertyNameAR ??
                                        "--",
                                style: AppTextStyle.semiBoldBlack11,
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1.0.h,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            SessionController().getLanguage() == 1
                                ? widget
                                        .lDReportController!
                                        .legalCaseReportModel
                                        .value
                                        .serviceRequests![widget.index!]
                                        .owner ??
                                    '--'
                                : widget
                                        .lDReportController!
                                        .legalCaseReportModel
                                        .value
                                        .serviceRequests![widget.index!]
                                        .ownerAR ??
                                    "--",
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyle.normalGrey10,
                            maxLines: 2,
                          ),
                        ),
                        SizedBox(
                          height: 1.0.h,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              AppMetaLabels().emirate,
                              style: AppTextStyle.normalGrey11,
                            ),
                            Spacer(),
                            Container(
                              alignment: Alignment.centerRight,
                              child: Text(
                                SessionController().getLanguage() == 1
                                    ? widget
                                            .lDReportController!
                                            .legalCaseReportModel
                                            .value
                                            .serviceRequests![widget.index!]
                                            .emirateName ??
                                        "--"
                                    : widget
                                            .lDReportController!
                                            .legalCaseReportModel
                                            .value
                                            .serviceRequests![widget.index!]
                                            .emirateNameAR ??
                                        "--",
                                style: AppTextStyle.normalGrey11,
                                textAlign: TextAlign.end,
                                maxLines: 3,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            Text(
                              AppMetaLabels().tenant +
                                  ' ' +
                                  AppMetaLabels().name,
                              style: AppTextStyle.normalGrey11,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Spacer(),
                            Container(
                              width: Get.width * 0.52,
                              alignment: Alignment.centerRight,
                              child: Text(
                                SessionController().getLanguage() == 1
                                    ? widget
                                            .lDReportController!
                                            .legalCaseReportModel
                                            .value
                                            .serviceRequests![widget.index!]
                                            .tenantName ??
                                        "--"
                                    : widget
                                            .lDReportController!
                                            .legalCaseReportModel
                                            .value
                                            .serviceRequests![widget.index!]
                                            .tenantNameAR ??
                                        "--",
                                textAlign: TextAlign.end,
                                style: AppTextStyle.normalGrey11,
                                maxLines: 3,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            Text(
                              AppMetaLabels().city,
                              style: AppTextStyle.normalGrey11,
                            ),
                            Spacer(),
                            Container(
                              alignment: Alignment.centerRight,
                              child: Text(
                                SessionController().getLanguage() == 1
                                    ? widget
                                            .lDReportController!
                                            .legalCaseReportModel
                                            .value
                                            .serviceRequests![widget.index!]
                                            .city ??
                                        "--"
                                    : widget
                                            .lDReportController!
                                            .legalCaseReportModel
                                            .value
                                            .serviceRequests![widget.index!]
                                            .cityAR ??
                                        "--",
                                textAlign: TextAlign.end,
                                style: AppTextStyle.normalGrey11,
                                maxLines: 3,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            Text(
                              AppMetaLabels().unitType,
                              style: AppTextStyle.normalGrey11,
                            ),
                            Spacer(),
                            Container(
                              alignment: Alignment.centerRight,
                              child: Text(
                                SessionController().getLanguage() == 1
                                    ? widget
                                            .lDReportController!
                                            .legalCaseReportModel
                                            .value
                                            .serviceRequests![widget.index!]
                                            .unitType ??
                                        "--"
                                    : widget
                                            .lDReportController!
                                            .legalCaseReportModel
                                            .value
                                            .serviceRequests![widget.index!]
                                            .unitTypeAR ??
                                        "--",
                                textAlign: TextAlign.end,
                                style: AppTextStyle.normalGrey11,
                                maxLines: 3,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            Text(
                              AppMetaLabels().rent,
                              style: AppTextStyle.normalGrey11,
                            ),
                            Spacer(),
                            Container(
                              alignment: Alignment.centerRight,
                              child: Text(
                                '${AppMetaLabels().aed} ${widget.lDReportController!.legalCaseReportModel.value.serviceRequests![widget.index!].rent.toString()}',
                                textAlign: TextAlign.end,
                                style: AppTextStyle.normalGrey11,
                                maxLines: 3,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            Text(
                              AppMetaLabels().rentPaidAmount,
                              style: AppTextStyle.normalGrey11,
                            ),
                            Spacer(),
                            Container(
                              alignment: Alignment.centerRight,
                              child: Text(
                                '${AppMetaLabels().aed} ${widget.lDReportController!.legalCaseReportModel.value.serviceRequests![widget.index!].rentPaidAmount.toString()}',
                                textAlign: TextAlign.end,
                                style: AppTextStyle.normalGrey11,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            Text(
                              AppMetaLabels().prevRent,
                              style: AppTextStyle.normalGrey11,
                            ),
                            Spacer(),
                            Container(
                              alignment: Alignment.centerRight,
                              child: Text(
                                '${AppMetaLabels().aed} ${widget.lDReportController!.legalCaseReportModel.value.serviceRequests![widget.index!].prevRent.toString()}',
                                textAlign: TextAlign.end,
                                style: AppTextStyle.normalGrey11,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            Text(
                              AppMetaLabels().lossofRent,
                              style: AppTextStyle.normalGrey11,
                            ),
                            Spacer(),
                            Container(
                              alignment: Alignment.centerRight,
                              child: Text(
                                '${AppMetaLabels().aed} ${widget.lDReportController!.legalCaseReportModel.value.serviceRequests![widget.index!].lossofRent.toString()}',
                                textAlign: TextAlign.end,
                                style: AppTextStyle.normalGrey11,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            Text(
                              AppMetaLabels().period,
                              style: AppTextStyle.normalGrey11,
                            ),
                            Spacer(),
                            Container(
                              alignment: Alignment.centerRight,
                              child: Text(
                                widget
                                    .lDReportController!
                                    .legalCaseReportModel
                                    .value
                                    .serviceRequests![widget.index!]
                                    .period
                                    .toString(),
                                textAlign: TextAlign.end,
                                style: AppTextStyle.normalGrey11,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            Text(
                              AppMetaLabels().lossofRentDays,
                              style: AppTextStyle.normalGrey11,
                            ),
                            Spacer(),
                            Container(
                              alignment: Alignment.centerRight,
                              child: Text(
                                widget
                                    .lDReportController!
                                    .legalCaseReportModel
                                    .value
                                    .serviceRequests![widget.index!]
                                    .lossofRent
                                    .toString(),
                                textAlign: TextAlign.end,
                                style: AppTextStyle.normalGrey11,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        widget.index ==
                widget.lDReportController!.legalCaseReportModel.value
                        .totalRecord! -
                    1
            ? SizedBox()
            : AppDivider(),
      ],
    );
  }
}

class ContractReportSummaryWidget extends StatefulWidget {
  final int? index;
  final LandLordReportPropController? lDReportController;
  const ContractReportSummaryWidget(
      {Key? key, @required this.index, @required this.lDReportController})
      : super(key: key);

  @override
  State<ContractReportSummaryWidget> createState() =>
      _ContractReportSummaryWidgetState();
}

class _ContractReportSummaryWidgetState
    extends State<ContractReportSummaryWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 1.0.h,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 4.w,
            ),
            Padding(
              padding: EdgeInsets.only(left: 1.0.h, bottom: 1.h, right: 1.0.h),
              child: Row(
                children: [
                  Container(
                    width: 78.0.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              width: 78.w,
                              child: Text(
                                SessionController().getLanguage() == 1
                                    ? widget
                                            .lDReportController!
                                            .contractReportModel
                                            .value
                                            .serviceRequests![widget.index!]
                                            .propertyName ??
                                        "--"
                                    : widget
                                            .lDReportController!
                                            .contractReportModel
                                            .value
                                            .serviceRequests![widget.index!]
                                            .propertyNameAR ??
                                        "--",
                                style: AppTextStyle.semiBoldBlack11,
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1.0.h,
                        ),
                        Row(
                          children: [
                            Text(
                              AppMetaLabels().contractNo,
                              style: AppTextStyle.normalGrey11,
                            ),
                            Spacer(),
                            Container(
                              alignment: Alignment.centerRight,
                              width: 38.w,
                              child: Text(
                                widget
                                    .lDReportController!
                                    .contractReportModel
                                    .value
                                    .serviceRequests![widget.index!]
                                    .contractno
                                    .toString(),
                                style: AppTextStyle.normalGrey10,
                                textAlign: TextAlign.end,
                                maxLines: 3,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1.0.h,
                        ),
                        Row(
                          children: [
                            Text(
                              AppMetaLabels().totalAmount,
                              style: AppTextStyle.normalGrey11,
                            ),
                            Spacer(),
                            Container(
                              alignment: Alignment.centerRight,
                              width: 38.w,
                              child: Text(
                                '${AppMetaLabels().aed} ${widget.lDReportController!.contractReportModel.value.serviceRequests![widget.index!].total.toString()}',
                                style: AppTextStyle.normalGrey10,
                                textAlign: TextAlign.end,
                                maxLines: 3,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1.0.h,
                        ),
                        Row(
                          children: [
                            Text(
                              AppMetaLabels().paid +
                                  ' ' +
                                  AppMetaLabels().amount,
                              style: AppTextStyle.normalGrey11,
                            ),
                            Spacer(),
                            Container(
                              alignment: Alignment.centerRight,
                              width: 38.w,
                              child: Text(
                                '${AppMetaLabels().aed} ${widget.lDReportController!.contractReportModel.value.serviceRequests![widget.index!].paid.toString()}',
                                style: AppTextStyle.normalGrey10,
                                textAlign: TextAlign.end,
                                maxLines: 3,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1.0.h,
                        ),
                        Row(
                          children: [
                            Text(
                              AppMetaLabels().vatAmount,
                              style: AppTextStyle.normalGrey11,
                            ),
                            Spacer(),
                            Container(
                              alignment: Alignment.centerRight,
                              width: 38.w,
                              child: Text(
                                '${AppMetaLabels().aed} ${widget.lDReportController!.contractReportModel.value.serviceRequests![widget.index!].vATAmount.toString()}',
                                style: AppTextStyle.normalGrey10,
                                textAlign: TextAlign.end,
                                maxLines: 3,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1.2.h,
                        ),
                        Row(
                          children: [
                            Text(
                              AppMetaLabels().vatOnCharges,
                              style: AppTextStyle.normalGrey11,
                            ),
                            Spacer(),
                            Container(
                              alignment: Alignment.centerRight,
                              width: 38.w,
                              child: Text(
                                '${AppMetaLabels().aed} ${widget.lDReportController!.contractReportModel.value.serviceRequests![widget.index!].vATCharges.toString()}',
                                textAlign: TextAlign.end,
                                style: AppTextStyle.normalGrey10,
                                maxLines: 3,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1.2.h,
                        ),
                        Row(
                          children: [
                            Text(
                              AppMetaLabels().status,
                              style: AppTextStyle.semiBoldBlack11,
                            ),
                            Spacer(),
                            Container(
                              alignment: Alignment.centerRight,
                              width: 22.w,
                              child: StatusWidget(
                                  text: SessionController().getLanguage() == 1
                                      ? widget
                                              .lDReportController!
                                              .contractReportModel
                                              .value
                                              .serviceRequests![widget.index!]
                                              .contractStatus ??
                                          "--"
                                      : widget
                                              .lDReportController!
                                              .contractReportModel
                                              .value
                                              .serviceRequests![widget.index!]
                                              .contractStatusAR ??
                                          "--",
                                  valueToCompare: widget
                                          .lDReportController!
                                          .contractReportModel
                                          .value
                                          .serviceRequests![widget.index!]
                                          .contractStatus ??
                                      ""),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 1.2.h,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        widget.index ==
                widget.lDReportController!.contractReportModel.value
                        .totalRecord! -
                    1
            ? SizedBox()
            : AppDivider(),
      ],
    );
  }
}

class ChequeRegiterReportSummaryWidget extends StatefulWidget {
  final int? index;
  final LandLordReportPropController? lDReportController;
  const ChequeRegiterReportSummaryWidget(
      {Key? key, @required this.index, @required this.lDReportController})
      : super(key: key);

  @override
  State<ChequeRegiterReportSummaryWidget> createState() =>
      _ChequeRegiterReportSummaryWidgetState();
}

class _ChequeRegiterReportSummaryWidgetState
    extends State<ChequeRegiterReportSummaryWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 1.0.h,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 4.w,
            ),
            Padding(
              padding: EdgeInsets.only(left: 1.0.h, bottom: 1.h, right: 1.0.h),
              child: Row(
                children: [
                  Container(
                    width: 78.0.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              width: 78.w,
                              child: Text(
                                SessionController().getLanguage() == 1
                                    ? widget
                                            .lDReportController!
                                            .chequeRegisterReportModel
                                            .value
                                            .serviceRequests![widget.index!]
                                            .propertyName ??
                                        "--"
                                    : widget
                                            .lDReportController!
                                            .chequeRegisterReportModel
                                            .value
                                            .serviceRequests![widget.index!]
                                            .propertyNameAR ??
                                        "--",
                                style: AppTextStyle.semiBoldBlack11,
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1.0.h,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            SessionController().getLanguage() == 1
                                ? widget
                                        .lDReportController!
                                        .chequeRegisterReportModel
                                        .value
                                        .serviceRequests![widget.index!]
                                        .landlordName ??
                                    '--'
                                : widget
                                        .lDReportController!
                                        .chequeRegisterReportModel
                                        .value
                                        .serviceRequests![widget.index!]
                                        .landlordNameAR ??
                                    "--",
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyle.normalGrey10,
                            maxLines: 2,
                          ),
                        ),
                        SizedBox(
                          height: 1.0.h,
                        ),
                        Row(
                          children: [
                            Text(
                              AppMetaLabels().emirate,
                              style: AppTextStyle.normalGrey11,
                            ),
                            Spacer(),
                            Container(
                              alignment: Alignment.centerRight,
                              width: 38.w,
                              child: Text(
                                SessionController().getLanguage() == 1
                                    ? widget
                                            .lDReportController!
                                            .chequeRegisterReportModel
                                            .value
                                            .serviceRequests![widget.index!]
                                            .emirateName ??
                                        ""
                                    : widget
                                            .lDReportController!
                                            .chequeRegisterReportModel
                                            .value
                                            .serviceRequests![widget.index!]
                                            .emirateNameAR ??
                                        "",
                                style: AppTextStyle.normalGrey10,
                                textAlign: TextAlign.end,
                                maxLines: 3,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1.2.h,
                        ),
                        Row(
                          children: [
                            Text(
                              AppMetaLabels().tenant +
                                  ' ' +
                                  AppMetaLabels().name,
                              style: AppTextStyle.normalGrey11,
                            ),
                            Spacer(),
                            Container(
                              alignment: Alignment.centerRight,
                              width: 38.w,
                              child: Text(
                                SessionController().getLanguage() == 1
                                    ? widget
                                            .lDReportController!
                                            .chequeRegisterReportModel
                                            .value
                                            .serviceRequests![widget.index!]
                                            .tenantName ??
                                        ""
                                    : widget
                                            .lDReportController!
                                            .chequeRegisterReportModel
                                            .value
                                            .serviceRequests![widget.index!]
                                            .tenantNameAR ??
                                        "",
                                textAlign: TextAlign.end,
                                style: AppTextStyle.normalGrey10,
                                maxLines: 3,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1.2.h,
                        ),
                        Row(
                          children: [
                            Text(
                              AppMetaLabels().cheque +
                                  ' ' +
                                  AppMetaLabels().amount,
                              style: AppTextStyle.normalGrey11,
                            ),
                            Spacer(),
                            Container(
                              alignment: Alignment.centerRight,
                              width: 30.w,
                              child: Text(
                                '${AppMetaLabels().aed} ${widget.lDReportController!.chequeRegisterReportModel.value.serviceRequests![widget.index!].chequeAmount.toString()}',
                                textAlign: TextAlign.end,
                                style: AppTextStyle.normalGrey10,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1.2.h,
                        ),
                        Row(
                          children: [
                            Text(
                              AppMetaLabels().status,
                              style: AppTextStyle.semiBoldBlack11,
                            ),
                            Spacer(),
                            Container(
                              alignment: Alignment.centerRight,
                              width: 30.w,
                              child: StatusWidget(
                                  text: SessionController().getLanguage() == 1
                                      ? widget
                                              .lDReportController!
                                              .chequeRegisterReportModel
                                              .value
                                              .serviceRequests![widget.index!]
                                              .chequeStatus ??
                                          ""
                                      : widget
                                              .lDReportController!
                                              .chequeRegisterReportModel
                                              .value
                                              .serviceRequests![widget.index!]
                                              .chequeStatusAR ??
                                          "",
                                  valueToCompare: widget
                                          .lDReportController!
                                          .chequeRegisterReportModel
                                          .value
                                          .serviceRequests![widget.index!]
                                          .chequeStatus ??
                                      ""),
                            ),
                            // Container(
                            //   alignment: Alignment.centerRight,
                            //   width: 30.w,
                            //   child: Text(
                            //     SessionController().getLanguage() == 1
                            //         ? widget
                            //                 .lDReportController
                            //                 .chequeRegisterReportModel
                            //                 .value
                            //                 .serviceRequests[widget.index!]
                            //                 .chequeStatus ??
                            //             ""
                            //         : widget
                            //                 .lDReportController
                            //                 .chequeRegisterReportModel
                            //                 .value
                            //                 .serviceRequests[widget.index!]
                            //                 .chequeStatusAR ??
                            //             "",
                            //     textAlign: TextAlign.end,
                            //     style: AppTextStyle.semiBoldBlack11,
                            //     maxLines: 1,
                            //   ),
                            // ),
                          ],
                        ),
                        SizedBox(
                          height: 1.2.h,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        widget.index ==
                widget.lDReportController!.chequeRegisterReportModel.value
                        .totalRecord! -
                    1
            ? SizedBox()
            : AppDivider(),
      ],
    );
  }
}

class BuildingStatusReportSummaryWidget extends StatefulWidget {
  final int? index;
  final LandLordReportPropController? lDReportController;
  const BuildingStatusReportSummaryWidget(
      {Key? key, @required this.index, @required this.lDReportController})
      : super(key: key);

  @override
  State<BuildingStatusReportSummaryWidget> createState() =>
      _BuildingStatusReportSummaryWidgetState();
}

class _BuildingStatusReportSummaryWidgetState
    extends State<BuildingStatusReportSummaryWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 1.0.h,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 4.w,
            ),
            Padding(
              padding: EdgeInsets.only(left: 1.0.h, bottom: 1.h, right: 1.0.h),
              child: Row(
                children: [
                  Container(
                    width: 78.0.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              width: 78.w,
                              child: Text(
                                SessionController().getLanguage() == 1
                                    ? widget
                                            .lDReportController!
                                            .buildingStatusReportModel
                                            .value
                                            .serviceRequests![widget.index!]
                                            .propertyName ??
                                        "--"
                                    : widget
                                            .lDReportController!
                                            .buildingStatusReportModel
                                            .value
                                            .serviceRequests![widget.index!]
                                            .propertyNameAR ??
                                        "--",
                                style: AppTextStyle.semiBoldBlack11,
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1.0.h,
                        ),
                        SizedBox(
                          height: 1.0.h,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            SessionController().getLanguage() == 1
                                ? widget
                                        .lDReportController!
                                        .buildingStatusReportModel
                                        .value
                                        .serviceRequests![widget.index!]
                                        .landlordName ??
                                    '--'
                                : widget
                                        .lDReportController!
                                        .buildingStatusReportModel
                                        .value
                                        .serviceRequests![widget.index!]
                                        .landlordNameAR ??
                                    "--",
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyle.normalGrey10,
                            maxLines: 2,
                          ),
                        ),
                        SizedBox(
                          height: 1.0.h,
                        ),
                        Row(
                          children: [
                            Text(
                              AppMetaLabels().emirate,
                              style: AppTextStyle.normalGrey11,
                            ),
                            Spacer(),
                            Container(
                              alignment: Alignment.centerRight,
                              width: 38.w,
                              child: Text(
                                SessionController().getLanguage() == 1
                                    ? widget
                                            .lDReportController!
                                            .buildingStatusReportModel
                                            .value
                                            .serviceRequests![widget.index!]
                                            .emirateName ??
                                        "--"
                                    : widget
                                            .lDReportController!
                                            .buildingStatusReportModel
                                            .value
                                            .serviceRequests![widget.index!]
                                            .emirateNameAR ??
                                        "--",
                                style: AppTextStyle.normalGrey10,
                                textAlign: TextAlign.end,
                                maxLines: 3,
                              ),
                            ),
                          ],
                        ),
                        widget
                                        .lDReportController!
                                        .buildingStatusReportModel
                                        .value
                                        .serviceRequests![widget.index!]
                                        .tenantName ==
                                    '' ||
                                widget
                                        .lDReportController!
                                        .buildingStatusReportModel
                                        .value
                                        .serviceRequests![widget.index!]
                                        .tenantName ==
                                    null ||
                                widget
                                        .lDReportController!
                                        .buildingStatusReportModel
                                        .value
                                        .serviceRequests![widget.index!]
                                        .tenantNameAR ==
                                    '' ||
                                widget
                                        .lDReportController!
                                        .buildingStatusReportModel
                                        .value
                                        .serviceRequests![widget.index!]
                                        .tenantNameAR ==
                                    null
                            ? SizedBox()
                            : SizedBox(
                                height: 1.2.h,
                              ),
                        widget
                                        .lDReportController!
                                        .buildingStatusReportModel
                                        .value
                                        .serviceRequests![widget.index!]
                                        .tenantName ==
                                    '' ||
                                widget
                                        .lDReportController!
                                        .buildingStatusReportModel
                                        .value
                                        .serviceRequests![widget.index!]
                                        .tenantName ==
                                    null ||
                                widget
                                        .lDReportController!
                                        .buildingStatusReportModel
                                        .value
                                        .serviceRequests![widget.index!]
                                        .tenantNameAR ==
                                    '' ||
                                widget
                                        .lDReportController!
                                        .buildingStatusReportModel
                                        .value
                                        .serviceRequests![widget.index!]
                                        .tenantNameAR ==
                                    null
                            ? SizedBox()
                            : Row(
                                children: [
                                  Text(
                                    AppMetaLabels().tenant +
                                        ' ' +
                                        AppMetaLabels().name,
                                    style: AppTextStyle.normalGrey11,
                                  ),
                                  Spacer(),
                                  Container(
                                    alignment: Alignment.centerRight,
                                    width: 38.w,
                                    child: Text(
                                      SessionController().getLanguage() == 1
                                          ? widget
                                              .lDReportController!
                                              .buildingStatusReportModel
                                              .value
                                              .serviceRequests![widget.index!]
                                              .tenantName
                                              .toString()
                                          : widget
                                              .lDReportController!
                                              .buildingStatusReportModel
                                              .value
                                              .serviceRequests![widget.index!]
                                              .tenantNameAR
                                              .toString(),
                                      textAlign: TextAlign.end,
                                      style: AppTextStyle.normalGrey10,
                                      maxLines: 3,
                                    ),
                                  ),
                                ],
                              ),
                        SizedBox(
                          height: 1.2.h,
                        ),
                        Row(
                          children: [
                            Text(
                              AppMetaLabels().unitType,
                              style: AppTextStyle.normalGrey10,
                            ),
                            Spacer(),
                            Container(
                              alignment: SessionController().getLanguage() == 1
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              width: 58.w,
                              child: Text(
                                SessionController().getLanguage() == 1
                                    ? widget
                                            .lDReportController!
                                            .buildingStatusReportModel
                                            .value
                                            .serviceRequests![widget.index!]
                                            .unitType ??
                                        "--"
                                    : widget
                                            .lDReportController!
                                            .buildingStatusReportModel
                                            .value
                                            .serviceRequests![widget.index!]
                                            .unitTypeAR ??
                                        "--",
                                style: AppTextStyle.normalGrey10,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1.0.h,
                        ),
                        Row(
                          children: [
                            Text(
                              AppMetaLabels().unitCatgLand,
                              style: AppTextStyle.normalGrey10,
                            ),
                            Spacer(),
                            Container(
                              alignment: SessionController().getLanguage() == 1
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              width: 53.w,
                              child: Text(
                                SessionController().getLanguage() == 1
                                    ? widget
                                            .lDReportController!
                                            .buildingStatusReportModel
                                            .value
                                            .serviceRequests![widget.index!]
                                            .unitCategory ??
                                        "--"
                                    : widget
                                            .lDReportController!
                                            .buildingStatusReportModel
                                            .value
                                            .serviceRequests![widget.index!]
                                            .unitCategoryAR ??
                                        "--",
                                style: AppTextStyle.normalGrey10,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1.0.h,
                        ),
                        Row(
                          children: [
                            Text(
                              AppMetaLabels().rent,
                              style: AppTextStyle.normalGrey11,
                            ),
                            Spacer(),
                            Container(
                              alignment: Alignment.centerRight,
                              width: 38.w,
                              child: Text(
                                '${AppMetaLabels().aed} ${widget.lDReportController!.buildingStatusReportModel.value.serviceRequests![widget.index!].rent.toString()}',
                                style: AppTextStyle.normalGrey10,
                                textAlign: TextAlign.end,
                                maxLines: 3,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1.2.h,
                        ),
                        Row(
                          children: [
                            Text(
                              AppMetaLabels().received,
                              style: AppTextStyle.normalGrey10,
                            ),
                            Spacer(),
                            Container(
                              alignment: Alignment.centerRight,
                              child: Text(
                                '${AppMetaLabels().aed} ${widget.lDReportController!.buildingStatusReportModel.value.serviceRequests![widget.index!].recived.toString()}',
                                textAlign: TextAlign.end,
                                style: AppTextStyle.normalGrey10,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            Text(
                              AppMetaLabels().balance,
                              style: AppTextStyle.normalGrey10,
                            ),
                            Spacer(),
                            Container(
                              alignment: Alignment.centerRight,
                              child: Text(
                                '${AppMetaLabels().aed} ${widget.lDReportController!.buildingStatusReportModel.value.serviceRequests![widget.index!].balance.toString()}',
                                textAlign: TextAlign.end,
                                style: AppTextStyle.normalGrey10,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            Text(AppMetaLabels().status,
                                style: AppTextStyle.semiBoldBlack10),
                            Spacer(),
                            Container(
                              alignment: Alignment.centerRight,
                              width: 22.w,
                              child: StatusWidget(
                                  text: SessionController().getLanguage() == 1
                                      ? widget
                                          .lDReportController!
                                          .buildingStatusReportModel
                                          .value
                                          .serviceRequests![widget.index!]
                                          .contractStatus
                                          .toString()
                                      : widget
                                          .lDReportController!
                                          .buildingStatusReportModel
                                          .value
                                          .serviceRequests![widget.index!]
                                          .contractStatusAR
                                          .toString(),
                                  valueToCompare: widget
                                      .lDReportController!
                                      .buildingStatusReportModel
                                      .value
                                      .serviceRequests![widget.index!]
                                      .contractStatus
                                      .toString()),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        widget.index ==
                widget.lDReportController!.buildingStatusReportModel.value
                        .totalRecord! -
                    1
            ? SizedBox()
            : AppDivider(),
      ],
    );
  }
}

class AMCReportSummaryWidget extends StatefulWidget {
  final int? index;
  final LandLordReportPropController? lDReportController;
  const AMCReportSummaryWidget(
      {Key? key, @required this.index, @required this.lDReportController})
      : super(key: key);

  @override
  State<AMCReportSummaryWidget> createState() => _AMCReportSummaryWidgetState();
}

class _AMCReportSummaryWidgetState extends State<AMCReportSummaryWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 1.0.h,
        ),
        Padding(
          padding: EdgeInsets.only(left: 2.0.h, bottom: 1.h, right: 2.0.h),
          child: Row(
            children: [
              Container(
                width: 80.0.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    widget
                                    .lDReportController!
                                    .amcRepportModel
                                    .value
                                    .serviceRequests![widget.index!]
                                    .propertyName ==
                                "" ||
                            widget
                                    .lDReportController!
                                    .amcRepportModel
                                    .value
                                    .serviceRequests![widget.index!]
                                    .propertyName ==
                                null ||
                            widget
                                    .lDReportController!
                                    .amcRepportModel
                                    .value
                                    .serviceRequests![widget.index!]
                                    .propertyNameAR ==
                                "" ||
                            widget
                                    .lDReportController!
                                    .amcRepportModel
                                    .value
                                    .serviceRequests![widget.index!]
                                    .propertyNameAR ==
                                null
                        ? SizedBox()
                        : Row(
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                width: 78.w,
                                child: Text(
                                  SessionController().getLanguage() == 1
                                      ? widget
                                              .lDReportController!
                                              .amcRepportModel
                                              .value
                                              .serviceRequests![widget.index!]
                                              .propertyName ??
                                          "--"
                                      : widget
                                              .lDReportController!
                                              .amcRepportModel
                                              .value
                                              .serviceRequests![widget.index!]
                                              .propertyNameAR ??
                                          "--",
                                  style: AppTextStyle.semiBoldBlack11,
                                  maxLines: 2,
                                ),
                              ),
                            ],
                          ),
                    widget
                                    .lDReportController!
                                    .amcRepportModel
                                    .value
                                    .serviceRequests![widget.index!]
                                    .ownerNameAR ==
                                "" ||
                            widget
                                    .lDReportController!
                                    .amcRepportModel
                                    .value
                                    .serviceRequests![widget.index!]
                                    .ownerNameAR ==
                                null ||
                            widget
                                    .lDReportController!
                                    .amcRepportModel
                                    .value
                                    .serviceRequests![widget.index!]
                                    .ownerNameAR ==
                                "" ||
                            widget
                                    .lDReportController!
                                    .amcRepportModel
                                    .value
                                    .serviceRequests![widget.index!]
                                    .ownerNameAR ==
                                null
                        ? SizedBox()
                        : SizedBox(
                            height: 1.0.h,
                          ),
                    widget
                                    .lDReportController!
                                    .amcRepportModel
                                    .value
                                    .serviceRequests![widget.index!]
                                    .ownerNameAR ==
                                "" ||
                            widget
                                    .lDReportController!
                                    .amcRepportModel
                                    .value
                                    .serviceRequests![widget.index!]
                                    .ownerNameAR ==
                                null ||
                            widget
                                    .lDReportController!
                                    .amcRepportModel
                                    .value
                                    .serviceRequests![widget.index!]
                                    .ownerNameAR ==
                                "" ||
                            widget
                                    .lDReportController!
                                    .amcRepportModel
                                    .value
                                    .serviceRequests![widget.index!]
                                    .ownerNameAR ==
                                null
                        ? SizedBox()
                        : Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              SessionController().getLanguage() == 1
                                  ? widget
                                          .lDReportController!
                                          .amcRepportModel
                                          .value
                                          .serviceRequests![widget.index!]
                                          .ownerName ??
                                      '--'
                                  : widget
                                          .lDReportController!
                                          .amcRepportModel
                                          .value
                                          .serviceRequests![widget.index!]
                                          .ownerNameAR ??
                                      "--",
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyle.normalGrey10,
                              maxLines: 2,
                            ),
                          ),
                    SizedBox(
                      height: 1.0.h,
                    ),
                    widget
                                    .lDReportController!
                                    .amcRepportModel
                                    .value
                                    .serviceRequests![widget.index!]
                                    .contractCategory ==
                                "" ||
                            widget
                                    .lDReportController!
                                    .amcRepportModel
                                    .value
                                    .serviceRequests![widget.index!]
                                    .contractCategory ==
                                null ||
                            widget
                                    .lDReportController!
                                    .amcRepportModel
                                    .value
                                    .serviceRequests![widget.index!]
                                    .contractCategory ==
                                "" ||
                            widget
                                    .lDReportController!
                                    .amcRepportModel
                                    .value
                                    .serviceRequests![widget.index!]
                                    .contractCategory ==
                                null
                        ? SizedBox()
                        : Row(
                            children: [
                              Text(
                                AppMetaLabels().contract +
                                    ' ' +
                                    AppMetaLabels().category,
                                style: AppTextStyle.normalGrey11,
                              ),
                              Spacer(),
                              Container(
                                alignment: Alignment.centerRight,
                                width: 38.w,
                                child: Text(
                                  SessionController().getLanguage() == 1
                                      ? widget
                                              .lDReportController!
                                              .amcRepportModel
                                              .value
                                              .serviceRequests![widget.index!]
                                              .contractCategory ??
                                          ""
                                      : widget
                                              .lDReportController!
                                              .amcRepportModel
                                              .value
                                              .serviceRequests![widget.index!]
                                              .contractCategory ??
                                          "",
                                  style: AppTextStyle.normalGrey10,
                                  textAlign: TextAlign.end,
                                  maxLines: 3,
                                ),
                              ),
                            ],
                          ),
                    widget
                                    .lDReportController!
                                    .amcRepportModel
                                    .value
                                    .serviceRequests![widget.index!]
                                    .contractCategory ==
                                "" ||
                            widget
                                    .lDReportController!
                                    .amcRepportModel
                                    .value
                                    .serviceRequests![widget.index!]
                                    .contractCategory ==
                                null ||
                            widget
                                    .lDReportController!
                                    .amcRepportModel
                                    .value
                                    .serviceRequests![widget.index!]
                                    .contractCategory ==
                                "" ||
                            widget
                                    .lDReportController!
                                    .amcRepportModel
                                    .value
                                    .serviceRequests![widget.index!]
                                    .contractCategory ==
                                null
                        ? SizedBox()
                        : SizedBox(
                            height: 1.2.h,
                          ),
                    widget
                                    .lDReportController!
                                    .amcRepportModel
                                    .value
                                    .serviceRequests![widget.index!]
                                    .contractor ==
                                "" ||
                            widget
                                    .lDReportController!
                                    .amcRepportModel
                                    .value
                                    .serviceRequests![widget.index!]
                                    .contractor ==
                                null ||
                            widget
                                    .lDReportController!
                                    .amcRepportModel
                                    .value
                                    .serviceRequests![widget.index!]
                                    .contractor ==
                                "" ||
                            widget
                                    .lDReportController!
                                    .amcRepportModel
                                    .value
                                    .serviceRequests![widget.index!]
                                    .contractor ==
                                null
                        ? SizedBox()
                        : Row(
                            children: [
                              Text(
                                AppMetaLabels().contractor1,
                                style: AppTextStyle.normalGrey11,
                              ),
                              Spacer(),
                              Container(
                                alignment: Alignment.centerRight,
                                width: 38.w,
                                child: Text(
                                  SessionController().getLanguage() == 1
                                      ? widget
                                              .lDReportController!
                                              .amcRepportModel
                                              .value
                                              .serviceRequests![widget.index!]
                                              .contractor ??
                                          ""
                                      : widget
                                              .lDReportController!
                                              .amcRepportModel
                                              .value
                                              .serviceRequests![widget.index!]
                                              .contractorAR ??
                                          "",
                                  textAlign: TextAlign.end,
                                  style: AppTextStyle.normalGrey10,
                                  maxLines: 3,
                                ),
                              ),
                            ],
                          ),
                    widget
                                    .lDReportController!
                                    .amcRepportModel
                                    .value
                                    .serviceRequests![widget.index!]
                                    .contractor ==
                                "" ||
                            widget
                                    .lDReportController!
                                    .amcRepportModel
                                    .value
                                    .serviceRequests![widget.index!]
                                    .contractor ==
                                null ||
                            widget
                                    .lDReportController!
                                    .amcRepportModel
                                    .value
                                    .serviceRequests![widget.index!]
                                    .contractor ==
                                "" ||
                            widget
                                    .lDReportController!
                                    .amcRepportModel
                                    .value
                                    .serviceRequests![widget.index!]
                                    .contractor ==
                                null
                        ? SizedBox()
                        : SizedBox(
                            height: 1.2.h,
                          ),
                    widget
                                    .lDReportController!
                                    .amcRepportModel
                                    .value
                                    .serviceRequests![widget.index!]
                                    .contractTotalAmount ==
                                "" ||
                            widget
                                    .lDReportController!
                                    .amcRepportModel
                                    .value
                                    .serviceRequests![widget.index!]
                                    .contractTotalAmount ==
                                null ||
                            widget
                                    .lDReportController!
                                    .amcRepportModel
                                    .value
                                    .serviceRequests![widget.index!]
                                    .contractTotalAmount ==
                                "" ||
                            widget
                                    .lDReportController!
                                    .amcRepportModel
                                    .value
                                    .serviceRequests![widget.index!]
                                    .contractTotalAmount ==
                                null
                        ? SizedBox()
                        : Row(
                            children: [
                              Text(
                                AppMetaLabels().contractTotalAmount,
                                style: AppTextStyle.normalGrey11,
                              ),
                              Spacer(),
                              Container(
                                alignment: Alignment.centerRight,
                                width: 30.w,
                                child: Text(
                                  '${AppMetaLabels().aed} ${widget.lDReportController!.amcRepportModel.value.serviceRequests![widget.index!].contractTotalAmount.toString()}',
                                  textAlign: TextAlign.end,
                                  style: AppTextStyle.normalGrey10,
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                    widget
                                    .lDReportController!
                                    .amcRepportModel
                                    .value
                                    .serviceRequests![widget.index!]
                                    .contractTotalAmount ==
                                "" ||
                            widget
                                    .lDReportController!
                                    .amcRepportModel
                                    .value
                                    .serviceRequests![widget.index!]
                                    .contractTotalAmount ==
                                null ||
                            widget
                                    .lDReportController!
                                    .amcRepportModel
                                    .value
                                    .serviceRequests![widget.index!]
                                    .contractTotalAmount ==
                                "" ||
                            widget
                                    .lDReportController!
                                    .amcRepportModel
                                    .value
                                    .serviceRequests![widget.index!]
                                    .contractTotalAmount ==
                                null
                        ? SizedBox()
                        : SizedBox(
                            height: 1.2.h,
                          ),
                    widget
                                    .lDReportController!
                                    .amcRepportModel
                                    .value
                                    .serviceRequests![widget.index!]
                                    .contractAnnualAmount ==
                                "" ||
                            widget
                                    .lDReportController!
                                    .amcRepportModel
                                    .value
                                    .serviceRequests![widget.index!]
                                    .contractAnnualAmount ==
                                null ||
                            widget
                                    .lDReportController!
                                    .amcRepportModel
                                    .value
                                    .serviceRequests![widget.index!]
                                    .contractAnnualAmount ==
                                "" ||
                            widget
                                    .lDReportController!
                                    .amcRepportModel
                                    .value
                                    .serviceRequests![widget.index!]
                                    .contractAnnualAmount ==
                                null
                        ? SizedBox()
                        : Row(
                            children: [
                              Text(
                                AppMetaLabels().contractAnnualAmount,
                                style: AppTextStyle.normalGrey11,
                              ),
                              Spacer(),
                              Container(
                                alignment: Alignment.centerRight,
                                width: 30.w,
                                child: Text(
                                  '${AppMetaLabels().aed} ${widget.lDReportController!.amcRepportModel.value.serviceRequests![widget.index!].contractAnnualAmount.toString()}',
                                  textAlign: TextAlign.end,
                                  style: AppTextStyle.normalGrey10,
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                    SizedBox(
                      height: 1.2.h,
                    ),
                    Row(
                      children: [
                        Text(
                          AppMetaLabels().contractValueUnPaid,
                          style: AppTextStyle.normalGrey11,
                        ),
                        Spacer(),
                        Container(
                          alignment: Alignment.centerRight,
                          width: 30.w,
                          child: Text(
                            '${AppMetaLabels().aed} ${widget.lDReportController!.amcRepportModel.value.serviceRequests![widget.index!].contractValueUnPaid.toString()}',
                            textAlign: TextAlign.end,
                            style: AppTextStyle.normalGrey10,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 1.2.h,
                    ),
                    Row(
                      children: [
                        Text(
                          AppMetaLabels().paidCharges,
                          style: AppTextStyle.normalGrey11,
                        ),
                        Spacer(),
                        Container(
                          alignment: Alignment.centerRight,
                          width: 38.w,
                          child: Text(
                            '${AppMetaLabels().aed} ${widget.lDReportController!.amcRepportModel.value.serviceRequests![widget.index!].paidAmount.toString()}',
                            textAlign: TextAlign.end,
                            style: AppTextStyle.normalGrey10,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 1.2.h,
                    ),
                    Row(
                      children: [
                        Text(
                          AppMetaLabels().balance,
                          style: AppTextStyle.semiBoldBlack11,
                        ),
                        Spacer(),
                        Container(
                          alignment: Alignment.centerRight,
                          width: 38.w,
                          child: Text(
                            '${AppMetaLabels().aed} ${widget.lDReportController!.amcRepportModel.value.serviceRequests![widget.index!].balance.toString()}',
                            style: AppTextStyle.semiBoldBlack11,
                            textAlign: TextAlign.end,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        widget.index ==
                widget.lDReportController!.amcRepportModel.value.totalRecord! -
                    1
            ? SizedBox()
            : AppDivider(),
      ],
    );
  }
}
