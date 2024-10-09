// ignore_for_file: unused_local_variable, unnecessary_null_comparison, deprecated_member_use

import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/data/models/tenant_models/card_model.dart';
import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/screen_disable.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/utils/text_validator.dart';
import 'package:fap_properties/views/tenant/tenant_dashboard/tenant_dashboard_tabs/tenant_dashboard_tabs.dart';
import 'package:fap_properties/views/tenant/tenant_services_request/tenant_request_details/tenant_request_details_controller.dart';
import 'package:fap_properties/views/widgets/common_widgets/error_text_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:fap_properties/views/tenant/tenant_services_request/tenant_request_details/tenant_service_request_tab/svc_req_docs_controller.dart';
import 'package:fap_properties/views/widgets/bottom_shadow.dart';
import 'package:fap_properties/views/widgets/clear_button.dart';
import 'package:fap_properties/views/widgets/file_view.dart';
import 'package:fap_properties/views/widgets/snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';

class TenantServiceDocuments extends StatefulWidget {
  final String? caseNo;
  final String? caller;
  TenantServiceDocuments({Key? key, this.caseNo, this.caller})
      : super(key: key) {
    Get.put(SvcReqDocsController(caseNo: caseNo));
  }

  @override
  _TenantServiceDocumentsState createState() => _TenantServiceDocumentsState();
}

class _TenantServiceDocumentsState extends State<TenantServiceDocuments> {
  final controller = Get.find<SvcReqDocsController>();
  final mainScreenController = Get.find<TenantRequestDetailsController>();

  // TextEditingController will use in the EID confirmation
  TextEditingController nameText = TextEditingController();
  TextEditingController iDNumberText = TextEditingController();
  var maskFormatter = MaskedInputFormatter(
    '###-####-#######-#',
    allowedCharMatcher: RegExp(r'[0-9]'),
  );

  String dOBText = '';
  String expiryText = '';
  bool isNameError = false;
  bool isIDError = false;
  bool isDOBError = false;
  bool isExpiryError = false;

  bool _isSolving = false;
  bool isEnableScreen = true;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // controller.getFiles();
      print('***********1**** ${widget.caller}');
      print('**********2***** ${mainScreenController.feedback}');
      print(
          '***********3**** ${mainScreenController.tenantRequestDetails.value.detail?.propertyNameAr}');
      print(
          '***********4**** ${mainScreenController.tenantRequestDetails.value.detail?.contactName}');
      print(
          '***********5**** ${mainScreenController.tenantRequestDetails.value.detail?.caseCategouryId}');
      print(
          '***********6**** ${mainScreenController.tenantRequestDetails.value.detail?.caseSubCatagouryId}');
      print(
          '***********7**** ${mainScreenController.tenantRequestDetails.value.detail?.caseType}');
      getInformation();
    });
    super.initState();
  }

  getInformation() async {
    setState(() {
      _isSolving = true;
    });
    print('*************** ${widget.caller}');
    await controller.getFiles();
    setState(() {});
    setState(() {});
    setState(() {
      _isSolving = false;
    });
  }

  bool highLightExpiry = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
                    controller.loadingDocs.value
                        ? Center(child: LoadingIndicatorBlue())
                        : Column(
                            children: [
                              Expanded(
                                child: Obx(() {
                                  return controller.loadingDocs.value
                                      ? Center(child: LoadingIndicatorBlue())
                                      : controller.errorLoadingDocs != ''
                                          ? AppErrorWidget(
                                              errorText:
                                                  controller.errorLoadingDocs,
                                            )
                                          : controller.docsModel?.docs == null
                                              ? SizedBox()
                                              : Container(
                                                  child: ListView.builder(
                                                      padding: EdgeInsets.zero,
                                                      itemCount: controller
                                                              .docsModel
                                                              ?.docs
                                                              ?.length ??
                                                          0 + 1,
                                                      itemBuilder:
                                                          (context, index) {
                                                        if (controller
                                                                .docsModel
                                                                ?.docs
                                                                ?.length ==
                                                            index) {
                                                          return Center(
                                                              child: Obx(() {
                                                            return controller
                                                                        .docsModel!
                                                                        .caseStageInfo!
                                                                        .stageId!
                                                                        .value <
                                                                    3
                                                                ? Column(
                                                                    children: [
                                                                      Padding(
                                                                        padding: EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                4.w,
                                                                            vertical: 2.h),
                                                                        child:
                                                                            Text(
                                                                          AppMetaLabels()
                                                                              .allMandatory,
                                                                          style:
                                                                              AppTextStyle.normalBlack10,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  )
                                                                : controller.docsModel?.responseMessageAR ==
                                                                            '' &&
                                                                        SessionController().getLanguage() !=
                                                                            1
                                                                    ? SizedBox()
                                                                    : controller.docsModel?.caseStageInfo?.stageId?.value ==
                                                                            4
                                                                        ? Container(
                                                                            alignment:
                                                                                Alignment.center,
                                                                            padding:
                                                                                EdgeInsets.all(8.0),
                                                                            margin:
                                                                                EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
                                                                            decoration:
                                                                                BoxDecoration(color: Color.fromRGBO(255, 249, 235, 1), borderRadius: BorderRadius.circular(8)),
                                                                            child:
                                                                                Row(
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              children: [
                                                                                Icon(
                                                                                  Icons.error_outline,
                                                                                  color: Colors.amber[400],
                                                                                ),
                                                                                SizedBox(
                                                                                  width: 8.0,
                                                                                ),
                                                                                Expanded(
                                                                                  child: Text(
                                                                                    SessionController().getLanguage() == 1 ? controller.docsModel?.responseMessage ?? '' : controller.docsModel?.responseMessageAR ?? "",
                                                                                    style: AppTextStyle.normalBlack12,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          )
                                                                        : SizedBox();
                                                          }));
                                                        }
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
                                                                          ? controller.docsModel?.docs![index].name ??
                                                                              ""
                                                                          : controller.docsModel?.docs?[index].nameAr ??
                                                                              '',
                                                                      style: AppTextStyle
                                                                          .semiBoldBlack12,
                                                                    ),
                                                                  ),
                                                                  controller.docsModel?.docs?[index].id ==
                                                                              null ||
                                                                          controller.docsModel?.docs?[index].isRejected ==
                                                                              true
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
                                                                              Obx(() {
                                                                            return FileView(
                                                                              file: controller.docsModel?.docs?[index],
                                                                              onDelete: controller.docsModel?.docs?[index].loading.value == true
                                                                                  ? () {}
                                                                                  : () async {
                                                                                      if (controller.docsModel?.docs?[index].name!.toLowerCase() == 'emirate id') {
                                                                                        setState(() {
                                                                                          isEnableScreen = false;
                                                                                        });
                                                                                        setState(() {
                                                                                          controller.mergedId = null;
                                                                                          controller.cardScanModel = CardScanModel();
                                                                                        });
                                                                                        setState(() {
                                                                                          nameText.clear();
                                                                                          iDNumberText.clear();
                                                                                          expiryText = '';
                                                                                          dOBText = '';
                                                                                          controller.mergedId = null;
                                                                                          controller.cardScanModel.backImage = null;
                                                                                          controller.cardScanModel.frontImage = null;
                                                                                        });
                                                                                        await controller.removePickedFile(index);
                                                                                        await controller.removeFile(index);
                                                                                        setState(() {
                                                                                          controller.isDocUploaded[index] = 'false';
                                                                                        });
                                                                                        setState(() {
                                                                                          isEnableScreen = true;
                                                                                        });
                                                                                        return;
                                                                                      }
                                                                                      setState(() {
                                                                                        isEnableScreen = false;
                                                                                      });
                                                                                      await controller.removeFile(index);
                                                                                      setState(() {
                                                                                        isEnableScreen = true;
                                                                                      });
                                                                                    },
                                                                              onPressed: () {
                                                                                print('Testing .....');
                                                                                controller.downloadDoc(index);
                                                                              },
                                                                              canDelete: controller.docsModel!.caseStageInfo!.stageId!.value < 3,
                                                                            );
                                                                          }),
                                                                        )
                                                                ]));
                                                      }),
                                                );
                                }),
                              ),
                              controller.docsModel?.docs == null
                                  ? SizedBox()
                                  : SingleChildScrollView(
                                      child: Obx(() {
                                        // implementing the caseCategouryId && caseSubCatagouryId condition
                                        // because we want to show submit button inside the SR detail?  Documents Tab
                                        // when caseCatID and caseSubCatID == 8 and 88 respectively it means that this req is
                                        // renewal Req then will show submit button and if not then will not show submit button
                                        // because it is not a renewal req
                                        return mainScreenController
                                                        .tenantRequestDetails
                                                        .value
                                                        .detail!
                                                        .caseCategouryId !=
                                                    8 &&
                                                mainScreenController
                                                        .tenantRequestDetails
                                                        .value
                                                        .detail!
                                                        .caseSubCatagouryId !=
                                                    88
                                            ? SizedBox()
                                            : controller.docsModel
                                                        ?.caseStageInfo ==
                                                    null
                                                ? SizedBox()
                                                : controller.loadingDocs.value
                                                    ? SizedBox()
                                                    : controller
                                                                .docsModel!
                                                                .caseStageInfo!
                                                                .stageId!
                                                                .value >=
                                                            3
                                                        ? SizedBox()
                                                        : Align(
                                                            alignment: Alignment
                                                                .bottomCenter,
                                                            child: Container(
                                                              width: 100.0.w,
                                                              height: 9.0.h,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: Colors
                                                                        .black12,
                                                                    blurRadius:
                                                                        0.5.h,
                                                                    spreadRadius:
                                                                        0.5.h,
                                                                    offset: Offset(
                                                                        0.1.h,
                                                                        0.1.h),
                                                                  ),
                                                                ],
                                                              ),
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(2.0
                                                                            .h),
                                                                child: controller
                                                                        .updatingDocStage
                                                                        .value
                                                                    ? LoadingIndicatorBlue()
                                                                    : ElevatedButton(
                                                                        onPressed: !controller.enableSubmit.value
                                                                            ? null
                                                                            : () async {
                                                                                setState(() {
                                                                                  isEnableScreen = false;
                                                                                });
                                                                                await controller.updateDocStage(widget.caller ?? "");
                                                                                setState(() {
                                                                                  isEnableScreen = true;
                                                                                });
                                                                                if (controller.docsModel!.caseStageInfo!.stageId!.value >= 3) {
                                                                                  showDialog(
                                                                                      context: context,
                                                                                      barrierDismissible: false,
                                                                                      builder: (BuildContext context) {
                                                                                        return AlertDialog(
                                                                                          contentPadding: EdgeInsets.zero,
                                                                                          backgroundColor: Colors.transparent,
                                                                                          content: showDialogData(),
                                                                                        );
                                                                                      });
                                                                                }
                                                                              },
                                                                        child:
                                                                            SizedBox(
                                                                          width:
                                                                              40.w,
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                Text(
                                                                              AppMetaLabels().submit,
                                                                              style: AppTextStyle.semiBoldWhite12,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        style: ElevatedButton
                                                                            .styleFrom(
                                                                          shape:
                                                                              RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(1.3.h),
                                                                          ),
                                                                          backgroundColor: controller.enableSubmit.value
                                                                              ? Color.fromRGBO(0, 61, 166, 1)
                                                                              : Colors.grey.shade400,
                                                                        ),
                                                                      ),
                                                              ),
                                                            ),
                                                          );
                                      }),
                                    ),
                            ],
                          ),
                    isEnableScreen == false
                        ? ScreenDisableWidget()
                        : SizedBox(),
                    Obx(() {
                      return controller.isLoadingForScanning.value == true
                          ? Container(
                              height: double.infinity,
                              width: double.infinity,
                              color: Colors.black.withOpacity(0.3),
                              child: Center(
                                  child: CircularProgressIndicator(
                                backgroundColor: Colors.white,
                                color: Colors.blue,
                              )),
                            )
                          : SizedBox();
                    }),
                    BottomShadow(),
                  ],
                )),
    );
  }

  Container uploadFile(BuildContext context, int index) {
    print('Index :::::: => $index');
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
            padding: EdgeInsets.only(left: 4.0.w, bottom: 3.5.h, right: 4.0.w),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (controller.docsModel?.docs?[index].isRejected == true)
                    RichText(
                      text: TextSpan(
                          text: '${AppMetaLabels().your} ',
                          style: AppTextStyle.normalErrorText3,
                          children: <TextSpan>[
                            TextSpan(
                                text: SessionController().getLanguage() == 1
                                    ? controller.docsModel?.docs![index].name ??
                                        ""
                                    : controller
                                            .docsModel?.docs?[index].nameAr ??
                                        "",
                                style: AppTextStyle.normalBlue10,
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    if (controller.docsModel?.docs?[index]
                                            .loading.value ==
                                        false) {
                                      setState(() {
                                        isEnableScreen = false;
                                      });
                                      controller.downloadDocRejected(index);
                                      // controller.downloadDoc(index);
                                      setState(() {
                                        isEnableScreen = true;
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
                  Obx(() {
                    if (controller.docsModel?.docs?[index].update.value ==
                        true) {}
                    return controller.docsModel?.docs?[index].path != null
                        ? FileView(
                            file: controller.docsModel?.docs?[index],
                            onPressed: () {
                              controller
                                  .showFile(controller.docsModel?.docs?[index]);
                            },
                            onDelete: controller.docsModel?.docs?[index].loading
                                        .value ==
                                    true
                                ? () {}
                                : () async {
                                    setState(() {
                                      isEnableScreen = false;
                                    });
                                    setState(() {
                                      nameText.clear();
                                      iDNumberText.clear();
                                      expiryText = '';
                                      dOBText = '';
                                    });
                                    if (controller.docsModel?.docs?[index].name!
                                            .toLowerCase() ==
                                        'emirate id') {
                                      setState(() {
                                        controller.cardScanModel.frontImage =
                                            null;
                                        controller.cardScanModel.backImage =
                                            null;
                                        controller.mergedId = null;
                                      });
                                    }
                                    await controller.removePickedFile(index);
                                    setState(() {
                                      controller.isDocUploaded[index] = 'false';
                                      controller.docsModel?.docs?[index]
                                          .errorLoading = false;
                                    });
                                    setState(() {
                                      highLightExpiry = false;
                                      if (controller
                                              .selectedIndexForUploadedDocument ==
                                          index) {
                                        controller
                                            .selectedIndexForUploadedDocument = -1;
                                      }
                                    });
                                    setState(() {
                                      isEnableScreen = true;
                                    });
                                  },
                            canDelete: true,
                          )
                        : InkWell(
                            onTap: () async {
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
                              if (controller.docsModel?.docs?[index].name!
                                      .toLowerCase() ==
                                  'emirate id') {
                                setState(() {
                                  controller.mergedId = null;
                                });
                                _showPicker(context, index);
                              } else {
                                await _showPickerPassport(context, index);
                                setState(() {
                                  highLightExpiry =
                                      controller.docsModel?.docs?[index].path !=
                                              null
                                          ? true
                                          : false;
                                });
                              }
                            },
                            child: Container(
                              // color: Colors.red,
                              padding: EdgeInsets.only(
                                left: 4.0.w,
                                right: 4.0.w,
                                top: 3.5.h,
                              ),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(246, 248, 249, 1),
                                borderRadius: BorderRadius.circular(0.5.h),
                              ),
                              child: Column(
                                children: [
                                  Center(
                                    child: IconButton(
                                      onPressed: () async {
                                        bool? isTrue;
                                        print(controller.isDocUploaded);
                                        for (int i = 0;
                                            i < controller.isDocUploaded.length;
                                            i++) {
                                          print(controller.isDocUploaded[i] ==
                                              'true');
                                          if (controller.isDocUploaded[i] ==
                                              'true') {
                                            setState(() {
                                              isTrue = true;
                                            });
                                          }
                                        }
                                        if (isTrue == true) {
                                          SnakBarWidget.getSnackBarErrorBlue(
                                              AppMetaLabels().alert,
                                              AppMetaLabels()
                                                  .uploadAttachedDocFirst);
                                          return;
                                        }
                                        if (controller
                                                .docsModel?.docs?[index].name!
                                                .toLowerCase() ==
                                            'emirate id') {
                                          setState(() {
                                            controller.mergedId = null;
                                          });
                                          _showPicker(context, index);
                                        } else {
                                          await _showPickerPassport(
                                              context, index);
                                          setState(() {
                                            highLightExpiry = controller
                                                        .docsModel
                                                        ?.docs?[index]
                                                        .path !=
                                                    null
                                                ? true
                                                : false;
                                          });
                                        }
                                      },
                                      icon: Image.asset(
                                        AppImagesPath.downloadimg,
                                        width: 4.5.h,
                                        height: 4.5.h,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1.5.h,
                                  ),
                                  Text(
                                    AppMetaLabels().uploadYourDoc,
                                    style: AppTextStyle.semiBoldBlack10,
                                  ),
                                  SizedBox(
                                    height: 1.5.h,
                                  ),
                                ],
                              ),
                            ),
                          );
                  }),
                  // SizedBox(
                  //   height: 2.5.h,
                  // ),
                  // Text(
                  //   AppMetaLabels().uploadYourDoc,
                  //   style: AppTextStyle.semiBoldBlack10,
                  // ),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  Text(
                    controller.docsModel?.docs?[index].name == 'Emirate ID'
                        ? AppMetaLabels().filedetailsEID
                        : AppMetaLabels().filedetails,
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
                          bool isTrue;
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

                          var expDate;
                          if (controller.docsModel?.docs?[index].path != null) {
                            print('Tapping :::::: ');
                            expDate = await showRoundedDatePicker(
                              theme:
                                  ThemeData(primaryColor: AppColors.blueColor),
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
                              // theme:
                              //     ThemeData(primarySwatch: Colors.deepPurple),
                              styleDatePicker: MaterialRoundedDatePickerStyle(
                                decorationDateSelected: BoxDecoration(
                                    color: AppColors.blueColor,
                                    borderRadius: BorderRadius.circular(100)),
                                textStyleButtonPositive: TextStyle(
                                  color: AppColors.blueColor,
                                ),
                                textStyleButtonNegative: TextStyle(
                                  color: AppColors.blueColor,
                                ),
                                backgroundHeader: Colors.grey.shade300,
                                // Appbar year like '2023' button
                                textStyleYearButton: TextStyle(
                                  fontSize: 30.sp,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  backgroundColor: Colors.grey.shade100,
                                  leadingDistribution:
                                      TextLeadingDistribution.even,
                                ),
                                // Appbar day like 'Thu, Mar 16' button
                                textStyleDayButton: TextStyle(
                                  fontSize: 18.sp,
                                  color: Colors.white,
                                ),

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
                          } else {
                            if (controller.isDocUploaded.contains('true')) {
                              SnakBarWidget.getSnackBarErrorBlue(
                                  AppMetaLabels().alert,
                                  AppMetaLabels().uploadAttachedDocFirst);
                            } else {
                              SnakBarWidget.getSnackBarErrorBlue(
                                  AppMetaLabels().alert,
                                  AppMetaLabels().pleaseSelectFileFirst);
                            }
                          }

                          if (expDate != null) {
                            if (expDate.isBefore(DateTime.now()) ||
                                expDate.isAtSameMomentAs(DateTime.now())) {
                              SnakBarWidget.getSnackBarErrorBlue(
                                AppMetaLabels().error,
                                AppMetaLabels().selectFuturedate,
                              );
                            } else {
                              DateFormat dateFormat = new DateFormat(
                                  AppMetaLabels()
                                      .dateFormatForShowRoundedDatePicker);
                              if (controller.docsModel?.docs?[index].name!
                                      .toLowerCase() ==
                                  'emirate id') {
                                if (controller.cardScanModel.expiry != null) {
                                  setState(() {
                                    controller.cardScanModel.expiry = null;
                                  });
                                }
                              }
                              await controller.setExpDate(
                                  index, dateFormat.format(expDate));
                              setState(() {
                                highLightExpiry = false;
                              });
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
                                  if (controller.docsModel?.docs?[index].update
                                          .value ==
                                      true) {}
                                  return Text(
                                    controller.docsModel?.docs?[index].expiry ??
                                        '',
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
                                    if (controller.cardScanModel.expiry !=
                                        null) {
                                      setState(() {
                                        controller.cardScanModel.expiry = null;
                                      });
                                    }
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
                        return controller
                                    .docsModel?.docs?[index].loading.value ==
                                true
                            ? LoadingIndicatorBlue(
                                size: 3.h,
                              )
                            : controller.docsModel?.docs?[index].errorLoading ==
                                    true
                                ? IconButton(
                                    onPressed: () async {
                                      // here also add refresh func for visa and passport

                                      if (controller
                                              .docsModel?.docs?[index].name!
                                              .toLowerCase() !=
                                          'emirate id') {
                                        setState(() {
                                          isEnableScreen = false;
                                        });
                                        if (controller.docsModel?.docs?[index]
                                                .isRejected ==
                                            false) {
                                          setState(() {
                                            isEnableScreen = false;
                                          });
                                          await controller.updateDoc(index);
                                          setState(() {
                                            isEnableScreen = true;
                                          });
                                        } else {
                                          setState(() {
                                            isEnableScreen = false;
                                          });
                                          await controller.uploadDoc(index);
                                          setState(() {
                                            isEnableScreen = true;
                                          });
                                        }
                                        setState(() {
                                          isEnableScreen = true;
                                        });
                                        return;
                                      }

                                      setState(() {
                                        isEnableScreen = false;
                                        controller.isLoadingForScanning.value =
                                            true;
                                      });
                                      if (controller.docsModel?.docs?[index]
                                              .isRejected ==
                                          true) {
                                        await controller.updateDoc(index);
                                        setState(() {
                                          isEnableScreen = false;
                                        });
                                      } else {
                                        bool isTrue = false;
                                        for (int i = 0;
                                            i < controller.isDocUploaded.length;
                                            i++) {
                                          if (controller
                                                  .docsModel?.docs?[index].name
                                                  ?.contains('Emirate ID') ==
                                              true) {
                                            if (controller.isDocUploaded[i] ==
                                                'true') {
                                              setState(() {
                                                isTrue = true;
                                                controller.isDocUploaded[i] =
                                                    false;
                                              });
                                            }
                                          }
                                        }
                                        setState(() {
                                          isEnableScreen = true;
                                          controller.isLoadingForScanning
                                              .value = false;
                                          controller.docsModel?.docs?[index]
                                              .errorLoading = false;
                                          controller.docsModel?.docs?[index]
                                              .path = null;
                                          SnakBarWidget.getSnackBarErrorBlue(
                                              AppMetaLabels().alert,
                                              AppMetaLabels()
                                                      .someThingWentWrong +
                                                  ' ' +
                                                  AppMetaLabels().please +
                                                  ' ' +
                                                  AppMetaLabels().reScane);
                                        });
                                      }
                                    },
                                    icon: Icon(
                                      Icons.refresh,
                                      size: 4.5.h,
                                      color: Colors.red,
                                    ),
                                  )
                                : Obx(() {
                                    if (controller.docsModel?.docs?[index]
                                            .update.value ==
                                        true) {}
                                    return ElevatedButton(
                                      onPressed: controller.docsModel
                                                      ?.docs?[index].expiry ==
                                                  null ||
                                              controller.docsModel?.docs?[index]
                                                      .path ==
                                                  null
                                          ? null
                                          : () async {
                                              setState(() {
                                                isEnableScreen = false;
                                              });
                                              print(
                                                  'Merge ID ::::::: ${(controller.mergedId != null)}');
                                              // if (controller.mergedId != null ) {
                                              if (controller.mergedId != null &&
                                                  controller.docsModel
                                                          ?.docs?[index].name!
                                                          .toLowerCase() ==
                                                      'emirate id') {
                                                WidgetsBinding.instance
                                                    .addPostFrameCallback(
                                                  (timeStamp) async {
                                                    // _showConfirmationDialog(
                                                    //     index, context);
                                                    await _showConfirmationDialog(
                                                        index, context);
                                                    setState(() {
                                                      controller
                                                          .isLoadingForScanning
                                                          .value = false;
                                                      isEnableScreen = true;
                                                    });
                                                    setState(() {});
                                                    print(
                                                        'ISEnable Screen Val :::::: $isEnableScreen');
                                                  },
                                                );
                                              }
                                              if (controller.docsModel
                                                      ?.docs?[index].name!
                                                      .toLowerCase() !=
                                                  'emirate id') {
                                                if (controller
                                                        .docsModel
                                                        ?.docs?[index]
                                                        .isRejected ==
                                                    true) {
                                                  if (controller
                                                              .docsModel
                                                              ?.docs?[index]
                                                              .expiry ==
                                                          '' ||
                                                      controller
                                                              .docsModel
                                                              ?.docs?[index]
                                                              .expiry ==
                                                          null) {
                                                    SnakBarWidget
                                                        .getSnackBarErrorBlue(
                                                            AppMetaLabels()
                                                                .alert,
                                                            AppMetaLabels()
                                                                .pleaseSelectExpiryDate);
                                                    setState(() {
                                                      isEnableScreen = true;
                                                      controller
                                                          .isLoadingForScanning
                                                          .value = false;
                                                    });
                                                    return;
                                                  }
                                                  setState(() {
                                                    isEnableScreen = false;
                                                    controller
                                                        .isLoadingForScanning
                                                        .value = true;
                                                  });
                                                  print(
                                                      ':::::::::::::: $isEnableScreen');
                                                  print(
                                                      ':::::::::::::: ${controller.isLoadingForScanning.value}');
                                                  print(
                                                      'Expiry : Testing :: ${controller.docsModel?.docs?[index].expiry}');

                                                  controller.updateDoc(index);
                                                  setState(() {
                                                    isEnableScreen = true;
                                                    controller
                                                        .isLoadingForScanning
                                                        .value = false;
                                                  });
                                                } else {
                                                  await controller
                                                      .uploadDoc(index);
                                                }
                                              }
                                              setState(() {
                                                isEnableScreen = true;
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

// upload passport and other pic from here
  _showPickerPassport(context, int index) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Directionality(
            textDirection: SessionController().getLanguage() == 1
                ? ui.TextDirection.ltr
                : ui.TextDirection.rtl,
            child: SafeArea(
              child: Container(
                color: Colors.white,
                child: new Wrap(
                  children: <Widget>[
                    new ListTile(
                        leading: new Icon(Icons.storage),
                        title: new Text(AppMetaLabels().storage),
                        onTap: () async {
                          // if (!await Permission.storage.request().isGranted) {
                          //   print('Else');
                          //   await permissions(
                          //     'Storage',
                          //     context,
                          //   );
                          //   return;
                          // }
                          try {
                            // await controller.pickDoc(index);
                            await controller.pickDocFilePicker(index);
                            setState(() {});
                            Navigator.of(context).pop();
                          } catch (e) {
                            print("Exception ::: $e");
                          }
                        }),
                    new ListTile(
                      leading: new Icon(Icons.photo_camera),
                      title: new Text(AppMetaLabels().camera),
                      onTap: () async {
                        // if (!await Permission.camera.request().isGranted) {
                        //   print('Else');
                        //   await permissions(
                        //     'Camera',
                        //     context,
                        //   );
                        //   return;
                        // }
                        try {
                          await controller.takePhoto(index);
                          setState(() {});
                          Navigator.of(context).pop();
                        } catch (e) {
                          print('Exception :: $e');
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

// upload emirate pic from here
  void _showPicker(context, int index) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Directionality(
              textDirection: SessionController().getLanguage() == 1
                  ? ui.TextDirection.ltr
                  : ui.TextDirection.rtl,
              child: SafeArea(
                  child: Container(
                color: Colors.white,
                child: new Wrap(
                  children: <Widget>[
                    new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text(AppMetaLabels().photoLibrary),
                      onTap: () async {
                        // new
                        // if (!await Permission.photos.request().isGranted) {
                        //   await permissions(
                        //     'Gallery',
                        //     context,
                        //   );
                        //   return;
                        // }
                        //

                        Navigator.of(context).pop();
                        setState(() {
                          controller.mergedId = null;
                          controller.cardScanModel = CardScanModel();
                        });

                        await _showFrontBackImage('gallery', context, index);

                        // old
                        if (controller.mergedId != null &&
                            controller.docsModel?.docs?[index].name!
                                    .toLowerCase() ==
                                'emirate id') {
                          WidgetsBinding.instance.addPostFrameCallback(
                            (timeStamp) async {
                              setState(() {
                                controller.isDocUploaded[index] = 'true';
                              });
                              // _showConfirmationDialog(index, context);
                              await _showConfirmationDialog(index, context);
                              setState(() {
                                controller.isLoadingForScanning.value = false;
                                isEnableScreen = true;
                              });
                              setState(() {});
                              print(
                                  'ISEnable Screen Val :::::: $isEnableScreen');
                            },
                          );
                        }
                      },
                    ),
                    new ListTile(
                      leading: new Icon(Icons.photo_camera),
                      title: new Text(AppMetaLabels().camera),
                      onTap: () async {
                        // new
                        // if (!await Permission.camera.request().isGranted) {
                        //   await permissions(
                        //     'Camera',
                        //     context,
                        //   );
                        //   return;
                        // }
                        //

                        Navigator.of(context).pop();
                        setState(() {
                          controller.mergedId = null;
                          controller.cardScanModel = CardScanModel();
                        });
                        await _showFrontBackImage('camera', context, index);

                        if (controller.mergedId != null &&
                            controller.docsModel?.docs?[index].name!
                                    .toLowerCase() ==
                                'emirate id') {
                          WidgetsBinding.instance.addPostFrameCallback(
                            (timeStamp) async {
                              setState(() {
                                controller.isDocUploaded[index] = 'true';
                              });
                              await _showConfirmationDialog(index, context);
                              setState(() {
                                controller.isLoadingForScanning.value = false;
                                isEnableScreen = true;
                              });
                              setState(() {});
                              print(
                                  'ISEnable Screen Val :::::: $isEnableScreen');
                            },
                          );
                        }
                      },
                    ),
                  ],
                ),
              )));
        });
  }

  // 112233 EID Name ,Id amnd etc
  // 002 For Tracking of Tenant->Due Action For Contract Renewal->upload Document->Scane Emirate ID
  // after scan the emirate id there is a pop up show in whic we show name EID nationality etc
  // all these data pass to the api of upload that we call in line 557 and 555
  // but when ali bhai publish the api
  // 112233 after scane EmirateID all code
  _showConfirmationDialog(int index, BuildContext context) {
    String nationality = controller.cardScanModel.nationality ?? "";
    String name = controller.cardScanModel.name ?? "";
    if (nationality != null) {
      if (controller.cardScanModel.nationality?.contains('Nationality') ==
          true) {
        if (controller.cardScanModel.nationality?.contains(',') == true) {
          setState(() {
            nationality = controller.cardScanModel.nationality!
                .replaceAll('Nationality,', '');
          });
        } else if (controller.cardScanModel.nationality?.contains(':') ==
            true) {
          setState(() {
            nationality = controller.cardScanModel.nationality!
                .replaceAll('Nationality:', '');
          });
        } else {
          setState(() {
            nationality = controller.cardScanModel.nationality!
                .replaceAll('Nationality', '');
          });
        }
      }
    }
    if (nationality != null) {
      if (controller.cardScanModel.nationality?.contains('nationality') ==
          true) {
        if (controller.cardScanModel.nationality?.contains(',') == true) {
          setState(() {
            nationality = controller.cardScanModel.nationality!
                .replaceAll('nationality,', '');
          });
        } else if (controller.cardScanModel.nationality?.contains(':') ==
            true) {
          setState(() {
            nationality = controller.cardScanModel.nationality!
                .replaceAll('nationality:', '');
          });
        } else {
          setState(() {
            nationality = controller.cardScanModel.nationality!
                .replaceAll('nationality', '');
          });
        }
      }
    }
    if (name != null) {
      if (controller.cardScanModel.name?.contains('Name') == true) {
        if (controller.cardScanModel.name?.contains(',') == true) {
          setState(() {
            name = controller.cardScanModel.name!.replaceAll('Name,', '');
          });
        } else if (controller.cardScanModel.name?.contains(':') == true) {
          setState(() {
            name = controller.cardScanModel.name!.replaceAll('Name:', '');
          });
        } else {
          setState(() {
            name = controller.cardScanModel.name!.replaceAll('Name', '');
          });
        }
      }
    }
    if (name != null) {
      if (controller.cardScanModel.name?.contains('name') == true) {
        if (controller.cardScanModel.name?.contains(',') == true) {
          setState(() {
            name = controller.cardScanModel.name!.replaceAll('name,', '');
          });
        } else if (controller.cardScanModel.name?.contains(':') == true) {
          setState(() {
            name = controller.cardScanModel.name!.replaceAll('name:', '');
          });
        } else {
          setState(() {
            name = controller.cardScanModel.name!.replaceAll('name', '');
          });
        }
      }
    }

    nameText.text = name;
    print('Name TextField :::: ${nameText.text}');
    // nameText.text = controller.cardScanModel.name;
    iDNumberText.text = controller.cardScanModel.idNumber ?? "";
    if (controller.cardScanModel.dob != null) {
      dOBText =
          '${DateFormat('dd-MM-yyyy').format(controller.cardScanModel.dob!)}';
    }
    print('iDNumberText TextField :::: ${iDNumberText.text}');
    expiryText = controller.cardScanModel.expiry == null
        ? controller.docsModel?.docs![index].expiry ?? ""
        : '${DateFormat('dd-MM-yyyy').format(controller.cardScanModel.expiry!)}';

    print('expiryText expiryText :::: $expiryText');
    setState(() {
      isNameError = false;
      isIDError = false;
      isExpiryError = false;
      isDOBError = false;
    });

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Align(
                  alignment: SessionController().getLanguage() == 1
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  child: Text(AppMetaLabels().pleaseVerify)),
              content: SingleChildScrollView(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Name
                      Padding(
                        padding: EdgeInsets.only(
                            left: 2.0.w, top: 0.5.h, right: 4.0.w),
                        child: SizedBox(
                          width: 70.w,
                          child: Align(
                            alignment: SessionController().getLanguage() == 1
                                ? Alignment.centerLeft
                                : Alignment.centerRight,
                            child: RichText(
                              textAlign: SessionController().getLanguage() == 1
                                  ? TextAlign.left
                                  : TextAlign.right,
                              maxLines: 2,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                      text: AppMetaLabels().name,
                                      style: AppTextStyle.normalGrey10),
                                  TextSpan(
                                    text: ' (' +
                                        '${AppMetaLabels().invalidName}' +
                                        ')',
                                    style: AppTextStyle.normalGrey8,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 0.5.h, left: 2.0.w, right: 2.0.w),
                        child: SizedBox(
                          // height: 4.h,
                          width: 90.w,
                          child: TextFormField(
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^[a-zA-Z\u0621-\u064A ]+$'))
                              // RegExp(r'^[a-zA-Z\u0621-\u064A ]+$'))
                            ],
                            controller: nameText,
                            maxLines: 2,
                            style: AppTextStyle.normalBlack10,
                            // onChanged: (val) {
                            //   if (val.isNotEmpty) {
                            //     setState(() {
                            //       isNameError = false;
                            //     });
                            //   } else {
                            //     if (!nameValidator.hasMatch(val)) {
                            //       setState(() {
                            //         isNameError = true;
                            //       });
                            //       return;
                            //     }
                            //   }
                            // },
                            // validator: (value) {
                            //   if (!nameValidator.hasMatch(value)) {
                            //     isNameError = true;
                            //     return;
                            //   } else
                            //     return null;
                            // },
                            decoration: InputDecoration(
                              suffixIconConstraints: BoxConstraints(
                                minWidth: 4.h,
                                minHeight: 2,
                              ),
                              suffixIcon: Icon(
                                Icons.edit,
                                size: 2.h,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                  color: isNameError
                                      ? AppColors.redColor
                                      : AppColors.blueColor,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                  color: isNameError
                                      ? AppColors.redColor
                                      : AppColors.bordercolornew,
                                  width: 0.2.w,
                                ),
                              ),
                              fillColor: AppColors.greyBG,
                              filled: true,
                              hintText: AppMetaLabels().name,
                              hintStyle: AppTextStyle.normalBlack10
                                  .copyWith(color: AppColors.textFieldBGColor),
                              errorStyle: TextStyle(fontSize: 0),
                              contentPadding: EdgeInsets.all(2.5.w),
                            ),
                          ),
                        ),
                      ),
                      isNameError == true
                          ? Padding(
                              padding: EdgeInsets.only(
                                  left: 2.0.w, top: 0.2.h, right: 4.0.w),
                              child: Text(
                                AppMetaLabels().invalidName,
                                style: AppTextStyle.normalGrey8
                                    .copyWith(color: Colors.red),
                              ),
                            )
                          : SizedBox(),
                      // ID Number
                      Padding(
                        padding: EdgeInsets.only(
                            left: 2.0.w, top: 1.0.h, right: 4.0.w),
                        child: Align(
                            alignment: SessionController().getLanguage() == 1
                                ? Alignment.centerLeft
                                : Alignment.centerRight,
                            child: Text(
                              // 'ID Number',
                              AppMetaLabels().iDNumber,
                              style: AppTextStyle.normalGrey10,
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 0.5.h, left: 2.0.w, right: 2.0.w),
                        child: SizedBox(
                          width: 90.0.w,
                          height: 4.0.h,
                          child: TextFormField(
                            inputFormatters: [maskFormatter],
                            controller: iDNumberText,
                            maxLength: 18,
                            keyboardType: TextInputType.numberWithOptions(),
                            onChanged: (val) {
                              if (val.isNotEmpty) {
                                setState(() {
                                  isIDError = false;
                                });
                              }
                            },
                            style: AppTextStyle.normalBlack10,
                            decoration: InputDecoration(
                              suffixIconConstraints: BoxConstraints(
                                minWidth: 4.h,
                                minHeight: 2,
                              ),
                              suffixIcon: Icon(
                                Icons.edit,
                                size: 2.h,
                              ),
                              counterText: "",
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                  color: isIDError
                                      ? AppColors.redColor
                                      : AppColors.blueColor,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                  color: isIDError
                                      ? AppColors.redColor
                                      : AppColors.bordercolornew,
                                  width: 0.2.w,
                                ),
                              ),
                              fillColor: AppColors.greyBG,
                              filled: true,
                              hintText: '000-0000-0000000-0',
                              hintStyle: AppTextStyle.normalBlack10
                                  .copyWith(color: AppColors.textFieldBGColor),
                              errorStyle: TextStyle(fontSize: 0),
                              contentPadding: EdgeInsets.all(2.5.w),
                            ),
                          ),
                        ),
                      ),
                      // Expiry
                      Padding(
                        padding: EdgeInsets.only(
                            left: 2.0.w, top: 1.0.h, right: 4.0.w),
                        child: Align(
                            alignment: SessionController().getLanguage() == 1
                                ? Alignment.centerLeft
                                : Alignment.centerRight,
                            child: Text(
                              AppMetaLabels().expDate,
                              style: AppTextStyle.normalGrey10,
                            )),
                      ),
                      SizedBox(
                        height: 0.5.h,
                      ),
                      InkWell(
                        onTap: () async {
                          print('Show ::::::');
                          var expDate = await showRoundedDatePicker(
                            theme: ThemeData(primaryColor: AppColors.blueColor),
                            height: 50.0.h,
                            context: context,
                            // locale: Locale('en'),
                            locale: SessionController().getLanguage() == 1
                                ? Locale('en', '')
                                : Locale('ar', ''),
                            initialDate: DateTime.now(),
                            firstDate:
                                DateTime.now().subtract(Duration(seconds: 1)),
                            lastDate: DateTime(DateTime.now().year + 10),
                            borderRadius: 2.0.h,
                            // theme:
                            //     ThemeData(primarySwatch: Colors.deepPurple),
                            styleDatePicker: MaterialRoundedDatePickerStyle(
                              decorationDateSelected: BoxDecoration(
                                  color: AppColors.blueColor,
                                  borderRadius: BorderRadius.circular(100)),
                              textStyleButtonPositive: TextStyle(
                                color: AppColors.blueColor,
                              ),
                              textStyleButtonNegative: TextStyle(
                                color: AppColors.blueColor,
                              ),
                              backgroundHeader: Colors.grey.shade300,
                              // Appbar year like '2023' button
                              textStyleYearButton: TextStyle(
                                fontSize: 30.sp,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                backgroundColor: Colors.grey.shade100,
                                leadingDistribution:
                                    TextLeadingDistribution.even,
                              ),
                              // Appbar day like 'Thu, Mar 16' button
                              textStyleDayButton: TextStyle(
                                fontSize: 18.sp,
                                color: Colors.white,
                              ),
                            ),
                          );

                          if (expDate != null) {
                            if (expDate.isBefore(DateTime.now()) ||
                                expDate.isAtSameMomentAs(DateTime.now())) {
                              SnakBarWidget.getSnackBarErrorBlue(
                                AppMetaLabels().error,
                                AppMetaLabels().selectFuturedate,
                              );
                            } else {
                              DateFormat dateFormat = new DateFormat(
                                  AppMetaLabels()
                                      .dateFormatForShowRoundedDatePicker);
                              setState(() {
                                expiryText = dateFormat.format(expDate);
                                controller.docsModel?.docs?[index].expiry =
                                    dateFormat.format(expDate);

                                isExpiryError = false;
                              });
                            }
                          }
                        },
                        child: Container(
                          width: 90.0.w,
                          height: 4.0.h,
                          margin: EdgeInsets.only(
                              top: 0.5.h, left: 2.0.w, right: 2.0.w),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(246, 248, 249, 1),
                            borderRadius: BorderRadius.circular(1.0.h),
                            border: Border.all(
                              color: isExpiryError == true
                                  ? AppColors.redColor
                                  : AppColors.bordercolornew,
                              width: 0.2.w,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 1.0.h),
                                child: Text(
                                  expiryText,
                                  style: AppTextStyle.normalBlack10,
                                ),
                              ),
                              Spacer(),
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 1.0.h),
                                child: ClearButton(
                                  clear: () {
                                    setState(() {
                                      expiryText = '';
                                      controller
                                          .docsModel?.docs?[index].expiry = '';
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // DOB
                      Padding(
                        padding: EdgeInsets.only(
                            left: 2.0.w, top: 1.0.h, right: 4.0.w),
                        child: Align(
                            alignment: SessionController().getLanguage() == 1
                                ? Alignment.centerLeft
                                : Alignment.centerRight,
                            child: Text(
                              // 'Date Of Birth',
                              AppMetaLabels().dateOFBirth,
                              style: AppTextStyle.normalGrey10,
                            )),
                      ),
                      SizedBox(
                        height: 0.5.h,
                      ),
                      InkWell(
                        onTap: () async {
                          var expDate = await showRoundedDatePicker(
                            theme: ThemeData(primaryColor: AppColors.blueColor),
                            height: 50.0.h,
                            context: context,
                            // locale: Locale('en'),
                            locale: SessionController().getLanguage() == 1
                                ? Locale('en', '')
                                : Locale('ar', ''),
                            initialDate: DateTime.now(),
                            firstDate: DateTime(DateTime.now().year - 100),
                            lastDate: DateTime.now(),
                            borderRadius: 2.0.h,
                            // theme:
                            //     ThemeData(primarySwatch: Colors.deepPurple),
                            styleDatePicker: MaterialRoundedDatePickerStyle(
                              decorationDateSelected: BoxDecoration(
                                  color: AppColors.blueColor,
                                  borderRadius: BorderRadius.circular(100)),
                              textStyleButtonPositive: TextStyle(
                                color: AppColors.blueColor,
                              ),
                              textStyleButtonNegative: TextStyle(
                                color: AppColors.blueColor,
                              ),
                              backgroundHeader: Colors.grey.shade300,
                              // Appbar year like '2023' button
                              textStyleYearButton: TextStyle(
                                fontSize: 30.sp,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                backgroundColor: Colors.grey.shade100,
                                leadingDistribution:
                                    TextLeadingDistribution.even,
                              ),
                              // Appbar day like 'Thu, Mar 16' button
                              textStyleDayButton: TextStyle(
                                fontSize: 18.sp,
                                color: Colors.white,
                              ),
                            ),
                          );

                          if (expDate != null) {
                            if (expDate.isAfter(DateTime.now()) ||
                                expDate.isAtSameMomentAs(DateTime.now())) {
                              SnakBarWidget.getSnackBarErrorBlue(
                                AppMetaLabels().error,
                                AppMetaLabels().selectFuturedate,
                              );
                            } else {
                              DateFormat dateFormat = new DateFormat(
                                  AppMetaLabels()
                                      .dateFormatForShowRoundedDatePicker);
                              setState(() {
                                isDOBError = false;
                                dOBText = dateFormat.format(expDate);
                              });
                            }
                          }
                        },
                        child: Container(
                          width: 90.0.w,
                          height: 4.0.h,
                          margin: EdgeInsets.only(
                              top: 0.5.h, left: 2.0.w, right: 2.0.w),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(246, 248, 249, 1),
                            borderRadius: BorderRadius.circular(1.0.h),
                            border: Border.all(
                              color: isDOBError == true
                                  ? AppColors.redColor
                                  : AppColors.bordercolornew,
                              width: 0.2.w,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 1.0.h),
                                child: Text(
                                  dOBText,
                                  style: AppTextStyle.normalBlack10,
                                ),
                              ),
                              Spacer(),
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 1.0.h),
                                child: ClearButton(
                                  clear: () {
                                    setState(() {
                                      dOBText = '';
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 2.0.h,
                      ),
                      SizedBox(
                        height: Get.height * 0.3,
                        width: double.infinity,
                        child: controller.mergedId != null
                            ? Image.file(
                                controller.mergedId!,
                                fit: BoxFit.contain,
                              )
                            : SizedBox(),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                SessionController().getLanguage() == 1
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              style: ButtonStyle(
                                foregroundColor: WidgetStateProperty.all(
                                    AppColors.blueColor),
                                textStyle: WidgetStateProperty.all(TextStyle(
                                  fontSize: 10.sp, // Adjust as needed
                                  fontWeight:
                                      FontWeight.bold, // Adjust as needed
                                )),
                              ),
                              child: Text(AppMetaLabels().cancel),
                              onPressed: () async {
                                Navigator.of(context).pop();
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  setState(() {
                                    controller.docsModel?.docs?[index].loading
                                        .value = false;
                                    controller.cardScanModel = CardScanModel();
                                    controller.mergedId = null;
                                    controller.isLoadingForScanning.value =
                                        false;
                                    controller.isDocUploaded[index] = 'false';
                                  });
                                });
                                setState(() {
                                  nameText.clear();
                                  iDNumberText.clear();
                                  expiryText = '';
                                  dOBText = '';
                                });
                                await controller.removePickedFile(index);
                                setState(() {});
                              }),
                          TextButton(
                              style: ButtonStyle(
                                foregroundColor: WidgetStateProperty.all(
                                    AppColors.blueColor),
                                textStyle: WidgetStateProperty.all(TextStyle(
                                  fontSize: 10.sp, // Adjust as needed
                                  fontWeight:
                                      FontWeight.bold, // Adjust as needed
                                )),
                              ),
                              child: Text(AppMetaLabels().confirm),
                              onPressed: () async {
                                if (controller.comparingUint8List(
                                    controller.cardScanModel.frontImage!,
                                    controller.cardScanModel.backImage!)) {
                                  await showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          contentPadding: EdgeInsets.zero,
                                          backgroundColor: Colors.transparent,
                                          content:
                                              showDialogForWrongScan(index),
                                        );
                                      });
                                  setState(() {});
                                } else {
                                  WidgetsBinding.instance.addPostFrameCallback(
                                    (timeStamp) async {
                                      if (controller.docsModel?.docs?[index]
                                              .isRejected ==
                                          true) {
                                        if (nameText.text.trim() == '' ||
                                            nameText.text.trim() == null) {
                                          SnakBarWidget.getSnackBarErrorBlue(
                                              AppMetaLabels().alert,
                                              AppMetaLabels()
                                                  .pleaseEnterFullName);
                                          setState(() {
                                            isNameError = true;
                                          });
                                          return;
                                        } else if (!nameValidator
                                            .hasMatch(nameText.text.trim())) {
                                          setState(() {
                                            isNameError = true;
                                          });
                                          return;
                                        } else if (iDNumberText.text.trim() ==
                                                '' ||
                                            iDNumberText.text.trim() == null ||
                                            iDNumberText.text.length < 18) {
                                          SnakBarWidget.getSnackBarErrorBlue(
                                              AppMetaLabels().alert,
                                              AppMetaLabels()
                                                  .pleaseEnterCorrectID);
                                          setState(() {
                                            isIDError = true;
                                          });
                                          return;
                                        } else if (expiryText == '' ||
                                            expiryText == null ||
                                            expiryText.contains('.')) {
                                          SnakBarWidget.getSnackBarErrorBlue(
                                              AppMetaLabels().alert,
                                              AppMetaLabels()
                                                  .pleaseSelectCorrectExpDate);
                                          setState(() {
                                            isExpiryError = true;
                                          });
                                          return;
                                        } else if (dOBText == '' ||
                                            dOBText == null ||
                                            dOBText.contains('.')) {
                                          SnakBarWidget.getSnackBarErrorBlue(
                                              AppMetaLabels().alert,
                                              AppMetaLabels().pleaseSelectDOB);
                                          setState(() {
                                            isDOBError = true;
                                          });
                                          return;
                                        } else {
                                          setState(() {
                                            isEnableScreen = false;
                                            controller.isLoadingForScanning
                                                .value = true;
                                          });
                                          Navigator.of(context).pop();
                                          await controller.updateDoc(index);
                                          isEnableScreen = true;
                                        }
                                      } else {
                                        if (nameText.text.trim() == '' ||
                                            nameText.text.trim() == null) {
                                          SnakBarWidget.getSnackBarErrorBlue(
                                              AppMetaLabels().alert,
                                              AppMetaLabels()
                                                  .pleaseEnterFullName);
                                          setState(() {
                                            isNameError = true;
                                          });
                                          return;
                                        } else if (!nameValidator
                                            .hasMatch(nameText.text.trim())) {
                                          setState(() {
                                            isNameError = true;
                                          });
                                          return;
                                        } else if (iDNumberText.text.trim() ==
                                                '' ||
                                            iDNumberText.text.trim() == null ||
                                            iDNumberText.text.length < 18) {
                                          SnakBarWidget.getSnackBarErrorBlue(
                                              AppMetaLabels().alert,
                                              AppMetaLabels()
                                                  .pleaseEnterCorrectID);
                                          setState(() {
                                            isIDError = true;
                                          });
                                          return;
                                        } else if (expiryText == '' ||
                                            expiryText == null ||
                                            expiryText.contains('.')) {
                                          SnakBarWidget.getSnackBarErrorBlue(
                                              AppMetaLabels().alert,
                                              AppMetaLabels()
                                                  .pleaseSelectCorrectExpDate);
                                          setState(() {
                                            isExpiryError = true;
                                          });
                                          return;
                                        } else if (dOBText == '' ||
                                            dOBText == null ||
                                            dOBText.contains('.')) {
                                          SnakBarWidget.getSnackBarErrorBlue(
                                              AppMetaLabels().alert,
                                              AppMetaLabels().pleaseSelectDOB);
                                          setState(() {
                                            isDOBError = true;
                                          });
                                          return;
                                        } else {
                                          try {
                                            setState(() {
                                              controller.isLoadingForScanning
                                                  .value = true;
                                            });
                                            Navigator.of(context).pop();
                                            await controller
                                                .uploadDocWithEIDParameter(
                                              index,
                                              iDNumberText.text,
                                              controller
                                                  .cardScanModel.nationality,
                                              nameText.text,
                                              nameText.text,
                                              '',
                                              dOBText,
                                            );
                                            setState(() {
                                              controller.isLoadingForScanning
                                                  .value = false;
                                            });
                                          } catch (e) {
                                            setState(() {
                                              controller.isLoadingForScanning
                                                  .value = false;
                                            });
                                          }
                                        }
                                      }
                                    },
                                  );
                                }
                              }),
                        ],
                      )
                    : Row(
                        children: [
                          TextButton(
                              style: ButtonStyle(
                                foregroundColor: WidgetStateProperty.all(
                                    AppColors.blueColor),
                                textStyle: WidgetStateProperty.all(TextStyle(
                                  fontSize: 10.sp, // Adjust as needed
                                  fontWeight:
                                      FontWeight.bold, // Adjust as needed
                                )),
                              ),
                              child: Text(AppMetaLabels().confirm),
                              onPressed: () async {
                                if (controller.comparingUint8List(
                                    controller.cardScanModel.frontImage!,
                                    controller.cardScanModel.backImage!)) {
                                  await showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          contentPadding: EdgeInsets.zero,
                                          backgroundColor: Colors.transparent,
                                          content:
                                              showDialogForWrongScan(index),
                                        );
                                      });
                                  setState(() {});
                                } else {
                                  WidgetsBinding.instance.addPostFrameCallback(
                                    (timeStamp) async {
                                      if (controller.docsModel?.docs?[index]
                                              .isRejected ==
                                          true) {
                                        setState(() {
                                          isEnableScreen = false;
                                          controller.isLoadingForScanning
                                              .value = true;
                                        });
                                        Navigator.of(context).pop();
                                        await controller.updateDoc(index);
                                        isEnableScreen = true;
                                      } else {
                                        if (nameText.text == '' ||
                                            nameText.text == null) {
                                          SnakBarWidget.getSnackBarErrorBlue(
                                              AppMetaLabels().alert,
                                              AppMetaLabels()
                                                  .pleaseEnterFullName);
                                          setState(() {
                                            isNameError = true;
                                          });
                                          return;
                                        } else if (!nameValidator
                                            .hasMatch(nameText.text)) {
                                          setState(() {
                                            isNameError = true;
                                          });
                                          return;
                                        } else if (iDNumberText.text == '' ||
                                            iDNumberText.text == null ||
                                            iDNumberText.text.length < 18) {
                                          SnakBarWidget.getSnackBarErrorBlue(
                                              AppMetaLabels().alert,
                                              AppMetaLabels()
                                                  .pleaseEnterCorrectID);
                                          setState(() {
                                            isIDError = true;
                                          });
                                          return;
                                        } else if (expiryText == '' ||
                                            expiryText == null ||
                                            expiryText.contains('.')) {
                                          SnakBarWidget.getSnackBarErrorBlue(
                                              AppMetaLabels().alert,
                                              AppMetaLabels()
                                                  .pleaseSelectCorrectExpDate);
                                          setState(() {
                                            isExpiryError = true;
                                          });
                                          return;
                                        } else if (dOBText == '' ||
                                            dOBText == null ||
                                            dOBText.contains('.')) {
                                          SnakBarWidget.getSnackBarErrorBlue(
                                              AppMetaLabels().alert,
                                              AppMetaLabels().pleaseSelectDOB);
                                          setState(() {
                                            isDOBError = true;
                                          });
                                          return;
                                        } else {
                                          try {
                                            setState(() {
                                              controller.isLoadingForScanning
                                                  .value = true;
                                            });
                                            Navigator.of(context).pop();
                                            await controller
                                                .uploadDocWithEIDParameter(
                                              index,
                                              iDNumberText.text,
                                              controller
                                                  .cardScanModel.nationality,
                                              nameText.text,
                                              nameText.text,
                                              '',
                                              dOBText,
                                            );
                                            setState(() {
                                              controller.isLoadingForScanning
                                                  .value = false;
                                            });
                                          } catch (e) {
                                            setState(() {
                                              controller.isLoadingForScanning
                                                  .value = false;
                                            });
                                          }
                                        }
                                      }
                                    },
                                  );
                                }
                              }),
                          TextButton(
                              style: ButtonStyle(
                                foregroundColor: WidgetStateProperty.all(
                                    AppColors.blueColor),
                                textStyle: WidgetStateProperty.all(TextStyle(
                                  fontSize: 10.sp, // Adjust as needed
                                  fontWeight:
                                      FontWeight.bold, // Adjust as needed
                                )),
                              ),
                              child: Text(AppMetaLabels().cancel),
                              onPressed: () async {
                                Navigator.of(context).pop();
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  setState(() {
                                    controller.docsModel?.docs?[index].loading
                                        .value = false;
                                    controller.cardScanModel = CardScanModel();
                                    controller.mergedId = null;
                                    controller.isLoadingForScanning.value =
                                        false;
                                    controller.isDocUploaded[index] = 'false';
                                  });
                                });
                                setState(() {
                                  nameText.clear();
                                  iDNumberText.clear();
                                  expiryText = '';
                                  dOBText = '';
                                });
                                await controller.removePickedFile(index);
                                setState(() {});
                              }),
                        ],
                      ),
              ],
            );
          },
        );
      },
    );
  }

  Widget showDialogData() {
    return Container(
        padding: EdgeInsets.all(3.0.w),
        // height: 45.0.h,
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
                AppMetaLabels().documentUploaded,
                textAlign: TextAlign.center,
                style: AppTextStyle.semiBoldBlack13,
              ),
              SizedBox(
                height: 3.0.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: Get.width * 0.03),
                child: Text(
                  AppMetaLabels().collierStage3,
                  style: AppTextStyle.normalBlack10
                      .copyWith(color: AppColors.renewelgreyclr1, height: 1.3),
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 5.0.h, bottom: 2.0.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          height: 4.8.h,
                          width: 30.0.w,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                elevation:
                                    WidgetStateProperty.all<double>(0.0.h),
                                backgroundColor: WidgetStateProperty.all<Color>(
                                    AppColors.whiteColor),
                                shape: WidgetStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(2.0.w),
                                      side: BorderSide(
                                        color: AppColors.blueColor,
                                        width: 1.0,
                                      )),
                                )),
                            onPressed: () {
                              Get.back();
                            },
                            child: Text(
                              AppMetaLabels().stayOnPage,
                              textAlign: TextAlign.center,
                              style: AppTextStyle.semiBoldWhite10
                                  .copyWith(color: Colors.blue),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          height: 5.0.h,
                          width: 30.0.w,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(1.3.h),
                              ),
                              backgroundColor: Color.fromRGBO(0, 61, 166, 1),
                            ),
                            onPressed: () {
                              Get.back();
                              Get.off(() => TenantDashboardTabs(
                                    initialIndex: 0,
                                  ));
                            },
                            child: Text(
                              AppMetaLabels().goToDashoboard,
                              textAlign: TextAlign.center,
                              style: AppTextStyle.semiBoldWhite10,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ]));
  }

  Widget showDialogForWrongScan(int index) {
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
          Icon(
            Icons.error,
            size: 9.0.h,
          ),
          SizedBox(
            height: 3.0.h,
          ),
          Text(
            AppMetaLabels().cardScanningFailed,
            textAlign: TextAlign.center,
            style: AppTextStyle.semiBoldBlack13,
          ),
          SizedBox(
            height: 3.0.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: Get.width * 0.03),
            child: Text(
              AppMetaLabels().pleaseScaneFrontSideOfEIDAgain,
              style: AppTextStyle.normalBlack10
                  .copyWith(color: AppColors.renewelgreyclr1, height: 1.3),
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5.0.h, bottom: 2.0.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 2.w,
                ),
                // Align(
                //   alignment: Alignment.center,
                //   child: SizedBox(
                //     height: 5.0.h,
                //     width: 30.0.w,
                //     child: ElevatedButton(
                //       style: ButtonStyle(
                //         shape:
                //             MaterialStateProperty.all<RoundedRectangleBorder>(
                //                 RoundedRectangleBorder(
                //                     borderRadius: BorderRadius.circular(3.0.w),
                //                     side: BorderSide(color: Colors.blue))),
                //         backgroundColor:
                //             MaterialStateProperty.all<Color>(Colors.white),
                //       ),
                //       onPressed: () {
                //         Get.back();
                //         Navigator.of(context).pop();
                //       },
                //       child: Text(
                //         AppMetaLabels().cancel,
                //         textAlign: TextAlign.center,
                //         style: AppTextStyle.semiBoldBlack10,
                //       ),
                //     ),
                //   ),
                // ),
                // SizedBox(
                //   width: 6.w,
                // ),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: 5.0.h,
                    width: 30.0.w,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(1.3.h),
                        ),
                        backgroundColor: Color.fromRGBO(0, 61, 166, 1),
                      ),
                      onPressed: () async {
                        Get.back();
                        Navigator.of(context).pop();
                        controller.docsModel?.docs?[index].loading.value =
                            false;
                        controller.cardScanModel = CardScanModel();
                        controller.mergedId = null;
                        controller.isLoadingForScanning.value = false;
                        await controller.removePickedFile(index);
                        setState(() {
                          nameText.clear();
                          iDNumberText.clear();
                          expiryText = '';
                          dOBText = '';
                        });
                        setState(() {
                          controller.isDocUploaded[index] = 'false';
                        });
                      },
                      child: Text(
                        AppMetaLabels().reScane,
                        textAlign: TextAlign.center,
                        style: AppTextStyle.semiBoldWhite10,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 2.w,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

// show fron and back side of image
  _showFrontBackImage(String source, BuildContext context, int index) {
    showDialog(
        context: context,
        // barrierDismissible: false,
        builder: (context) {
          return Directionality(
            textDirection: SessionController().getLanguage() == 1
                ? ui.TextDirection.ltr
                : ui.TextDirection.rtl,
            child: AlertDialog(
              title: Text(AppMetaLabels().emirateid),
              content: Container(
                height: Get.height * 0.6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    SizedBox(
                        child: Center(
                            child: Text(
                                AppMetaLabels().pleaseScaneFrontSideOfEID,
                                textAlign: TextAlign.center,
                                style: AppTextStyle.semiBoldBlack10))),
                    SizedBox(
                      height: Get.height * 0.05,
                    ),
                    SizedBox(
                      height: Get.height * 0.15,
                      width: double.infinity,
                      child: Image.asset(
                        // AppImagesPath.emiratesID,
                        'assets/images/tenant_images/cropImage1.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    SizedBox(
                      height: Get.height * 0.15,
                      width: double.infinity,
                      child: Image.asset(
                        // AppImagesPath.emiratesID,
                        'assets/images/tenant_images/cropImage2.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.05,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Spacer(),
                        SizedBox(
                          width: Get.width * 0.3,
                          height: Get.height * 0.05,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context, rootNavigator: true)
                                  .pop('dialog');
                            },
                            style: ButtonStyle(
                              shape: WidgetStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(3.0.w),
                                      side: BorderSide(color: Colors.blue))),
                              backgroundColor:
                                  WidgetStateProperty.all<Color>(Colors.white),
                            ),
                            child: Text(
                              AppMetaLabels().cancel,
                              style: AppTextStyle.semiBoldBlue11
                                  .copyWith(color: Colors.blue),
                            ),
                          ),
                        ),
                        Spacer(),
                        SizedBox(
                          width: Get.width * 0.3,
                          height: Get.height * 0.05,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(1.3.h),
                                ),
                                backgroundColor: Colors.blue),
                            onPressed: () async {
                              if (source == 'gallery') {
                                Navigator.of(context, rootNavigator: true)
                                    .pop('dialog');
                                setState(() {
                                  isEnableScreen = false;
                                  controller.isLoadingForScanning.value = true;
                                  controller.controllerTRDC.isEnableBackButton
                                      .value = false;
                                });
                                setState(() {
                                  SessionController().idNumber = null;
                                  controller.isbothScane.value = false;
                                });
                                await controller.scanEmirateId(
                                    ImageSource.gallery, index);
                                setState(() {
                                  isEnableScreen = true;
                                  controller.isLoadingForScanning.value = false;
                                  controller.controllerTRDC.isEnableBackButton
                                      .value = true;
                                });
                              } else {
                                Navigator.of(context, rootNavigator: true)
                                    .pop('dialog');
                                setState(() {
                                  isEnableScreen = false;
                                  controller.isLoadingForScanning.value = true;
                                  controller.controllerTRDC.isEnableBackButton
                                      .value = false;
                                });
                                setState(() {
                                  SessionController().idNumber = null;
                                  controller.isbothScane.value = false;
                                });
                                await controller.scanEmirateId(
                                    ImageSource.camera, index);

                                setState(() {
                                  isEnableScreen = true;
                                  controller.isLoadingForScanning.value = false;
                                  controller.controllerTRDC.isEnableBackButton
                                      .value = true;
                                });
                              }
                            },
                            child: Text(
                              AppMetaLabels().scane,
                              style: AppTextStyle.semiBoldWhite10,
                            ),
                          ),
                        ),
                        Spacer(),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}


// Before Compress Image Func and Add Croper
// // ignore_for_file: unused_local_variable

// import 'package:fap_properties/data/helpers/session_controller.dart';
// import 'package:fap_properties/data/models/tenant_models/card_model.dart';
// import 'package:fap_properties/utils/constants/assets_path.dart';
// import 'package:fap_properties/utils/constants/meta_labels.dart';
// import 'package:fap_properties/utils/screen_disable.dart';
// import 'package:fap_properties/utils/styles/colors.dart';
// import 'package:fap_properties/utils/styles/text_styles.dart';
// import 'package:fap_properties/utils/text_validator.dart';
// import 'package:fap_properties/views/tenant/tenant_dashboard/tenant_dashboard_tabs/tenant_dashboard_tabs.dart';
// import 'package:fap_properties/views/widgets/common_widgets/error_text_widget.dart';
// import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
// import 'package:fap_properties/views/tenant/tenant_services_request/tenant_request_details/tenant_service_request_tab/svc_req_docs_controller.dart';
// import 'package:fap_properties/views/widgets/bottom_shadow.dart';
// import 'package:fap_properties/views/widgets/clear_button.dart';
// import 'package:fap_properties/views/widgets/file_view.dart';
// import 'package:fap_properties/views/widgets/snackbar_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
// import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:sizer/sizer.dart';
// import 'package:get/get.dart';
// import 'package:flutter/gestures.dart';
// import 'dart:ui' as ui;

// class TenantServiceDocuments extends StatefulWidget {
//   final String caseNo;
//   final String caller;
//   TenantServiceDocuments({Key key, this.caseNo, this.caller})
//       : super(key: key) {
//     Get.put(SvcReqDocsController(caseNo: caseNo));
//   }

//   @override
//   _TenantServiceDocumentsState createState() => _TenantServiceDocumentsState();
// }

// class _TenantServiceDocumentsState extends State<TenantServiceDocuments> {
//   final controller = Get.find<SvcReqDocsController>();

//   // TextEditingController will use in the EID confirmation
//   TextEditingController nameText = TextEditingController();
//   TextEditingController iDNumberText = TextEditingController();
//   var maskFormatter = MaskedInputFormatter(
//     '###-####-#######-#',
//     allowedCharMatcher: RegExp(r'[0-9]'),
//   );

//   String dOBText = '';
//   String expiryText = '';
//   bool isNameError = false;
//   bool isIDError = false;
//   bool isDOBError = false;
//   bool isExpiryError = false;

//   bool _isSolving = false;
//   bool isEnableScreen = true;
//   @override
//   void initState() {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       // controller.getFiles();
//       getInformation();
//     });
//     super.initState();
//   }

//   getInformation() async {
//     setState(() {
//       _isSolving = true;
//     });
//     await controller.getFiles();
//     setState(() {});
//     setState(() {});
//     setState(() {
//       _isSolving = false;
//     });
//   }

//   bool highLightExpiry = false;

//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () => Future.value(false),
//       child: Scaffold(
//           key: _scaffoldKey,
//           resizeToAvoidBottomInset: false,
//           backgroundColor: Colors.white,
//           body: _isSolving == true
//               ? Center(child: LoadingIndicatorBlue())
//               : Stack(
//                   children: [
//                     controller.loadingDocs.value
//                         ? Center(child: LoadingIndicatorBlue())
//                         : Column(
//                             children: [
//                               Expanded(
//                                 child: Obx(() {
//                                   return controller.loadingDocs.value
//                                       ? Center(child: LoadingIndicatorBlue())
//                                       : controller.errorLoadingDocs != ''
//                                           ? AppErrorWidget(
//                                               errorText:
//                                                   controller.errorLoadingDocs,
//                                             )
//                                           : controller.docsModel??.docs? == null
//                                               ? SizedBox()
//                                               : Container(
//                                                   child: ListView.builder(
//                                                       padding: EdgeInsets.zero,
//                                                       itemCount: controller
//                                                               .docsModel?
//                                                               .docs?
//                                                               .length +
//                                                           1,
//                                                       itemBuilder:
//                                                           (context, index) {
//                                                         if (controller.docsModel?
//                                                                 .docs?.length ==
//                                                             index) {
//                                                           return Center(
//                                                               child: Obx(() {
//                                                             return controller
//                                                                         .docsModel?
//                                                                         .caseStageInfo?!
//                                                                         .stageId
//                                                                         .value <
//                                                                     3
//                                                                 ? Column(
//                                                                     children: [
//                                                                       Padding(
//                                                                         padding: EdgeInsets.symmetric(
//                                                                             horizontal:
//                                                                                 4.w,
//                                                                             vertical: 2.h),
//                                                                         child:
//                                                                             Text(
//                                                                           AppMetaLabels()
//                                                                               .allMandatory,
//                                                                           style:
//                                                                               AppTextStyle.normalBlack10,
//                                                                         ),
//                                                                       ),
//                                                                     ],
//                                                                   )
//                                                                 : controller.docsModel?.responseMessageAR ==
//                                                                             '' &&
//                                                                         SessionController().getLanguage() !=
//                                                                             1
//                                                                     ? SizedBox()
//                                                                     : controller.docsModel?.caseStageInfo?!.stageId.value ==
//                                                                             4
//                                                                         ? Container(
//                                                                             alignment:
//                                                                                 Alignment.center,
//                                                                             padding:
//                                                                                 EdgeInsets.all(8.0),
//                                                                             margin:
//                                                                                 EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
//                                                                             decoration:
//                                                                                 BoxDecoration(color: Color.fromRGBO(255, 249, 235, 1), borderRadius: BorderRadius.circular(8)),
//                                                                             child:
//                                                                                 Row(
//                                                                               crossAxisAlignment: CrossAxisAlignment.center,
//                                                                               children: [
//                                                                                 Icon(
//                                                                                   Icons.error_outline,
//                                                                                   color: Colors.amber[400],
//                                                                                 ),
//                                                                                 SizedBox(
//                                                                                   width: 8.0,
//                                                                                 ),
//                                                                                 Expanded(
//                                                                                   child: Text(
//                                                                                     SessionController().getLanguage() == 1 ? controller.docsModel?.responseMessage ?? '' : controller.docsModel?.responseMessageAR ?? "",
//                                                                                     style: AppTextStyle.normalBlack12,
//                                                                                   ),
//                                                                                 ),
//                                                                               ],
//                                                                             ),
//                                                                           )
//                                                                         : SizedBox();
//                                                           }));
//                                                         }
//                                                         return Padding(
//                                                             padding:
//                                                                 EdgeInsets.all(
//                                                                     2.0.h),
//                                                             child: Column(
//                                                                 crossAxisAlignment:
//                                                                     CrossAxisAlignment
//                                                                         .start,
//                                                                 children: [
//                                                                   Padding(
//                                                                     padding: EdgeInsets.only(
//                                                                         left: 4.0
//                                                                             .w,
//                                                                         bottom: 2.0
//                                                                             .h,
//                                                                         right: 4.0
//                                                                             .w),
//                                                                     child: Text(
//                                                                       SessionController().getLanguage() ==
//                                                                               1
//                                                                           ? controller.docsModel?.docs?[index].name ??
//                                                                               ""
//                                                                           : controller.docsModel?.docs?[index].nameAr ??
//                                                                               '',
//                                                                       style: AppTextStyle
//                                                                           .semiBoldBlack12,
//                                                                     ),
//                                                                   ),
//                                                                   controller.docsModel?.docs?[index].id ==
//                                                                               null ||
//                                                                           controller
//                                                                               .docsModel?
//                                                                               .docs?[
//                                                                                   index]
//                                                                               .isRejected
//                                                                       ? uploadFile(
//                                                                           context,
//                                                                           index)
//                                                                       : Container(
//                                                                           width:
//                                                                               100.0.w,
//                                                                           padding: EdgeInsets.symmetric(
//                                                                               vertical: 1.h,
//                                                                               horizontal: 4.w),
//                                                                           decoration:
//                                                                               BoxDecoration(
//                                                                             color:
//                                                                                 Colors.white,
//                                                                             borderRadius:
//                                                                                 BorderRadius.circular(2.0.h),
//                                                                             boxShadow: [
//                                                                               BoxShadow(
//                                                                                 color: Colors.black12,
//                                                                                 blurRadius: 0.5.h,
//                                                                                 spreadRadius: 0.1.h,
//                                                                                 offset: Offset(0.1.h, 0.1.h),
//                                                                               ),
//                                                                             ],
//                                                                           ),
//                                                                           child:
//                                                                               Obx(() {
//                                                                             return FileView(
//                                                                               file: controller.docsModel?.docs?[index],
//                                                                               onDelete: controller.docsModel?.docs?[index].loading.value == true
//                                                                                   ? () {}
//                                                                                   : () async {
//                                                                                       if (controller.docsModel?.docs?[index].name.toLowerCase() == 'emirate id') {
//                                                                                         setState(() {
//                                                                                           isEnableScreen = false;
//                                                                                         });
//                                                                                         setState(() {
//                                                                                           controller.mergedId = null;
//                                                                                           controller.cardScanModel = CardScanModel();
//                                                                                         });
//                                                                                         setState(() {
//                                                                                           nameText.clear();
//                                                                                           iDNumberText.clear();
//                                                                                           expiryText = '';
//                                                                                           dOBText = '';
//                                                                                         });
//                                                                                         await controller.removePickedFile(index);
//                                                                                         await controller.removeFile(index);
//                                                                                         setState(() {
//                                                                                           controller.isDocUploaded[index] = 'false';
//                                                                                         });
//                                                                                         setState(() {
//                                                                                           isEnableScreen = true;
//                                                                                         });
//                                                                                         return;
//                                                                                       }
//                                                                                       setState(() {
//                                                                                         isEnableScreen = false;
//                                                                                       });
//                                                                                       await controller.removeFile(index);
//                                                                                       setState(() {
//                                                                                         isEnableScreen = true;
//                                                                                       });
//                                                                                     },
//                                                                               onPressed: () {
//                                                                                 controller.downloadDoc(index);
//                                                                               },
//                                                                               canDelete: controller.docsModel?.caseStageInfo?!.stageId.value < 3,
//                                                                             );
//                                                                           }),
//                                                                         )
//                                                                 ]));
//                                                       }),
//                                                 );
//                                 }),
//                               ),
//                               controller.docsModel??.docs? == null
//                                   ? SizedBox()
//                                   : SingleChildScrollView(
//                                       child: Obx(() {
//                                         return controller
//                                                     .docsModel?.caseStageInfo?! ==
//                                                 null
//                                             ? SizedBox()
//                                             : controller.loadingDocs.value
//                                                 ? SizedBox()
//                                                 : controller
//                                                             .docsModel?
//                                                             .caseStageInfo?!
//                                                             .stageId
//                                                             .value >=
//                                                         3
//                                                     ? SizedBox()
//                                                     : Align(
//                                                         alignment: Alignment
//                                                             .bottomCenter,
//                                                         child: Container(
//                                                           width: 100.0.w,
//                                                           height: 9.0.h,
//                                                           decoration:
//                                                               BoxDecoration(
//                                                             color: Colors.white,
//                                                             boxShadow: [
//                                                               BoxShadow(
//                                                                 color: Colors
//                                                                     .black12,
//                                                                 blurRadius:
//                                                                     0.5.h,
//                                                                 spreadRadius:
//                                                                     0.5.h,
//                                                                 offset: Offset(
//                                                                     0.1.h,
//                                                                     0.1.h),
//                                                               ),
//                                                             ],
//                                                           ),
//                                                           child: Padding(
//                                                             padding:
//                                                                 EdgeInsets.all(
//                                                                     2.0.h),
//                                                             child: controller
//                                                                     .updatingDocStage
//                                                                     .value
//                                                                 ? LoadingIndicatorBlue()
//                                                                 : ElevatedButton(
//                                                                     onPressed: !controller
//                                                                             .enableSubmit
//                                                                             .value
//                                                                         ? null
//                                                                         : () async {
//                                                                             setState(() {
//                                                                               isEnableScreen = false;
//                                                                             });
//                                                                             await controller.updateDocStage(widget.caller);
//                                                                             setState(() {
//                                                                               isEnableScreen = true;
//                                                                             });
//                                                                             if (controller.docsModel?.caseStageInfo?!.stageId.value >=
//                                                                                 3) {
//                                                                               showDialog(
//                                                                                   context: context,
//                                                                                   barrierDismissible: false,
//                                                                                   builder: (BuildContext context) {
//                                                                                     return AlertDialog(
//                                                                                       contentPadding: EdgeInsets.zero,
//                                                                                       backgroundColor: Colors.transparent,
//                                                                                       content: showDialogData(),
//                                                                                     );
//                                                                                   });
//                                                                             }
//                                                                           },
//                                                                     child:
//                                                                         SizedBox(
//                                                                       width:
//                                                                           40.w,
//                                                                       child:
//                                                                           Center(
//                                                                         child:
//                                                                             Text(
//                                                                           AppMetaLabels()
//                                                                               .submit,
//                                                                           style:
//                                                                               AppTextStyle.semiBoldWhite12,
//                                                                         ),
//                                                                       ),
//                                                                     ),
//                                                                     style: ElevatedButton
//                                                                         .styleFrom(
//                                                                       shape:
//                                                                           RoundedRectangleBorder(
//                                                                         borderRadius:
//                                                                             BorderRadius.circular(1.3.h),
//                                                                       ),
//                                                                       backgroundColor: controller
//                                                                               .enableSubmit
//                                                                               .value
//                                                                           ? Color.fromRGBO(
//                                                                               0,
//                                                                               61,
//                                                                               166,
//                                                                               1)
//                                                                           : Colors
//                                                                               .grey
//                                                                               .shade400,
//                                                                     ),
//                                                                   ),
//                                                           ),
//                                                         ),
//                                                       );
//                                       }),
//                                     ),
//                             ],
//                           ),
//                     isEnableScreen == false
//                         ? ScreenDisableWidget()
//                         : SizedBox(),
//                     Obx(() {
//                       return controller.isLoadingForScanning.value == true
//                           ? Container(
//                               height: double.infinity,
//                               width: double.infinity,
//                               color: Colors.black.withOpacity(0.3),
//                               child: Center(
//                                   child: CircularProgressIndicator(
//                                 backgroundColor: Colors.white,
//                                 color: Colors.blue,
//                               )),
//                             )
//                           : SizedBox();
//                     }),
//                     BottomShadow(),
//                   ],
//                 )),
//     );
//   }

//   Container uploadFile(BuildContext context, int index) {
//     print('Index :::::: $index');
//     return Container(
//         width: 100.0.w,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(2.0.h),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black12,
//               blurRadius: 0.5.h,
//               spreadRadius: 0.1.h,
//               offset: Offset(0.1.h, 0.1.h),
//             ),
//           ],
//         ),
//         child: Padding(
//             padding: EdgeInsets.only(left: 4.0.w, bottom: 3.5.h, right: 4.0.w),
//             child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   if (controller.docsModel?.docs?[index].isRejected)
//                     RichText(
//                       text: TextSpan(
//                           text: '${AppMetaLabels().your} ',
//                           style: AppTextStyle.normalErrorText3,
//                           children: <TextSpan>[
//                             TextSpan(
//                                 text: controller.docsModel?.docs?[index].name,
//                                 style: AppTextStyle.normalBlue10,
//                                 recognizer: TapGestureRecognizer()
//                                   ..onTap = () {
//                                     if (!controller
//                                         .docsModel?.docs?[index].loading.value) {
//                                       setState(() {
//                                         isEnableScreen = false;
//                                       });
//                                       controller.downloadDocRejected(index);
//                                       // controller.downloadDoc(index);
//                                       setState(() {
//                                         isEnableScreen = true;
//                                       });
//                                     }
//                                   }),
//                             TextSpan(
//                                 text: ' ${AppMetaLabels().fileRejected}',
//                                 style: AppTextStyle.normalErrorText3)
//                           ]),
//                     ),
//                   SizedBox(
//                     height: 8,
//                   ),
//                   Obx(() {
//                     if (controller.docsModel?.docs?[index].update.value) {}
//                     return controller.docsModel?.docs?[index].path != null
//                         ? FileView(
//                             file: controller.docsModel?.docs?[index],
//                             onPressed: () {
//                               controller
//                                   .showFile(controller.docsModel?.docs?[index]);
//                             },
//                             onDelete: controller
//                                         .docsModel?.docs?[index].loading.value ==
//                                     true
//                                 ? () {}
//                                 : () async {
//                                     setState(() {
//                                       isEnableScreen = false;
//                                     });
//                                     setState(() {
//                                       nameText.clear();
//                                       iDNumberText.clear();
//                                       expiryText = '';
//                                       dOBText = '';
//                                     });
//                                     await controller.removePickedFile(index);
//                                     setState(() {
//                                       controller.isDocUploaded[index] = 'false';
//                                       controller.docsModel?.docs?[index]
//                                           .errorLoading = false;
//                                     });
//                                     setState(() {
//                                       highLightExpiry = false;
//                                       if (controller
//                                               .selectedIndexForUploadedDocument ==
//                                           index) {
//                                         controller
//                                             .selectedIndexForUploadedDocument = -1;
//                                       }
//                                     });
//                                     setState(() {
//                                       isEnableScreen = true;
//                                     });
//                                   },
//                             canDelete: true,
//                           )
//                         : InkWell(
//                             onTap: () async {
//                               bool isTrue;
//                               print(controller.isDocUploaded);
//                               for (int i = 0;
//                                   i < controller.isDocUploaded.length;
//                                   i++) {
//                                 print(controller.isDocUploaded[i] == 'true');
//                                 if (controller.isDocUploaded[i] == 'true') {
//                                   setState(() {
//                                     isTrue = true;
//                                   });
//                                 }
//                               }
//                               if (isTrue == true) {
//                                 SnakBarWidget.getSnackBarErrorBlue(
//                                     AppMetaLabels().alert,
//                                     AppMetaLabels().uploadAttachedDocFirst);
//                                 return;
//                               }
//                               if (controller.docsModel?.docs?[index].name
//                                       .toLowerCase() ==
//                                   'emirate id') {
//                                 _showPicker(context, index);
//                               } else {
//                                 await _showPickerPassport(context, index);
//                                 setState(() {
//                                   highLightExpiry =
//                                       controller.docsModel?.docs?[index].path !=
//                                               null
//                                           ? true
//                                           : false;
//                                 });
//                               }
//                             },
//                             child: Container(
//                               // color: Colors.red,
//                               padding: EdgeInsets.only(
//                                 left: 4.0.w,
//                                 right: 4.0.w,
//                                 top: 3.5.h,
//                               ),
//                               width: double.infinity,
//                               decoration: BoxDecoration(
//                                 color: Color.fromRGBO(246, 248, 249, 1),
//                                 borderRadius: BorderRadius.circular(0.5.h),
//                               ),
//                               child: Column(
//                                 children: [
//                                   Center(
//                                     child: IconButton(
//                                       onPressed: () async {
//                                         bool isTrue;
//                                         print(controller.isDocUploaded);
//                                         for (int i = 0;
//                                             i < controller.isDocUploaded.length;
//                                             i++) {
//                                           print(controller.isDocUploaded[i] ==
//                                               'true');
//                                           if (controller.isDocUploaded[i] ==
//                                               'true') {
//                                             setState(() {
//                                               isTrue = true;
//                                             });
//                                           }
//                                         }
//                                         if (isTrue == true) {
//                                           SnakBarWidget.getSnackBarErrorBlue(
//                                               AppMetaLabels().alert,
//                                               AppMetaLabels()
//                                                   .uploadAttachedDocFirst);
//                                           return;
//                                         }
//                                         if (controller
//                                                 .docsModel?.docs?[index].name
//                                                 .toLowerCase() ==
//                                             'emirate id') {
//                                           _showPicker(context, index);
//                                         } else {
//                                           await _showPickerPassport(
//                                               context, index);
//                                           setState(() {
//                                             highLightExpiry = controller
//                                                         .docsModel?
//                                                         .docs?[index]
//                                                         .path !=
//                                                     null
//                                                 ? true
//                                                 : false;
//                                           });
//                                         }
//                                       },
//                                       icon: Image.asset(
//                                         AppImagesPath.downloadimg,
//                                         width: 4.5.h,
//                                         height: 4.5.h,
//                                         fit: BoxFit.contain,
//                                       ),
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     height: 1.5.h,
//                                   ),
//                                   Text(
//                                     AppMetaLabels().uploadYourDoc,
//                                     style: AppTextStyle.semiBoldBlack10,
//                                   ),
//                                   SizedBox(
//                                     height: 1.5.h,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           );
//                   }),
//                   // SizedBox(
//                   //   height: 2.5.h,
//                   // ),
//                   // Text(
//                   //   AppMetaLabels().uploadYourDoc,
//                   //   style: AppTextStyle.semiBoldBlack10,
//                   // ),
//                   SizedBox(
//                     height: 1.5.h,
//                   ),
//                   Text(
//                     controller.docsModel?.docs?[index].name == 'Emirate ID'
//                         ? AppMetaLabels().filedetailsEID
//                         : AppMetaLabels().filedetails,
//                     style: AppTextStyle.normalGrey9,
//                   ),
//                   SizedBox(
//                     height: 3.h,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         '${AppMetaLabels().expDate} *',
//                         style: AppTextStyle.semiBoldBlack10,
//                       ),
//                       InkWell(
//                         onTap: () async {
//                           bool isTrue;
//                           print(controller.isDocUploaded);
//                           for (int i = 0;
//                               i < controller.isDocUploaded.length;
//                               i++) {
//                             print(controller.isDocUploaded[i] == 'true');
//                             if (controller.isDocUploaded[i] == 'true') {
//                               setState(() {
//                                 isTrue = true;
//                               });
//                             }
//                           }

//                           var expDate;
//                           if (controller.docsModel?.docs?[index].path != null) {
//                             print('Tapping :::::: ');
//                             expDate = await showRoundedDatePicker(
//                               height: 50.0.h,
//                               context: context,
//                               locale: SessionController().getLanguage() == 1
                                  // ? Locale('en', '')
                                  // : Locale('ar', ''),
//                               initialDate: DateTime.now(),
//                               firstDate:
//                                   DateTime.now().subtract(Duration(seconds: 1)),
//                               lastDate: DateTime(DateTime.now().year + 20),
//                               borderRadius: 2.0.h,
//                               // theme:
//                               //     ThemeData(primarySwatch: Colors.deepPurple),
//                               styleDatePicker: MaterialRoundedDatePickerStyle(
//                                 backgroundHeader: Colors.grey.shade300,
//                                 // Appbar year like '2023' button
//                                 textStyleYearButton: TextStyle(
//                                   fontSize: 30.sp,
//                                   color: Colors.blue,
//                                   fontWeight: FontWeight.bold,
//                                   backgroundColor: Colors.grey.shade100,
//                                   leadingDistribution:
//                                       TextLeadingDistribution.even,
//                                 ),
//                                 // Appbar day like 'Thu, Mar 16' button
//                                 textStyleDayButton: TextStyle(
//                                   fontSize: 18.sp,
//                                   color: Colors.white,
//                                 ),

//                                 // Heading year like 'S M T W TH FR SA ' button
//                                 // textStyleDayHeader: TextStyle(
//                                 //   fontSize: 30.sp,
//                                 //   color: Colors.white,
//                                 //   backgroundColor: Colors.red,
//                                 //   decoration: TextDecoration.overline,
//                                 //   decorationColor: Colors.pink,
//                                 // ),
//                               ),
//                             );
//                           } else {
//                             if (controller.isDocUploaded.contains('true')) {
//                               SnakBarWidget.getSnackBarErrorBlue(
//                                   AppMetaLabels().alert,
//                                   AppMetaLabels().uploadAttachedDocFirst);
//                             } else {
//                               SnakBarWidget.getSnackBarErrorBlue(
//                                   AppMetaLabels().alert,
//                                   AppMetaLabels().pleaseSelectFileFirst);
//                             }
//                           }

//                           if (expDate != null) {
//                             if (expDate.isBefore(DateTime.now()) ||
//                                 expDate.isAtSameMomentAs(DateTime.now())) {
//                               SnakBarWidget.getSnackBarErrorBlue(
//                                 AppMetaLabels().error,
//                                 AppMetaLabels().selectFuturedate,
//                               );
//                             } else {
//                               DateFormat dateFormat = new DateFormat(
//                                   AppMetaLabels()
//                                       .dateFormatForShowRoundedDatePicker);
//                               if (controller.docsModel?.docs?[index].name
//                                       .toLowerCase() ==
//                                   'emirate id') {
//                                 if (controller.cardScanModel.expiry != null) {
//                                   setState(() {
//                                     controller.cardScanModel.expiry = null;
//                                   });
//                                 }
//                               }
//                               await controller.setExpDate(
//                                   index, dateFormat.format(expDate));
//                               setState(() {
//                                 highLightExpiry = false;
//                               });
//                               setState(() {
//                                 if (controller
//                                         .selectedIndexForUploadedDocument ==
//                                     index) {
//                                   controller.selectedIndexForUploadedDocument =
//                                       -1;
//                                 }
//                               });
//                             }
//                           }
//                         },
//                         child: Container(
//                           width: 40.0.w,
//                           height: 5.5.h,
//                           decoration: BoxDecoration(
//                               color: Color.fromRGBO(246, 248, 249, 1),
//                               borderRadius: BorderRadius.circular(1.0.h),
//                               border: Border.all(
//                                   color: index ==
//                                           controller
//                                               .selectedIndexForUploadedDocument
//                                       ? Colors.red
//                                       : Colors.transparent)),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             children: [
//                               Padding(
//                                 padding:
//                                     EdgeInsets.symmetric(horizontal: 1.0.h),
//                                 child: Obx(() {
//                                   if (controller
//                                       .docsModel?.docs?[index].update.value) {}
//                                   return Text(
//                                     controller.docsModel?.docs?[index].expiry ??
//                                         '',
//                                     style: AppTextStyle.normalBlack12,
//                                   );
//                                 }),
//                               ),
//                               Spacer(),
//                               Padding(
//                                 padding:
//                                     EdgeInsets.symmetric(horizontal: 1.0.h),
//                                 child: ClearButton(
//                                   clear: () {
//                                     controller.clearExpDate(index);
//                                     if (controller.cardScanModel.expiry !=
//                                         null) {
//                                       setState(() {
//                                         controller.cardScanModel.expiry = null;
//                                       });
//                                     }
//                                   },
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   controller.selectedIndexForUploadedDocument == index
//                       ? SizedBox(
//                           height: 20,
//                           child: Center(
//                               child: Text(
//                             AppMetaLabels().pleaseSelectExpiryDate,
//                             style: TextStyle(color: Colors.blue),
//                           )))
//                       : SizedBox(
//                           height: 10,
//                         ),
//                   Container(
//                       margin: EdgeInsets.only(top: 3.h),
//                       width: 50.w,
//                       height: 5.h,
//                       child: Obx(() {
//                         return controller.docsModel?.docs?[index].loading.value
//                             ? LoadingIndicatorBlue(
//                                 size: 3.h,
//                               )
//                             : controller.docsModel?.docs?[index].errorLoading
//                                 ? IconButton(
//                                     onPressed: () async {
//                                       // here also add refresh func for visa and passport

//                                       if (controller.docsModel?.docs?[index].name
//                                               .toLowerCase() !=
//                                           'emirate id') {
//                                         setState(() {
//                                           isEnableScreen = false;
//                                         });
//                                         if (controller
//                                             .docsModel?.docs?[index].isRejected) {
//                                           setState(() {
//                                             isEnableScreen = false;
//                                           });
//                                           await controller.updateDoc(index);
//                                           setState(() {
//                                             isEnableScreen = true;
//                                           });
//                                         } else {
//                                           setState(() {
//                                             isEnableScreen = false;
//                                           });
//                                           await controller.uploadDoc(index);
//                                           setState(() {
//                                             isEnableScreen = true;
//                                           });
//                                         }
//                                         setState(() {
//                                           isEnableScreen = true;
//                                         });
//                                         return;
//                                       }

//                                       setState(() {
//                                         isEnableScreen = false;
//                                         controller.isLoadingForScanning.value =
//                                             true;
//                                       });
//                                       if (controller
//                                           .docsModel?.docs?[index].isRejected) {
//                                         await controller.updateDoc(index);
//                                         setState(() {
//                                           isEnableScreen = false;
//                                         });
//                                       } else {
//                                         var dOB;
//                                         var exp;
//                                         if (controller.cardScanModel.dob !=
//                                             null) {
//                                           dOB =
//                                               '${DateFormat('dd-MM-yyyy').format(controller.cardScanModel.dob)}';
//                                         }
//                                         if (controller.cardScanModel.expiry !=
//                                             null) {
//                                           exp =
//                                               '${DateFormat('dd-MM-yyyy').format(controller.cardScanModel.expiry)}';
//                                         }
//                                         await controller
//                                             .uploadDocWithEIDParameter(
//                                           index,
//                                           controller.cardScanModel.idNumber,
//                                           controller.cardScanModel.nationality,
//                                           controller.cardScanModel.name,
//                                           controller.cardScanModel.name,
//                                           '',
//                                           // controller.cardScanModel.dob,
//                                           dOB,
//                                         );
//                                         setState(() {
//                                           isEnableScreen = true;
//                                           controller.isLoadingForScanning
//                                               .value = false;
//                                         });
//                                       }
//                                       setState(() {
//                                         isEnableScreen = true;
//                                         controller.isLoadingForScanning.value =
//                                             false;
//                                       });
//                                     },
//                                     icon: Icon(
//                                       Icons.refresh,
//                                       size: 4.5.h,
//                                       color: Colors.red,
//                                     ),
//                                   )
//                                 : Obx(() {
//                                     if (controller
//                                         .docsModel?.docs?[index].update.value) {}
//                                     return ElevatedButton(
//                                       onPressed: controller.docsModel?
//                                                       .docs?[index].expiry ==
//                                                   null ||
//                                               controller.docsModel?.docs?[index]
//                                                       .path ==
//                                                   null
//                                           ? null
//                                           : () async {
//                                               setState(() {
//                                                 isEnableScreen = false;
//                                               });
//                                               if (controller.mergedId != null) {
//                                                 WidgetsBinding.instance
//                                                     .addPostFrameCallback(
//                                                   (timeStamp) async {
//                                                     // _showConfirmationDialog(
//                                                     //     index, context);
//                                                     await _showConfirmationDialog(
//                                                         index, context);
//                                                     setState(() {
//                                                       controller
//                                                           .isLoadingForScanning
//                                                           .value = false;
//                                                       isEnableScreen = true;
//                                                     });
//                                                     setState(() {});
//                                                     print(
//                                                         'ISEnable Screen Val :::::: $isEnableScreen');
//                                                   },
//                                                 );
//                                               }
//                                               if (controller.docsModel?
//                                                       .docs?[index].name
//                                                       .toLowerCase() !=
//                                                   'emirate id') {
//                                                 if (controller.docsModel?
//                                                     .docs?[index].isRejected) {
//                                                   setState(() {
//                                                     isEnableScreen = false;
//                                                     controller
//                                                         .isLoadingForScanning
//                                                         .value = true;
//                                                   });
//                                                   print(
//                                                       ':::::::::::::: $isEnableScreen');
//                                                   print(
//                                                       ':::::::::::::: ${controller.isLoadingForScanning.value}');
//                                                   controller.updateDoc(index);
//                                                   setState(() {
//                                                     isEnableScreen = true;
//                                                     controller
//                                                         .isLoadingForScanning
//                                                         .value = false;
//                                                   });
//                                                 } else {
//                                                   await controller
//                                                       .uploadDoc(index);
//                                                 }
//                                               }
//                                               setState(() {
//                                                 isEnableScreen = true;
//                                               });
//                                             },
//                                       child: Text(
//                                         AppMetaLabels().upload,
//                                         style: AppTextStyle.semiBoldWhite12,
//                                       ),
//                                       style: ElevatedButton.styleFrom(
//                                         shape: RoundedRectangleBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(1.3.h),
//                                         ),
//                                         backgroundColor:
//                                             Color.fromRGBO(0, 61, 166, 1),
//                                       ),
//                                     );
//                                   });
//                       }))
//                 ])));
//   }

// // upload passport and other pic from here
//   _showPickerPassport(context, int index) {
//     showModalBottomSheet(
//         context: context,
//         builder: (BuildContext bc) {
//           return SafeArea(
//             child: Container(
//               color: Colors.white,
//               child: new Wrap(
//                 children: <Widget>[
//                   new ListTile(
//                       leading: new Icon(Icons.storage),
//                       title: new Text(AppMetaLabels().storage),
//                       onTap: () async {
//                         await controller.pickDoc(index);
//                         setState(() {});
//                         Navigator.of(context).pop();
//                       }),
//                   new ListTile(
//                     leading: new Icon(Icons.photo_camera),
//                     title: new Text(AppMetaLabels().camera),
//                     onTap: () async {
//                       await controller.takePhoto(index);
//                       setState(() {});
//                       Navigator.of(context).pop();
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           );
//         });
//   }

// // upload emirate pic from here
//   void _showPicker(context, int index) {
//     showModalBottomSheet(
//         context: context,
//         builder: (BuildContext bc) {
//           return Directionality(
//               textDirection: SessionController().getLanguage() == 1
//                   ? ui.TextDirection.ltr
//                   : ui.TextDirection.rtl,
//               child: SafeArea(
//                   child: Container(
//                 color: Colors.white,
//                 child: new Wrap(
//                   children: <Widget>[
//                     new ListTile(
//                       leading: new Icon(Icons.photo_library),
//                       title: new Text(AppMetaLabels().photoLibrary),
//                       onTap: () async {
//                         Navigator.of(context).pop();
//                         setState(() {
//                           controller.mergedId = null;
//                           controller.cardScanModel = CardScanModel();
//                         });
//                         await _showFrontBackImage('gallery', context, index);

//                         // old
//                         if (controller.mergedId != null) {
//                           WidgetsBinding.instance.addPostFrameCallback(
//                             (timeStamp) async {
//                               setState(() {
//                                 controller.isDocUploaded[index] = 'true';
//                               });
//                               // _showConfirmationDialog(index, context);
//                               await _showConfirmationDialog(index, context);
//                               setState(() {
//                                 controller.isLoadingForScanning.value = false;
//                                 isEnableScreen = true;
//                               });
//                               setState(() {});
//                               print(
//                                   'ISEnable Screen Val :::::: $isEnableScreen');
//                             },
//                           );
//                         }
//                       },
//                     ),
//                     new ListTile(
//                       leading: new Icon(Icons.photo_camera),
//                       title: new Text(AppMetaLabels().camera),
//                       onTap: () async {
//                         Navigator.of(context).pop();
//                         setState(() {
//                           controller.mergedId = null;
//                           controller.cardScanModel = CardScanModel();
//                         });
//                         await _showFrontBackImage('camera', context, index);

//                         if (controller.mergedId != null) {
//                           WidgetsBinding.instance.addPostFrameCallback(
//                             (timeStamp) async {
//                               setState(() {
//                                 controller.isDocUploaded[index] = 'true';
//                               });
//                               await _showConfirmationDialog(index, context);
//                               setState(() {
//                                 controller.isLoadingForScanning.value = false;
//                                 isEnableScreen = true;
//                               });
//                               setState(() {});
//                               print(
//                                   'ISEnable Screen Val :::::: $isEnableScreen');
//                             },
//                           );
//                         }
//                       },
//                     ),
//                   ],
//                 ),
//               )));
//         });
//   }

//   // 112233 EID Name ,Id amnd etc
//   // 002 For Tracking of Tenant->Due Action For Contract Renewal->upload Document->Scane Emirate ID
//   // after scan the emirate id there is a pop up show in whic we show name EID nationality etc
//   // all these data pass to the api of upload that we call in line 557 and 555
//   // but when ali bhai publish the api
//   // 112233 after scane EmirateID all code
//   _showConfirmationDialog(int index, BuildContext context) {
//     String nationality = controller.cardScanModel.nationality;
//     String name = controller.cardScanModel.name;
//     if (nationality != null) {
//       if (controller.cardScanModel.nationality.contains('Nationality') ==
//           true) {
//         if (controller.cardScanModel.nationality.contains(',')) {
//           setState(() {
//             nationality = controller.cardScanModel.nationality
//                 .replaceAll('Nationality,', '');
//           });
//         } else if (controller.cardScanModel.nationality.contains(':')) {
//           setState(() {
//             nationality = controller.cardScanModel.nationality
//                 .replaceAll('Nationality:', '');
//           });
//         } else {
//           setState(() {
//             nationality = controller.cardScanModel.nationality
//                 .replaceAll('Nationality', '');
//           });
//         }
//       }
//     }
//     if (nationality != null) {
//       if (controller.cardScanModel.nationality.contains('nationality') ==
//           true) {
//         if (controller.cardScanModel.nationality.contains(',')) {
//           setState(() {
//             nationality = controller.cardScanModel.nationality
//                 .replaceAll('nationality,', '');
//           });
//         } else if (controller.cardScanModel.nationality.contains(':')) {
//           setState(() {
//             nationality = controller.cardScanModel.nationality
//                 .replaceAll('nationality:', '');
//           });
//         } else {
//           setState(() {
//             nationality = controller.cardScanModel.nationality
//                 .replaceAll('nationality', '');
//           });
//         }
//       }
//     }
//     if (name != null) {
//       if (controller.cardScanModel.name.contains('Name') ==
//           true) {
//         if (controller.cardScanModel.name.contains(',')) {
//           setState(() {
//             name = controller.cardScanModel.name
//                 .replaceAll('Name,', '');
//           });
//         } else if (controller.cardScanModel.name.contains(':')) {
//           setState(() {
//             name = controller.cardScanModel.name
//                 .replaceAll('Name:', '');
//           });
//         } else {
//           setState(() {
//             name = controller.cardScanModel.name
//                 .replaceAll('Name', '');
//           });
//         }
//       }
//     }
//     if (name != null) {
//       if (controller.cardScanModel.name.contains('name') ==
//           true) {
//         if (controller.cardScanModel.name.contains(',')) {
//           setState(() {
//             name = controller.cardScanModel.name
//                 .replaceAll('name,', '');
//           });
//         } else if (controller.cardScanModel.name.contains(':')) {
//           setState(() {
//             name = controller.cardScanModel.name
//                 .replaceAll('name:', '');
//           });
//         } else {
//           setState(() {
//             name = controller.cardScanModel.name
//                 .replaceAll('name', '');
//           });
//         }
//       }
//     }

//     nameText.text = name;
//     // nameText.text = controller.cardScanModel.name;
//     iDNumberText.text = controller.cardScanModel.idNumber;
//     if (controller.cardScanModel.dob != null) {
//       dOBText =
//           '${DateFormat('dd-MM-yyyy').format(controller.cardScanModel.dob)}';
//     }

//     expiryText = controller.cardScanModel.expiry == null
//         ? controller.docsModel?.docs?[index].expiry
//         : '${DateFormat('dd-MM-yyyy').format(controller.cardScanModel.expiry)}';

//     setState(() {
//       isNameError = false;
//       isIDError = false;
//       isExpiryError = false;
//       isDOBError = false;
//     });

//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) {
//         return StatefulBuilder(
//           builder: (context, setState) {
//             return AlertDialog(
//               title: Text(AppMetaLabels().pleaseVerify),
//               content: SingleChildScrollView(
//                 child: Container(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       // Name
//                       Padding(
//                         padding: EdgeInsets.only(
//                             left: 2.0.w, top: 0.5.h, right: 4.0.w),
//                         child: Align(
//                             alignment: SessionController().getLanguage() == 1
//                                 ? Alignment.centerLeft
//                                 : Alignment.centerRight,
//                             child: Text(
//                               AppMetaLabels().name,
//                               style: AppTextStyle.normalGrey10,
//                             )),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(
//                             top: 0.5.h, left: 2.0.w, right: 2.0.w),
//                         child: SizedBox(
//                           // height: 4.h,
//                           width: 90.w,
//                           child: TextFormField(
//                             controller: nameText,
//                             maxLines: 2,
//                             style: AppTextStyle.normalBlack10,
//                             onChanged: (val) {
//                               if (val.isNotEmpty) {
//                                 setState(() {
//                                   isNameError = false;
//                                 });
//                               } else {
//                                 if (!nameValidator.hasMatch(val)) {
//                                   setState(() {
//                                     isNameError = true;
//                                   });
//                                   return;
//                                 }
//                               }
//                             },
//                             validator: (value) {
//                               if (!nameValidator.hasMatch(value)) {
//                                 setState(() {
//                                   isNameError = true;
//                                 });
//                                 return;
//                               } else
//                                 return null;
//                             },
//                             decoration: InputDecoration(
//                               suffixIconConstraints: BoxConstraints(
//                                 minWidth: 4.h,
//                                 minHeight: 2,
//                               ),
//                               suffixIcon: Icon(
//                                 Icons.edit,
//                                 size: 2.h,
//                               ),
//                               focusedBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(5.0),
//                                 borderSide: BorderSide(
//                                   color: isNameError
//                                       ? AppColors.redColor
//                                       : AppColors.blueColor,
//                                 ),
//                               ),
//                               enabledBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(5.0),
//                                 borderSide: BorderSide(
//                                   color: isNameError
//                                       ? AppColors.redColor
//                                       : AppColors.bordercolornew,
//                                   width: 0.2.w,
//                                 ),
//                               ),
//                               fillColor: AppColors.greyBG,
//                               filled: true,
//                               hintText: AppMetaLabels().name,
//                               hintStyle: AppTextStyle.normalBlack10
//                                   .copyWith(color: AppColors.textFieldBGColor),
//                               errorStyle: TextStyle(fontSize: 0),
//                               contentPadding: EdgeInsets.all(2.5.w),
//                             ),
//                           ),
//                         ),
//                       ),
//                       isNameError == true
//                           ? Padding(
//                               padding: EdgeInsets.only(
//                                   left: 2.0.w, top: 0.2.h, right: 4.0.w),
//                               child: Text(
//                                 AppMetaLabels().invalidName,
//                                 style: AppTextStyle.normalGrey8
//                                     .copyWith(color: Colors.red),
//                               ),
//                             )
//                           : SizedBox(),
//                       // ID Number
//                       Padding(
//                         padding: EdgeInsets.only(
//                             left: 2.0.w, top: 1.0.h, right: 4.0.w),
//                         child: Align(
//                             alignment: SessionController().getLanguage() == 1
//                                 ? Alignment.centerLeft
//                                 : Alignment.centerRight,
//                             child: Text(
//                               // 'ID Number',
//                               AppMetaLabels().iDNumber,
//                               style: AppTextStyle.normalGrey10,
//                             )),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(
//                             top: 0.5.h, left: 2.0.w, right: 2.0.w),
//                         child: SizedBox(
//                           width: 90.0.w,
//                           height: 4.0.h,
//                           child: TextFormField(
//                             inputFormatters: [maskFormatter],
//                             controller: iDNumberText,
//                             maxLength: 18,
//                             keyboardType: TextInputType.numberWithOptions(),
//                             onChanged: (val) {
//                               if (val.isNotEmpty) {
//                                 setState(() {
//                                   isIDError = false;
//                                 });
//                               }
//                             },
//                             style: AppTextStyle.normalBlack10,
//                             decoration: InputDecoration(
//                               suffixIconConstraints: BoxConstraints(
//                                 minWidth: 4.h,
//                                 minHeight: 2,
//                               ),
//                               suffixIcon: Icon(
//                                 Icons.edit,
//                                 size: 2.h,
//                               ),
//                               counterText: "",
//                               focusedBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(5.0),
//                                 borderSide: BorderSide(
//                                   color: isIDError
//                                       ? AppColors.redColor
//                                       : AppColors.blueColor,
//                                 ),
//                               ),
//                               enabledBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(5.0),
//                                 borderSide: BorderSide(
//                                   color: isIDError
//                                       ? AppColors.redColor
//                                       : AppColors.bordercolornew,
//                                   width: 0.2.w,
//                                 ),
//                               ),
//                               fillColor: AppColors.greyBG,
//                               filled: true,
//                               hintText: '000-0000-0000000-0',
//                               hintStyle: AppTextStyle.normalBlack10
//                                   .copyWith(color: AppColors.textFieldBGColor),
//                               errorStyle: TextStyle(fontSize: 0),
//                               contentPadding: EdgeInsets.all(2.5.w),
//                             ),
//                           ),
//                         ),
//                       ),
//                       // Expiry
//                       Padding(
//                         padding: EdgeInsets.only(
//                             left: 2.0.w, top: 1.0.h, right: 4.0.w),
//                         child: Align(
//                             alignment: SessionController().getLanguage() == 1
//                                 ? Alignment.centerLeft
//                                 : Alignment.centerRight,
//                             child: Text(
//                               AppMetaLabels().expDate,
//                               style: AppTextStyle.normalGrey10,
//                             )),
//                       ),
//                       SizedBox(
//                         height: 0.5.h,
//                       ),
//                       InkWell(
//                         onTap: () async {
//                           var expDate = await showRoundedDatePicker(
//                             height: 50.0.h,
//                             context: context,
//                                 locale: SessionController().getLanguage() == 1
                                  // ? Locale('en', '')
                                  // : Locale('ar', ''),
//                             initialDate: DateTime.now(),
//                             firstDate:
//                                 DateTime.now().subtract(Duration(seconds: 1)),
//                             lastDate: DateTime(DateTime.now().year + 10),
//                             borderRadius: 2.0.h,
//                             // theme:
//                             //     ThemeData(primarySwatch: Colors.deepPurple),
//                             styleDatePicker: MaterialRoundedDatePickerStyle(
//                               backgroundHeader: Colors.grey.shade300,
//                               // Appbar year like '2023' button
//                               textStyleYearButton: TextStyle(
//                                 fontSize: 30.sp,
//                                 color: Colors.blue,
//                                 fontWeight: FontWeight.bold,
//                                 backgroundColor: Colors.grey.shade100,
//                                 leadingDistribution:
//                                     TextLeadingDistribution.even,
//                               ),
//                               // Appbar day like 'Thu, Mar 16' button
//                               textStyleDayButton: TextStyle(
//                                 fontSize: 18.sp,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           );

//                           if (expDate != null) {
//                             if (expDate.isBefore(DateTime.now()) ||
//                                 expDate.isAtSameMomentAs(DateTime.now())) {
//                               SnakBarWidget.getSnackBarErrorBlue(
//                                 AppMetaLabels().error,
//                                 AppMetaLabels().selectFuturedate,
//                               );
//                             } else {
//                               DateFormat dateFormat = new DateFormat(
//                                   AppMetaLabels()
//                                       .dateFormatForShowRoundedDatePicker);
//                               setState(() {
//                                 expiryText = dateFormat.format(expDate);
//                                 controller.docsModel?.docs?[index].expiry =
//                                     dateFormat.format(expDate);

//                                 isExpiryError = false;
//                               });
//                             }
//                           }
//                         },
//                         child: Container(
//                           width: 90.0.w,
//                           height: 4.0.h,
//                           margin: EdgeInsets.only(
//                               top: 0.5.h, left: 2.0.w, right: 2.0.w),
//                           decoration: BoxDecoration(
//                             color: Color.fromRGBO(246, 248, 249, 1),
//                             borderRadius: BorderRadius.circular(1.0.h),
//                             border: Border.all(
//                               color: isExpiryError == true
//                                   ? AppColors.redColor
//                                   : AppColors.bordercolornew,
//                               width: 0.2.w,
//                             ),
//                           ),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             children: [
//                               Padding(
//                                 padding:
//                                     EdgeInsets.symmetric(horizontal: 1.0.h),
//                                 child: Text(
//                                   expiryText,
//                                   style: AppTextStyle.normalBlack10,
//                                 ),
//                               ),
//                               Spacer(),
//                               Padding(
//                                 padding:
//                                     EdgeInsets.symmetric(horizontal: 1.0.h),
//                                 child: ClearButton(
//                                   clear: () {
//                                     setState(() {
//                                       expiryText = '';
//                                       controller.docsModel?.docs?[index].expiry =
//                                           '';
//                                     });
//                                   },
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       // DOB
//                       Padding(
//                         padding: EdgeInsets.only(
//                             left: 2.0.w, top: 1.0.h, right: 4.0.w),
//                         child: Align(
//                             alignment: SessionController().getLanguage() == 1
//                                 ? Alignment.centerLeft
//                                 : Alignment.centerRight,
//                             child: Text(
//                               // 'Date Of Birth',
//                               AppMetaLabels().dateOFBirth,
//                               style: AppTextStyle.normalGrey10,
//                             )),
//                       ),
//                       SizedBox(
//                         height: 0.5.h,
//                       ),
//                       InkWell(
//                         onTap: () async {
//                           var expDate = await showRoundedDatePicker(
//                             height: 50.0.h,
//                             context: context,
//                                locale: SessionController().getLanguage() == 1
                                  // ? Locale('en', '')
                                  // : Locale('ar', ''),
//                             initialDate: DateTime.now(),
//                             firstDate: DateTime(DateTime.now().year - 100),
//                             lastDate: DateTime.now(),
//                             borderRadius: 2.0.h,
//                             // theme:
//                             //     ThemeData(primarySwatch: Colors.deepPurple),
//                             styleDatePicker: MaterialRoundedDatePickerStyle(
//                               backgroundHeader: Colors.grey.shade300,
//                               // Appbar year like '2023' button
//                               textStyleYearButton: TextStyle(
//                                 fontSize: 30.sp,
//                                 color: Colors.blue,
//                                 fontWeight: FontWeight.bold,
//                                 backgroundColor: Colors.grey.shade100,
//                                 leadingDistribution:
//                                     TextLeadingDistribution.even,
//                               ),
//                               // Appbar day like 'Thu, Mar 16' button
//                               textStyleDayButton: TextStyle(
//                                 fontSize: 18.sp,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           );

//                           if (expDate != null) {
//                             if (expDate.isAfter(DateTime.now()) ||
//                                 expDate.isAtSameMomentAs(DateTime.now())) {
//                               SnakBarWidget.getSnackBarErrorBlue(
//                                 AppMetaLabels().error,
//                                 AppMetaLabels().selectFuturedate,
//                               );
//                             } else {
//                               DateFormat dateFormat = new DateFormat(
//                                   AppMetaLabels()
//                                       .dateFormatForShowRoundedDatePicker);
//                               setState(() {
//                                 isDOBError = false;
//                                 dOBText = dateFormat.format(expDate);
//                               });
//                             }
//                           }
//                         },
//                         child: Container(
//                           width: 90.0.w,
//                           height: 4.0.h,
//                           margin: EdgeInsets.only(
//                               top: 0.5.h, left: 2.0.w, right: 2.0.w),
//                           decoration: BoxDecoration(
//                             color: Color.fromRGBO(246, 248, 249, 1),
//                             borderRadius: BorderRadius.circular(1.0.h),
//                             border: Border.all(
//                               color: isDOBError == true
//                                   ? AppColors.redColor
//                                   : AppColors.bordercolornew,
//                               width: 0.2.w,
//                             ),
//                           ),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             children: [
//                               Padding(
//                                 padding:
//                                     EdgeInsets.symmetric(horizontal: 1.0.h),
//                                 child: Text(
//                                   dOBText,
//                                   style: AppTextStyle.normalBlack10,
//                                 ),
//                               ),
//                               Spacer(),
//                               Padding(
//                                 padding:
//                                     EdgeInsets.symmetric(horizontal: 1.0.h),
//                                 child: ClearButton(
//                                   clear: () {
//                                     setState(() {
//                                       dOBText = '';
//                                     });
//                                   },
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 2.0.h,
//                       ),
//                       SizedBox(
//                         height: Get.height * 0.3,
//                         width: double.infinity,
//                         child: controller.mergedId != null
//                             ? Image.file(
//                                 controller.mergedId,
//                                 fit: BoxFit.contain,
//                               )
//                             : SizedBox(),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               actions: [
//                 TextButton(
//                     child: Text(AppMetaLabels().cancel),
//                     onPressed: () async {
//                       Navigator.of(context).pop();
//                       WidgetsBinding.instance.addPostFrameCallback((_) {
//                         setState(() {
//                           controller.docsModel?.docs?[index].loading.value =
//                               false;
//                           controller.cardScanModel = CardScanModel();
//                           controller.mergedId = null;
//                           controller.isLoadingForScanning.value = false;
//                           controller.isDocUploaded[index] = 'false';
//                         });
//                       });
//                       setState(() {
//                         nameText.clear();
//                         iDNumberText.clear();
//                         expiryText = '';
//                         dOBText = '';
//                       });
//                       await controller.removePickedFile(index);
//                       setState(() {});
//                     }),
//                 TextButton(
//                     child: Text(AppMetaLabels().confirm),
//                     onPressed: () async {
                     
//                       if (controller.comparingUint8List(
//                           controller.cardScanModel.frontImage,
//                           controller.cardScanModel.backImage)) {
//                         await showDialog(
//                             context: context,
//                             barrierDismissible: false,
//                             builder: (BuildContext context) {
//                               return AlertDialog(
//                                 contentPadding: EdgeInsets.zero,
//                                 backgroundColor: Colors.transparent,
//                                 content: showDialogForWrongScan(index),
//                               );
//                             });
//                         setState(() {});
//                       } else {
//                         WidgetsBinding.instance.addPostFrameCallback(
//                           (timeStamp) async {
//                             if (controller.docsModel?.docs?[index].isRejected) {
//                               setState(() {
//                                 isEnableScreen = false;
//                                 controller.isLoadingForScanning.value = true;
//                               });
//                               Navigator.of(context).pop();
//                               await controller.updateDoc(index);
//                               isEnableScreen = true;
//                             } else {
//                               if (nameText.text == '' ||
//                                   nameText.text == null) {
//                                 SnakBarWidget.getSnackBarErrorBlue(
//                                     AppMetaLabels().alert,
//                                     AppMetaLabels().pleaseEnterFullName);
//                                 setState(() {
//                                   isNameError = true;
//                                 });
//                                 return;
//                               } else if (!nameValidator
//                                   .hasMatch(nameText.text)) {
//                                 setState(() {
//                                   isNameError = true;
//                                 });
//                                 return;
//                               } else if (iDNumberText.text == '' ||
//                                   iDNumberText.text == null ||
//                                   iDNumberText.text.length < 18) {
//                                 SnakBarWidget.getSnackBarErrorBlue(
//                                     AppMetaLabels().alert,
//                                     AppMetaLabels().pleaseEnterCorrectID);
//                                 setState(() {
//                                   isIDError = true;
//                                 });
//                                 return;
//                               } else if (expiryText == '' ||
//                                   expiryText == null ||
//                                   expiryText.contains('.')) {
//                                 SnakBarWidget.getSnackBarErrorBlue(
//                                     AppMetaLabels().alert,
//                                     AppMetaLabels().pleaseSelectCorrectExpDate);
//                                 setState(() {
//                                   isExpiryError = true;
//                                 });
//                                 return;
//                               } else if (dOBText == '' ||
//                                   dOBText == null ||
//                                   dOBText.contains('.')) {
//                                 SnakBarWidget.getSnackBarErrorBlue(
//                                     AppMetaLabels().alert,
//                                     AppMetaLabels().pleaseSelectDOB);
//                                 setState(() {
//                                   isDOBError = true;
//                                 });
//                                 return;
//                               } else {
//                                 setState(() {
//                                   isEnableScreen = false;
//                                   controller.isLoadingForScanning.value = true;
//                                 });
//                                 Navigator.of(context).pop();
//                                 await controller.uploadDocWithEIDParameter(
//                                   index,
//                                   iDNumberText.text,
//                                   controller.cardScanModel.nationality,
//                                   nameText.text,
//                                   nameText.text,
//                                   '',
//                                   dOBText,
//                                 );
//                                 isEnableScreen = true;
//                               }
//                             }
//                           },
//                         );
//                       }
//                     }),
//               ],
//             );
//           },
//         );
//       },
//     );
//   }

//   Widget showDialogData() {
//     return Container(
//         padding: EdgeInsets.all(3.0.w),
//         // height: 45.0.h,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(2.0.h),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black12,
//               blurRadius: 0.5.h,
//               spreadRadius: 0.3.h,
//               offset: Offset(0.1.h, 0.1.h),
//             ),
//           ],
//         ),
//         child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               SizedBox(
//                 height: 4.0.h,
//               ),
//               Image.asset(
//                 AppImagesPath.bluttickimg,
//                 height: 9.0.h,
//                 fit: BoxFit.contain,
//               ),
//               SizedBox(
//                 height: 3.0.h,
//               ),
//               Text(
//                 AppMetaLabels().documentUploaded,
//                 textAlign: TextAlign.center,
//                 style: AppTextStyle.semiBoldBlack13,
//               ),
//               SizedBox(
//                 height: 3.0.h,
//               ),
//               Padding(
//                 padding: EdgeInsets.only(left: Get.width * 0.03),
//                 child: Text(
//                   AppMetaLabels().menaStage3,
//                   style: AppTextStyle.normalBlack10
//                       .copyWith(color: AppColors.renewelgreyclr1, height: 1.3),
//                   maxLines: 5,
//                   overflow: TextOverflow.ellipsis,
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               Padding(
//                   padding: EdgeInsets.only(top: 5.0.h, bottom: 2.0.h),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Align(
//                         alignment: Alignment.center,
//                         child: SizedBox(
//                           height: 4.8.h,
//                           width: 30.0.w,
//                           child: ElevatedButton(
//                             style: ButtonStyle(
//                                 elevation:
//                                     MaterialStateProperty.all<double>(0.0.h),
//                                 backgroundColor:
//                                     MaterialStateProperty.all<Color>(
//                                         AppColors.whiteColor),
//                                 shape: MaterialStateProperty.all<
//                                     RoundedRectangleBorder>(
//                                   RoundedRectangleBorder(
//                                       borderRadius:
//                                           BorderRadius.circular(2.0.w),
//                                       side: BorderSide(
//                                         color: AppColors.blueColor,
//                                         width: 1.0,
//                                       )),
//                                 )),
//                             onPressed: () {
//                               Get.back();
//                             },
//                             child: Text(
//                               AppMetaLabels().stayOnPage,
//                               textAlign: TextAlign.center,
//                               style: AppTextStyle.semiBoldWhite10
//                                   .copyWith(color: Colors.blue),
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       Align(
//                         alignment: Alignment.center,
//                         child: SizedBox(
//                           height: 5.0.h,
//                           width: 30.0.w,
//                           child: ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(1.3.h),
//                               ),
//                               backgroundColor: Color.fromRGBO(0, 61, 166, 1),
//                             ),
//                             onPressed: () {
//                               Get.back();
//                               Get.off(() => TenantDashboardTabs(
//                                     initialIndex: 0,
//                                   ));
//                             },
//                             child: Text(
//                               AppMetaLabels().goToDashoboard,
//                               textAlign: TextAlign.center,
//                               style: AppTextStyle.semiBoldWhite10,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   )),
//             ]));
//   }

//   Widget showDialogForWrongScan(int index) {
//     return Container(
//       padding: EdgeInsets.all(3.0.w),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(2.0.h),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black12,
//             blurRadius: 0.5.h,
//             spreadRadius: 0.3.h,
//             offset: Offset(0.1.h, 0.1.h),
//           ),
//         ],
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           SizedBox(
//             height: 4.0.h,
//           ),
//           Icon(
//             Icons.error,
//             size: 9.0.h,
//           ),
//           SizedBox(
//             height: 3.0.h,
//           ),
//           Text(
//             AppMetaLabels().cardScanningFailed,
//             textAlign: TextAlign.center,
//             style: AppTextStyle.semiBoldBlack13,
//           ),
//           SizedBox(
//             height: 3.0.h,
//           ),
//           Padding(
//             padding: EdgeInsets.only(left: Get.width * 0.03),
//             child: Text(
//               AppMetaLabels().pleaseScaneFrontSideOfEIDAgain,
//               style: AppTextStyle.normalBlack10
//                   .copyWith(color: AppColors.renewelgreyclr1, height: 1.3),
//               maxLines: 5,
//               overflow: TextOverflow.ellipsis,
//               textAlign: TextAlign.center,
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.only(top: 5.0.h, bottom: 2.0.h),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 SizedBox(
//                   width: 2.w,
//                 ),
//                 // Align(
//                 //   alignment: Alignment.center,
//                 //   child: SizedBox(
//                 //     height: 5.0.h,
//                 //     width: 30.0.w,
//                 //     child: ElevatedButton(
//                 //       style: ButtonStyle(
//                 //         shape:
//                 //             MaterialStateProperty.all<RoundedRectangleBorder>(
//                 //                 RoundedRectangleBorder(
//                 //                     borderRadius: BorderRadius.circular(3.0.w),
//                 //                     side: BorderSide(color: Colors.blue))),
//                 //         backgroundColor:
//                 //             MaterialStateProperty.all<Color>(Colors.white),
//                 //       ),
//                 //       onPressed: () {
//                 //         Get.back();
//                 //         Navigator.of(context).pop();
//                 //       },
//                 //       child: Text(
//                 //         AppMetaLabels().cancel,
//                 //         textAlign: TextAlign.center,
//                 //         style: AppTextStyle.semiBoldBlack10,
//                 //       ),
//                 //     ),
//                 //   ),
//                 // ),
//                 // SizedBox(
//                 //   width: 6.w,
//                 // ),
//                 Align(
//                   alignment: Alignment.center,
//                   child: SizedBox(
//                     height: 5.0.h,
//                     width: 30.0.w,
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(1.3.h),
//                         ),
//                         backgroundColor: Color.fromRGBO(0, 61, 166, 1),
//                       ),
//                       onPressed: () async {
//                         Get.back();
//                         Navigator.of(context).pop();
//                         controller.docsModel?.docs?[index].loading.value = false;
//                         controller.cardScanModel = CardScanModel();
//                         controller.mergedId = null;
//                         controller.isLoadingForScanning.value = false;
//                         await controller.removePickedFile(index);
//                         setState(() {
//                           nameText.clear();
//                           iDNumberText.clear();
//                           expiryText = '';
//                           dOBText = '';
//                         });
//                         setState(() {
//                           controller.isDocUploaded[index] = 'false';
//                         });
//                       },
//                       child: Text(
//                         AppMetaLabels().reScane,
//                         textAlign: TextAlign.center,
//                         style: AppTextStyle.semiBoldWhite10,
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   width: 2.w,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

// // show fron and back side of image
//   _showFrontBackImage(String source, BuildContext context, int index) {
//     showDialog(
//         context: context,
//         // barrierDismissible: false,
//         builder: (context) {
//           return AlertDialog(
//             title: Text(AppMetaLabels().emirateid),
//             content: Container(
//               height: Get.height * 0.6,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   SizedBox(
//                     height: Get.height * 0.02,
//                   ),
//                   SizedBox(
//                       child: Center(
//                           child: Text(AppMetaLabels().pleaseScaneFrontSideOfEID,
//                               textAlign: TextAlign.center,
//                               style: AppTextStyle.semiBoldBlack10))),
//                   SizedBox(
//                     height: Get.height * 0.05,
//                   ),
//                   SizedBox(
//                     height: Get.height * 0.15,
//                     width: double.infinity,
//                     child: Image.asset(
//                       // AppImagesPath.emiratesID,
//                       'assets/images/tenant_images/cropImage1.png',
//                       fit: BoxFit.fill,
//                     ),
//                   ),
//                   SizedBox(
//                     height: Get.height * 0.02,
//                   ),
//                   SizedBox(
//                     height: Get.height * 0.15,
//                     width: double.infinity,
//                     child: Image.asset(
//                       // AppImagesPath.emiratesID,
//                       'assets/images/tenant_images/cropImage2.png',
//                       fit: BoxFit.fill,
//                     ),
//                   ),
//                   SizedBox(
//                     height: Get.height * 0.05,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Spacer(),
//                       SizedBox(
//                         width: Get.width * 0.3,
//                         height: Get.height * 0.05,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             Navigator.of(context, rootNavigator: true)
//                                 .pop('dialog');
//                           },
//                           style: ButtonStyle(
//                             shape: MaterialStateProperty.all<
//                                     RoundedRectangleBorder>(
//                                 RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(3.0.w),
//                                     side: BorderSide(color: Colors.blue))),
//                             backgroundColor:
//                                 MaterialStateProperty.all<Color>(Colors.white),
//                           ),
//                           child: Text(
//                             AppMetaLabels().cancel,
//                             style: AppTextStyle.semiBoldBlue11
//                                 .copyWith(color: Colors.blue),
//                           ),
//                         ),
//                       ),
//                       Spacer(),
//                       SizedBox(
//                         width: Get.width * 0.3,
//                         height: Get.height * 0.05,
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(1.3.h),
//                               ),
//                               backgroundColor: Colors.blue),
//                           onPressed: () async {
//                             if (source == 'gallery') {
//                               Navigator.of(context, rootNavigator: true)
//                                   .pop('dialog');
//                               setState(() {
//                                 isEnableScreen = false;
//                                 controller.isLoadingForScanning.value = true;
//                                 controller.controllerTRDC.isEnableBackButton
//                                     .value = false;
//                               });
//                               // just clear the Session of ID Number
//                               //old
//                               // setState(() {
//                               //   SessionController().idNumber = null;
//                               // });
//                               setState(() {
//                                 SessionController().idNumber = null;
//                                 controller.isbothScane.value = false;
//                               });
//                               await controller.scanEmirateId(
//                                   ImageSource.gallery, index);
//                               setState(() {
//                                 isEnableScreen = true;
//                                 controller.isLoadingForScanning.value = false;
//                                 controller.controllerTRDC.isEnableBackButton
//                                     .value = true;
//                               });
//                             } else {
//                               Navigator.of(context, rootNavigator: true)
//                                   .pop('dialog');
//                               setState(() {
//                                 isEnableScreen = false;
//                                 controller.isLoadingForScanning.value = true;
//                                 controller.controllerTRDC.isEnableBackButton
//                                     .value = false;
//                               });
//                               // just clear the Session of ID Number
//                               // old
//                               // setState(() {
//                               //   SessionController().idNumber = null;
//                               // });
//                               setState(() {
//                                 SessionController().idNumber = null;
//                                 controller.isbothScane.value = false;
//                               });
//                               await controller.scanEmirateId(
//                                   ImageSource.camera, index);

//                               setState(() {
//                                 isEnableScreen = true;
//                                 controller.isLoadingForScanning.value = false;
//                                 controller.controllerTRDC.isEnableBackButton
//                                     .value = true;
//                               });
//                             }
//                           },
//                           child: Text(
//                             AppMetaLabels().scane,
//                             style: AppTextStyle.semiBoldWhite10,
//                           ),
//                         ),
//                       ),
//                       Spacer(),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           );
//         });
//   }
// }

// // with full validation
// // ignore_for_file: unused_local_variable
// import 'package:fap_properties/data/helpers/session_controller.dart';
// import 'package:fap_properties/data/models/tenant_models/card_model.dart';
// import 'package:fap_properties/utils/constants/assets_path.dart';
// import 'package:fap_properties/utils/constants/meta_labels.dart';
// import 'package:fap_properties/utils/screen_disable.dart';
// import 'package:fap_properties/utils/styles/colors.dart';
// import 'package:fap_properties/utils/styles/text_styles.dart';
// import 'package:fap_properties/utils/text_validator.dart';
// import 'package:fap_properties/views/tenant/tenant_dashboard/tenant_dashboard_tabs/tenant_dashboard_tabs.dart';
// import 'package:fap_properties/views/widgets/common_widgets/error_text_widget.dart';
// import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
// import 'package:fap_properties/views/tenant/tenant_services_request/tenant_request_details/tenant_service_request_tab/svc_req_docs_controller.dart';
// import 'package:fap_properties/views/widgets/bottom_shadow.dart';
// import 'package:fap_properties/views/widgets/clear_button.dart';
// import 'package:fap_properties/views/widgets/file_view.dart';
// import 'package:fap_properties/views/widgets/snackbar_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
// import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:sizer/sizer.dart';
// import 'package:get/get.dart';
// import 'package:flutter/gestures.dart';
// import 'dart:ui' as ui;

// class TenantServiceDocuments extends StatefulWidget {
//   final String caseNo;
//   final String caller;
//   TenantServiceDocuments({Key key, this.caseNo, this.caller})
//       : super(key: key) {
//     Get.put(SvcReqDocsController(caseNo: caseNo));
//   }

//   @override
//   _TenantServiceDocumentsState createState() => _TenantServiceDocumentsState();
// }

// class _TenantServiceDocumentsState extends State<TenantServiceDocuments> {
//   final controller = Get.find<SvcReqDocsController>();

//   // TextEditingController will use in the EID confirmation
//   TextEditingController nameText = TextEditingController();
//   TextEditingController iDNumberText = TextEditingController();
//   var maskFormatter = MaskedInputFormatter(
//     '###-####-#######-#',
//     allowedCharMatcher: RegExp(r'[0-9]'),
//   );

//   String dOBText = '';
//   String expiryText = '';
//   bool isNameError = false;
//   bool isIDError = false;
//   bool isDOBError = false;
//   bool isExpiryError = false;

//   bool _isSolving = false;
//   bool isEnableScreen = true;
//   @override
//   void initState() {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       // controller.getFiles();
//       getInformation();
//     });
//     super.initState();
//   }

//   getInformation() async {
//     setState(() {
//       _isSolving = true;
//     });
//     await controller.getFiles();
//     setState(() {});
//     setState(() {});
//     setState(() {
//       _isSolving = false;
//     });
//   }

//   bool highLightExpiry = false;

//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () => Future.value(false),
//       child: Scaffold(
//           key: _scaffoldKey,
//           resizeToAvoidBottomInset: false,
//           backgroundColor: Colors.white,
//           body: _isSolving == true
//               ? Center(child: LoadingIndicatorBlue())
//               : Stack(
//                   children: [
//                     controller.loadingDocs.value
//                         ? Center(child: LoadingIndicatorBlue())
//                         : Column(
//                             children: [
//                               Expanded(
//                                 child: Obx(() {
//                                   return controller.loadingDocs.value
//                                       ? Center(child: LoadingIndicatorBlue())
//                                       : controller.errorLoadingDocs != ''
//                                           ? AppErrorWidget(
//                                               errorText:
//                                                   controller.errorLoadingDocs,
//                                             )
//                                           : controller.docsModel??.docs? == null
//                                               ? SizedBox()
//                                               : Container(
//                                                   child: ListView.builder(
//                                                       padding: EdgeInsets.zero,
//                                                       itemCount: controller
//                                                               .docsModel?
//                                                               .docs?
//                                                               .length +
//                                                           1,
//                                                       itemBuilder:
//                                                           (context, index) {
//                                                         if (controller.docsModel?
//                                                                 .docs?.length ==
//                                                             index) {
//                                                           return Center(
//                                                               child: Obx(() {
//                                                             return controller
//                                                                         .docsModel?
//                                                                         .caseStageInfo?!
//                                                                         .stageId
//                                                                         .value <
//                                                                     3
//                                                                 ? Column(
//                                                                     children: [
//                                                                       Padding(
//                                                                         padding: EdgeInsets.symmetric(
//                                                                             horizontal:
//                                                                                 4.w,
//                                                                             vertical: 2.h),
//                                                                         child:
//                                                                             Text(
//                                                                           AppMetaLabels()
//                                                                               .allMandatory,
//                                                                           style:
//                                                                               AppTextStyle.normalBlack10,
//                                                                         ),
//                                                                       ),
//                                                                     ],
//                                                                   )
//                                                                 : controller.docsModel?.responseMessageAR ==
//                                                                             '' &&
//                                                                         SessionController().getLanguage() !=
//                                                                             1
//                                                                     ? SizedBox()
//                                                                     : controller.docsModel?.caseStageInfo?!.stageId.value ==
//                                                                             4
//                                                                         ? Container(
//                                                                             alignment:
//                                                                                 Alignment.center,
//                                                                             padding:
//                                                                                 EdgeInsets.all(8.0),
//                                                                             margin:
//                                                                                 EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
//                                                                             decoration:
//                                                                                 BoxDecoration(color: Color.fromRGBO(255, 249, 235, 1), borderRadius: BorderRadius.circular(8)),
//                                                                             child:
//                                                                                 Row(
//                                                                               crossAxisAlignment: CrossAxisAlignment.center,
//                                                                               children: [
//                                                                                 Icon(
//                                                                                   Icons.error_outline,
//                                                                                   color: Colors.amber[400],
//                                                                                 ),
//                                                                                 SizedBox(
//                                                                                   width: 8.0,
//                                                                                 ),
//                                                                                 Expanded(
//                                                                                   child: Text(
//                                                                                     SessionController().getLanguage() == 1 ? controller.docsModel?.responseMessage ?? '' : controller.docsModel?.responseMessageAR ?? "",
//                                                                                     style: AppTextStyle.normalBlack12,
//                                                                                   ),
//                                                                                 ),
//                                                                               ],
//                                                                             ),
//                                                                           )
//                                                                         : SizedBox();
//                                                           }));
//                                                         }
//                                                         return Padding(
//                                                             padding:
//                                                                 EdgeInsets.all(
//                                                                     2.0.h),
//                                                             child: Column(
//                                                                 crossAxisAlignment:
//                                                                     CrossAxisAlignment
//                                                                         .start,
//                                                                 children: [
//                                                                   Padding(
//                                                                     padding: EdgeInsets.only(
//                                                                         left: 4.0
//                                                                             .w,
//                                                                         bottom: 2.0
//                                                                             .h,
//                                                                         right: 4.0
//                                                                             .w),
//                                                                     child: Text(
//                                                                       SessionController().getLanguage() ==
//                                                                               1
//                                                                           ? controller.docsModel?.docs?[index].name ??
//                                                                               ""
//                                                                           : controller.docsModel?.docs?[index].nameAr ??
//                                                                               '',
//                                                                       style: AppTextStyle
//                                                                           .semiBoldBlack12,
//                                                                     ),
//                                                                   ),
//                                                                   controller.docsModel?.docs?[index].id ==
//                                                                               null ||
//                                                                           controller
//                                                                               .docsModel?
//                                                                               .docs?[
//                                                                                   index]
//                                                                               .isRejected
//                                                                       ? uploadFile(
//                                                                           context,
//                                                                           index)
//                                                                       : Container(
//                                                                           width:
//                                                                               100.0.w,
//                                                                           padding: EdgeInsets.symmetric(
//                                                                               vertical: 1.h,
//                                                                               horizontal: 4.w),
//                                                                           decoration:
//                                                                               BoxDecoration(
//                                                                             color:
//                                                                                 Colors.white,
//                                                                             borderRadius:
//                                                                                 BorderRadius.circular(2.0.h),
//                                                                             boxShadow: [
//                                                                               BoxShadow(
//                                                                                 color: Colors.black12,
//                                                                                 blurRadius: 0.5.h,
//                                                                                 spreadRadius: 0.1.h,
//                                                                                 offset: Offset(0.1.h, 0.1.h),
//                                                                               ),
//                                                                             ],
//                                                                           ),
//                                                                           child:
//                                                                               Obx(() {
//                                                                             return FileView(
//                                                                               file: controller.docsModel?.docs?[index],
//                                                                               onDelete: controller.docsModel?.docs?[index].loading.value == true
//                                                                                   ? () {}
//                                                                                   : () async {
//                                                                                       if (controller.docsModel?.docs?[index].name.toLowerCase() == 'emirate id') {
//                                                                                         setState(() {
//                                                                                           isEnableScreen = false;
//                                                                                         });
//                                                                                         setState(() {
//                                                                                           controller.mergedId = null;
//                                                                                           controller.cardScanModel = CardScanModel();
//                                                                                         });
//                                                                                         await controller.removePickedFile(index);
//                                                                                         await controller.removeFile(index);
//                                                                                         setState(() {
//                                                                                           controller.isDocUploaded[index] = 'false';
//                                                                                         });
//                                                                                         setState(() {
//                                                                                           isEnableScreen = true;
//                                                                                         });
//                                                                                         return;
//                                                                                       }
//                                                                                       setState(() {
//                                                                                         isEnableScreen = false;
//                                                                                       });
//                                                                                       await controller.removeFile(index);
//                                                                                       setState(() {
//                                                                                         isEnableScreen = true;
//                                                                                       });
//                                                                                     },
//                                                                               onPressed: () {
//                                                                                 controller.downloadDoc(index);
//                                                                               },
//                                                                               canDelete: controller.docsModel?.caseStageInfo?!.stageId.value < 3,
//                                                                             );
//                                                                           }),
//                                                                         )
//                                                                 ]));
//                                                       }),
//                                                 );
//                                 }),
//                               ),
//                               controller.docsModel??.docs? == null
//                                   ? SizedBox()
//                                   : SingleChildScrollView(
//                                       child: Obx(() {
//                                         return controller
//                                                     .docsModel?.caseStageInfo?! ==
//                                                 null
//                                             ? SizedBox()
//                                             : controller.loadingDocs.value
//                                                 ? SizedBox()
//                                                 : controller
//                                                             .docsModel?
//                                                             .caseStageInfo?!
//                                                             .stageId
//                                                             .value >=
//                                                         3
//                                                     ? SizedBox()
//                                                     : Align(
//                                                         alignment: Alignment
//                                                             .bottomCenter,
//                                                         child: Container(
//                                                           width: 100.0.w,
//                                                           height: 9.0.h,
//                                                           decoration:
//                                                               BoxDecoration(
//                                                             color: Colors.white,
//                                                             boxShadow: [
//                                                               BoxShadow(
//                                                                 color: Colors
//                                                                     .black12,
//                                                                 blurRadius:
//                                                                     0.5.h,
//                                                                 spreadRadius:
//                                                                     0.5.h,
//                                                                 offset: Offset(
//                                                                     0.1.h,
//                                                                     0.1.h),
//                                                               ),
//                                                             ],
//                                                           ),
//                                                           child: Padding(
//                                                             padding:
//                                                                 EdgeInsets.all(
//                                                                     2.0.h),
//                                                             child: controller
//                                                                     .updatingDocStage
//                                                                     .value
//                                                                 ? LoadingIndicatorBlue()
//                                                                 : ElevatedButton(
//                                                                     onPressed: !controller
//                                                                             .enableSubmit
//                                                                             .value
//                                                                         ? null
//                                                                         : () async {
//                                                                             setState(() {
//                                                                               isEnableScreen = false;
//                                                                             });
//                                                                             await controller.updateDocStage(widget.caller);
//                                                                             setState(() {
//                                                                               isEnableScreen = true;
//                                                                             });
//                                                                             if (controller.docsModel?.caseStageInfo?!.stageId.value >=
//                                                                                 3) {
//                                                                               showDialog(
//                                                                                   context: context,
//                                                                                   barrierDismissible: false,
//                                                                                   builder: (BuildContext context) {
//                                                                                     return AlertDialog(
//                                                                                       contentPadding: EdgeInsets.zero,
//                                                                                       backgroundColor: Colors.transparent,
//                                                                                       content: showDialogData(),
//                                                                                     );
//                                                                                   });
//                                                                             }
//                                                                           },
//                                                                     child:
//                                                                         SizedBox(
//                                                                       width:
//                                                                           40.w,
//                                                                       child:
//                                                                           Center(
//                                                                         child:
//                                                                             Text(
//                                                                           AppMetaLabels()
//                                                                               .submit,
//                                                                           style:
//                                                                               AppTextStyle.semiBoldWhite12,
//                                                                         ),
//                                                                       ),
//                                                                     ),
//                                                                     style: ElevatedButton
//                                                                         .styleFrom(
//                                                                       shape:
//                                                                           RoundedRectangleBorder(
//                                                                         borderRadius:
//                                                                             BorderRadius.circular(1.3.h),
//                                                                       ),
//                                                                       backgroundColor: controller
//                                                                               .enableSubmit
//                                                                               .value
//                                                                           ? Color.fromRGBO(
//                                                                               0,
//                                                                               61,
//                                                                               166,
//                                                                               1)
//                                                                           : Colors
//                                                                               .grey
//                                                                               .shade400,
//                                                                     ),
//                                                                   ),
//                                                           ),
//                                                         ),
//                                                       );
//                                       }),
//                                     ),
//                             ],
//                           ),
//                     isEnableScreen == false
//                         ? ScreenDisableWidget()
//                         : SizedBox(),
//                     Obx(() {
//                       return controller.isLoadingForScanning.value == true
//                           ? Container(
//                               height: double.infinity,
//                               width: double.infinity,
//                               color: Colors.black.withOpacity(0.3),
//                               child: Center(
//                                   child: CircularProgressIndicator(
//                                 backgroundColor: Colors.white,
//                                 color: Colors.blue,
//                               )),
//                             )
//                           : SizedBox();
//                     }),
//                     BottomShadow(),
//                   ],
//                 )),
//     );
//   }

//   Container uploadFile(BuildContext context, int index) {
//     print('Index :::::: $index');
//     return Container(
//         width: 100.0.w,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(2.0.h),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black12,
//               blurRadius: 0.5.h,
//               spreadRadius: 0.1.h,
//               offset: Offset(0.1.h, 0.1.h),
//             ),
//           ],
//         ),
//         child: Padding(
//             padding: EdgeInsets.only(left: 4.0.w, bottom: 3.5.h, right: 4.0.w),
//             child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   if (controller.docsModel?.docs?[index].isRejected)
//                     RichText(
//                       text: TextSpan(
//                           text: '${AppMetaLabels().your} ',
//                           style: AppTextStyle.normalErrorText3,
//                           children: <TextSpan>[
//                             TextSpan(
//                                 text: controller.docsModel?.docs?[index].name,
//                                 style: AppTextStyle.normalBlue10,
//                                 recognizer: TapGestureRecognizer()
//                                   ..onTap = () {
//                                     if (!controller
//                                         .docsModel?.docs?[index].loading.value) {
//                                       setState(() {
//                                         isEnableScreen = false;
//                                       });
//                                       controller.downloadDocRejected(index);
//                                       // controller.downloadDoc(index);
//                                       setState(() {
//                                         isEnableScreen = true;
//                                       });
//                                     }
//                                   }),
//                             TextSpan(
//                                 text: ' ${AppMetaLabels().fileRejected}',
//                                 style: AppTextStyle.normalErrorText3)
//                           ]),
//                     ),
//                   SizedBox(
//                     height: 8,
//                   ),
//                   Obx(() {
//                     if (controller.docsModel?.docs?[index].update.value) {}
//                     return controller.docsModel?.docs?[index].path != null
//                         ? FileView(
//                             file: controller.docsModel?.docs?[index],
//                             onPressed: () {
//                               controller
//                                   .showFile(controller.docsModel?.docs?[index]);
//                             },
//                             onDelete: controller
//                                         .docsModel?.docs?[index].loading.value ==
//                                     true
//                                 ? () {}
//                                 : () async {
//                                     setState(() {
//                                       isEnableScreen = false;
//                                     });
//                                     await controller.removePickedFile(index);
//                                     setState(() {
//                                       controller.isDocUploaded[index] = 'false';
//                                       controller.docsModel?.docs?[index]
//                                           .errorLoading = false;
//                                     });
//                                     setState(() {
//                                       highLightExpiry = false;
//                                       if (controller
//                                               .selectedIndexForUploadedDocument ==
//                                           index) {
//                                         controller
//                                             .selectedIndexForUploadedDocument = -1;
//                                       }
//                                     });
//                                     setState(() {
//                                       isEnableScreen = true;
//                                     });
//                                   },
//                             canDelete: true,
//                           )
//                         : InkWell(
//                             onTap: () async {
//                               bool isTrue;
//                               print(controller.isDocUploaded);
//                               for (int i = 0;
//                                   i < controller.isDocUploaded.length;
//                                   i++) {
//                                 print(controller.isDocUploaded[i] == 'true');
//                                 if (controller.isDocUploaded[i] == 'true') {
//                                   setState(() {
//                                     isTrue = true;
//                                   });
//                                 }
//                               }
//                               if (isTrue == true) {
//                                 SnakBarWidget.getSnackBarErrorBlue(
//                                     AppMetaLabels().alert,
//                                     AppMetaLabels().uploadAttachedDocFirst);
//                                 return;
//                               }
//                               if (controller.docsModel?.docs?[index].name
//                                       .toLowerCase() ==
//                                   'emirate id') {
//                                 _showPicker(context, index);
//                               } else {
//                                 await _showPickerPassport(context, index);
//                                 setState(() {
//                                   highLightExpiry =
//                                       controller.docsModel?.docs?[index].path !=
//                                               null
//                                           ? true
//                                           : false;
//                                 });
//                               }
//                             },
//                             child: Container(
//                               // color: Colors.red,
//                               padding: EdgeInsets.only(
//                                 left: 4.0.w,
//                                 right: 4.0.w,
//                                 top: 3.5.h,
//                               ),
//                               width: double.infinity,
//                               decoration: BoxDecoration(
//                                 color: Color.fromRGBO(246, 248, 249, 1),
//                                 borderRadius: BorderRadius.circular(0.5.h),
//                               ),
//                               child: Column(
//                                 children: [
//                                   Center(
//                                     child: IconButton(
//                                       onPressed: () async {
//                                         bool isTrue;
//                                         print(controller.isDocUploaded);
//                                         for (int i = 0;
//                                             i < controller.isDocUploaded.length;
//                                             i++) {
//                                           print(controller.isDocUploaded[i] ==
//                                               'true');
//                                           if (controller.isDocUploaded[i] ==
//                                               'true') {
//                                             setState(() {
//                                               isTrue = true;
//                                             });
//                                           }
//                                         }
//                                         if (isTrue == true) {
//                                           SnakBarWidget.getSnackBarErrorBlue(
//                                               AppMetaLabels().alert,
//                                               AppMetaLabels()
//                                                   .uploadAttachedDocFirst);
//                                           return;
//                                         }
//                                         if (controller
//                                                 .docsModel?.docs?[index].name
//                                                 .toLowerCase() ==
//                                             'emirate id') {
//                                           _showPicker(context, index);
//                                         } else {
//                                           await _showPickerPassport(
//                                               context, index);
//                                           setState(() {
//                                             highLightExpiry = controller
//                                                         .docsModel?
//                                                         .docs?[index]
//                                                         .path !=
//                                                     null
//                                                 ? true
//                                                 : false;
//                                           });
//                                         }
//                                       },
//                                       icon: Image.asset(
//                                         AppImagesPath.downloadimg,
//                                         width: 4.5.h,
//                                         height: 4.5.h,
//                                         fit: BoxFit.contain,
//                                       ),
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     height: 1.5.h,
//                                   ),
//                                   Text(
//                                     AppMetaLabels().uploadYourDoc,
//                                     style: AppTextStyle.semiBoldBlack10,
//                                   ),
//                                   SizedBox(
//                                     height: 1.5.h,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           );
//                   }),
//                   // SizedBox(
//                   //   height: 2.5.h,
//                   // ),
//                   // Text(
//                   //   AppMetaLabels().uploadYourDoc,
//                   //   style: AppTextStyle.semiBoldBlack10,
//                   // ),
//                   SizedBox(
//                     height: 1.5.h,
//                   ),
//                   Text(
//                     controller.docsModel?.docs?[index].name == 'Emirate ID'
//                         ? AppMetaLabels().filedetailsEID
//                         : AppMetaLabels().filedetails,
//                     style: AppTextStyle.normalGrey9,
//                   ),
//                   SizedBox(
//                     height: 3.h,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         '${AppMetaLabels().expDate} *',
//                         style: AppTextStyle.semiBoldBlack10,
//                       ),
//                       InkWell(
//                         onTap: () async {
//                           bool isTrue;
//                           print(controller.isDocUploaded);
//                           for (int i = 0;
//                               i < controller.isDocUploaded.length;
//                               i++) {
//                             print(controller.isDocUploaded[i] == 'true');
//                             if (controller.isDocUploaded[i] == 'true') {
//                               setState(() {
//                                 isTrue = true;
//                               });
//                             }
//                           }

//                           var expDate;
//                           if (controller.docsModel?.docs?[index].path != null) {
//                             print('Tapping :::::: ');
//                             expDate = await showRoundedDatePicker(
//                               height: 50.0.h,
//                               context: context,
//                                   locale: SessionController().getLanguage() == 1
                                  // ? Locale('en', '')
                                  // : Locale('ar', ''),
//                               initialDate: DateTime.now(),
//                               firstDate:
//                                   DateTime.now().subtract(Duration(seconds: 1)),
//                               lastDate: DateTime(DateTime.now().year + 20),
//                               borderRadius: 2.0.h,
//                               // theme:
//                               //     ThemeData(primarySwatch: Colors.deepPurple),
//                               styleDatePicker: MaterialRoundedDatePickerStyle(
//                                 backgroundHeader: Colors.grey.shade300,
//                                 // Appbar year like '2023' button
//                                 textStyleYearButton: TextStyle(
//                                   fontSize: 30.sp,
//                                   color: Colors.blue,
//                                   fontWeight: FontWeight.bold,
//                                   backgroundColor: Colors.grey.shade100,
//                                   leadingDistribution:
//                                       TextLeadingDistribution.even,
//                                 ),
//                                 // Appbar day like 'Thu, Mar 16' button
//                                 textStyleDayButton: TextStyle(
//                                   fontSize: 18.sp,
//                                   color: Colors.white,
//                                 ),

//                                 // Heading year like 'S M T W TH FR SA ' button
//                                 // textStyleDayHeader: TextStyle(
//                                 //   fontSize: 30.sp,
//                                 //   color: Colors.white,
//                                 //   backgroundColor: Colors.red,
//                                 //   decoration: TextDecoration.overline,
//                                 //   decorationColor: Colors.pink,
//                                 // ),
//                               ),
//                             );
//                           } else {
//                             if (controller.isDocUploaded.contains('true')) {
//                               SnakBarWidget.getSnackBarErrorBlue(
//                                   AppMetaLabels().alert,
//                                   AppMetaLabels().uploadAttachedDocFirst);
//                             } else {
//                               SnakBarWidget.getSnackBarErrorBlue(
//                                   AppMetaLabels().alert,
//                                   AppMetaLabels().pleaseSelectFileFirst);
//                             }
//                           }

//                           if (expDate != null) {
//                             if (expDate.isBefore(DateTime.now()) ||
//                                 expDate.isAtSameMomentAs(DateTime.now())) {
//                               SnakBarWidget.getSnackBarErrorBlue(
//                                 AppMetaLabels().error,
//                                 AppMetaLabels().selectFuturedate,
//                               );
//                             } else {
//                               DateFormat dateFormat = new DateFormat(
//                                   AppMetaLabels()
//                                       .dateFormatForShowRoundedDatePicker);
//                               if (controller.docsModel?.docs?[index].name
//                                       .toLowerCase() ==
//                                   'emirate id') {
//                                 if (controller.cardScanModel.expiry != null) {
//                                   setState(() {
//                                     controller.cardScanModel.expiry = null;
//                                   });
//                                 }
//                               }
//                               await controller.setExpDate(
//                                   index, dateFormat.format(expDate));
//                               setState(() {
//                                 highLightExpiry = false;
//                               });
//                               setState(() {
//                                 if (controller
//                                         .selectedIndexForUploadedDocument ==
//                                     index) {
//                                   controller.selectedIndexForUploadedDocument =
//                                       -1;
//                                 }
//                               });
//                             }
//                           }
//                         },
//                         child: Container(
//                           width: 40.0.w,
//                           height: 5.5.h,
//                           decoration: BoxDecoration(
//                               color: Color.fromRGBO(246, 248, 249, 1),
//                               borderRadius: BorderRadius.circular(1.0.h),
//                               border: Border.all(
//                                   color: index ==
//                                           controller
//                                               .selectedIndexForUploadedDocument
//                                       ? Colors.red
//                                       : Colors.transparent)),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             children: [
//                               Padding(
//                                 padding:
//                                     EdgeInsets.symmetric(horizontal: 1.0.h),
//                                 child: Obx(() {
//                                   if (controller
//                                       .docsModel?.docs?[index].update.value) {}
//                                   return Text(
//                                     controller.docsModel?.docs?[index].expiry ??
//                                         '',
//                                     style: AppTextStyle.normalBlack12,
//                                   );
//                                 }),
//                               ),
//                               Spacer(),
//                               Padding(
//                                 padding:
//                                     EdgeInsets.symmetric(horizontal: 1.0.h),
//                                 child: ClearButton(
//                                   clear: () {
//                                     controller.clearExpDate(index);
//                                     if (controller.cardScanModel.expiry !=
//                                         null) {
//                                       setState(() {
//                                         controller.cardScanModel.expiry = null;
//                                       });
//                                     }
//                                   },
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   controller.selectedIndexForUploadedDocument == index
//                       ? SizedBox(
//                           height: 20,
//                           child: Center(
//                               child: Text(
//                             AppMetaLabels().pleaseSelectExpiryDate,
//                             style: TextStyle(color: Colors.blue),
//                           )))
//                       : SizedBox(
//                           height: 10,
//                         ),
//                   Container(
//                       margin: EdgeInsets.only(top: 3.h),
//                       width: 50.w,
//                       height: 5.h,
//                       child: Obx(() {
//                         return controller.docsModel?.docs?[index].loading.value
//                             ? LoadingIndicatorBlue(
//                                 size: 3.h,
//                               )
//                             : controller.docsModel?.docs?[index].errorLoading
//                                 ? IconButton(
//                                     onPressed: () async {
//                                       // here also add refresh func for visa and passport

//                                       if (controller.docsModel?.docs?[index].name
//                                               .toLowerCase() !=
//                                           'emirate id') {
//                                         setState(() {
//                                           isEnableScreen = false;
//                                         });
//                                         if (controller
//                                             .docsModel?.docs?[index].isRejected) {
//                                           setState(() {
//                                             isEnableScreen = false;
//                                           });
//                                           await controller.updateDoc(index);
//                                           setState(() {
//                                             isEnableScreen = true;
//                                           });
//                                         } else {
//                                           setState(() {
//                                             isEnableScreen = false;
//                                           });
//                                           await controller.uploadDoc(index);
//                                           setState(() {
//                                             isEnableScreen = true;
//                                           });
//                                         }
//                                         setState(() {
//                                           isEnableScreen = true;
//                                         });
//                                         return;
//                                       }

//                                       setState(() {
//                                         isEnableScreen = false;
//                                         controller.isLoadingForScanning.value =
//                                             true;
//                                       });
//                                       if (controller
//                                           .docsModel?.docs?[index].isRejected) {
//                                         await controller.updateDoc(index);
//                                         setState(() {
//                                           isEnableScreen = false;
//                                         });
//                                       } else {
//                                         var dOB;
//                                         var exp;
//                                         if (controller.cardScanModel.dob !=
//                                             null) {
//                                           dOB =
//                                               '${DateFormat('dd-MM-yyyy').format(controller.cardScanModel.dob)}';
//                                         }
//                                         if (controller.cardScanModel.expiry !=
//                                             null) {
//                                           exp =
//                                               '${DateFormat('dd-MM-yyyy').format(controller.cardScanModel.expiry)}';
//                                         }
//                                         await controller
//                                             .uploadDocWithEIDParameter(
//                                           index,
//                                           controller.cardScanModel.idNumber,
//                                           controller.cardScanModel.nationality,
//                                           controller.cardScanModel.name,
//                                           controller.cardScanModel.name,
//                                           '',
//                                           // controller.cardScanModel.dob,
//                                           dOB,
//                                         );
//                                         setState(() {
//                                           isEnableScreen = true;
//                                           controller.isLoadingForScanning
//                                               .value = false;
//                                         });
//                                       }
//                                       setState(() {
//                                         isEnableScreen = true;
//                                         controller.isLoadingForScanning.value =
//                                             false;
//                                       });
//                                     },
//                                     icon: Icon(
//                                       Icons.refresh,
//                                       size: 4.5.h,
//                                       color: Colors.red,
//                                     ),
//                                   )
//                                 : Obx(() {
//                                     if (controller
//                                         .docsModel?.docs?[index].update.value) {}
//                                     return ElevatedButton(
//                                       onPressed: controller.docsModel?
//                                                       .docs?[index].expiry ==
//                                                   null ||
//                                               controller.docsModel?.docs?[index]
//                                                       .path ==
//                                                   null
//                                           ? null
//                                           : () async {
//                                               setState(() {
//                                                 isEnableScreen = false;
//                                               });
//                                               if (controller.mergedId != null) {
//                                                 WidgetsBinding.instance
//                                                     .addPostFrameCallback(
//                                                   (timeStamp) async {
//                                                     // _showConfirmationDialog(
//                                                     //     index, context);
//                                                     await _showConfirmationDialog(
//                                                         index, context);
//                                                     setState(() {
//                                                       controller
//                                                           .isLoadingForScanning
//                                                           .value = false;
//                                                       isEnableScreen = true;
//                                                     });
//                                                     setState(() {});
//                                                     print(
//                                                         'ISEnable Screen Val :::::: $isEnableScreen');
//                                                   },
//                                                 );
//                                               }
//                                               if (controller.docsModel?
//                                                       .docs?[index].name
//                                                       .toLowerCase() !=
//                                                   'emirate id') {
//                                                 if (controller.docsModel?
//                                                     .docs?[index].isRejected) {
//                                                   setState(() {
//                                                     isEnableScreen = false;
//                                                     controller
//                                                         .isLoadingForScanning
//                                                         .value = true;
//                                                   });
//                                                   print(
//                                                       ':::::::::::::: $isEnableScreen');
//                                                   print(
//                                                       ':::::::::::::: ${controller.isLoadingForScanning.value}');
//                                                   controller.updateDoc(index);
//                                                   setState(() {
//                                                     isEnableScreen = true;
//                                                     controller
//                                                         .isLoadingForScanning
//                                                         .value = false;
//                                                   });
//                                                 } else {
//                                                   await controller
//                                                       .uploadDoc(index);
//                                                 }
//                                               }
//                                               setState(() {
//                                                 isEnableScreen = true;
//                                               });
//                                             },
//                                       child: Text(
//                                         AppMetaLabels().upload,
//                                         style: AppTextStyle.semiBoldWhite12,
//                                       ),
//                                       style: ElevatedButton.styleFrom(
//                                         shape: RoundedRectangleBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(1.3.h),
//                                         ),
//                                         backgroundColor:
//                                             Color.fromRGBO(0, 61, 166, 1),
//                                       ),
//                                     );
//                                   });
//                       }))
//                 ])));
//   }

// // upload passport and other pic from here
//   _showPickerPassport(context, int index) {
//     showModalBottomSheet(
//         context: context,
//         builder: (BuildContext bc) {
//           return SafeArea(
//             child: Container(
//               color: Colors.white,
//               child: new Wrap(
//                 children: <Widget>[
//                   new ListTile(
//                       leading: new Icon(Icons.storage),
//                       title: new Text(AppMetaLabels().storage),
//                       onTap: () async {
//                         await controller.pickDoc(index);
//                         setState(() {});
//                         Navigator.of(context).pop();
//                       }),
//                   new ListTile(
//                     leading: new Icon(Icons.photo_camera),
//                     title: new Text(AppMetaLabels().camera),
//                     onTap: () async {
//                       await controller.takePhoto(index);
//                       setState(() {});
//                       Navigator.of(context).pop();
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           );
//         });
//   }

// // upload emirate pic from here
//   void _showPicker(context, int index) {
//     showModalBottomSheet(
//         context: context,
//         builder: (BuildContext bc) {
//           return Directionality(
//               textDirection: SessionController().getLanguage() == 1
//                   ? ui.TextDirection.ltr
//                   : ui.TextDirection.rtl,
//               child: SafeArea(
//                   child: Container(
//                 color: Colors.white,
//                 child: new Wrap(
//                   children: <Widget>[
//                     new ListTile(
//                       leading: new Icon(Icons.photo_library),
//                       title: new Text(AppMetaLabels().photoLibrary),
//                       onTap: () async {
//                         Navigator.of(context).pop();
//                         setState(() {
//                           controller.mergedId = null;
//                           controller.cardScanModel = CardScanModel();
//                         });
//                         await _showFrontBackImage('gallery', context, index);

//                         // old
//                         if (controller.mergedId != null) {
//                           WidgetsBinding.instance.addPostFrameCallback(
//                             (timeStamp) async {
//                               setState(() {
//                                 controller.isDocUploaded[index] = 'true';
//                               });
//                               // _showConfirmationDialog(index, context);
//                               await _showConfirmationDialog(index, context);
//                               setState(() {
//                                 controller.isLoadingForScanning.value = false;
//                                 isEnableScreen = true;
//                               });
//                               setState(() {});
//                               print(
//                                   'ISEnable Screen Val :::::: $isEnableScreen');
//                             },
//                           );
//                         }
//                       },
//                     ),
//                     new ListTile(
//                       leading: new Icon(Icons.photo_camera),
//                       title: new Text(AppMetaLabels().camera),
//                       onTap: () async {
//                         Navigator.of(context).pop();
//                         setState(() {
//                           controller.mergedId = null;
//                           controller.cardScanModel = CardScanModel();
//                         });
//                         await _showFrontBackImage('camera', context, index);

//                         if (controller.mergedId != null) {
//                           WidgetsBinding.instance.addPostFrameCallback(
//                             (timeStamp) async {
//                               setState(() {
//                                 controller.isDocUploaded[index] = 'true';
//                               });
//                               await _showConfirmationDialog(index, context);
//                               setState(() {
//                                 controller.isLoadingForScanning.value = false;
//                                 isEnableScreen = true;
//                               });
//                               setState(() {});
//                               print(
//                                   'ISEnable Screen Val :::::: $isEnableScreen');
//                             },
//                           );
//                         }
//                       },
//                     ),
//                   ],
//                 ),
//               )));
//         });
//   }

//   // 112233 EID Name ,Id amnd etc
//   // 002 For Tracking of Tenant->Due Action For Contract Renewal->upload Document->Scane Emirate ID
//   // after scan the emirate id there is a pop up show in whic we show name EID nationality etc
//   // all these data pass to the api of upload that we call in line 557 and 555
//   // but when ali bhai publish the api
//   // 112233 after scane EmirateID all code
//   _showConfirmationDialog(int index, BuildContext context) {
//     String nationality = controller.cardScanModel.nationality;
//     if (nationality != null) {
//       if (controller.cardScanModel.nationality.contains('Nationality') ==
//           true) {
//         if (controller.cardScanModel.nationality.contains(',')) {
//           setState(() {
//             nationality = controller.cardScanModel.nationality
//                 .replaceAll('Nationality,', '');
//           });
//         } else if (controller.cardScanModel.nationality.contains(':')) {
//           setState(() {
//             nationality = controller.cardScanModel.nationality
//                 .replaceAll('Nationality:', '');
//           });
//         } else {
//           setState(() {
//             nationality = controller.cardScanModel.nationality
//                 .replaceAll('Nationality', '');
//           });
//         }
//       }
//     }

//     nameText.text = controller.cardScanModel.name;
//     iDNumberText.text = controller.cardScanModel.idNumber;
//     if (controller.cardScanModel.dob != null) {
//       dOBText =
//           '${DateFormat('dd-MM-yyyy').format(controller.cardScanModel.dob)}';
//     }

//     expiryText = controller.cardScanModel.expiry == null
//         ? controller.docsModel?.docs?[index].expiry
//         : '${DateFormat('dd-MM-yyyy').format(controller.cardScanModel.expiry)}';

//     setState(() {
//       isNameError = false;
//       isIDError = false;
//       isExpiryError = false;
//       isDOBError = false;
//     });

//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) {
//         return StatefulBuilder(
//           builder: (context, setState) {
//             return AlertDialog(
//               title: Text(AppMetaLabels().pleaseVerify),
//               content: SingleChildScrollView(
//                 child: Container(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       // Name
//                       Padding(
//                         padding: EdgeInsets.only(
//                             left: 2.0.w, top: 0.5.h, right: 4.0.w),
//                         child: Align(
//                             alignment: SessionController().getLanguage() == 1
//                                 ? Alignment.centerLeft
//                                 : Alignment.centerRight,
//                             child: Text(
//                               AppMetaLabels().name,
//                               style: AppTextStyle.normalGrey10,
//                             )),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(
//                             top: 0.5.h, left: 2.0.w, right: 2.0.w),
//                         child: SizedBox(
//                           // height: 4.h,
//                           width: 90.w,
//                           child: TextFormField(
//                             controller: nameText,
//                             maxLines: 2,
//                             style: AppTextStyle.normalBlack10,
//                             onChanged: (val) {
//                               if (val.isNotEmpty) {
//                                 setState(() {
//                                   isNameError = false;
//                                 });
//                               } else {
//                                 if (!nameValidator.hasMatch(val)) {
//                                   setState(() {
//                                     isNameError = true;
//                                   });
//                                   return;
//                                 }
//                               }
//                             },
//                             validator: (value) {
//                               if (!nameValidator.hasMatch(value)) {
//                                 setState(() {
//                                   isNameError = true;
//                                 });
//                                 return;
//                               } else
//                                 return null;
//                             },
//                             decoration: InputDecoration(
//                               suffixIconConstraints: BoxConstraints(
//                                 minWidth: 4.h,
//                                 minHeight: 2,
//                               ),
//                               suffixIcon: Icon(
//                                 Icons.edit,
//                                 size: 2.h,
//                               ),
//                               focusedBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(5.0),
//                                 borderSide: BorderSide(
//                                   color: isNameError
//                                       ? AppColors.redColor
//                                       : AppColors.blueColor,
//                                 ),
//                               ),
//                               enabledBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(5.0),
//                                 borderSide: BorderSide(
//                                   color: isNameError
//                                       ? AppColors.redColor
//                                       : AppColors.bordercolornew,
//                                   width: 0.2.w,
//                                 ),
//                               ),
//                               fillColor: AppColors.greyBG,
//                               filled: true,
//                               hintText: AppMetaLabels().name,
//                               hintStyle: AppTextStyle.normalBlack10
//                                   .copyWith(color: AppColors.textFieldBGColor),
//                               errorStyle: TextStyle(fontSize: 0),
//                               contentPadding: EdgeInsets.all(2.5.w),
//                             ),
//                           ),
//                         ),
//                       ),
//                       isNameError == true
//                           ? Padding(
//                               padding: EdgeInsets.only(
//                                   left: 2.0.w, top: 0.2.h, right: 4.0.w),
//                               child: Text(
//                                 AppMetaLabels().invalidName,
//                                 style: AppTextStyle.normalGrey8
//                                     .copyWith(color: Colors.red),
//                               ),
//                             )
//                           : SizedBox(),
//                       // ID Number
//                       Padding(
//                         padding: EdgeInsets.only(
//                             left: 2.0.w, top: 1.0.h, right: 4.0.w),
//                         child: Align(
//                             alignment: SessionController().getLanguage() == 1
//                                 ? Alignment.centerLeft
//                                 : Alignment.centerRight,
//                             child: Text(
//                               // 'ID Number',
//                               AppMetaLabels().iDNumber,
//                               style: AppTextStyle.normalGrey10,
//                             )),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(
//                             top: 0.5.h, left: 2.0.w, right: 2.0.w),
//                         child: SizedBox(
//                           width: 90.0.w,
//                           height: 4.0.h,
//                           child: TextFormField(
//                             inputFormatters: [maskFormatter],
//                             controller: iDNumberText,
//                             maxLength: 18,
//                             keyboardType: TextInputType.numberWithOptions(),
//                             onChanged: (val) {
//                               if (val.isNotEmpty) {
//                                 setState(() {
//                                   isIDError = false;
//                                 });
//                               }
//                             },
//                             style: AppTextStyle.normalBlack10,
//                             decoration: InputDecoration(
//                               suffixIconConstraints: BoxConstraints(
//                                 minWidth: 4.h,
//                                 minHeight: 2,
//                               ),
//                               suffixIcon: Icon(
//                                 Icons.edit,
//                                 size: 2.h,
//                               ),
//                               counterText: "",
//                               focusedBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(5.0),
//                                 borderSide: BorderSide(
//                                   color: isIDError
//                                       ? AppColors.redColor
//                                       : AppColors.blueColor,
//                                 ),
//                               ),
//                               enabledBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(5.0),
//                                 borderSide: BorderSide(
//                                   color: isIDError
//                                       ? AppColors.redColor
//                                       : AppColors.bordercolornew,
//                                   width: 0.2.w,
//                                 ),
//                               ),
//                               fillColor: AppColors.greyBG,
//                               filled: true,
//                               hintText: '000-0000-0000000-0',
//                               hintStyle: AppTextStyle.normalBlack10
//                                   .copyWith(color: AppColors.textFieldBGColor),
//                               errorStyle: TextStyle(fontSize: 0),
//                               contentPadding: EdgeInsets.all(2.5.w),
//                             ),
//                           ),
//                         ),
//                       ),
//                       // Expiry
//                       Padding(
//                         padding: EdgeInsets.only(
//                             left: 2.0.w, top: 1.0.h, right: 4.0.w),
//                         child: Align(
//                             alignment: SessionController().getLanguage() == 1
//                                 ? Alignment.centerLeft
//                                 : Alignment.centerRight,
//                             child: Text(
//                               AppMetaLabels().expDate,
//                               style: AppTextStyle.normalGrey10,
//                             )),
//                       ),
//                       SizedBox(
//                         height: 0.5.h,
//                       ),
//                       InkWell(
//                         onTap: () async {
//                           var expDate = await showRoundedDatePicker(
//                             height: 50.0.h,
//                             context: context,
//                                 locale: SessionController().getLanguage() == 1
                                  // ? Locale('en', '')
                                  // : Locale('ar', ''),
//                             initialDate: DateTime.now(),
//                             firstDate:
//                                 DateTime.now().subtract(Duration(seconds: 1)),
//                             lastDate: DateTime(DateTime.now().year + 10),
//                             borderRadius: 2.0.h,
//                             // theme:
//                             //     ThemeData(primarySwatch: Colors.deepPurple),
//                             styleDatePicker: MaterialRoundedDatePickerStyle(
//                               backgroundHeader: Colors.grey.shade300,
//                               // Appbar year like '2023' button
//                               textStyleYearButton: TextStyle(
//                                 fontSize: 30.sp,
//                                 color: Colors.blue,
//                                 fontWeight: FontWeight.bold,
//                                 backgroundColor: Colors.grey.shade100,
//                                 leadingDistribution:
//                                     TextLeadingDistribution.even,
//                               ),
//                               // Appbar day like 'Thu, Mar 16' button
//                               textStyleDayButton: TextStyle(
//                                 fontSize: 18.sp,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           );

//                           if (expDate != null) {
//                             if (expDate.isBefore(DateTime.now()) ||
//                                 expDate.isAtSameMomentAs(DateTime.now())) {
//                               SnakBarWidget.getSnackBarErrorBlue(
//                                 AppMetaLabels().error,
//                                 AppMetaLabels().selectFuturedate,
//                               );
//                             } else {
//                               DateFormat dateFormat = new DateFormat(
//                                   AppMetaLabels()
//                                       .dateFormatForShowRoundedDatePicker);
//                               setState(() {
//                                 expiryText = dateFormat.format(expDate);
//                                 controller.docsModel?.docs?[index].expiry =
//                                     dateFormat.format(expDate);

//                                 isExpiryError = false;
//                               });
//                             }
//                           }
//                         },
//                         child: Container(
//                           width: 90.0.w,
//                           height: 4.0.h,
//                           margin: EdgeInsets.only(
//                               top: 0.5.h, left: 2.0.w, right: 2.0.w),
//                           decoration: BoxDecoration(
//                             color: Color.fromRGBO(246, 248, 249, 1),
//                             borderRadius: BorderRadius.circular(1.0.h),
//                             border: Border.all(
//                               color: isExpiryError == true
//                                   ? AppColors.redColor
//                                   : AppColors.bordercolornew,
//                               width: 0.2.w,
//                             ),
//                           ),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             children: [
//                               Padding(
//                                 padding:
//                                     EdgeInsets.symmetric(horizontal: 1.0.h),
//                                 child: Text(
//                                   expiryText,
//                                   style: AppTextStyle.normalBlack10,
//                                 ),
//                               ),
//                               Spacer(),
//                               Padding(
//                                 padding:
//                                     EdgeInsets.symmetric(horizontal: 1.0.h),
//                                 child: ClearButton(
//                                   clear: () {
//                                     setState(() {
//                                       expiryText = '';
//                                       controller.docsModel?.docs?[index].expiry =
//                                           '';
//                                     });
//                                   },
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       // DOB
//                       Padding(
//                         padding: EdgeInsets.only(
//                             left: 2.0.w, top: 1.0.h, right: 4.0.w),
//                         child: Align(
//                             alignment: SessionController().getLanguage() == 1
//                                 ? Alignment.centerLeft
//                                 : Alignment.centerRight,
//                             child: Text(
//                               // 'Date Of Birth',
//                               AppMetaLabels().dateOFBirth,
//                               style: AppTextStyle.normalGrey10,
//                             )),
//                       ),
//                       SizedBox(
//                         height: 0.5.h,
//                       ),
//                       InkWell(
//                         onTap: () async {
//                           var expDate = await showRoundedDatePicker(
//                             height: 50.0.h,
//                             context: context,
//                               locale: SessionController().getLanguage() == 1
                                  // ? Locale('en', '')
                                  // : Locale('ar', ''),
//                             initialDate: DateTime.now(),
//                             firstDate: DateTime(DateTime.now().year - 100),
//                             lastDate: DateTime.now(),
//                             borderRadius: 2.0.h,
//                             // theme:
//                             //     ThemeData(primarySwatch: Colors.deepPurple),
//                             styleDatePicker: MaterialRoundedDatePickerStyle(
//                               backgroundHeader: Colors.grey.shade300,
//                               // Appbar year like '2023' button
//                               textStyleYearButton: TextStyle(
//                                 fontSize: 30.sp,
//                                 color: Colors.blue,
//                                 fontWeight: FontWeight.bold,
//                                 backgroundColor: Colors.grey.shade100,
//                                 leadingDistribution:
//                                     TextLeadingDistribution.even,
//                               ),
//                               // Appbar day like 'Thu, Mar 16' button
//                               textStyleDayButton: TextStyle(
//                                 fontSize: 18.sp,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           );

//                           if (expDate != null) {
//                             if (expDate.isAfter(DateTime.now()) ||
//                                 expDate.isAtSameMomentAs(DateTime.now())) {
//                               SnakBarWidget.getSnackBarErrorBlue(
//                                 AppMetaLabels().error,
//                                 AppMetaLabels().selectFuturedate,
//                               );
//                             } else {
//                               DateFormat dateFormat = new DateFormat(
//                                   AppMetaLabels()
//                                       .dateFormatForShowRoundedDatePicker);
//                               setState(() {
//                                 isDOBError = false;
//                                 dOBText = dateFormat.format(expDate);
//                               });
//                             }
//                           }
//                         },
//                         child: Container(
//                           width: 90.0.w,
//                           height: 4.0.h,
//                           margin: EdgeInsets.only(
//                               top: 0.5.h, left: 2.0.w, right: 2.0.w),
//                           decoration: BoxDecoration(
//                             color: Color.fromRGBO(246, 248, 249, 1),
//                             borderRadius: BorderRadius.circular(1.0.h),
//                             border: Border.all(
//                               color: isDOBError == true
//                                   ? AppColors.redColor
//                                   : AppColors.bordercolornew,
//                               width: 0.2.w,
//                             ),
//                           ),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             children: [
//                               Padding(
//                                 padding:
//                                     EdgeInsets.symmetric(horizontal: 1.0.h),
//                                 child: Text(
//                                   dOBText,
//                                   style: AppTextStyle.normalBlack10,
//                                 ),
//                               ),
//                               Spacer(),
//                               Padding(
//                                 padding:
//                                     EdgeInsets.symmetric(horizontal: 1.0.h),
//                                 child: ClearButton(
//                                   clear: () {
//                                     setState(() {
//                                       dOBText = '';
//                                     });
//                                   },
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 2.0.h,
//                       ),
//                       SizedBox(
//                         height: Get.height * 0.3,
//                         width: double.infinity,
//                         child: controller.mergedId != null
//                             ? Image.file(
//                                 controller.mergedId,
//                                 fit: BoxFit.contain,
//                               )
//                             : SizedBox(),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               actions: [
//                 TextButton(
//                     child: Text(AppMetaLabels().cancel),
//                     onPressed: () async {
//                       Navigator.of(context).pop();
//                       WidgetsBinding.instance.addPostFrameCallback((_) {
//                         setState(() {
//                           controller.docsModel?.docs?[index].loading.value =
//                               false;
//                           controller.cardScanModel = CardScanModel();
//                           controller.mergedId = null;
//                           controller.isLoadingForScanning.value = false;
//                           controller.isDocUploaded[index] = 'false';
//                         });
//                       });
//                       await controller.removePickedFile(index);
//                       setState(() {});
//                     }),
//                 TextButton(
//                     child: Text(AppMetaLabels().confirm),
//                     onPressed: () async {
//                       if (controller.comparingUint8List(
//                           controller.cardScanModel.backImage,
//                           controller.cardScanModel.frontImage)) {
//                         await showDialog(
//                             context: context,
//                             barrierDismissible: false,
//                             builder: (BuildContext context) {
//                               return AlertDialog(
//                                 contentPadding: EdgeInsets.zero,
//                                 backgroundColor: Colors.transparent,
//                                 content: showDialogForWrongScan(index),
//                               );
//                             });
//                         setState(() {});
//                       } else {
//                         WidgetsBinding.instance.addPostFrameCallback(
//                           (timeStamp) async {
//                             if (controller.docsModel?.docs?[index].isRejected) {
//                               setState(() {
//                                 isEnableScreen = false;
//                                 controller.isLoadingForScanning.value = true;
//                               });
//                               Navigator.of(context).pop();
//                               await controller.updateDoc(index);
//                               isEnableScreen = true;
//                             } else {
//                               if (nameText.text == '' ||
//                                   nameText.text == null) {
//                                 SnakBarWidget.getSnackBarErrorBlue(
//                                     AppMetaLabels().alert,
//                                     AppMetaLabels().pleaseEnterFullName);
//                                 setState(() {
//                                   isNameError = true;
//                                 });
//                                 return;
//                               } else if (!nameValidator
//                                   .hasMatch(nameText.text)) {
//                                 setState(() {
//                                   isNameError = true;
//                                 });
//                                 return;
//                               } else if (iDNumberText.text == '' ||
//                                   iDNumberText.text == null ||
//                                   iDNumberText.text.length < 18) {
//                                 SnakBarWidget.getSnackBarErrorBlue(
//                                     AppMetaLabels().alert,
//                                     AppMetaLabels().pleaseEnterCorrectID);
//                                 setState(() {
//                                   isIDError = true;
//                                 });
//                                 return;
//                               } else if (expiryText == '' ||
//                                   expiryText == null ||
//                                   expiryText.contains('.')) {
//                                 SnakBarWidget.getSnackBarErrorBlue(
//                                     AppMetaLabels().alert,
//                                     AppMetaLabels().pleaseSelectCorrectExpDate);
//                                 setState(() {
//                                   isExpiryError = true;
//                                 });
//                                 return;
//                               } else if (dOBText == '' ||
//                                   dOBText == null ||
//                                   dOBText.contains('.')) {
//                                 SnakBarWidget.getSnackBarErrorBlue(
//                                     AppMetaLabels().alert,
//                                     AppMetaLabels().pleaseSelectDOB);
//                                 setState(() {
//                                   isDOBError = true;
//                                 });
//                                 return;
//                               } else {
//                                 setState(() {
//                                   isEnableScreen = false;
//                                   controller.isLoadingForScanning.value = true;
//                                 });
//                                 Navigator.of(context).pop();
//                                 await controller.uploadDocWithEIDParameter(
//                                   index,
//                                   iDNumberText.text,
//                                   controller.cardScanModel.nationality,
//                                   nameText.text,
//                                   nameText.text,
//                                   '',
//                                   dOBText,
//                                 );
//                                 isEnableScreen = true;
//                               }
//                             }
//                           },
//                         );
//                       }
//                     }),
//               ],
//             );
//           },
//         );
//       },
//     );
//   }

//   Widget showDialogData() {
//     return Container(
//         padding: EdgeInsets.all(3.0.w),
//         // height: 45.0.h,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(2.0.h),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black12,
//               blurRadius: 0.5.h,
//               spreadRadius: 0.3.h,
//               offset: Offset(0.1.h, 0.1.h),
//             ),
//           ],
//         ),
//         child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               SizedBox(
//                 height: 4.0.h,
//               ),
//               Image.asset(
//                 AppImagesPath.bluttickimg,
//                 height: 9.0.h,
//                 fit: BoxFit.contain,
//               ),
//               SizedBox(
//                 height: 3.0.h,
//               ),
//               Text(
//                 AppMetaLabels().documentUploaded,
//                 textAlign: TextAlign.center,
//                 style: AppTextStyle.semiBoldBlack13,
//               ),
//               SizedBox(
//                 height: 3.0.h,
//               ),
//               Padding(
//                 padding: EdgeInsets.only(left: Get.width * 0.03),
//                 child: Text(
//                   AppMetaLabels().menaStage3,
//                   style: AppTextStyle.normalBlack10
//                       .copyWith(color: AppColors.renewelgreyclr1, height: 1.3),
//                   maxLines: 5,
//                   overflow: TextOverflow.ellipsis,
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               Padding(
//                   padding: EdgeInsets.only(top: 5.0.h, bottom: 2.0.h),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Align(
//                         alignment: Alignment.center,
//                         child: SizedBox(
//                           height: 4.8.h,
//                           width: 30.0.w,
//                           child: ElevatedButton(
//                             style: ButtonStyle(
//                                 elevation:
//                                     MaterialStateProperty.all<double>(0.0.h),
//                                 backgroundColor:
//                                     MaterialStateProperty.all<Color>(
//                                         AppColors.whiteColor),
//                                 shape: MaterialStateProperty.all<
//                                     RoundedRectangleBorder>(
//                                   RoundedRectangleBorder(
//                                       borderRadius:
//                                           BorderRadius.circular(2.0.w),
//                                       side: BorderSide(
//                                         color: AppColors.blueColor,
//                                         width: 1.0,
//                                       )),
//                                 )),
//                             onPressed: () {
//                               Get.back();
//                             },
//                             child: Text(
//                               AppMetaLabels().stayOnPage,
//                               textAlign: TextAlign.center,
//                               style: AppTextStyle.semiBoldWhite10
//                                   .copyWith(color: Colors.blue),
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       Align(
//                         alignment: Alignment.center,
//                         child: SizedBox(
//                           height: 5.0.h,
//                           width: 30.0.w,
//                           child: ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(1.3.h),
//                               ),
//                               backgroundColor: Color.fromRGBO(0, 61, 166, 1),
//                             ),
//                             onPressed: () {
//                               Get.back();
//                               Get.off(() => TenantDashboardTabs(
//                                     initialIndex: 0,
//                                   ));
//                             },
//                             child: Text(
//                               AppMetaLabels().goToDashoboard,
//                               textAlign: TextAlign.center,
//                               style: AppTextStyle.semiBoldWhite10,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   )),
//             ]));
//   }

//   Widget showDialogForWrongScan(int index) {
//     return Container(
//       padding: EdgeInsets.all(3.0.w),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(2.0.h),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black12,
//             blurRadius: 0.5.h,
//             spreadRadius: 0.3.h,
//             offset: Offset(0.1.h, 0.1.h),
//           ),
//         ],
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           SizedBox(
//             height: 4.0.h,
//           ),
//           Icon(
//             Icons.error,
//             size: 9.0.h,
//           ),
//           SizedBox(
//             height: 3.0.h,
//           ),
//           Text(
//             AppMetaLabels().cardScanningFailed,
//             textAlign: TextAlign.center,
//             style: AppTextStyle.semiBoldBlack13,
//           ),
//           SizedBox(
//             height: 3.0.h,
//           ),
//           Padding(
//             padding: EdgeInsets.only(left: Get.width * 0.03),
//             child: Text(
//               AppMetaLabels().pleaseScaneFrontSideOfEIDAgain,
//               style: AppTextStyle.normalBlack10
//                   .copyWith(color: AppColors.renewelgreyclr1, height: 1.3),
//               maxLines: 5,
//               overflow: TextOverflow.ellipsis,
//               textAlign: TextAlign.center,
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.only(top: 5.0.h, bottom: 2.0.h),
//             child: Row(
//               children: [
//                 SizedBox(
//                   width: 2.w,
//                 ),
//                 Align(
//                   alignment: Alignment.center,
//                   child: SizedBox(
//                     height: 5.0.h,
//                     width: 30.0.w,
//                     child: ElevatedButton(
//                       style: ButtonStyle(
//                         shape:
//                             MaterialStateProperty.all<RoundedRectangleBorder>(
//                                 RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(3.0.w),
//                                     side: BorderSide(color: Colors.blue))),
//                         backgroundColor:
//                             MaterialStateProperty.all<Color>(Colors.white),
//                       ),
//                       onPressed: () {
//                         Get.back();
//                         Navigator.of(context).pop();
//                       },
//                       child: Text(
//                         AppMetaLabels().cancel,
//                         textAlign: TextAlign.center,
//                         style: AppTextStyle.semiBoldBlack10,
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   width: 6.w,
//                 ),
//                 Align(
//                   alignment: Alignment.center,
//                   child: SizedBox(
//                     height: 5.0.h,
//                     width: 30.0.w,
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(1.3.h),
//                         ),
//                         backgroundColor: Color.fromRGBO(0, 61, 166, 1),
//                       ),
//                       onPressed: () async {
//                         Get.back();
//                         Navigator.of(context).pop();
//                         controller.docsModel?.docs?[index].loading.value = false;
//                         controller.cardScanModel = CardScanModel();
//                         controller.mergedId = null;
//                         controller.isLoadingForScanning.value = false;
//                         await controller.removePickedFile(index);
//                         setState(() {
//                           controller.isDocUploaded[index] = 'false';
//                         });
//                       },
//                       child: Text(
//                         AppMetaLabels().reScane,
//                         textAlign: TextAlign.center,
//                         style: AppTextStyle.semiBoldWhite10,
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   width: 2.w,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

// // show fron and back side of image
//   _showFrontBackImage(String source, BuildContext context, int index) {
//     showDialog(
//         context: context,
//         // barrierDismissible: false,
//         builder: (context) {
//           return AlertDialog(
//             title: Text(AppMetaLabels().emirateid),
//             content: Container(
//               height: Get.height * 0.6,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   SizedBox(
//                     height: Get.height * 0.02,
//                   ),
//                   SizedBox(
//                       child: Center(
//                           child: Text(AppMetaLabels().pleaseScaneFrontSideOfEID,
//                               textAlign: TextAlign.center,
//                               style: AppTextStyle.semiBoldBlack10))),
//                   SizedBox(
//                     height: Get.height * 0.05,
//                   ),
//                   SizedBox(
//                     height: Get.height * 0.15,
//                     width: double.infinity,
//                     child: Image.asset(
//                       // AppImagesPath.emiratesID,
//                       'assets/images/tenant_images/cropImage1.png',
//                       fit: BoxFit.fill,
//                     ),
//                   ),
//                   SizedBox(
//                     height: Get.height * 0.02,
//                   ),
//                   SizedBox(
//                     height: Get.height * 0.15,
//                     width: double.infinity,
//                     child: Image.asset(
//                       // AppImagesPath.emiratesID,
//                       'assets/images/tenant_images/cropImage2.png',
//                       fit: BoxFit.fill,
//                     ),
//                   ),
//                   SizedBox(
//                     height: Get.height * 0.05,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Spacer(),
//                       SizedBox(
//                         width: Get.width * 0.3,
//                         height: Get.height * 0.05,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             Navigator.of(context, rootNavigator: true)
//                                 .pop('dialog');
//                           },
//                           style: ButtonStyle(
//                             shape: MaterialStateProperty.all<
//                                     RoundedRectangleBorder>(
//                                 RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(3.0.w),
//                                     side: BorderSide(color: Colors.blue))),
//                             backgroundColor:
//                                 MaterialStateProperty.all<Color>(Colors.white),
//                           ),
//                           child: Text(
//                             AppMetaLabels().cancel,
//                             style: AppTextStyle.semiBoldBlue11
//                                 .copyWith(color: Colors.blue),
//                           ),
//                         ),
//                       ),
//                       Spacer(),
//                       SizedBox(
//                         width: Get.width * 0.3,
//                         height: Get.height * 0.05,
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(1.3.h),
//                               ),
//                               backgroundColor: Colors.blue),
//                           onPressed: () async {
//                             if (source == 'gallery') {
//                               Navigator.of(context, rootNavigator: true)
//                                   .pop('dialog');
//                               setState(() {
//                                 isEnableScreen = false;
//                                 controller.isLoadingForScanning.value = true;
//                                 controller.controllerTRDC.isEnableBackButton
//                                     .value = false;
//                               });
//                               // just clear the Session of ID Number
//                               setState(() {
//                                 SessionController().idNumber = null;
//                               });
//                               await controller.scanEmirateId(
//                                   ImageSource.gallery, index);
//                               setState(() {
//                                 isEnableScreen = true;
//                                 controller.isLoadingForScanning.value = false;
//                                 controller.controllerTRDC.isEnableBackButton
//                                     .value = true;
//                               });
//                             } else {
//                               Navigator.of(context, rootNavigator: true)
//                                   .pop('dialog');
//                               setState(() {
//                                 isEnableScreen = false;
//                                 controller.isLoadingForScanning.value = true;
//                                 controller.controllerTRDC.isEnableBackButton
//                                     .value = false;
//                               });
//                               // just clear the Session of ID Number
//                               setState(() {
//                                 SessionController().idNumber = null;
//                               });
//                               await controller.scanEmirateId(
//                                   ImageSource.camera, index);

//                               setState(() {
//                                 isEnableScreen = true;
//                                 controller.isLoadingForScanning.value = false;
//                                 controller.controllerTRDC.isEnableBackButton
//                                     .value = true;
//                               });
//                             }
//                           },
//                           child: Text(
//                             AppMetaLabels().scane,
//                             style: AppTextStyle.semiBoldWhite10,
//                           ),
//                         ),
//                       ),
//                       Spacer(),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           );
//         });
//   }
// }


