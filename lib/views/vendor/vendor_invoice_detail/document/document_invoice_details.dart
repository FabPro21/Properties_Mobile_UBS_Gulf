import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/screen_disable.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/vendor/vendor_invoice_detail/document/document_invoice_details_controller.dart';
import 'package:fap_properties/views/vendor/vendor_invoice_detail/vendor_invoice_details_controller.dart';
import 'package:fap_properties/views/widgets/common_widgets/error_text_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:fap_properties/views/widgets/bottom_shadow.dart';
import 'package:fap_properties/views/widgets/file_view.dart';
import 'package:fap_properties/views/widgets/snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui' as ui;

class VendorInvoiceDocumentsDetails extends StatefulWidget {
  final String? caseNo;
  final String? caller;
  VendorInvoiceDocumentsDetails({
    Key? key,
    this.caseNo,
    this.caller,
  }) : super(key: key) {
    Get.put(VendorInvoiceDocsController(caseNo: caseNo));
  }

  @override
  _VendorInvoiceDocumentsDetailsState createState() =>
      _VendorInvoiceDocumentsDetailsState();
}

class _VendorInvoiceDocumentsDetailsState
    extends State<VendorInvoiceDocumentsDetails> {
  final controller = Get.find<VendorInvoiceDocsController>();
  final detailController = Get.find<VendorInvoiceDetailsController>();
  bool _isSolving = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // controller.getFiles();
      getInformation();
    });
    print('Case No :::::: ${widget.caseNo}');
    print('ReqID :::::: ${detailController.reqID}');
    print('downloading ::::: ${widget.caseNo}');
    super.initState();
  }

  getInformation() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        _isSolving = true;
      });
      await controller.getFiles();
      setState(() {
        _isSolving = false;
      });
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

// Tab for DOCUMENTS upload
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
          key: _scaffoldKey,
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: _isSolving == true
              ? Center(child: LoadingIndicatorBlue())
              : Stack(
                  children: [
                    // the below loading indicator is just for removing (A RenderFlex overflowed by 99449 pixels on the bottom.)
                    // this error , there is no other logic behind this
                    controller.docs.isEmpty
                        ? Center(child: SizedBox())
                        : controller.loadingDocs.value
                            ? Center(child: LoadingIndicatorBlue())
                            : Column(
                                children: [
                                  Expanded(
                                    child: Obx(() {
                                      return controller.loadingDocs.value
                                          ? Center(
                                              child: LoadingIndicatorBlue())
                                          : controller.errorLoadingDocs != ''
                                              ? AppErrorWidget(
                                                  errorText: controller
                                                      .errorLoadingDocs,
                                                )
                                              : Container(
                                                  child: ListView.builder(
                                                      padding: EdgeInsets.zero,
                                                      itemCount: controller
                                                          .docs.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    2.0.h),
                                                            child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsets.only(
                                                                        left: 4.0
                                                                            .w,
                                                                        bottom: 2.0
                                                                            .h,
                                                                        right: 4.0
                                                                            .w),
                                                                    child: Text(
                                                                      SessionController().getLanguage() ==
                                                                              1
                                                                          ? controller.docs[index].name ??
                                                                              ""
                                                                          : controller.docs[index].nameAr ??
                                                                              '',
                                                                      style: AppTextStyle
                                                                          .semiBoldBlack12,
                                                                    ),
                                                                  ),
                                                                  controller.docs[index].id ==
                                                                              null ||
                                                                          controller
                                                                              .docs[
                                                                                  index]
                                                                              .isRejected!
                                                                      ? uploadFile(
                                                                          context,
                                                                          index)
                                                                      : Container(
                                                                          width:
                                                                              100.0.w,
                                                                          padding: EdgeInsets.symmetric(
                                                                              vertical: 1.h,
                                                                              horizontal: 4.w),
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                Colors.white,
                                                                            borderRadius:
                                                                                BorderRadius.circular(2.0.h),
                                                                            boxShadow: [
                                                                              BoxShadow(
                                                                                color: Colors.black12,
                                                                                blurRadius: 0.5.h,
                                                                                spreadRadius: 0.1.h,
                                                                                offset: Offset(0.1.h, 0.1.h),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          child:
                                                                              FileView(
                                                                            file:
                                                                                controller.docs[index],
                                                                            onDelete:
                                                                                () {
                                                                              print('Anhan:::');
                                                                            },
                                                                            //     () async {
                                                                            //       print('Anhan:::');
                                                                            //   setState(() {
                                                                            //     controller.isEnableScreen.value = false;
                                                                            //   });
                                                                            //   await controller.removeFile(index);
                                                                            //   setState(() {
                                                                            //     controller.isEnableScreen.value = true;
                                                                            //   });
                                                                            // },
                                                                            onPressed:
                                                                                () {
                                                                              setState(() {
                                                                                controller.isEnableScreen.value = false;
                                                                              });
                                                                              print('downloading ::::: ${int.parse(detailController.caseNoInvoice.toString())}');
                                                                              controller.downloadDoc(index, int.parse(detailController.caseNoInvoice.toString()));

                                                                              setState(() {
                                                                                controller.isEnableScreen.value = true;
                                                                              });
                                                                            },
                                                                            canDelete:
                                                                                false,
                                                                          ),
                                                                        )
                                                                ]));
                                                      }),
                                                );
                                    }),
                                  ),
                                  // SingleChildScrollView(
                                  //   child: Obx(() {
                                  //     return controller.loadingDocs.value
                                  //         ? SizedBox()
                                  //         : Align(
                                  //             alignment: Alignment.bottomCenter,
                                  //             child: Container(
                                  //               width: 100.0.w,
                                  //               height: 9.0.h,
                                  //               decoration: BoxDecoration(
                                  //                 color: Colors.white,
                                  //                 boxShadow: [
                                  //                   BoxShadow(
                                  //                     color: Colors.black12,
                                  //                     blurRadius: 0.5.h,
                                  //                     spreadRadius: 0.5.h,
                                  //                     offset:
                                  //                         Offset(0.1.h, 0.1.h),
                                  //                   ),
                                  //                 ],
                                  //               ),
                                  //               child: Padding(
                                  //                 padding:
                                  //                     EdgeInsets.all(2.0.h),
                                  //                 child: controller
                                  //                         .loadingDocs.value
                                  //                     ? LoadingIndicatorBlue()
                                  //                     : ElevatedButton(
                                  //                         onPressed: !controller
                                  //                                 .enableSubmit
                                  //                                 .value
                                  //                             ? null
                                  //                             : () async {
                                  //                                 // setState(() {
                                  //                                 //   controller.isEnableScreen =
                                  //                                 //       false;
                                  //                                 // });
                                  //                                 // fuc call for all insertions
                                  //                                 // setState(() {
                                  //                                 //   controller.isEnableScreen =
                                  //                                 //       true;
                                  //                                 // });
                                  //                               },
                                  //                         child: SizedBox(
                                  //                           width: 40.w,
                                  //                           child: Center(
                                  //                             child: Text(
                                  //                               AppMetaLabels()
                                  //                                   .submit,
                                  //                               style: AppTextStyle
                                  //                                   .semiBoldWhite12,
                                  //                             ),
                                  //                           ),
                                  //                         ),
                                  //                         style: ElevatedButton
                                  //                             .styleFrom(
                                  //                           shape:
                                  //                               RoundedRectangleBorder(
                                  //                             borderRadius:
                                  //                                 BorderRadius
                                  //                                     .circular(
                                  //                                         1.3.h),
                                  //                           ),
                                  //                           backgroundColor: controller
                                  //                                   .enableSubmit
                                  //                                   .value
                                  //                               ? Color
                                  //                                   .fromRGBO(
                                  //                                       0,
                                  //                                       61,
                                  //                                       166,
                                  //                                       1)
                                  //                               : Colors.grey
                                  //                                   .shade400,
                                  //                         ),
                                  //                       ),
                                  //               ),
                                  //             ),
                                  //           );
                                  //   }),
                                  // ),
                                ],
                              ),
                    Obx(() {
                      return controller.isEnableScreen.value == false
                          ? ScreenDisableWidget()
                          : SizedBox();
                    }),

                    BottomShadow(),
                  ],
                )),
    );
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
                  if (controller.docs[index].isRejected!)
                    RichText(
                      text: TextSpan(
                          text: '${AppMetaLabels().your} ',
                          style: AppTextStyle.normalErrorText3,
                          children: <TextSpan>[
                            TextSpan(
                                text: controller.docs[index].name,
                                style: AppTextStyle.normalBlue10,
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    if (!controller.docs[index].loading.value) {
                                      setState(() {
                                        controller.isEnableScreen.value = false;
                                      });
                                      print(
                                          'downloading ::::: ${int.parse(detailController.caseNoInvoice.toString())}');
                                      controller.downloadDoc(
                                          index,
                                          int.parse(detailController
                                              .caseNoInvoice
                                              .toString()));
                                      setState(() {
                                        controller.isEnableScreen.value = true;
                                      });
                                      setState(() {
                                        controller.isEnableScreen.value = true;
                                      });
                                    }
                                  }),
                            TextSpan(
                                text: ' ${AppMetaLabels().fileRejected}',
                                style: AppTextStyle.normalErrorText3)
                          ]),
                    ),
                  SizedBox(
                    height: 8,
                  ),
                  // upload document icon/Button
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
                                controller.isEnableScreen.value = false;
                              });
                              await controller.removePickedFile(index);
                              setState(() {
                                controller.isDocUploaded[index] = 'false';
                              });
                              setState(() {
                                if (controller
                                        .selectedIndexForUploadedDocument ==
                                    index) {
                                  controller.selectedIndexForUploadedDocument =
                                      -1;
                                }
                              });
                              setState(() {
                                controller.isEnableScreen.value = true;
                              });
                            },
                            canDelete: true,
                          )
                        : IconButton(
                            onPressed: () async {
                              bool? isTrue;
                              print(controller.isDocUploaded);
                              for (int i = 0;
                                  i < controller.isDocUploaded.length;
                                  i++) {
                                print(controller.isDocUploaded[i] == 'true');
                                if (controller.isDocUploaded[i] == 'true') {
                                  setState(() {
                                    isTrue = true;
                                  });
                                }
                              }
                              if (isTrue == true) {
                                SnakBarWidget.getSnackBarErrorBlue(
                                    AppMetaLabels().alert,
                                    AppMetaLabels().uploadAttachedDocFirst);
                                return;
                              }
                              await _showPickerForDoc(context, index);
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
                  // 112233 Upload Document
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
                    height: 2.h,
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 3.h),
                      width: 50.w,
                      height: 5.h,
                      child: Obx(() {
                        return controller.docs[index].loading.value
                            ? LoadingIndicatorBlue(
                                size: 3.h,
                              )
                            : controller.docs[index].errorLoading
                                ? IconButton(
                                    onPressed: () async {
                                      setState(() {
                                        controller.isEnableScreen.value = false;
                                      });
                                      print(
                                          'Uploading :::::: ${widget.caseNo}');
                                      await controller.uploadDoc(
                                          index,
                                          int.parse(detailController
                                              .caseNoInvoice
                                              .toString()),
                                          detailController.reqID.toString());
                                      setState(() {
                                        controller.isEnableScreen.value = true;
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
                                          controller.docs[index].path == null
                                              ? null
                                              : () async {
                                                  // setState(() {
                                                  //   controller.isEnableScreen =
                                                  //       false;
                                                  // });

                                                  if (controller
                                                      .docs[index].isRejected!)
                                                    controller.updateDoc(index);

                                                  print(
                                                      'Uploading :::::: ${widget.caseNo}');

                                                  await controller.uploadDoc(
                                                      index,
                                                      int.parse(detailController
                                                          .caseNoInvoice
                                                          .toString()),
                                                      detailController.reqID
                                                          .toString());
                                                  setState(() {
                                                    controller.isEnableScreen
                                                        .value = true;
                                                  });
                                                },
                                      child: Text(
                                        AppMetaLabels().upload,
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

// upload docs and other pic from here
  _showPickerForDoc(context, int index) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Directionality(
              textDirection: SessionController().getLanguage() == 1
                  ? ui.TextDirection.ltr
                  : ui.TextDirection.rtl,
              child: Container(
                color: Colors.white,
                child: new Wrap(
                  children: <Widget>[
                    new ListTile(
                        leading: new Icon(Icons.storage),
                        title: new Text(AppMetaLabels().storage),
                        onTap: () async {
                          print('Index ::::::  $index');
                          // new S 6 jul 2023
                          // if ((await Permission.storage
                          //         .request()
                          //         .isPermanentlyDenied) &&
                          //     io.Platform.isAndroid) {
                          //   print(':::::::::::::: Permission');
                          //   await PermissionHandlerClass().permissions(
                          //     'Storage',
                          //     context,
                          //   );
                          //   return;
                          // }
                          // if ((await Permission.storage
                          //             .request()
                          //             .isPermanentlyDenied ==
                          //         true) &&
                          //     io.Platform.isIOS) {
                          //   print(':::::::::::::: Permission');
                          //   await PermissionHandlerClass().permissions(
                          //     'Storage',
                          //     context,
                          //   );
                          //   return;
                          // }
                          // new E 6 jul 2023
                          await controller.pickDoc(index, context);
                          setState(() {});
                          setState(() {});
                          Navigator.of(context).pop();
                        }),
                    new ListTile(
                      leading: new Icon(Icons.photo_camera),
                      title: new Text(AppMetaLabels().camera),
                      onTap: () async {
                        // new S 6 jul 2023
                        // if ((await Permission.camera
                        //         .request()
                        //         .isPermanentlyDenied) &&
                        //     io.Platform.isAndroid) {
                        //   await PermissionHandlerClass().permissions(
                        //     'Camera',
                        //     context,
                        //   );
                        //   return;
                        // }
                        // if ((await Permission.camera
                        //             .request()
                        //             .isPermanentlyDenied ==
                        //         true) &&
                        //     io.Platform.isIOS) {
                        //   await PermissionHandlerClass().permissions(
                        //     'Camera',
                        //     context,
                        //   );
                        //   return;
                        // }
                        // new E 6 jul 2023
                        await controller.takePhoto(index, context);
                        setState(() {});
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
}
