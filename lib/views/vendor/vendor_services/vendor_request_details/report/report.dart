// ignore_for_file: deprecated_member_use, unnecessary_null_comparison
import 'dart:typed_data';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/utils/text_validator.dart';
import 'package:fap_properties/views/vendor/vendor_services/vendor_request_details/main_info/main_info_controller.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:fap_properties/views/vendor/vendor_services/vendor_request_details/report/report_controller.dart';
import 'package:fap_properties/views/widgets/bottom_shadow.dart';
import 'package:fap_properties/views/widgets/snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:signature/signature.dart';
import 'package:sizer/sizer.dart';
import 'package:zoom_pinch_overlay/zoom_pinch_overlay.dart';

import '../../../../widgets/signature_pad.dart';
import '../../vendor_request_list/vendor_request_list_controller.dart';

class SvcReqReport extends StatefulWidget {
  final int? caseNo;
  final bool? status;
  SvcReqReport({Key? key, this.caseNo, this.status}) : super(key: key);

  @override
  State<SvcReqReport> createState() => _SvcReqReportState();
}

class _SvcReqReportState extends State<SvcReqReport> {
  // double mainContainerHeight = 84.h;
  bool isShowList = false;
  int selectedFABCorrectiveAcion = -1;

  String erroFABCorrectiveList = '';
  String erroFreEntryText1 = '';
  String erroFreEntryText2 = '';
  List<String> listvalues = AppMetaLabels().fABCorrectiveActionList;

  ///
  final controller = Get.put(SvcReqReportController());
  final SignatureController signatureController1 = SignatureController(
    penStrokeWidth: 1,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
    onDrawStart: () => print('onDrawStart called'),
    onDrawEnd: () => print('onDrawEnd called'),
  );
  final SignatureController signatureController2 = SignatureController(
    penStrokeWidth: 1,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
    onDrawStart: () => print('onDrawStart called'),
    onDrawEnd: () => print('onDrawEnd called'),
  );

  @override
  initState() {
    print('Status :::::  ${widget.status} :::  if ${widget.status == true}');
    controller.caseNo = widget.caseNo;
    controller.getPhotos();
    controller.getFiles();
    getReportDetail();
    super.initState();
  }

  getReportDetail() {
    setState(() {
      controller.status = widget.status;
    });
    controller.getReportTABData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BottomShadow(),
        Obx(() {
          return controller.loadingDataReportTAB.value == true
              ? Expanded(
                  child: Center(child: LoadingIndicatorBlue()),
                )
              : Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 2.0.h, bottom: 2.0.h),
                    child: SingleChildScrollView(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: SessionController().getLanguage() == 1
                                  ? 10
                                  : 0,
                            ),
                            //  Report
                            // listviewbuilder
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isShowList = !isShowList;
                                });
                                // if (mainContainerHeight == 84.h) {
                                //   setState(() {
                                //     mainContainerHeight = 95.h;
                                //     isShowList = true;
                                //   });
                                // } else {
                                //   setState(() {
                                //     mainContainerHeight = 84.h;
                                //     isShowList = false;
                                //   });
                                // }
                              },
                              child: Container(
                                padding: EdgeInsets.all(2.0.h),
                                margin: EdgeInsets.only(left: 2.w, right: 2.w),
                                width: 90.0.w,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: erroFABCorrectiveList != ''
                                        ? Colors.red
                                        : Colors.transparent,
                                  ),
                                  borderRadius: isShowList == true
                                      ? BorderRadius.only(
                                          topLeft: Radius.circular(2.0.h),
                                          topRight: Radius.circular(2.0.h))
                                      : BorderRadius.circular(2.0.h),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 0.5.h,
                                      spreadRadius: 0.24.h,
                                      offset: Offset(0.1.h, 0.1.h),
                                    ),
                                  ],
                                ),
                                height: Get.height * 0.065,
                                child: Row(
                                  children: [
                                    Text(
                                      controller.listTitle,
                                      style: AppTextStyle.normalGrey10,
                                    ),
                                    Spacer(),
                                    Icon(
                                      isShowList != true
                                          ? Icons.arrow_drop_down
                                          : Icons.arrow_drop_up,
                                      color: AppColors.greyColor,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            isShowList != true
                                ? SizedBox()
                                : Container(
                                    padding: EdgeInsets.all(2.0.h),
                                    margin:
                                        EdgeInsets.only(left: 2.w, right: 2.w),
                                    width: 90.0.w,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(2.0.h),
                                          bottomRight: Radius.circular(2.0.h)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 0.5.h,
                                          spreadRadius: 0.1.h,
                                          offset: Offset(0.1.h, 0.1.h),
                                        ),
                                      ],
                                    ),
                                    child: ListView.builder(
                                      itemCount: listvalues.length,
                                      shrinkWrap: true,
                                      padding: EdgeInsets.zero,
                                      itemBuilder: (_, index) {
                                        return InkWell(
                                          onTap: () {
                                            setState(() {
                                              isShowList = !isShowList;
                                              controller.listTitle =
                                                  listvalues[index];
                                              selectedFABCorrectiveAcion =
                                                  index + 1;
                                              print(selectedFABCorrectiveAcion);
                                              // mainContainerHeight = 84.h;
                                              erroFABCorrectiveList = '';
                                            });
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: Text(
                                              listvalues[index],
                                              style: AppTextStyle.normalGrey10,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                            SizedBox(
                              height: erroFABCorrectiveList == '' ? 0 : 5,
                            ),
                            erroFABCorrectiveList == ''
                                ? SizedBox()
                                : Text(
                                    erroFABCorrectiveList,
                                    style: AppTextStyle.normalErrorText1,
                                  ),

                            SizedBox(
                              height: 15,
                            ),
                            // Free Entry Text 1
                            Container(
                              padding: EdgeInsets.all(2.0.h),
                              width: 90.0.w,
                              margin: EdgeInsets.only(left: 2.w, right: 2.w),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(2.0.h),
                                border: Border.all(
                                  color: erroFreEntryText1 != ''
                                      ? Colors.red
                                      : Colors.transparent,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 0.5.h,
                                    spreadRadius: 0.24.h,
                                    offset: Offset(0.1.h, 0.1.h),
                                  ),
                                ],
                              ),
                              height: Get.height * 0.065,
                              child: Center(
                                child: TextField(
                                  controller:
                                      controller.textEditingControlerFET1,
                                  onChanged: (value) {
                                    setState(() {
                                      erroFreEntryText1 = '';
                                    });
                                  },
                                  style: AppTextStyle.normalGrey10,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                        left: 2.0.w, right: 5.0.w),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(0.5.h),
                                      borderSide: BorderSide(
                                          color: AppColors.whiteColor,
                                          width: 0.1.h),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(0.5.h),
                                      borderSide: BorderSide(
                                          color: AppColors.whiteColor,
                                          width: 0.1.h),
                                    ),
                                    hintText: AppMetaLabels().purposedRemedy,
                                    hintStyle: AppTextStyle.normalBlack10
                                        .copyWith(color: Colors.grey),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: erroFreEntryText1 == '' ? 0 : 5,
                            ),
                            erroFreEntryText1 == ''
                                ? SizedBox()
                                : Text(
                                    erroFreEntryText1,
                                    style: AppTextStyle.normalErrorText1,
                                  ),
                            SizedBox(
                              height: 15,
                            ),
                            // Free Entry Text 2
                            Container(
                              padding: EdgeInsets.all(2.0.h),
                              margin: EdgeInsets.only(left: 2.w, right: 2.w),
                              width: 90.0.w,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: erroFreEntryText2 != ''
                                      ? Colors.red
                                      : Colors.transparent,
                                ),
                                borderRadius: BorderRadius.circular(2.0.h),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 0.5.h,
                                    spreadRadius: 0.24.h,
                                    offset: Offset(0.1.h, 0.1.h),
                                  ),
                                ],
                              ),
                              height: Get.height * 0.065,
                              child: Center(
                                child: TextField(
                                  controller:
                                      controller.textEditingControlerFET2,
                                  onChanged: (value) {
                                    setState(() {
                                      erroFreEntryText2 = '';
                                    });
                                  },
                                  style: AppTextStyle.normalGrey10,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                        left: 2.0.w, right: 5.0.w),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(0.5.h),
                                      borderSide: BorderSide(
                                          color: AppColors.whiteColor,
                                          width: 0.1.h),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(0.5.h),
                                      borderSide: BorderSide(
                                          color: AppColors.whiteColor,
                                          width: 0.1.h),
                                    ),
                                    hintText: AppMetaLabels().descriptionn,
                                    hintStyle: AppTextStyle.normalBlack10
                                        .copyWith(color: Colors.grey),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: erroFreEntryText2 == '' ? 0 : 5,
                            ),
                            erroFreEntryText2 == ''
                                ? SizedBox()
                                : Text(
                                    erroFreEntryText2,
                                    style: AppTextStyle.normalErrorText1,
                                  ),
                            // report
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 3.5.h,
                                  left: 4.0.w,
                                  bottom: 1.5.h,
                                  right: 4.0.w),
                              child: Text(
                                AppMetaLabels().serviceCompletionReport,
                                style: AppTextStyle.semiBoldBlack11,
                              ),
                            ),
                            // upload service request
                            Container(
                                padding: EdgeInsets.all(2.0.h),
                                width: 88.0.w,
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
                                child: Obx(() {
                                  return controller.loadingReport.value
                                      ? Container(
                                          height: 9.h,
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.all(0.5.h),
                                          child: LoadingIndicatorBlue(),
                                        )
                                      : controller.errorLoadingReport != ''
                                          ? Center(
                                              child: SizedBox(
                                                height: 12.h,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      controller
                                                          .errorLoadingReport,
                                                      style: AppTextStyle
                                                          .semiBoldGrey10,
                                                    ),
                                                    IconButton(
                                                        onPressed: () {
                                                          controller.getFiles();
                                                        },
                                                        icon: Icon(
                                                          Icons.refresh,
                                                        ))
                                                  ],
                                                ),
                                              ),
                                            )
                                          : controller.report.value.id != null
                                              ? showReport()
                                              : controller.canClose.value
                                                  ? uploadReport()
                                                  : Text(
                                                      AppMetaLabels().noReports,
                                                      style: AppTextStyle
                                                          .normalBlack10,
                                                    );
                                })),
                            SizedBox(height: 2.h),
                            // upload photo
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 1.h,
                                  left: 4.0.w,
                                  bottom: 1.0.h,
                                  right: 4.0.w),
                              child: Text(
                                AppMetaLabels().uploadPhotos,
                                style: AppTextStyle.semiBoldBlack11,
                              ),
                            ),

                            Container(
                              margin: EdgeInsets.only(top: 1.h, bottom: 3.h),
                              padding: EdgeInsets.all(2.0.h),
                              width: 88.0.w,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(2.0.h),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 0.5.h,
                                    spreadRadius: 0.24.h,
                                    offset: Offset(0.1.h, 0.1.h),
                                  ),
                                ],
                              ),
                              child: Obx(() {
                                return controller.gettingPhotos.value
                                    ? Container(
                                        height: 9.h,
                                        alignment: Alignment.center,
                                        margin: EdgeInsets.all(0.5.h),
                                        child: LoadingIndicatorBlue(),
                                      )
                                    : controller.errorGettingPhotos != ''
                                        ? Center(
                                            child: SizedBox(
                                              height: 12.h,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    controller
                                                        .errorGettingPhotos,
                                                    style: AppTextStyle
                                                        .semiBoldGrey10,
                                                  ),
                                                  IconButton(
                                                      onPressed: () {
                                                        controller.getPhotos();
                                                      },
                                                      icon: Icon(Icons.refresh))
                                                ],
                                              ),
                                            ),
                                          )
                                        : controller.photos.length > 0
                                            ? GridView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                padding:
                                                    EdgeInsets.only(top: 1.h),
                                                gridDelegate:
                                                    SliverGridDelegateWithMaxCrossAxisExtent(
                                                        maxCrossAxisExtent:
                                                            25.w,
                                                        childAspectRatio: 3 / 2,
                                                        crossAxisSpacing: 1.w,
                                                        mainAxisSpacing: 1.w),
                                                itemCount:
                                                    controller.photos.length,
                                                itemBuilder:
                                                    (BuildContext ctx, index) {
                                                  return showImage(
                                                      context, index);
                                                })
                                            : Text(
                                                AppMetaLabels().noPhotos,
                                                style:
                                                    AppTextStyle.normalBlack10,
                                              );
                              }),
                            ),
                            // signature
                            Obx(() {
                              return controller.canClose.value &&
                                      !controller.tenantSignatureSaved.value
                                  ? Center(
                                      child: OutlinedButton(
                                        onPressed: () {
                                          showTenantSignDialog(context);
                                        },
                                        style: OutlinedButton.styleFrom(
                                          side: BorderSide(
                                            width: 0.2.w,
                                            color:
                                                Color.fromRGBO(0, 61, 166, 1),
                                            style: BorderStyle.solid,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                new BorderRadius.circular(
                                                    1.3.h),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 9.0.h, vertical: 2.h),
                                          child: Text(
                                            AppMetaLabels().takeTenantSignature,
                                            style: AppTextStyle.semiBoldWhite12
                                                .copyWith(
                                              color:
                                                  Color.fromRGBO(0, 61, 166, 1),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : SizedBox();
                            })
                          ],
                        ),
                      ),
                    ),
                  ),
                );
        }),
        // 112233 close request Button
        Container(
          width: 100.0.w,
          height: 10.0.h,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 0.5.h,
                spreadRadius: 0.5.h,
                offset: Offset(0.1.h, 0.1.h),
              ),
            ],
          ),
          child: Padding(
              padding: EdgeInsets.all(2.0.h),
              child: Obx(() {
                if (controller.report.value.loading.value) {}
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(1.3.h),
                    ),
                    backgroundColor: AppColors.colliersBlueColor,
                  ),
                  onPressed: controller.canClose.value &&
                          (controller.report.value.id != null ||
                              controller.tenantSignatureSaved.value)
                      ? () {
                          if (controller.listTitle ==
                              AppMetaLabels().selectFABCorrectiveAction) {
                            setState(() {
                              erroFABCorrectiveList = AppMetaLabels()
                                  .pleaseSelectFABCorrectiveAction;
                            });
                          }
                          if (controller
                              .textEditingControlerFET1.text.isEmpty) {
                            setState(() {
                              erroFreEntryText1 = AppMetaLabels().requiredField;
                            });
                          } else if (!textValidator.hasMatch(controller
                              .textEditingControlerFET1.text
                              .replaceAll('\n', ' '))) {
                            setState(() {
                              erroFreEntryText1 = AppMetaLabels().invalidText;
                            });
                            // return AppMetaLabels().invalidText;
                          }
                          if (controller
                              .textEditingControlerFET2.text.isEmpty) {
                            setState(() {
                              erroFreEntryText2 = AppMetaLabels().requiredField;
                            });
                            // return AppMetaLabels().requiredField;
                          } else if (!textValidator.hasMatch(controller
                              .textEditingControlerFET2.text
                              .replaceAll('\n', ' '))) {
                            setState(() {
                              erroFreEntryText2 = AppMetaLabels().invalidText;
                            });
                            // return AppMetaLabels().invalidText;
                          }
                          // SR Stands for Service Request
                          print('***********************');
                          print(controller.listTitle);
                          print(controller.textEditingControlerFET1.text);
                          print(controller.textEditingControlerFET2.text);
                          print('***********************');
                          showCloseSvcReqDialog(context);
                        }
                      : null,
                  child: Text(
                    AppMetaLabels().closeReq,
                    style: AppTextStyle.semiBoldWhite12,
                  ),
                );
              })),
        ),
      ],
    );
  }

  Column uploadReport() {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Obx(() {
        return controller.editingReport.value
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    width: 3.h, height: 3.h, child: LoadingIndicatorBlue()),
              )
            : controller.errorEditingReport
                ? IconButton(
                    onPressed: () {
                      controller.uploadReport();
                    },
                    icon: Icon(
                      Icons.refresh,
                      size: 4.5.h,
                      color: Colors.red,
                    ),
                  )
                : IconButton(
                    onPressed: () {
                      controller.pickReport();
                    },
                    icon: Image.asset(
                      AppImagesPath.downloadimg,
                      width: 4.5.h,
                      height: 4.5.h,
                      fit: BoxFit.contain,
                    ),
                  );
      }),
      Text(
        AppMetaLabels().uploadReport,
        style: AppTextStyle.semiBoldBlack10,
      ),
      SizedBox(
        height: 1.5.h,
      ),
      Text(
        AppMetaLabels().fileMustNot,
        style: AppTextStyle.normalGrey9,
      ),
    ]);
  }

  Widget showReport() {
    return InkWell(
      onTap: () {
        controller.showReport();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            AppImagesPath.pdfimg,
            width: 6.5.h,
            height: 6.5.h,
            fit: BoxFit.contain,
          ),
          Padding(
            padding: EdgeInsets.only(left: 3.0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.report.value.name ?? AppMetaLabels().report,
                  style: AppTextStyle.semiBoldBlue11,
                ),
                SizedBox(
                  height: 0.5.h,
                ),
                Text(
                  controller.report.value.size ?? '--',
                  style: AppTextStyle.normalGrey9,
                ),
              ],
            ),
          ),
          Spacer(),
          Obx(() {
            return controller.editingReport.value
                ? SizedBox(
                    width: 3.2.h, height: 3.2.h, child: LoadingIndicatorBlue())
                : !controller.canClose.value
                    ? SizedBox()
                    : InkWell(
                        onTap: () {
                          controller.removeReport();
                        },
                        child: controller.errorEditingReport
                            ? Icon(Icons.refresh, color: Colors.red)
                            : Image.asset(
                                AppImagesPath.deleteimg,
                                width: 3.2.h,
                                height: 3.2.h,
                                fit: BoxFit.contain,
                              ),
                      );
          }),
        ],
      ),
    );
  }

  void _showPicker(context, int index) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Directionality(
            textDirection: SessionController().getLanguage() == 1
                ? TextDirection.ltr
                : TextDirection.rtl,
            child: SafeArea(
              child: Container(
                color: Colors.white,
                child: new Wrap(
                  children: <Widget>[
                    new ListTile(
                        leading: new Icon(Icons.photo_library),
                        title: new Text(AppMetaLabels().photoLibrary),
                        onTap: () {
                          controller.pickPhoto(ImageSource.gallery);
                          Navigator.of(context).pop();
                        }),
                    new ListTile(
                      leading: new Icon(Icons.photo_camera),
                      title: new Text(AppMetaLabels().camera),
                      onTap: () {
                        controller.pickPhoto(ImageSource.camera);
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget showImage(BuildContext context, int index) {
    return !controller.canClose.value && controller.photos[index] == null
        ? SizedBox()
        : InkWell(
            onTap: controller.photos[index] == null
                ? () {
                    _showPicker(context, index);
                  }
                : null,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(1.h),
              child: Container(
                width: 20.0.w,
                height: 9.0.h,
                color: Color.fromRGBO(246, 248, 249, 1),
                child: controller.photos[index] != null
                    ? Stack(
                        children: [
                          InkWell(
                            onTap: () {
                              showBigImage(
                                  context, controller.photos[index]!.file!);
                            },
                            child: Image.memory(
                              controller.photos[index]!.file!,
                              width: 20.0.w,
                              height: 9.0.h,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Obx(() {
                            return controller.photos[index]!.uploading.value ||
                                    controller.photos[index]!.errorUploading
                                ? Container(
                                    width: 20.0.w,
                                    height: 9.0.h,
                                    color: Color.fromRGBO(255, 255, 255, 0.5),
                                    alignment: Alignment.center,
                                    child: controller
                                            .photos[index]!.uploading.value
                                        ? LoadingIndicatorBlue(
                                            size: 20,
                                          )
                                        : controller
                                                .photos[index]!.errorUploading
                                            ? IconButton(
                                                onPressed: () {
                                                  controller.uploadPhoto(index);
                                                },
                                                icon: Icon(
                                                  Icons.refresh_outlined,
                                                  color: Colors.red,
                                                ),
                                              )
                                            : null)
                                : !controller.canClose.value
                                    ? SizedBox()
                                    : InkWell(
                                        onTap: () {
                                          controller.removePhoto(index);
                                        },
                                        child: Container(
                                          width: 28,
                                          height: 28,
                                          decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  255, 255, 255, 0.5),
                                              borderRadius:
                                                  BorderRadius.circular(24)),
                                          padding: EdgeInsets.all(2),
                                          child: controller
                                                  .photos[index]!.removing.value
                                              ? LoadingIndicatorBlue(
                                                  size: 20,
                                                )
                                              : Icon(
                                                  controller.photos[index]!
                                                          .errorRemoving
                                                      ? Icons.refresh_outlined
                                                      : Icons.cancel_outlined,
                                                  color: Colors.red),
                                        ),
                                      );
                          }),
                        ],
                      )
                    : Center(
                        child: Text(
                          "+",
                          style: AppTextStyle.semiBoldWhite16.copyWith(
                              color: Color.fromRGBO(184, 184, 184, 1)),
                        ),
                      ),
              ),
            ),
          );
  }

  showBigImage(BuildContext context, Uint8List image) {
    showDialog(
        context: context,
        builder: (context) {
          return Material(
            child: Center(
              child: Stack(
                children: [
                  ZoomOverlay(
                      minScale: 0.5, // Optional
                      maxScale: 3.0, // Optional
                      twoTouchOnly: true, // Defaults to false
                      child: Image.memory(image)),
                  IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(Icons.cancel))
                ],
              ),
            ),
          );
        });
  }

  AwesomeDialog showCloseSvcReqDialog(BuildContext context) {
    return AwesomeDialog(
      context: context,
      animType: AnimType.scale,
      dialogType: DialogType.noHeader,
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(2.0.h),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: EdgeInsets.all(1.7.h),
                  child: Icon(
                    Icons.draw,
                    color: Colors.blue,
                    size: 3.5.h,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 2.0.h),
              child: Text(
                AppMetaLabels().vendorSignature,
                style: AppTextStyle.semiBoldBlack12,
              ),
            ),
            SignaturePad(height: 12.h, controller: signatureController1),
          ],
        ),
      ),
      dialogBorderRadius: BorderRadius.circular(2.0.h),
      btnOk: Column(
        children: [
          Obx(() {
            return controller.closingReq.value
                ? LoadingIndicatorBlue(
                    size: 4.h,
                  )
                : SizedBox(
                    height: 4.h,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(1.3.h),
                        ),
                        backgroundColor: Color.fromRGBO(255, 36, 27, 1),
                      ),
                      onPressed: () async {
                        if (signatureController1.isEmpty) {
                          // Get.snackbar(
                          //   AppMetaLabels().error,
                          //   AppMetaLabels().yourSignature,
                          //   backgroundColor: Colors.white54,
                          // );
                          SnakBarWidget.getSnackBarErrorBlue(
                            AppMetaLabels().error,
                            AppMetaLabels().yourSignature,
                          );
                        } else {
                          print(controller.listTitle);
                          print(controller.textEditingControlerFET1.text);
                          print(controller.textEditingControlerFET2.text);

                          if (await controller.closeSvcReq(
                            await signatureController1.toPngBytes(),
                            selectedFABCorrectiveAcion.toString(),
                            controller.textEditingControlerFET1.text.trim(),
                            controller.textEditingControlerFET2.text.trim(),
                          )) {
                            GetVendorServiceRequestsController
                                reqListController = Get.find();
                            SvcReqMainInfoController reqDetailsController =
                                Get.find();
                            reqDetailsController.getData();
                            reqListController.getData();
                            Navigator.pop(context);
                          }
                        }
                      },
                      child: SizedBox(
                        width: 84.w,
                        child: Center(
                          child: Text(
                            AppMetaLabels().closeReq,
                            style: AppTextStyle.semiBoldWhite11,
                          ),
                        ),
                      ),
                    ),
                  );
          }),
          OutlinedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                width: 0.2.w,
                color: Color.fromRGBO(0, 61, 166, 1),
                style: BorderStyle.solid,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(1.3.h),
              ),
            ),
            child: SizedBox(
              width: 84.w,
              child: Center(
                child: Text(
                  AppMetaLabels().cancel,
                  style: AppTextStyle.semiBoldWhite12.copyWith(
                    color: Color.fromRGBO(0, 61, 166, 1),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    )..show();
  }

  AwesomeDialog showTenantSignDialog(BuildContext context) {
    return AwesomeDialog(
      context: context,
      animType: AnimType.scale,
      dialogType: DialogType.noHeader,
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(2.0.h),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: EdgeInsets.all(1.7.h),
                  child: Icon(
                    Icons.draw,
                    color: Colors.blue,
                    size: 3.5.h,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 2.0.h),
              child: Text(
                AppMetaLabels().tenantSignature,
                style: AppTextStyle.semiBoldBlack12,
              ),
            ),
            SignaturePad(height: 16.h, controller: signatureController2),
          ],
        ),
      ),
      dialogBorderRadius: BorderRadius.circular(2.0.h),
      btnOk: Column(
        children: [
          Obx(() {
            return controller.savingTenantSign.value
                ? LoadingIndicatorBlue(
                    size: 4.h,
                  )
                : SizedBox(
                    height: 4.h,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(1.3.h),
                        ),
                        backgroundColor: AppColors.blueColor,
                      ),
                      onPressed: () async {
                        if (signatureController2.isEmpty) {
                          // Get.snackbar(AppMetaLabels().error,
                          //     AppMetaLabels().yourSignature,
                          //     backgroundColor: Colors.white54);
                          SnakBarWidget.getSnackBarErrorBlue(
                            AppMetaLabels().error,
                            AppMetaLabels().yourSignature,
                          );
                        } else {
                          if (await controller.saveTenantSignature(
                              await signatureController2.toPngBytes()))
                            Navigator.pop(context);
                        }
                      },
                      child: SizedBox(
                        width: 84.w,
                        child: Center(
                          child: Text(
                            AppMetaLabels().saveSignature,
                            style: AppTextStyle.semiBoldWhite11,
                          ),
                        ),
                      ),
                    ),
                  );
          }),
          OutlinedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                width: 0.2.w,
                color: Color.fromRGBO(0, 61, 166, 1),
                style: BorderStyle.solid,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(1.3.h),
              ),
            ),
            child: SizedBox(
              width: 84.w,
              child: Center(
                child: Text(
                  AppMetaLabels().cancel,
                  style: AppTextStyle.semiBoldWhite12.copyWith(
                    color: Color.fromRGBO(0, 61, 166, 1),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    )..show();
  }
}
