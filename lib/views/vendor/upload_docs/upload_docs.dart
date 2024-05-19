import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/screen_disable.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/error_text_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:fap_properties/views/vendor/upload_docs/upload_docs_controller.dart';
import 'package:fap_properties/views/widgets/clear_button.dart';
import 'package:fap_properties/views/widgets/custom_app_bar2.dart';
import 'package:fap_properties/views/widgets/file_view.dart';
import 'package:fap_properties/views/widgets/snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:sizer/sizer.dart';
import 'package:flutter/gestures.dart';

import '../../../data/helpers/session_controller.dart';

// 112233 upload document Vendor
// ignore: must_be_immutable
class UploadDocs extends StatefulWidget {
  final String title;
  final int caseNo;
  final int docCode;

  UploadDocs({Key key, this.caseNo, this.title, this.docCode})
      : super(key: key);

  @override
  State<UploadDocs> createState() => _UploadDocsState();
}

class _UploadDocsState extends State<UploadDocs> {
  UploadDocsController controller;
  bool isEnableScreen = true;
  @override
  Widget build(BuildContext context) {
    controller = Get.put(
        UploadDocsController(caseNo: widget.caseNo, docCode: widget.docCode));
    print('Case No :::: ${widget.caseNo}');
    print('Doc No :::: ${widget.docCode}');
    print('Case Nooooooo : ${controller.caseNo}');

    return Scaffold(
        backgroundColor: Colors.white,
        body: Directionality(
          textDirection: SessionController().getLanguage() == 1
              ? TextDirection.ltr
              : TextDirection.rtl,
          child: Stack(
            children: [
              Column(children: [
                CustomAppBar2(
                  title: widget.title ?? '',
                ),
                Expanded(
                  child: Obx(() {
                    return controller.loadingDocs.value
                        ? Center(child: LoadingIndicatorBlue())
                        : controller.errorLoadingDocs != ''
                            ? AppErrorWidget(
                                errorText: controller.errorLoadingDocs,
                              )
                            : Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 2.h, horizontal: 4.w),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          AppMetaLabels().caseNo,
                                          style: AppTextStyle.semiBoldBlack12,
                                        ),
                                        Text(
                                          controller.caseNo.toString(),
                                          style: AppTextStyle.semiBoldBlack12,
                                        )
                                      ],
                                    ),
                                  ),
                                  AppDivider(),
                                  Expanded(
                                    child: ListView.builder(
                                        padding: EdgeInsets.zero,
                                        itemCount: 2, //controller.docs.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                              padding: EdgeInsets.all(2.0.h),
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 4.0.w,
                                                          bottom: 2.0.h,
                                                          right: 4.0.w),
                                                      child: Text(
                                                        controller
                                                            .docs[index].name,
                                                        style: AppTextStyle
                                                            .semiBoldBlack12,
                                                      ),
                                                    ),
                                                    controller.docs[index].id ==
                                                                null ||
                                                            controller
                                                                .docs[index]
                                                                .isRejected
                                                        ? uploadFile(
                                                            context, index)
                                                        : Container(
                                                            width: 100.0.w,
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        1.h,
                                                                    horizontal:
                                                                        4.w),
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          2.0.h),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: Colors
                                                                      .black12,
                                                                  blurRadius:
                                                                      0.5.h,
                                                                  spreadRadius:
                                                                      0.1.h,
                                                                  offset: Offset(
                                                                      0.1.h,
                                                                      0.1.h),
                                                                ),
                                                              ],
                                                            ),
                                                            child: FileView(
                                                              file: controller
                                                                  .docs[index],
                                                              onDelete:
                                                                  () async {
                                                                setState(() {
                                                                  isEnableScreen =
                                                                      false;
                                                                });
                                                                await controller
                                                                    .removeFile(
                                                                        index);
                                                                setState(() {
                                                                  controller
                                                                      .docs[
                                                                          index]
                                                                      .expiry = '';
                                                                  isEnableScreen =
                                                                      true;
                                                                });
                                                              },
                                                              onPressed:
                                                                  () async {
                                                                setState(() {
                                                                  isEnableScreen =
                                                                      false;
                                                                });
                                                                await controller
                                                                    .downloadDoc(
                                                                        index);
                                                                setState(() {
                                                                  isEnableScreen =
                                                                      true;
                                                                });
                                                              },
                                                            ),
                                                          )
                                                  ]));
                                        }),
                                  ),
                                ],
                              );
                  }),
                ),
              ]),
              isEnableScreen == false ? ScreenDisableWidget() : SizedBox(),
            ],
          ),
        ));
  }

  Container uploadFile(BuildContext context, int index) {
    return Container(
        width: 100.0.w,
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
            padding: EdgeInsets.only(
                top: 3.5.h, left: 4.0.w, bottom: 3.5.h, right: 4.0.w),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (controller.docs[index].isRejected)
                    RichText(
                      text: TextSpan(
                          text: '${AppMetaLabels().your} ',
                          style: AppTextStyle.normalErrorText3,
                          children: <TextSpan>[
                            TextSpan(
                                text: controller.docs[index].name,
                                style: AppTextStyle.normalBlue10,
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    setState(() {
                                      isEnableScreen = false;
                                    });

                                    if (!controller.docs[index].loading.value)
                                      await controller.downloadDoc(index);

                                    setState(() {
                                      isEnableScreen = true;
                                    });
                                  }),
                            TextSpan(
                                text: ' ${AppMetaLabels().fileRejected}',
                                style: AppTextStyle.normalErrorText3)
                          ]),
                    ),
                  SizedBox(
                    height: 8,
                  ),
                  Obx(() {
                    if (controller.docs[index].update.value) {}
                    return controller.docs[index].path != null
                        ? FileView(
                            file: controller.docs[index],
                            onPressed: () {
                              controller.showFile(controller.docs[index]);
                            },
                            onDelete: () async {
                              setState(() {
                                isEnableScreen = false;
                              });
                              await controller.removePickedFile(index);

                              setState(() {
                                controller.docs[index].expiry = '';
                                isEnableScreen = true;
                              });
                              setState(() {
                                if (controller
                                        .selectedIndexForUploadedDocument ==
                                    index) {
                                  controller.selectedIndexForUploadedDocument =
                                      -1;
                                }
                              });
                            },
                          )
                        : IconButton(
                            onPressed: () async {
                              await controller.pickDoc(index);
                              setState(() {});
                            },
                            icon: Image.asset(
                              AppImagesPath.downloadimg,
                              width: 4.5.h,
                              height: 4.5.h,
                              fit: BoxFit.contain,
                            ),
                          );
                  }),
                  SizedBox(
                    height: 2.5.h,
                  ),
                  Text(
                    AppMetaLabels().uploadYourDoc,
                    style: AppTextStyle.semiBoldBlack10,
                  ),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  Text(
                    AppMetaLabels().filedetails,
                    style: AppTextStyle.normalGrey9,
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${AppMetaLabels().expDate} *',
                        style: AppTextStyle.semiBoldBlack10,
                      ),
                      InkWell(
                        onTap: () async {
                          var expDate = await showRoundedDatePicker(
                            height: 50.0.h,
                            context: context,
                            // locale: Locale('en'),
                            locale: SessionController().getLanguage() == 1
                                ? Locale('en', '')
                                : Locale('ar', ''),
                            initialDate: DateTime.now(),
                            firstDate:
                                DateTime.now().subtract(Duration(seconds: 1)),
                            lastDate: DateTime(DateTime.now().year + 20),
                            borderRadius: 2.0.h,
                          );

                          if (expDate != null) {
                            if (expDate.isBefore(DateTime.now()) ||
                                expDate.isAtSameMomentAs(DateTime.now())) {
                              SnakBarWidget.getSnackBarErrorBlue(
                                AppMetaLabels().error,
                                AppMetaLabels().selectFuturedate,
                              );
                            } else {
                              intl.DateFormat dateFormat = new intl.DateFormat(
                                  AppMetaLabels()
                                      .dateFormatForShowRoundedDatePicker);
                              // intl.DateFormat dateFormat = new intl.DateFormat(
                              //     AppMetaLabels().dateFormat);
                              controller.setExpDate(
                                  index, dateFormat.format(expDate));
                              setState(() {
                                if (controller
                                        .selectedIndexForUploadedDocument ==
                                    index) {
                                  controller.selectedIndexForUploadedDocument =
                                      -1;
                                }
                              });
                            }
                          }
                        },
                        child: Container(
                          width: 40.0.w,
                          height: 5.5.h,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(246, 248, 249, 1),
                              borderRadius: BorderRadius.circular(1.0.h),
                              border: Border.all(
                                  color: index ==
                                          controller
                                              .selectedIndexForUploadedDocument
                                      ? Colors.red
                                      : Colors.transparent)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 1.0.h),
                                child: Obx(() {
                                  if (controller.docs[index].update.value) {}
                                  return Text(
                                    controller.docs[index].expiry ?? '',
                                    style: AppTextStyle.normalBlack12,
                                  );
                                }),
                              ),
                              Spacer(),
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 1.0.h),
                                child: ClearButton(
                                  clear: () {
                                    controller.clearExpDate(index);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  controller.selectedIndexForUploadedDocument == index
                      ? SizedBox(
                          height: 20,
                          child: Center(
                              child: Text(
                            // 'Please select expiry date',
                            AppMetaLabels().pleaseSelectExpiryDate,
                            style: TextStyle(color: Colors.blue),
                          )))
                      : SizedBox(
                          height: 10,
                        ),
                  Container(
                      margin: EdgeInsets.only(top: 3.h),
                      width: 50.w,
                      height: 5.h,
                      child: Obx(() {
                        return controller.docs[index].loading.value
                            ? LoadingIndicatorBlue(size: 3.h)
                            : controller.docs[index].errorLoading
                                ? IconButton(
                                    onPressed: () async {
                                      setState(() {
                                        isEnableScreen = false;
                                      });
                                      await controller.uploadDoc(index);
                                      setState(() {
                                        isEnableScreen = true;
                                      });
                                    },
                                    icon: Icon(
                                      Icons.refresh,
                                      size: 4.5.h,
                                      color: Colors.red,
                                    ),
                                  )
                                : Obx(() {
                                    if (controller.docs[index].update.value) {}
                                    return ElevatedButton(
                                      onPressed:
                                          controller.docs[index].expiry ==
                                                      null ||
                                                  controller.docs[index].path ==
                                                      null
                                              ? null
                                              : () async {
                                                  setState(() {
                                                    isEnableScreen = false;
                                                  });

                                                  if (controller
                                                      .docs[index].isRejected)
                                                    await controller
                                                        .updateDoc(index);
                                                  else
                                                    await controller
                                                        .uploadDoc(index);

                                                  setState(() {
                                                    isEnableScreen = true;
                                                  });
                                                },
                                      child: Text(
                                        AppMetaLabels().submit,
                                        style: AppTextStyle.semiBoldWhite12,
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(1.3.h),
                                        ),
                                        backgroundColor:
                                            Color.fromRGBO(0, 61, 166, 1),
                                      ),
                                    );
                                  });
                      }))
                ])));
  }
}
