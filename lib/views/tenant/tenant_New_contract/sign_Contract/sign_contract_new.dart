import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/tenant/tenant_New_contract/sign_Contract/sign_contract_new_controller.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/error_text_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:fap_properties/views/widgets/signature_pad.dart';
import 'package:fap_properties/views/widgets/snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import 'package:signature/signature.dart';
import 'package:sizer/sizer.dart';
import 'dart:ui' as ui;

class AuthenticateNewContract extends StatefulWidget {
  final String? contractNo;
  final int? contractId;
  final String? filePath;
  final int? dueActionId;
  final int? stageId;
  final String? caller;
  final int? caseId;
  const AuthenticateNewContract(
      {Key? key,
      this.filePath,
      this.contractNo,
      this.contractId,
      this.dueActionId = 0,
      this.stageId = 0,
      this.caller,
      this.caseId})
      : super(key: key);

  @override
  _AuthenticateNewContractState createState() => _AuthenticateNewContractState();
}

class _AuthenticateNewContractState extends State<AuthenticateNewContract> {
  final controller = Get.put(AuthenticateNewContractController());
  bool acceptTerms = false;
  final SignatureController signatureController = SignatureController(
    penStrokeWidth: 1,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
    onDrawStart: () => print('onDrawStart called!'),
    onDrawEnd: () => print('onDrawEnd called!'),
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: SessionController().getLanguage() == 1
          ? ui.TextDirection.ltr
          : ui.TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Obx(() {
            return Column(children: [
              Padding(
                padding: EdgeInsets.only(left: 7.0.w, right: 7.0.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${AppMetaLabels().contractNo}${widget.contractNo}",
                      style: AppTextStyle.semiBoldBlack15,
                    ),

                    // SizedBox(width: 15.0.w,),
                    InkWell(
                      onTap: () {
                        Get.back();
                        Get.back();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromRGBO(118, 118, 128, 0.12),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(0.5.h),
                          child: Icon(Icons.close,
                              size: 2.5.h,
                              color: Color.fromRGBO(158, 158, 158, 1)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 2.0.h, bottom: 2.0.h),
                child: AppDivider(),
              ),
              Expanded(
                child: controller.gettingCaseNo.value
                    ? LoadingIndicatorBlue()
                    : controller.errorGettingCaseNo != ''
                        ? AppErrorWidget(
                            errorText: controller.errorGettingCaseNo,
                          )
                        : Padding(
                            padding: EdgeInsets.only(bottom: 4.0.h),
                            child: Container(
                              width: 92.0.w,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        SessionController().getLanguage() == 1
                                            ? EdgeInsets.only(
                                                top: 3.0.h, left: 4.0.w)
                                            : EdgeInsets.only(
                                                top: 3.0.h, right: 4.0.w),
                                    child: Text(
                                      AppMetaLabels().contractDocumnets,
                                      style: AppTextStyle.semiBoldBlack11,
                                    ),
                                  ),
                                  Expanded(
                                      child: PDFView(
                                    filePath: widget.filePath,
                                  )),
                                  SizedBox(
                                    height: 1.0.h,
                                  ),
                                  AppDivider(),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 1.0.h,
                                        left: 4.0.w,
                                        right: 4.0.w,
                                        bottom: 1.h),
                                    child: Text(
                                      AppMetaLabels().drawYourSig,
                                      style: AppTextStyle.semiBoldBlack11,
                                    ),
                                  ),
                                  SignaturePad(
                                      height: 16.h,
                                      // height: 12.h,
                                      controller: signatureController),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Checkbox(
                                        activeColor: AppColors.blueColor,
                                        value: this.acceptTerms,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            this.acceptTerms = value!;
                                          });
                                        },
                                      ), //Check
                                      Text(
                                        AppMetaLabels().iAgree,
                                        style: AppTextStyle.normalBlack10,
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          controller.getTerms(widget.contractId??0,
                                              widget.contractNo??"");
                                        },
                                        child: Obx(() {
                                          return controller.loadingTerms.value
                                              ? AnimatedTextKit(
                                                  isRepeatingAnimation: true,
                                                  repeatForever: true,
                                                  pause: Duration(
                                                      milliseconds: 10),
                                                  animatedTexts: [
                                                    ColorizeAnimatedText(
                                                        AppMetaLabels()
                                                            .termsConditions,
                                                        textStyle: AppTextStyle
                                                            .normalBlue10,
                                                        colors: [
                                                          AppColors.blueColor,
                                                          AppColors.blueColor2,
                                                          AppColors.blueColor
                                                        ],
                                                        speed: Duration(
                                                            milliseconds: 200)),
                                                  ],
                                                )
                                              : Text(
                                                  AppMetaLabels()
                                                      .termsConditions,
                                                  style:
                                                      AppTextStyle.normalBlue10,
                                                );
                                        }),
                                      ),
                                    ],
                                  ),
                                  // 112233 SUbmit button enable disable for Sign Contract
                                  Center(
                                    child: Container(
                                      height: 5.0.h,
                                      width: 69.0.w,
                                      child: Obx(() {
                                        return controller.savingSignature.value
                                            ? LoadingIndicatorBlue()
                                            : ElevatedButton(
                                                onPressed: !acceptTerms
                                                    ? null
                                                    : () async {
                                                        print(acceptTerms);
                                                        if (!acceptTerms) {
                                                          Get.snackbar(
                                                              AppMetaLabels()
                                                                  .error,
                                                              AppMetaLabels()
                                                                  .acceptTermsConditions,
                                                              backgroundColor:
                                                                  Colors
                                                                      .white54);
                                                        } else if (signatureController
                                                            .isEmpty) {
                                                          SnakBarWidget
                                                              .getSnackBarErrorBlue(
                                                            AppMetaLabels()
                                                                .alert,
                                                            AppMetaLabels()
                                                                .yourSignature,
                                                          );
                                                        } else {
                                                          bool saved;
                                                          if (controller
                                                              .errorUpdatingStage) {
                                                            saved = await controller
                                                                .updateDocStage(
                                                                    widget
                                                                        .dueActionId??-1,
                                                                    widget
                                                                        .stageId??-1,
                                                                    widget
                                                                        .caller??"");
                                                          } else {
                                                            var signature =
                                                                await signatureController
                                                                    .toPngBytes();
                                                            saved = await controller
                                                                .saveSignature(
                                                                    signature!,
                                                                    widget
                                                                        .dueActionId??-1,
                                                                    widget
                                                                        .stageId??-1,
                                                                    widget
                                                                        .caller??"",
                                                                    widget
                                                                        .caseId??-1);
                                                          }
                                                          if (saved) {
                                                            showSuccessDialog();
                                                          }
                                                        }
                                                      },
                                                child: Text(
                                                  SessionController()
                                                              .getLanguage() ==
                                                          1
                                                      ? AppMetaLabels().submit
                                                      : AppMetaLabels().apply,
                                                  style: AppTextStyle
                                                      .semiBoldBlack11
                                                      .copyWith(
                                                          color: Colors.white),
                                                ),
                                                style: ButtonStyle(
                                                    elevation:
                                                        WidgetStateProperty
                                                            .all<double>(0.0),
                                                    backgroundColor: !acceptTerms
                                                        ? WidgetStateProperty
                                                            .all<Color>(Colors
                                                                .grey.shade400)
                                                        : WidgetStateProperty
                                                            .all<Color>(AppColors
                                                                .blueColor),
                                                    shape: WidgetStateProperty
                                                        .all<
                                                            RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    2.0.w),
                                                      ),
                                                    )),
                                              );
                                      }),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2.0.h,
                                  )
                                ],
                              ),
                            ),
                          ),
              ),
            ]);
          }),
        ),
      ),
    );
  }

  showSuccessDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              contentPadding: EdgeInsets.zero,
              backgroundColor: Colors.transparent,
              content: Stack(children: <Widget>[
                Container(
                    padding: EdgeInsets.all(3.0.w),
                    height: 47.0.h,
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
                          // signed
                          Obx(
                            () {
                              return Center(
                                child: Text(
                                  controller.emirateId.value != 1
                                      ? AppMetaLabels().signatureSavedTenant
                                      : AppMetaLabels()
                                          .signatureSavedTenantEIDOne,
                                  style: AppTextStyle.semiBoldBlack13,
                                  textAlign: TextAlign.center,
                                ),
                              );
                            },
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
                                      borderRadius:
                                          BorderRadius.circular(1.3.h),
                                    ),
                                    backgroundColor:
                                        Color.fromRGBO(0, 61, 166, 1),
                                  ),
                                  onPressed: () {
                                    Get.back();
                                    Get.back();
                                  },
                                  child: Text(
                                    AppMetaLabels().done,
                                    style: AppTextStyle.semiBoldWhite12,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ])),
              ]));
        });
  }
}
