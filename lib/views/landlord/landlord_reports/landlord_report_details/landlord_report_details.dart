// ignore_for_file: unrelated_type_equality_checks, unused_local_variable, unnecessary_null_comparison

import 'dart:isolate';
import 'dart:ui';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/screen_disable.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/landlord/landlord_reports/landlord_report_details/landlord_report_controller.dart';
import 'package:fap_properties/views/landlord/landlord_reports/landlord_report_details/landlord_report_property/landlord_report_properties.dart';
import 'package:fap_properties/views/landlord/landlord_reports/landlord_report_details/landlord_summary_report.dart';
import 'package:fap_properties/views/widgets/clear_button.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:fap_properties/views/widgets/custom_app_bar2.dart';
import 'package:fap_properties/views/widgets/snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';
import 'package:fap_properties/data/models/landlord_models/report/get_dropdown_model.dart'
    as dropDownModel;

class LandLordReportDetails extends StatefulWidget {
  final String? fileNmae;
  const LandLordReportDetails({Key? key, this.fileNmae}) : super(key: key);

  @override
  _LandLordReportDetailsState createState() => _LandLordReportDetailsState();
}

class _LandLordReportDetailsState extends State<LandLordReportDetails> {
  final LandLordReportPropController lDReportController =
      Get.put(LandLordReportPropController());
  //  final LandlordPropertiesController controller = Get.find();
  bool isButtonEnable = false;
  bool isTapOnDownload = false;
  bool isDownloaded = false;

  bool isEnableScreen = true;
  bool isLoading = false;

  @override
  void initState() {
    initForSetState();
    getPermission();
    print('File Name :::::  ${widget.fileNmae}');
    lDReportController.resetValues();
    super.initState();
  }

  getPermission() async {
    await Permission.storage.request();
  }

  ReceivePort _recivePort = ReceivePort();
  initForSetState() {
    setState(() {
      print('testing ::::');
      lDReportController.selectedPropType.value =
          dropDownModel.ServiceRequests();
      lDReportController.selectedcontractorType.value =
          dropDownModel.ServiceRequests();
      lDReportController.selectedcontractCategoryType.value =
          dropDownModel.ServiceRequests();
      lDReportController.selectedserviceContractStatusType.value =
          dropDownModel.ServiceRequests();
      // lDReportController.selectedPropType.value = null;
      // lDReportController.selectedcontractorType.value = null;
      // lDReportController.selectedcontractCategoryType.value = null;
      // lDReportController.selectedserviceContractStatusType.value = null;
    });
    IsolateNameServer.registerPortWithName(
        _recivePort.sendPort, 'downloader_send_port');
    _recivePort.listen((dynamic data) async {
      // String id = data[0];
      // DownloadTaskStatus status = data[1];

      print('::::: data[0] :::::: ${data[0]}');
      print('::::: data[0] :::::: ${data[1]}');

      int progress = data[2];
      setState(() {});
      //
      if (DownloadTaskStatus.canceled == true) {
        setState(() {
          isDownloaded = false;
          isTapOnDownload = false;
        });
        SnakBarWidget.getSnackBarErrorBlue('cancled', 'File Download Failed');
      } else if (progress == 100) {
        if (isDownloaded == false) {
          await SnakBarWidget.getSnackBarErrorBlue(
              'File Download', 'File Downloaded Successfully');
        }
        setState(() {
          isDownloaded = true;
          isTapOnDownload = false;
        });
        setState(() {});
      } else if (progress < 0) {
        SnakBarWidget.getSnackBarError('Failed', 'File Download Failed');
        setState(() {
          isDownloaded = false;
          isTapOnDownload = false;
        });
        setState(() {});
      } else {
        print('***:::*****:::::');
        // print(status);
        print('***:::*****:::::');
      }
    });
    // FlutterDownloader.registerCallback(downloadingCallBack as DownloadCallback);
    setState(() {});
  }

  // downloadingCallBack() when downloading complete then whatever we want to do we can

  @pragma('vm:entry-point')
  static downloadingCallBack(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort? sendPort =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    sendPort?.send([id, status, progress]);
    // sendPort?.send([id, status, progress]);
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.fileNmae == 'Occupancy Vacancy Register Report') {
      setState(() {
        isButtonEnable = true;
      });
    }
    return Directionality(
      textDirection: SessionController().getLanguage() == 1
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    CustomAppBar2(
                      title: widget.fileNmae ?? "",
                      // title: AppMetaLabels().report,
                    ),
                    Padding(
                      padding: EdgeInsets.all(2.0.h),
                      child: Obx(() {
                        return Container(
                          width: 100.0.w,
                          // height: lDReportController.filterError.value == ""
                          //     ? 25.h
                          //     : 28.0.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(2.0.h),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 0.5.h,
                                spreadRadius: 0.1.h,
                                offset: Offset(0.1.h, 0.1.h),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(2.0.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Property
                                SizedBox(
                                  height: 1.0.h,
                                ),
                                Text(
                                  widget.fileNmae == 'Building Status Report' ||
                                          widget.fileNmae ==
                                              'Unit Status Report'
                                      ? AppMetaLabels().property + ' *'
                                      : AppMetaLabels().property,
                                  style: AppTextStyle.normalGrey10,
                                ),
                                SizedBox(
                                  height: 1.0.h,
                                ),
                                InkWell(
                                  onTap: () async {
                                    lDReportController.selectedPropType.value =
                                        await Get.to(
                                            () => LandlordReportProperties(
                                                  dropDownType: '4',
                                                ));

                                    if (lDReportController
                                            .selectedPropType.value ==
                                        null) {
                                      print(
                                          'TEsting :::::: ${lDReportController.selectedPropType.value}');
                                      return;
                                    }
                                    if (lDReportController
                                            .selectedPropType.value !=
                                        null) {
                                      if (lDReportController.fromDate.value !=
                                              '' &&
                                          lDReportController.toDate.value !=
                                              '') {
                                        setState(() {
                                          isButtonEnable = true;
                                        });
                                      } else {
                                        setState(() {
                                          isButtonEnable = false;
                                        });
                                      }
                                      if (widget.fileNmae ==
                                              'Building Status Report' ||
                                          widget.fileNmae ==
                                              'Unit Status Report') {
                                        if (lDReportController
                                                .selectedPropType.value !=
                                            null) {
                                          setState(() {
                                            isButtonEnable = true;
                                          });
                                        } else {
                                          setState(() {
                                            isButtonEnable = false;
                                          });
                                        }
                                      }
                                      setState(() {
                                        isDownloaded = false;
                                        isTapOnDownload = false;
                                        isDownloaded = false;
                                      });

                                      // lDReportController.propType.value =
                                      //     lDReportController.selectedPropType;
                                    }
                                    setState(() {});
                                  },
                                  child: Container(
                                    width: 100.0.w,
                                    height: 5.5.h,
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(246, 248, 249, 1),
                                      borderRadius:
                                          BorderRadius.circular(0.5.h),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: 1.5.h, right: 1.5.h),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: Get.width * 0.6,
                                            child: Text(
                                              lDReportController
                                                          .selectedPropType
                                                          .value ==
                                                      null
                                                  ? ''
                                                  : SessionController()
                                                              .getLanguage() ==
                                                          1
                                                      ? lDReportController
                                                              .selectedPropType
                                                              .value
                                                              .name ??
                                                          ''
                                                      : lDReportController
                                                              .selectedPropType
                                                              .value
                                                              .nameAr ??
                                                          '',
                                              style: AppTextStyle.normalBlack12,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                            ),
                                          ),
                                          Spacer(),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 0.1),
                                            child: ClearButton(
                                              clear: () {
                                                setState(() {
                                                  lDReportController
                                                          .selectedPropType
                                                          .value =
                                                      dropDownModel
                                                          .ServiceRequests();
                                                  ;
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 1.5.h,
                                ),

                                // Cheque Status
                                widget.fileNmae == 'Cheque Register Report'
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppMetaLabels().cheque +
                                                ' ' +
                                                AppMetaLabels().status,
                                            style: AppTextStyle.normalGrey10,
                                          ),
                                          SizedBox(
                                            height: 1.0.h,
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              lDReportController
                                                      .selectedChequeStatus
                                                      .value =
                                                  await Get.to(() =>
                                                      LandlordReportProperties(
                                                        dropDownType: '7',
                                                      ));
                                              if (lDReportController
                                                      .selectedChequeStatus
                                                      .value !=
                                                  null) {
                                                if (lDReportController
                                                            .fromDate.value !=
                                                        '' &&
                                                    lDReportController
                                                            .toDate.value !=
                                                        '') {
                                                  setState(() {
                                                    isButtonEnable = true;
                                                  });
                                                } else {
                                                  setState(() {
                                                    isButtonEnable = false;
                                                  });
                                                }
                                                setState(() {
                                                  isDownloaded = false;
                                                  isTapOnDownload = false;
                                                  isDownloaded = false;
                                                });

                                                // lDReportController.propType.value =
                                                //     lDReportController.selectedPropType;
                                              }
                                              setState(() {});
                                            },
                                            child: Container(
                                              width: 100.0.w,
                                              height: 5.0.h,
                                              decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    246, 248, 249, 1),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        0.5.h),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 1.5.h, right: 1.5.h),
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: Get.width * 0.6,
                                                      child: Text(
                                                        lDReportController
                                                                    .selectedChequeStatus
                                                                    .value ==
                                                                null
                                                            ? ''
                                                            : SessionController()
                                                                        .getLanguage() ==
                                                                    1
                                                                ? lDReportController
                                                                        .selectedChequeStatus
                                                                        .value
                                                                        .name ??
                                                                    ''
                                                                : lDReportController
                                                                        .selectedChequeStatus
                                                                        .value
                                                                        .nameAr ??
                                                                    '',
                                                        style: AppTextStyle
                                                            .normalBlack12,
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 0.1),
                                                      child: ClearButton(
                                                        clear: () {
                                                          setState(() {
                                                            lDReportController
                                                                    .selectedChequeStatus
                                                                    .value =
                                                                dropDownModel
                                                                    .ServiceRequests();
                                                            ;
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : SizedBox(),

                                // Unit Status
                                widget.fileNmae == 'Unit Status Report'
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppMetaLabels().unit +
                                                ' ' +
                                                AppMetaLabels().status,
                                            style: AppTextStyle.normalGrey10,
                                          ),
                                          SizedBox(
                                            height: 1.0.h,
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              lDReportController
                                                      .selectedUnitStatus
                                                      .value =
                                                  await Get.to(() =>
                                                      LandlordReportProperties(
                                                        dropDownType: '6',
                                                      ));
                                              if (lDReportController
                                                      .selectedUnitStatus
                                                      .value !=
                                                  null) {
                                                setState(() {
                                                  isDownloaded = false;
                                                  isTapOnDownload = false;
                                                  isDownloaded = false;
                                                });

                                                // lDReportController.propType.value =
                                                //     lDReportController.selectedPropType;
                                              }
                                              setState(() {});
                                            },
                                            child: Container(
                                              width: 100.0.w,
                                              height: 5.0.h,
                                              decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    246, 248, 249, 1),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        0.5.h),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 1.5.h, right: 1.5.h),
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: Get.width * 0.6,
                                                      child: Text(
                                                        lDReportController
                                                                    .selectedUnitStatus
                                                                    .value ==
                                                                null
                                                            ? ''
                                                            : SessionController()
                                                                        .getLanguage() ==
                                                                    1
                                                                ? lDReportController
                                                                        .selectedUnitStatus
                                                                        .value
                                                                        .name ??
                                                                    ''
                                                                : lDReportController
                                                                        .selectedUnitStatus
                                                                        .value
                                                                        .nameAr ??
                                                                    '',
                                                        style: AppTextStyle
                                                            .normalBlack12,
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 0.1),
                                                      child: ClearButton(
                                                        clear: () {
                                                          setState(() {
                                                            lDReportController
                                                                    .selectedUnitStatus
                                                                    .value =
                                                                dropDownModel
                                                                    .ServiceRequests();
                                                            ;
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : SizedBox(),

                                // Contractor
                                widget.fileNmae == 'AMC Report' ||
                                        widget.fileNmae == 'LPO Report'
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppMetaLabels().contractor1,
                                            style: AppTextStyle.normalGrey10,
                                          ),
                                          SizedBox(
                                            height: 1.0.h,
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              lDReportController
                                                      .selectedcontractorType
                                                      .value =
                                                  await Get.to(() =>
                                                      LandlordReportProperties(
                                                        dropDownType: '3',
                                                      ));
                                              if (lDReportController
                                                      .selectedcontractorType
                                                      .value !=
                                                  null) {
                                                if (lDReportController
                                                            .fromDate.value !=
                                                        '' &&
                                                    lDReportController
                                                            .toDate.value !=
                                                        '') {
                                                  setState(() {
                                                    isButtonEnable = true;
                                                  });
                                                } else {
                                                  setState(() {
                                                    isButtonEnable = false;
                                                  });
                                                }
                                                setState(() {
                                                  isDownloaded = false;
                                                  isTapOnDownload = false;
                                                  isDownloaded = false;
                                                });

                                                // lDReportController.propType.value =
                                                //     propType;
                                              }
                                              setState(() {});
                                            },
                                            child: Container(
                                              width: 100.0.w,
                                              height: 5.0.h,
                                              decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    246, 248, 249, 1),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        0.5.h),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 1.5.h, right: 1.5.h),
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: Get.width * 0.6,
                                                      child: Text(
                                                        lDReportController
                                                                    .selectedcontractorType
                                                                    .value ==
                                                                null
                                                            ? ''
                                                            : SessionController()
                                                                        .getLanguage() ==
                                                                    1
                                                                ? lDReportController
                                                                        .selectedcontractorType
                                                                        .value
                                                                        .name ??
                                                                    ''
                                                                : lDReportController
                                                                        .selectedcontractorType
                                                                        .value
                                                                        .nameAr ??
                                                                    '',
                                                        style: AppTextStyle
                                                            .normalBlack12,
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 0.1),
                                                      child: ClearButton(
                                                        clear: () {
                                                          setState(() {
                                                            lDReportController
                                                                    .selectedcontractorType
                                                                    .value =
                                                                dropDownModel
                                                                    .ServiceRequests();
                                                            ;
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : SizedBox(),
                                widget.fileNmae == 'AMC Report' ||
                                        widget.fileNmae == 'LPO Report'
                                    ? SizedBox(
                                        height: 1.5.h,
                                      )
                                    : SizedBox(),

                                // ContractCategory
                                widget.fileNmae == "AMC Report" ||
                                        widget.fileNmae == "LPO Report"
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppMetaLabels().contract +
                                                ' ' +
                                                AppMetaLabels().category,
                                            style: AppTextStyle.normalGrey10,
                                          ),
                                          SizedBox(
                                            height: 1.0.h,
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              lDReportController
                                                      .selectedcontractCategoryType
                                                      .value =
                                                  await Get.to(() =>
                                                      LandlordReportProperties(
                                                        dropDownType: '2',
                                                      ));
                                              if (lDReportController
                                                      .selectedcontractCategoryType
                                                      .value !=
                                                  null) {
                                                if (lDReportController
                                                            .fromDate.value !=
                                                        '' &&
                                                    lDReportController
                                                            .toDate.value !=
                                                        '') {
                                                  setState(() {
                                                    isButtonEnable = true;
                                                  });
                                                } else {
                                                  setState(() {
                                                    isButtonEnable = false;
                                                  });
                                                }
                                                setState(() {
                                                  // isButtonEnable = true;
                                                  isDownloaded = false;
                                                  isTapOnDownload = false;
                                                  isDownloaded = false;
                                                });

                                                // lDReportController.propType.value =
                                                //     propType;
                                              }
                                              setState(() {});
                                            },
                                            child: Container(
                                              width: 100.0.w,
                                              height: 5.0.h,
                                              decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    246, 248, 249, 1),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        0.5.h),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 1.5.h, right: 1.5.h),
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: Get.width * 0.6,
                                                      child: Text(
                                                        lDReportController
                                                                    .selectedcontractCategoryType
                                                                    .value ==
                                                                null
                                                            ? ''
                                                            : SessionController()
                                                                        .getLanguage() ==
                                                                    1
                                                                ? lDReportController
                                                                        .selectedcontractCategoryType
                                                                        .value
                                                                        .name ??
                                                                    ''
                                                                : lDReportController
                                                                        .selectedcontractCategoryType
                                                                        .value
                                                                        .nameAr ??
                                                                    '',
                                                        style: AppTextStyle
                                                            .normalBlack12,
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 0.1),
                                                      child: ClearButton(
                                                        clear: () {
                                                          setState(() {
                                                            lDReportController
                                                                    .selectedcontractCategoryType
                                                                    .value =
                                                                dropDownModel
                                                                    .ServiceRequests();
                                                            ;
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : SizedBox(),

                                widget.fileNmae == 'AMC Report' ||
                                        widget.fileNmae == 'LPO Report'
                                    ? SizedBox(
                                        height: 1.5.h,
                                      )
                                    : SizedBox(),

                                // ServiceContractStatus
                                widget.fileNmae == 'AMC Report' ||
                                        widget.fileNmae == 'LPO Report'
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppMetaLabels()
                                                .servieContractStatus,
                                            style: AppTextStyle.normalGrey10,
                                          ),
                                          SizedBox(
                                            height: 1.0.h,
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              lDReportController
                                                      .selectedserviceContractStatusType
                                                      .value =
                                                  await Get.to(() =>
                                                      LandlordReportProperties(
                                                        dropDownType: '1',
                                                      ));
                                              if (lDReportController
                                                      .selectedserviceContractStatusType
                                                      .value !=
                                                  null) {
                                                if (lDReportController
                                                            .fromDate.value !=
                                                        '' &&
                                                    lDReportController
                                                            .toDate.value !=
                                                        '') {
                                                  setState(() {
                                                    isButtonEnable = true;
                                                  });
                                                } else {
                                                  setState(() {
                                                    isButtonEnable = false;
                                                  });
                                                }
                                                setState(() {
                                                  isDownloaded = false;
                                                  isTapOnDownload = false;
                                                  isDownloaded = false;
                                                });

                                                // lDReportController.propType.value =
                                                //     propType;
                                              }
                                              setState(() {});
                                            },
                                            child: Container(
                                              width: 100.0.w,
                                              height: 5.0.h,
                                              decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    246, 248, 249, 1),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        0.5.h),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 1.5.h, right: 1.5.h),
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: Get.width * 0.6,
                                                      child: Text(
                                                        lDReportController
                                                                    .selectedserviceContractStatusType
                                                                    .value ==
                                                                null
                                                            ? ''
                                                            : SessionController()
                                                                        .getLanguage() ==
                                                                    1
                                                                ? lDReportController
                                                                        .selectedserviceContractStatusType
                                                                        .value
                                                                        .name ??
                                                                    ''
                                                                : lDReportController
                                                                        .selectedserviceContractStatusType
                                                                        .value
                                                                        .nameAr ??
                                                                    '',
                                                        style: AppTextStyle
                                                            .normalBlack12,
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 0.1),
                                                      child: ClearButton(
                                                        clear: () {
                                                          setState(() {
                                                            lDReportController
                                                                    .selectedserviceContractStatusType
                                                                    .value =
                                                                dropDownModel
                                                                    .ServiceRequests();
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : SizedBox(),
                                SizedBox(
                                  height: widget.fileNmae == 'AMC Report' ||
                                          widget.fileNmae == 'LPO Report'
                                      ? 1.5.h
                                      : 1.5.h,
                                ),

                                widget.fileNmae == 'AMC Report'
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppMetaLabels().aSonoDate + ' *',
                                            style: AppTextStyle.normalGrey10,
                                          ),
                                          SizedBox(
                                            height: 1.0.h,
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              try {
                                                var dT =
                                                    await showRoundedDatePicker(
                                                  theme: ThemeData(
                                                      primaryColor:
                                                          AppColors.blueColor),
                                                  height: 50.0.h,
                                                  context: context,
                                                  // locale: Locale('en'),
                                                  locale: SessionController()
                                                              .getLanguage() ==
                                                          1
                                                      ? Locale('en', '')
                                                      : Locale('ar', ''),
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(
                                                      DateTime.now().year - 10),
                                                  lastDate: DateTime(
                                                      DateTime.now().year + 10),
                                                  borderRadius: 2.0.h,
                                                  // theme:
                                                  //     ThemeData(primarySwatch: Colors.deepPurple),
                                                  styleDatePicker:
                                                      MaterialRoundedDatePickerStyle(
                                                          decorationDateSelected:
                                                              BoxDecoration(
                                                                  color: AppColors
                                                                      .blueColor,
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          100)),
                                                          textStyleButtonPositive:
                                                              TextStyle(
                                                            color: AppColors
                                                                .blueColor,
                                                          ),
                                                          textStyleButtonNegative:
                                                              TextStyle(
                                                            color: AppColors
                                                                .blueColor,
                                                          ),
                                                          backgroundHeader: Colors
                                                              .grey.shade300,
                                                          // Appbar year like '2023' button
                                                          textStyleYearButton: AppTextStyle
                                                              .boldBlue30
                                                              .copyWith(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .grey
                                                                          .shade100,
                                                                  leadingDistribution:
                                                                      TextLeadingDistribution
                                                                          .even),
                                                          // Appbar day like 'Thu, Mar 16' button
                                                          textStyleDayButton:
                                                              AppTextStyle
                                                                  .normalWhite16

                                                          // Heading year like 'S M T W TH FR SA ' button
                                                          // textStyleDayHeader: TextStyle(
                                                          //   fontSize: 30.sp,
                                                          //   color: Colors.white,
                                                          //   backgroundColor: Colors.red,
                                                          //   decoration: TextDecoration.overline,
                                                          //   decorationColor: Colors.pink,
                                                          // ),
                                                          ),
                                                );
                                                setState(() {
                                                  lDReportController
                                                      .asNoDateDT = dT!;
                                                });
                                                if (!lDReportController
                                                    .setAsnoDate(dT!)) {
                                                  lDReportController
                                                          .filterError.value =
                                                      AppMetaLabels()
                                                          .validDateRange;
                                                }
                                              } catch (e) {}
                                            },
                                            child: Container(
                                              width: 100.0.w,
                                              height: 5.0.h,
                                              decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    246, 248, 249, 1),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        1.0.h),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Obx(() {
                                                    return Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal:
                                                                  1.0.h),
                                                      child: Text(
                                                        lDReportController
                                                            .asnoDateText.value,
                                                        style: AppTextStyle
                                                            .normalBlack12,
                                                      ),
                                                    );
                                                  }),
                                                  Spacer(),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 0.1),
                                                    child: ClearButton(
                                                      clear: () {
                                                        lDReportController
                                                            .asnoDateText
                                                            .value = "";
                                                        setState(() {
                                                          isButtonEnable =
                                                              false;
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : SizedBox(),
                                widget.fileNmae == 'AMC Report'
                                    ? SizedBox(
                                        height: 1.5.h,
                                      )
                                    : SizedBox(),

                                // widget.fileNmae == 'Receipt Register Report'
                                //     ? Column(
                                //         crossAxisAlignment:
                                //             CrossAxisAlignment.start,
                                //         children: [
                                //           Text(
                                //             AppMetaLabels().transactionID,
                                //             style: AppTextStyle.normalGrey10,
                                //           ),
                                //           SizedBox(
                                //             height: 1.0.h,
                                //           ),
                                //           InkWell(
                                //             onTap: () async {
                                //               lDReportController
                                //                       .selectedTransactionID
                                //                       .value =
                                //                   await Get.to(() =>
                                //                       LandlordReportProperties(
                                //                         dropDownType: '5',
                                //                       ));
                                //               if (lDReportController
                                //                       .selectedTransactionID
                                //                       .value !=
                                //                   null) {
                                //                 if (lDReportController
                                //                             .fromDate.value !=
                                //                         '' &&
                                //                     lDReportController
                                //                             .toDate.value !=
                                //                         '') {
                                //                   setState(() {
                                //                     isButtonEnable = true;
                                //                   });
                                //                 } else {
                                //                   setState(() {
                                //                     isButtonEnable = false;
                                //                   });
                                //                 }
                                //                 setState(() {
                                //                   isDownloaded = false;
                                //                   isTapOnDownload = false;
                                //                   isDownloaded = false;
                                //                 });
                                //                 // lDReportController.propType.value =
                                //                 //     propType;
                                //               }
                                //               setState(() {});
                                //             },
                                //             child: Container(
                                //               width: 100.0.w,
                                //               height: 5.0.h,
                                //               decoration: BoxDecoration(
                                //                 color: Color.fromRGBO(
                                //                     246, 248, 249, 1),
                                //                 borderRadius:
                                //                     BorderRadius.circular(
                                //                         0.5.h),
                                //               ),
                                //               child: Padding(
                                //                 padding: EdgeInsets.only(
                                //                     left: 1.5.h, right: 1.5.h),
                                //                 child: Row(
                                //                   children: [
                                //                     Text(
                                //                       lDReportController
                                //                                   .selectedTransactionID
                                //                                   .value ==
                                //                               null
                                //                           ? ''
                                //                           : SessionController()
                                //                                       .getLanguage() ==
                                //                                   1
                                //                               ? lDReportController
                                //                                       .selectedTransactionID
                                //                                       .value
                                //                                       .name ??
                                //                                   ''
                                //                               : lDReportController
                                //                                       .selectedTransactionID
                                //                                       .value
                                //                                       .nameAr ??
                                //                                   '',
                                //                       style: AppTextStyle
                                //                           .normalBlack12,
                                //                     ),
                                //                     Spacer(),
                                //                     Padding(
                                //                       padding:
                                //                           EdgeInsets.symmetric(
                                //                               horizontal: 0.1),
                                //                       child: ClearButton(
                                //                         clear: () {
                                //                           setState(() {
                                //                             lDReportController
                                //                                 .selectedTransactionID
                                //                                 .value = null;
                                //                           });
                                //                         },
                                //                       ),
                                //                     ),
                                //                   ],
                                //                 ),
                                //               ),
                                //             ),
                                //           ),
                                //         ],
                                //       )
                                //     : SizedBox(),
                                // widget.fileNmae == 'Receipt Register Report'
                                //     ? SizedBox(
                                //         height: 2.5.h,
                                //       )
                                //     : SizedBox(),

                                widget.fileNmae == 'Receipt Register Report' ||
                                        widget.fileNmae ==
                                            'Unit Status Report' ||
                                        widget.fileNmae ==
                                            'Building Status Report' ||
                                        widget.fileNmae == 'Legal Case Report'
                                    ? Container(
                                        height: 9.0.h,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              AppMetaLabels().unitRefNo,
                                              style: AppTextStyle.normalGrey10,
                                            ),
                                            SizedBox(
                                              height: 1.0.h,
                                            ),
                                            Container(
                                              width: 100.0.w,
                                              height: 5.0.h,
                                              decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    246, 248, 249, 1),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        1.0.h),
                                              ),
                                              child: TextField(
                                                controller: lDReportController
                                                    .unitRefNoController,
                                                onChanged: (value) {
                                                  print(
                                                      'On change ::::::: $value');
                                                },
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  fillColor: Color.fromRGBO(
                                                      246, 248, 249, 1),
                                                  focusColor: Colors.red,
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:
                                                            Colors.transparent),
                                                  ),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:
                                                            Colors.transparent),
                                                  ),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2.0.h),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : SizedBox(),

                                widget.fileNmae == 'Tenancy Contracts Report'
                                    ? Container(
                                        height: 9.0.h,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              AppMetaLabels().contractNo,
                                              style: AppTextStyle.normalGrey10,
                                            ),
                                            SizedBox(
                                              height: 1.0.h,
                                            ),
                                            Container(
                                              width: 100.0.w,
                                              height: 5.0.h,
                                              decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    246, 248, 249, 1),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        1.0.h),
                                              ),
                                              child: TextField(
                                                controller: lDReportController
                                                    .contractNoController,
                                                onChanged: (value) {
                                                  print(
                                                      'On change ::::::: $value');
                                                },
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  fillColor: Color.fromRGBO(
                                                      246, 248, 249, 1),
                                                  focusColor: Colors.red,
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:
                                                            Colors.transparent),
                                                  ),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:
                                                            Colors.transparent),
                                                  ),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2.0.h),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : SizedBox(),

                                widget.fileNmae == 'Receipt Register Report' ||
                                        widget.fileNmae ==
                                            'Unit Status Report' ||
                                        widget.fileNmae ==
                                            'Building Status Report' ||
                                        widget.fileNmae ==
                                            'Legal Case Report' ||
                                        widget.fileNmae ==
                                            'Tenancy Contracts Report'
                                    ? SizedBox(
                                        height: 1.5.h,
                                      )
                                    : SizedBox(),

                                // From & To Date
                                widget.fileNmae == 'Building Status Report' ||
                                        widget.fileNmae ==
                                            'Unit Status Report' ||
                                        widget.fileNmae ==
                                            'Occupancy Vacancy Register Report'
                                    ? SizedBox()
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                AppMetaLabels().from + ' *',
                                                style:
                                                    AppTextStyle.normalGrey10,
                                              ),
                                              SizedBox(
                                                height: 1.0.h,
                                              ),
                                              InkWell(
                                                onTap: () async {
                                                  try {
                                                    var dT =
                                                        await showRoundedDatePicker(
                                                      theme: ThemeData(
                                                          primaryColor:
                                                              AppColors
                                                                  .blueColor),
                                                      height: 50.0.h,
                                                      context: context,
                                                      // locale: Locale('en'),
                                                      locale: SessionController()
                                                                  .getLanguage() ==
                                                              1
                                                          ? Locale('en', '')
                                                          : Locale('ar', ''),
                                                      initialDate:
                                                          DateTime.now(),
                                                      firstDate: DateTime(
                                                          DateTime.now().year -
                                                              10),
                                                      lastDate: DateTime(
                                                          DateTime.now().year +
                                                              10),
                                                      borderRadius: 2.0.h,
                                                      // theme:
                                                      //     ThemeData(primarySwatch: Colors.deepPurple),
                                                      styleDatePicker:
                                                          MaterialRoundedDatePickerStyle(
                                                              decorationDateSelected: BoxDecoration(
                                                                  color: AppColors
                                                                      .blueColor,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              100)),
                                                              textStyleButtonPositive:
                                                                  TextStyle(
                                                                color: AppColors
                                                                    .blueColor,
                                                              ),
                                                              textStyleButtonNegative:
                                                                  TextStyle(
                                                                color: AppColors
                                                                    .blueColor,
                                                              ),
                                                              backgroundHeader:
                                                                  Colors.grey
                                                                      .shade300,
                                                              // Appbar year like '2023' button
                                                              textStyleYearButton: AppTextStyle
                                                                  .boldBlue30
                                                                  .copyWith(
                                                                      backgroundColor: Colors
                                                                          .grey
                                                                          .shade100,
                                                                      leadingDistribution:
                                                                          TextLeadingDistribution
                                                                              .even),
                                                              // Appbar day like 'Thu, Mar 16' button
                                                              textStyleDayButton:
                                                                  AppTextStyle
                                                                      .normalWhite16

                                                              // Heading year like 'S M T W TH FR SA ' button
                                                              // textStyleDayHeader: TextStyle(
                                                              //   fontSize: 30.sp,
                                                              //   color: Colors.white,
                                                              //   backgroundColor: Colors.red,
                                                              //   decoration: TextDecoration.overline,
                                                              //   decorationColor: Colors.pink,
                                                              // ),
                                                              ),
                                                    );
                                                    setState(() {
                                                      lDReportController
                                                          .fromDateDT = dT!;
                                                    });
                                                    if (!lDReportController
                                                        .setFromDate(dT!)) {
                                                      lDReportController
                                                              .filterError
                                                              .value =
                                                          AppMetaLabels()
                                                              .validDateRange;
                                                    }
                                                    if (lDReportController
                                                            .toDate.value !=
                                                        '') {
                                                      setState(() {
                                                        isButtonEnable = true;
                                                        isDownloaded = false;
                                                        isTapOnDownload = false;
                                                        isDownloaded = false;
                                                      });
                                                    }
                                                  } catch (e) {}
                                                },
                                                child: Container(
                                                  width: 40.0.w,
                                                  height: 5.5.h,
                                                  decoration: BoxDecoration(
                                                    color: Color.fromRGBO(
                                                        246, 248, 249, 1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            1.0.h),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Obx(() {
                                                        return Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      1.0.h),
                                                          child: Text(
                                                            lDReportController
                                                                .fromDateText
                                                                .value,
                                                            // lDReportController
                                                            //     .fromDate.value,
                                                            style: AppTextStyle
                                                                .normalBlack12,
                                                          ),
                                                        );
                                                      }),
                                                      Spacer(),
                                                      Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    1.0.h),
                                                        child: ClearButton(
                                                          clear: () {
                                                            lDReportController
                                                                .fromDateText
                                                                .value = "";
                                                            lDReportController
                                                                .toDateText
                                                                .value = "";
                                                            lDReportController
                                                                .fromDate
                                                                .value = "";
                                                            lDReportController
                                                                .toDate
                                                                .value = "";
                                                            lDReportController
                                                                .filterError
                                                                .value = "";
                                                            setState(() {
                                                              isButtonEnable =
                                                                  false;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                AppMetaLabels().to + ' *',
                                                style:
                                                    AppTextStyle.normalGrey10,
                                              ),
                                              SizedBox(
                                                height: 1.0.h,
                                              ),
                                              InkWell(
                                                onTap: () async {
                                                  try {
                                                    if (lDReportController
                                                            .fromDateText
                                                            .value ==
                                                        '') {
                                                      SnakBarWidget
                                                          .getSnackBarErrorBlue(
                                                              AppMetaLabels()
                                                                  .alert,
                                                              AppMetaLabels()
                                                                      .pleaseSelectFromDate +
                                                                  AppMetaLabels()
                                                                      .first);
                                                      return;
                                                    }
                                                    var dT =
                                                        await showRoundedDatePicker(
                                                      theme: ThemeData(
                                                          primaryColor:
                                                              AppColors
                                                                  .blueColor),
                                                      height: 50.0.h,
                                                      context: context,
                                                      // locale: Locale('en'),
                                                      locale: SessionController()
                                                                  .getLanguage() ==
                                                              1
                                                          ? Locale('en', '')
                                                          : Locale('ar', ''),
                                                      initialDate:
                                                          lDReportController
                                                              .fromDateDT,
                                                      firstDate:
                                                          lDReportController
                                                              .fromDateDT,
                                                      lastDate: DateTime(
                                                          DateTime.now().year +
                                                              10),
                                                      borderRadius: 2.0.h,
                                                      // theme:
                                                      //     ThemeData(primarySwatch: Colors.deepPurple),
                                                      styleDatePicker:
                                                          MaterialRoundedDatePickerStyle(
                                                              decorationDateSelected: BoxDecoration(
                                                                  color: AppColors
                                                                      .blueColor,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              100)),
                                                              textStyleButtonPositive:
                                                                  TextStyle(
                                                                color: AppColors
                                                                    .blueColor,
                                                              ),
                                                              textStyleButtonNegative:
                                                                  TextStyle(
                                                                color: AppColors
                                                                    .blueColor,
                                                              ),
                                                              backgroundHeader:
                                                                  Colors.grey
                                                                      .shade300,
                                                              // Appbar year like '2023' button
                                                              textStyleYearButton: AppTextStyle
                                                                  .boldBlue30
                                                                  .copyWith(
                                                                      backgroundColor: Colors
                                                                          .grey
                                                                          .shade100,
                                                                      leadingDistribution:
                                                                          TextLeadingDistribution
                                                                              .even),
                                                              // Appbar day like 'Thu, Mar 16' button
                                                              textStyleDayButton:
                                                                  AppTextStyle
                                                                      .normalWhite16

                                                              // Heading year like 'S M T W TH FR SA ' button
                                                              // textStyleDayHeader: TextStyle(
                                                              //   fontSize: 30.sp,
                                                              //   color: Colors.white,
                                                              //   backgroundColor: Colors.red,
                                                              //   decoration: TextDecoration.overline,
                                                              //   decorationColor: Colors.pink,
                                                              // ),
                                                              ),
                                                    );
                                                    setState(() {
                                                      lDReportController
                                                          .toDateDT = dT!;
                                                    });

                                                    print(
                                                        'Date :::: dt1: ${lDReportController.fromDateDT}');
                                                    print(
                                                        'Date :::: dt2: ${lDReportController.toDateDT}');

                                                    Duration diff =
                                                        lDReportController
                                                            .toDateDT!
                                                            .difference(
                                                                lDReportController
                                                                    .fromDateDT!);

                                                    int allowYears =
                                                        1 * 365 + 1;
                                                    if (diff.inDays <=
                                                        allowYears) {
                                                      if (!lDReportController
                                                          .setToDate(dT!)) {
                                                        lDReportController
                                                                .filterError
                                                                .value =
                                                            AppMetaLabels()
                                                                .validDateRange;
                                                      } else {
                                                        lDReportController
                                                            .filterError
                                                            .value = "";
                                                      }
                                                      if (lDReportController
                                                                  .fromDate
                                                                  .value !=
                                                              '' &&
                                                          lDReportController
                                                                  .toDate
                                                                  .value !=
                                                              '') {
                                                        setState(() {
                                                          isButtonEnable = true;
                                                          isDownloaded = false;
                                                          isTapOnDownload =
                                                              false;
                                                          isDownloaded = false;
                                                        });
                                                      }
                                                    } else {
                                                      SnakBarWidget
                                                          .getSnackBarErrorBlueWith5Sec(
                                                              AppMetaLabels()
                                                                  .alert,
                                                              AppMetaLabels()
                                                                  .dateRangeOfReport);
                                                      lDReportController
                                                          .toDate.value = '';
                                                      lDReportController
                                                          .toDateText
                                                          .value = '';
                                                      return;
                                                    }
                                                  } catch (e) {}
                                                },
                                                child: Container(
                                                  width: 40.0.w,
                                                  height: 5.5.h,
                                                  decoration: BoxDecoration(
                                                    color: Color.fromRGBO(
                                                        246, 248, 249, 1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            1.0.h),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Obx(() {
                                                        return Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      1.0.h),
                                                          child: Text(
                                                            // lDReportController
                                                            //     .toDate.value,
                                                            lDReportController
                                                                .toDateText
                                                                .value,
                                                            style: AppTextStyle
                                                                .normalBlack12,
                                                          ),
                                                        );
                                                      }),
                                                      Spacer(),
                                                      Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    1.0.h),
                                                        child: ClearButton(
                                                          clear: () {
                                                            lDReportController
                                                                .toDate
                                                                .value = "";
                                                            lDReportController
                                                                .toDateText
                                                                .value = "";
                                                            lDReportController
                                                                .filterError
                                                                .value = "";
                                                            setState(() {
                                                              isButtonEnable =
                                                                  false;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                Obx(() {
                                  return lDReportController.filterError.value ==
                                          ""
                                      ? Container()
                                      : Padding(
                                          padding: EdgeInsets.only(top: 0.0.h),
                                          child: Container(
                                            width: 80.0.w,
                                            decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  255, 59, 48, 0.6),
                                              borderRadius:
                                                  BorderRadius.circular(1.0.h),
                                              border: Border.all(
                                                color: Color.fromRGBO(
                                                    255, 59, 48, 1),
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(0.4.h),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.info_outline,
                                                    color: Colors.white,
                                                    size: 3.5.h,
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 1.0.h),
                                                    child: Text(
                                                      lDReportController
                                                          .filterError.value,
                                                      style: AppTextStyle
                                                          .semiBoldWhite11,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                }),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
              Obx(() {
                return lDReportController.isLoading.value ||
                        lDReportController.isLoadingSummary.value
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
              child: Container(
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
                  child: Center(
                    child: Container(
                      height: 5.5.h,
                      width: 86.0.w,
                      margin: EdgeInsets.only(top: 0.5.h, bottom: 0.5.h),
                      child: lDReportController.isLoading.value
                          ? LoadingIndicatorBlue()
                          : ElevatedButton(
                              onPressed: isButtonEnable == false
                                  ? null
                                  : () async {
                                      FocusScope.of(context).unfocus();
                                      print(
                                          'File Name :::: ${widget.fileNmae}');
                                      print(
                                          'File Name :::: ${(widget.fileNmae != 'Building Status Report')}');
                                      print(
                                          'File Name :::: ${(widget.fileNmae != 'Unit Status Report')}');

                                      if (widget.fileNmae !=
                                              'Building Status Report' &&
                                          widget.fileNmae !=
                                              'Unit Status Report' &&
                                          widget.fileNmae !=
                                              'Occupancy Vacancy Register Report') {
                                        if (lDReportController.fromDate.value ==
                                                '' ||
                                            lDReportController.fromDate.value ==
                                                null) {
                                          SnakBarWidget.getSnackBarErrorBlue(
                                              AppMetaLabels().alert,
                                              AppMetaLabels()
                                                  .pleaseSelectFromDate);
                                          return;
                                        }
                                        if (lDReportController.toDate.value ==
                                                '' ||
                                            lDReportController.toDate.value ==
                                                null) {
                                          SnakBarWidget.getSnackBarErrorBlue(
                                              AppMetaLabels().alert,
                                              AppMetaLabels()
                                                  .pleaseSelectToDate);
                                          return;
                                        }
                                      }
                                      if (widget.fileNmae == 'AMC Report') {
                                        if (lDReportController.asnoDate.value ==
                                                '' ||
                                            lDReportController.asnoDate.value ==
                                                null) {
                                          SnakBarWidget.getSnackBarErrorBlue(
                                              AppMetaLabels().alert,
                                              AppMetaLabels()
                                                  .pleaseSelectAsNODate);
                                          return;
                                        }
                                      }
                                      if (widget.fileNmae ==
                                              'Building Status Report' ||
                                          widget.fileNmae ==
                                              'Unit Status Report') {
                                        if (lDReportController
                                                .selectedPropType.value ==
                                            null) {
                                          SnakBarWidget.getSnackBarErrorBlue(
                                              AppMetaLabels().alert,
                                              AppMetaLabels().pleaseSelect +
                                                  ' ' +
                                                  AppMetaLabels().property);
                                          return;
                                        }
                                      }

                                      dynamic propertyID;
                                      if (lDReportController
                                              .selectedPropType.value ==
                                          null) {
                                        propertyID = null;
                                      } else {
                                        propertyID = lDReportController
                                                .selectedPropType.value.id ??
                                            null;
                                      }
                                      dynamic chequeStatusID;
                                      if (lDReportController
                                              .selectedChequeStatus.value ==
                                          null) {
                                        chequeStatusID = null;
                                      } else {
                                        chequeStatusID = lDReportController
                                                .selectedChequeStatus
                                                .value
                                                .id ??
                                            null;
                                      }
                                      dynamic unitStatusID;
                                      if (lDReportController
                                              .selectedUnitStatus.value ==
                                          null) {
                                        unitStatusID = null;
                                      } else {
                                        unitStatusID = lDReportController
                                                .selectedUnitStatus.value.id ??
                                            null;
                                      }

                                      dynamic contractorID;
                                      if (lDReportController
                                              .selectedcontractorType.value ==
                                          null) {
                                        contractorID = null;
                                      } else {
                                        contractorID = lDReportController
                                                .selectedcontractorType
                                                .value
                                                .id ??
                                            null;
                                      }

                                      dynamic contractCategoryStatusID;
                                      if (lDReportController
                                              .selectedcontractCategoryType
                                              .value ==
                                          null) {
                                        contractCategoryStatusID = null;
                                      } else {
                                        contractCategoryStatusID =
                                            lDReportController
                                                    .selectedcontractCategoryType
                                                    .value
                                                    .id ??
                                                null;
                                      }
                                      dynamic serviceContractStatusID;
                                      if (lDReportController
                                              .selectedserviceContractStatusType
                                              .value ==
                                          null) {
                                        serviceContractStatusID = null;
                                      } else {
                                        serviceContractStatusID = lDReportController
                                                .selectedserviceContractStatusType
                                                .value
                                                .id ??
                                            null;
                                      }
                                      dynamic transactionID;
                                      if (lDReportController
                                              .selectedTransactionID.value ==
                                          null) {
                                        transactionID = null;
                                      } else {
                                        transactionID = lDReportController
                                                .selectedTransactionID
                                                .value
                                                .id ??
                                            null;
                                      }
                                      if (propertyID == null) {
                                        propertyID = "-1";
                                      }
                                      if (contractorID == null) {
                                        contractorID = "-1";
                                      }
                                      if (contractCategoryStatusID == null) {
                                        contractCategoryStatusID = "-1";
                                      }
                                      if (serviceContractStatusID == null) {
                                        serviceContractStatusID = "-1";
                                      }
                                      if (transactionID == null) {
                                        transactionID = "-1";
                                      }
                                      if (chequeStatusID == null) {
                                        chequeStatusID = "-1";
                                      }
                                      if (unitStatusID == null) {
                                        unitStatusID = "-1";
                                      }
                                      // Done
                                      Map data;
                                      if (widget.fileNmae == "AMC Report" ||
                                          widget.fileNmae == "LPO Report") {
                                        data = {
                                          "language": SessionController()
                                                      .getLanguage() ==
                                                  1
                                              ? "english"
                                              : "arabic",
                                          "emirateID": null,
                                          "propertyID": propertyID == "-1"
                                              ? null
                                              : propertyID,
                                          "contractCategoryID":
                                              contractCategoryStatusID == "-1"
                                                  ? null
                                                  : contractCategoryStatusID,
                                          "contractStatusID":
                                              serviceContractStatusID == "-1"
                                                  ? null
                                                  : serviceContractStatusID,
                                          "contractorID": contractorID == "-1"
                                              ? null
                                              : contractorID,
                                          "dateFrom":
                                              lDReportController.fromDate.value,
                                          "dateTo":
                                              lDReportController.toDate.value,
                                          "asondate": lDReportController
                                                      .asnoDate.value ==
                                                  ''
                                              ? null
                                              : lDReportController
                                                  .asnoDate.value,
                                        };
                                        print('B-Move Data:$data');
                                        print(
                                            'B-Move FilName:${widget.fileNmae}');
                                        await lDReportController
                                            .getreportSummary(
                                                data, widget.fileNmae ?? "");
                                        Get.to(() => LandLordSummaryReports(
                                            reportName: widget.fileNmae,
                                            data: data));
                                      } else if (widget.fileNmae ==
                                          "Cheque Register Report") {
                                        // Done
                                        data = {
                                          "language": SessionController()
                                                      .getLanguage() ==
                                                  1
                                              ? "english"
                                              : "arabic",
                                          "emirateID": null,
                                          "propertyID": propertyID == "-1"
                                              ? null
                                              : propertyID,
                                          "statusID": chequeStatusID == "-1"
                                              ? null
                                              : chequeStatusID,
                                          "dateFrom":
                                              lDReportController.fromDate.value,
                                          "dateTo":
                                              lDReportController.toDate.value,
                                          "contractID": null,
                                        };
                                        print('B-Move Data:$data');
                                        print(
                                            'B-Move FilName:${widget.fileNmae}');
                                        await lDReportController
                                            .getreportSummary(
                                                data, widget.fileNmae ?? "");
                                        Get.to(() => LandLordSummaryReports(
                                            reportName: widget.fileNmae,
                                            data: data));
                                      } else if (widget.fileNmae ==
                                          "VAT Report") {
                                        data = {
                                          "language": SessionController()
                                                      .getLanguage() ==
                                                  1
                                              ? "english"
                                              : "arabic",
                                          "emirateID": null,
                                          "propertyID": propertyID == "-1"
                                              ? null
                                              : propertyID,
                                          "dateFrom":
                                              lDReportController.fromDate.value,
                                          "dateTo":
                                              lDReportController.toDate.value,
                                        };
                                        print('B-Move Data:$data');
                                        print(
                                            'B-Move FilName:${widget.fileNmae}');
                                        await lDReportController
                                            .getreportSummary(
                                                data, widget.fileNmae ?? '');
                                        Get.to(() => LandLordSummaryReports(
                                            reportName: widget.fileNmae,
                                            data: data));
                                      } else if (widget.fileNmae ==
                                          'Receipt Register Report') {
                                        data = {
                                          "language": SessionController()
                                                      .getLanguage() ==
                                                  1
                                              ? "english"
                                              : "arabic",
                                          "emirateID": null,
                                          "propertyID": propertyID == "-1"
                                              ? null
                                              : propertyID,
                                          "transactionTypeID":
                                              transactionID == "-1"
                                                  ? null
                                                  : transactionID,
                                          "dateFrom":
                                              lDReportController.fromDate.value,
                                          "dateTo":
                                              lDReportController.toDate.value,
                                          "unitRefNo": lDReportController
                                                      .unitRefNoController
                                                      .text ==
                                                  ''
                                              ? null
                                              : lDReportController
                                                  .unitRefNoController.text
                                        };
                                        print('B-Move Data:$data');
                                        print(
                                            'B-Move FilName:${widget.fileNmae}');
                                        await lDReportController
                                            .getreportSummary(
                                                data, widget.fileNmae ?? "");
                                        Get.to(() => LandLordSummaryReports(
                                            reportName: widget.fileNmae,
                                            data: data));
                                      } else if (widget.fileNmae ==
                                          'Legal Case Report') {
                                        data = {
                                          "language": SessionController()
                                                      .getLanguage() ==
                                                  1
                                              ? "english"
                                              : "arabic",
                                          "emirateID": null,
                                          "propertyID": propertyID == "-1"
                                              ? null
                                              : propertyID,
                                          "dateFrom":
                                              lDReportController.fromDate.value,
                                          "dateTo":
                                              lDReportController.toDate.value,
                                          "unitRefNo": lDReportController
                                                      .unitRefNoController
                                                      .text ==
                                                  ''
                                              ? null
                                              : lDReportController
                                                  .unitRefNoController.text
                                        };
                                        print('B-Move Data:$data');
                                        print(
                                            'B-Move FilName:${widget.fileNmae}');
                                        await lDReportController
                                            .getreportSummary(
                                                data, widget.fileNmae ?? "");
                                        Get.to(() => LandLordSummaryReports(
                                            reportName: widget.fileNmae,
                                            data: data));
                                      } else if (widget.fileNmae ==
                                          'Unit Status Report') {
                                        data = {
                                          "language": SessionController()
                                                      .getLanguage() ==
                                                  1
                                              ? "english"
                                              : "arabic",
                                          "emirateID": null,
                                          "propertyID": propertyID == "-1"
                                              ? null
                                              : propertyID,
                                          "statusID": unitStatusID == "-1"
                                              ? null
                                              : unitStatusID,
                                          "unitRefNo": lDReportController
                                                      .unitRefNoController
                                                      .text ==
                                                  ''
                                              ? null
                                              : lDReportController
                                                  .unitRefNoController.text
                                        };
                                        print('B-Move Data:$data');
                                        print(
                                            'B-Move FilName:${widget.fileNmae}');
                                        await lDReportController
                                            .getreportSummary(
                                                data, widget.fileNmae ?? "");
                                        Get.to(() => LandLordSummaryReports(
                                            reportName: widget.fileNmae,
                                            data: data));
                                      } else if (widget.fileNmae ==
                                          'Building Status Report') {
                                        data = {
                                          "language": SessionController()
                                                      .getLanguage() ==
                                                  1
                                              ? "english"
                                              : "arabic",
                                          "emirateID": null,
                                          "propertyID": propertyID == "-1"
                                              ? null
                                              : propertyID,
                                          "unitRefNo": lDReportController
                                                      .unitRefNoController
                                                      .text ==
                                                  ''
                                              ? null
                                              : lDReportController
                                                  .unitRefNoController.text
                                        };
                                        print('B-Move Data:$data');
                                        print(
                                            'B-Move FilName:${widget.fileNmae}');
                                        await lDReportController
                                            .getreportSummary(
                                                data, widget.fileNmae ?? "");
                                        Get.to(() => LandLordSummaryReports(
                                            reportName: widget.fileNmae,
                                            data: data));
                                      } else if (widget.fileNmae ==
                                          'Tenancy Contracts Report') {
                                        data = {
                                          "language": SessionController()
                                                      .getLanguage() ==
                                                  1
                                              ? "english"
                                              : "arabic",
                                          "emirateID": null,
                                          "propertyID": propertyID == "-1"
                                              ? null
                                              : propertyID,
                                          "contractNo": lDReportController
                                                      .contractNoController
                                                      .text ==
                                                  ''
                                              ? null
                                              : lDReportController
                                                  .contractNoController.text,
                                          "dateFrom":
                                              lDReportController.fromDate.value,
                                          "dateTo":
                                              lDReportController.toDate.value,
                                        };
                                        print('B-Move Data:$data');
                                        print(
                                            'B-Move FilName:${widget.fileNmae}');
                                        await lDReportController
                                            .getreportSummary(
                                                data, widget.fileNmae ?? "");
                                        Get.to(() => LandLordSummaryReports(
                                            reportName: widget.fileNmae,
                                            data: data));
                                      } else if (widget.fileNmae ==
                                          'Occupancy Vacancy Register Report') {
                                        data = {
                                          "language": SessionController()
                                                      .getLanguage() ==
                                                  1
                                              ? "english"
                                              : "arabic",
                                          "emirateID": null,
                                          "propertyID": propertyID == "-1"
                                              ? null
                                              : propertyID
                                        };
                                        print('B-Move Data:$data');
                                        print(
                                            'B-Move FilName:${widget.fileNmae}');
                                        await lDReportController
                                            .getreportSummary(
                                                data, widget.fileNmae!);
                                        Get.to(() => LandLordSummaryReports(
                                            reportName: widget.fileNmae,
                                            data: data));
                                      } else {
                                        SnakBarWidget.getSnackBarSuccess(
                                            'Alert', 'Working... ');
                                      }
                                    },
                              child: Text(
                                AppMetaLabels().viewReport,
                                style: isButtonEnable == false
                                    ? AppTextStyle.semiBoldBlack11
                                    : AppTextStyle.semiBoldWhite11,
                              ),
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(2.0.w),
                                ),
                                backgroundColor: AppColors.blueColor,
                              ),
                            ),
                    ),
                  )))),
    );
  }
}
