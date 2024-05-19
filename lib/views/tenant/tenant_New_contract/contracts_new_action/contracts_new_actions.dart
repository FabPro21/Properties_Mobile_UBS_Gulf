import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/screen_disable.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/fonts.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/tenant/tenant_contracts/contract_checkin/contract_checkin.dart';
import 'package:fap_properties/views/tenant/tenant_contracts/contract_renewel/contract_renewel.dart';
import 'package:fap_properties/views/tenant/tenant_contracts/make_payment/outstanding_payments/outstanding_payments.dart';
import 'package:fap_properties/views/tenant/tenant_contracts/tenant_contracts_tabs.dart/tenant_contracts_details.dart/authenticate_contract/authenticate_contract.dart';
import 'package:fap_properties/views/tenant/tenant_contracts/tenant_contracts_tabs.dart/tenant_contracts_details.dart/municipal_approval/municipal_approval.dart';
import 'package:fap_properties/views/tenant/tenant_contracts/tenant_contracts_tabs.dart/tenant_contracts_details.dart/tenant_contract_details.dart';
import 'package:fap_properties/views/tenant/tenant_contracts/tenant_contracts_tabs.dart/tenant_contracts_details.dart/tenant_contract_download/tenant_contract_download_controller.dart';
import 'package:fap_properties/views/tenant/tenant_New_contract/make_payment/outstanding_payments_new/outstanding_payments_new.dart';
import 'package:fap_properties/views/tenant/tenant_New_contract/muinciplity/muinciplity_new_contract.dart';
import 'package:fap_properties/views/tenant/tenant_New_contract/sign_Contract/sign_contract_new.dart';
import 'package:fap_properties/views/tenant/tenant_services_request/tenant_request_details/tenant_service_request_tab/tenant_service_request_tab.dart';
import 'package:fap_properties/views/widgets/common_widgets/custom_error_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:fap_properties/views/widgets/common_widgets/status_widget.dart';
import 'package:fap_properties/views/widgets/custom_button.dart';
import 'package:fap_properties/views/widgets/due_action_List_button.dart';
import 'package:fap_properties/views/widgets/snackbar_widget.dart';
import 'package:fap_properties/views/widgets/srno_widget.dart';
import 'package:fap_properties/views/widgets/step_no_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';
import 'contracts_new_actions_controller.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ContractNewAction extends StatefulWidget {
  ContractNewAction({Key key}) : super(key: key);

  @override
  State<ContractNewAction> createState() => _ContractNewActionState();
}

class _ContractNewActionState extends State<ContractNewAction> {
  // Controller for End Contract
  final ContractEndActionsController controller =
      Get.put(ContractEndActionsController());

  // calling same func through "ContractDownloadController" as we called in the
  // Renewal Flow
  final contractDownloadController = Get.put(ContractDownloadController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getContractsNew();
    });
    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  VideoPlayerController videoCotroller;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        setState(() {
          controller.isEnableScreen.value = true;
        });
        Get.back();
        return;
      },
      child: Directionality(
          textDirection: SessionController().getLanguage() == 1
              ? TextDirection.ltr
              : TextDirection.rtl,
          child: Scaffold(
              key: _scaffoldKey,
              backgroundColor: Colors.white,
              body: Obx(() {
                return Stack(children: [
                  SafeArea(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 1.h,
                        ),
                        Expanded(
                          child: Stack(
                            children: [
                              RefreshIndicator(
                                backgroundColor: Colors.white,
                                color: Colors.blue,
                                strokeWidth: 3,
                                triggerMode: RefreshIndicatorTriggerMode.onEdge,
                                onRefresh: () async {
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    controller.getContractsNew();
                                  });
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: 0.0.h,
                                  ),
                                  child: ConstrainedBox(
                                    constraints:
                                        BoxConstraints(minHeight: 50.h),
                                    child: Container(
                                      width: 92.0.w,
                                      margin: EdgeInsets.all(1.5.h),
                                      padding: EdgeInsets.only(top: 0.5.h),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(2.0.h),
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
                                        return controller
                                                    .loadingContracts.value ==
                                                true
                                            ? LoadingIndicatorBlue()
                                            : controller.errorLoadingContracts !=
                                                    ''
                                                ? CustomErrorWidget(
                                                    errorText: controller
                                                        .errorLoadingContracts,
                                                    errorImage: AppImagesPath
                                                        .noContractsFound,
                                                    onRetry: () {
                                                      controller
                                                          .getContractsNew();
                                                    },
                                                  )
                                                : ListView.builder(
                                                    padding: EdgeInsets.zero,
                                                    itemCount: controller
                                                        .contractsList.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Column(
                                                        children: [
                                                          inkWell(
                                                              index, context),
                                                          // SR No
                                                          controller
                                                                      .contractsList[
                                                                          index]
                                                                      .caseId ==
                                                                  0
                                                              ? SizedBox()
                                                              : Container(
                                                                  width: double
                                                                      .infinity,
                                                                  child: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .centerRight,
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsets.only(
                                                                          right: 2.5
                                                                              .w,
                                                                          left:
                                                                              2.5.w),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.end,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        children: [
                                                                          InkWell(
                                                                            onTap:
                                                                                () {
                                                                              SessionController().setCaseNo(
                                                                                controller.contractsList[index].caseId.toString(),
                                                                              );
                                                                              Get.to(() => TenantServiceRequestTabs(
                                                                                    requestNo: controller.contractsList[index].caseId.toString(),
                                                                                    caller: 'contracts_with_actions',
                                                                                    title: AppMetaLabels().renewalReq,
                                                                                    initialIndex: 0,
                                                                                  ));
                                                                            },
                                                                            child: Text(AppMetaLabels().requestno + ' ' + controller.contractsList[index].caseId.toString() + ' ',
                                                                                textAlign: TextAlign.left,
                                                                                style: TextStyle(
                                                                                  fontWeight: FontWeight.normal,
                                                                                  color: AppColors.blueColor,
                                                                                  fontSize: 12.5.sp,
                                                                                )),
                                                                          ),
                                                                          Icon(
                                                                            Icons.arrow_forward_ios_rounded,
                                                                            size:
                                                                                16,
                                                                            color:
                                                                                AppColors.blueColor,
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),

                                                          // Actions Buttons
                                                          SizedBox(
                                                            height: 1.5.h,
                                                          ),
                                                          // Upload Document
                                                          controller
                                                                      .contractsList[
                                                                          index]
                                                                      .stageId !=
                                                                  2
                                                              ? SizedBox()
                                                              : InkWell(
                                                                  onTap: controller.contractsList[index].isCanceled ==
                                                                              1 ||
                                                                          controller.contractsList[index].isClosed ==
                                                                              1
                                                                      ? () {
                                                                          SnakBarWidget.getSnackBarErrorBlue(
                                                                              AppMetaLabels().alert,
                                                                              AppMetaLabels().yourRequestCancelled);
                                                                        }
                                                                      : () {
                                                                          SessionController()
                                                                              .setCaseNo(
                                                                            controller.contractsList[index].caseId.toString(),
                                                                          );
                                                                          Get.to(
                                                                            () =>
                                                                                TenantServiceRequestTabs(
                                                                              requestNo: controller.contractsList[index].caseId.toString(),
                                                                              caller: 'contracts_with_actions',
                                                                              title: AppMetaLabels().renewalReq,
                                                                              initialIndex: 1,
                                                                            ),
                                                                          );
                                                                        },
                                                                  child: Center(
                                                                    child:
                                                                        new Container(
                                                                      width:
                                                                          50.w,
                                                                      padding: EdgeInsets.symmetric(
                                                                          vertical: 2.5
                                                                              .w,
                                                                          horizontal:
                                                                              1.w),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: AppColors
                                                                            .blueColor,
                                                                        borderRadius:
                                                                            BorderRadius.all(Radius.circular(6.sp)),
                                                                      ),
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      child:
                                                                          Text(
                                                                        AppMetaLabels()
                                                                            .uploadDocs,
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              AppColors.whiteColor,
                                                                          fontFamily:
                                                                              AppFonts.graphikSemibold,
                                                                          fontSize:
                                                                              12.0.sp,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                          // Make Payment
                                                          controller
                                                                      .contractsList[
                                                                          index]
                                                                      .stageId !=
                                                                  5
                                                              ? SizedBox()
                                                              : InkWell(
                                                                  onTap: controller.contractsList[index].isCanceled ==
                                                                              1 ||
                                                                          controller.contractsList[index].isClosed ==
                                                                              1
                                                                      ? () {
                                                                          SnakBarWidget.getSnackBarErrorBlue(
                                                                              AppMetaLabels().alert,
                                                                              AppMetaLabels().yourRequestCancelled);
                                                                        }
                                                                      : () {
                                                                          SessionController().setContractID(controller
                                                                              .contractsList[index]
                                                                              .contractid);
                                                                          SessionController().setContractNo(controller
                                                                              .contractsList[index]
                                                                              .contractno);
                                                                          print(
                                                                              'Status :::::::: ${controller.contractsList[index].status}');
                                                                          Get.to(() =>
                                                                              OutstandingPaymentsNewContract(
                                                                                contractNo: controller.contractsList[index].contractno,
                                                                                contractId: controller.contractsList[index].contractid,
                                                                              ));
                                                                        },
                                                                  child: Center(
                                                                    child:
                                                                        new Container(
                                                                      width:
                                                                          50.w,
                                                                      padding: EdgeInsets.symmetric(
                                                                          vertical: 2.5
                                                                              .w,
                                                                          horizontal:
                                                                              1.w),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: AppColors
                                                                            .blueColor,
                                                                        borderRadius:
                                                                            BorderRadius.all(Radius.circular(10.sp)),
                                                                      ),
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      child:
                                                                          Text(
                                                                        AppMetaLabels()
                                                                            .makePayment,
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              AppColors.whiteColor,
                                                                          fontFamily:
                                                                              AppFonts.graphikSemibold,
                                                                          fontSize:
                                                                              12.0.sp,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                          // Contract Sign
                                                          controller
                                                                      .contractsList[
                                                                          index]
                                                                      .stageId !=
                                                                  6
                                                              ? SizedBox()
                                                              : InkWell(
                                                                  onTap: controller.contractsList[index].isCanceled ==
                                                                              1 ||
                                                                          controller.contractsList[index].isClosed ==
                                                                              1
                                                                      ? () {
                                                                          SnakBarWidget.getSnackBarErrorBlue(
                                                                              AppMetaLabels().alert,
                                                                              AppMetaLabels().yourRequestCancelled);
                                                                        }
                                                                      : () async {
                                                                          controller
                                                                              .isEnableScreen
                                                                              .value = false;

                                                                          SessionController().setContractID(controller
                                                                              .contractsList[index]
                                                                              .contractid);
                                                                          SessionController().setContractNo(controller
                                                                              .contractsList[index]
                                                                              .contractno);
                                                                          SnakBarWidget
                                                                              .getLoadingWithColor();

                                                                          SnakBarWidget
                                                                              .getSnackBarErrorBlueWith20Sec(
                                                                            AppMetaLabels().loading,
                                                                            AppMetaLabels().generatingContractInfo,
                                                                          );

                                                                          String
                                                                              path =
                                                                              await contractDownloadController.downloadContractNew(controller.contractsList[index].contractno, false);

                                                                          controller
                                                                              .isEnableScreen
                                                                              .value = true;
                                                                          if (path !=
                                                                              null) {
                                                                            Get.closeAllSnackbars();
                                                                            setState(() {});
                                                                            Get.to(() => AuthenticateNewContract(
                                                                                contractNo: controller.contractsList[index].contractno,
                                                                                contractId: controller.contractsList[index].contractid,
                                                                                filePath: path,
                                                                                dueActionId: controller.contractsList[index].dueActionid,
                                                                                stageId: controller.contractsList[index].stageId,
                                                                                caller: 'contracts_with_actions',
                                                                                caseId: controller.contractsList[index].caseId));
                                                                          }
                                                                        },
                                                                  child: Center(
                                                                    child:
                                                                        new Container(
                                                                      width:
                                                                          50.w,
                                                                      padding: EdgeInsets.symmetric(
                                                                          vertical: 2.5
                                                                              .w,
                                                                          horizontal:
                                                                              1.w),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: AppColors
                                                                            .blueColor,
                                                                        borderRadius:
                                                                            BorderRadius.all(Radius.circular(10.sp)),
                                                                      ),
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      child:
                                                                          Text(
                                                                        AppMetaLabels()
                                                                            .signContract2,
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              AppColors.whiteColor,
                                                                          fontFamily:
                                                                              AppFonts.graphikSemibold,
                                                                          fontSize:
                                                                              12.0.sp,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                          // Municplity Approval

                                                          controller
                                                                      .contractsList[
                                                                          index]
                                                                      .stageId !=
                                                                  8
                                                              ? SizedBox()
                                                              : InkWell(
                                                                  onTap: controller.contractsList[index].isCanceled ==
                                                                              1 ||
                                                                          controller.contractsList[index].isClosed ==
                                                                              1
                                                                      ? () {
                                                                          SnakBarWidget.getSnackBarErrorBlue(
                                                                              AppMetaLabels().alert,
                                                                              AppMetaLabels().yourRequestCancelled);
                                                                        }
                                                                      : () {
                                                                          Get.to(() =>
                                                                              MunicipalApprovalNewContract(
                                                                                caller: 'contracts_with_actions',
                                                                                dueActionId: controller.contractsList[index].dueActionid,
                                                                                contractId: controller.contractsList[index].contractid,
                                                                              ));
                                                                        },
                                                                  child: Center(
                                                                    child:
                                                                        new Container(
                                                                      width:
                                                                          50.w,
                                                                      padding: EdgeInsets.symmetric(
                                                                          vertical: 2.5
                                                                              .w,
                                                                          horizontal:
                                                                              1.w),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: AppColors
                                                                            .blueColor,
                                                                        borderRadius:
                                                                            BorderRadius.all(Radius.circular(10.sp)),
                                                                      ),
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      child:
                                                                          Text(
                                                                        AppMetaLabels()
                                                                            .approveMunicipal,
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              AppColors.whiteColor,
                                                                          fontFamily:
                                                                              AppFonts.graphikSemibold,
                                                                          fontSize:
                                                                              12.0.sp,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),

                                                          // stages Information
                                                          Container(
                                                            alignment: Alignment
                                                                .center,
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 10,
                                                                    right: 10,
                                                                    bottom: 10),
                                                            margin:
                                                                EdgeInsets.only(
                                                                    top: 2.h,
                                                                    bottom:
                                                                        3.5.h,
                                                                    left: 20,
                                                                    right: 20),
                                                            decoration:
                                                                BoxDecoration(
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            255,
                                                                            249,
                                                                            235,
                                                                            1),
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .only(
                                                                      bottomLeft:
                                                                          Radius.circular(
                                                                              20),
                                                                      bottomRight:
                                                                          Radius.circular(
                                                                              0),
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              0),
                                                                      topRight:
                                                                          Radius.circular(
                                                                              20),
                                                                    )),
                                                            child: Column(
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .info,
                                                                      color: Colors
                                                                              .amber[
                                                                          300],
                                                                      size: 22,
                                                                    ),
                                                                    SizedBox(
                                                                      width: Get
                                                                              .width *
                                                                          0.03,
                                                                    ),
                                                                    Container(
                                                                      width: Get
                                                                              .width *
                                                                          0.66,
                                                                      child:
                                                                          Text(
                                                                        controller.contractsList[index].stageId ==
                                                                                1
                                                                            ? AppMetaLabels().stage1
                                                                            : controller.contractsList[index].stageId == 2
                                                                                ? AppMetaLabels().stage2
                                                                                : controller.contractsList[index].stageId == 3
                                                                                    ? AppMetaLabels().stage3
                                                                                    : controller.contractsList[index].stageId == 4
                                                                                        ? AppMetaLabels().stage4
                                                                                        : controller.contractsList[index].stageId == 5
                                                                                            ? controller.contractsList[index].isAllPaid == 1
                                                                                                ? AppMetaLabels().stage5_1
                                                                                                : AppMetaLabels().stage5
                                                                                            : controller.contractsList[index].stageId == 6
                                                                                                ? AppMetaLabels().stage6
                                                                                                : controller.contractsList[index].stageId == 7
                                                                                                    ? AppMetaLabels().stage7
                                                                                                    : controller.contractsList[index].stageId == 8
                                                                                                        ? AppMetaLabels().stage8
                                                                                                        : AppMetaLabels().stage9,
                                                                        textAlign:
                                                                            TextAlign.justify,
                                                                        style: AppTextStyle
                                                                            .normalBlack12,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          AppDivider()
                                                        ],
                                                      );
                                                    },
                                                  );
                                      }),
                                    ),
                                  ),
                                ),
                              ),

                              // Video Tutorial Tooltip
                              // Align(
                              //   alignment:
                              //       SessionController().getLanguage() == 1
                              //           ? Alignment.topRight
                              //           : Alignment.topLeft,
                              //   child: Obx(() {
                              //     // Tooltip Conditions
                              //     // will show always but just for 10 or 5 seconds
                              //     return controller.loadingContracts.value !=
                              //                 true &&
                              //             controller
                              //                     .isShowCustomToolTip.value ==
                              //                 true &&
                              //             controller.errorLoadingContracts == ''
                              //         ? Transform.translate(
                              //             offset: Offset(0, -5),
                              //             child: Container(
                              //               width: 50.w,
                              //               height: Get.height * 0.099,
                              //               margin: EdgeInsets.only(
                              //                 right: SessionController()
                              //                             .getLanguage() ==
                              //                         1
                              //                     ? 2.h
                              //                     : 0.h,
                              //                 left: SessionController()
                              //                             .getLanguage() ==
                              //                         1
                              //                     ? 0.h
                              //                     : 2.h,
                              //               ),
                              //               decoration: ShapeDecoration(
                              //                 color: Colors.white,
                              //                 shape:
                              //                     MessageBorderForVideoTutorial(),
                              //                 shadows: [
                              //                   BoxShadow(
                              //                       color: Colors.black,
                              //                       blurRadius: 4.0,
                              //                       offset: Offset(2, 2)),
                              //                 ],
                              //               ),
                              //               alignment: Alignment.center,
                              //               padding: EdgeInsets.only(
                              //                 left: 1.w,
                              //                 right: 1.w,
                              //                 top: 1.w,
                              //                 bottom: 1.w,
                              //               ),
                              //               child: RichText(
                              //                 textAlign: TextAlign.center,
                              //                 text: TextSpan(
                              //                   children: [
                              //                     TextSpan(
                              //                       text: AppMetaLabels()
                              //                               .clickabovebtnForContractTutorial +
                              //                           "  ",
                              //                       style: AppTextStyle
                              //                           .normalBlack9
                              //                           .copyWith(height: 1.2),
                              //                     ),
                              //                     TextSpan(
                              //                         text: AppMetaLabels()
                              //                             .clickHere,
                              //                         style: AppTextStyle
                              //                             .semiBoldBlue9ul
                              //                             .copyWith(
                              //                                 height: 1.2),
                              //                         recognizer:
                              //                             TapGestureRecognizer()
                              //                               ..onTap = () async {
                              //                                 setState(() {
                              //                                   SessionController()
                              //                                           .videoURl =
                              //                                       'https://vimeo.com/829328299/8b66d7dc3f';
                              //                                   SessionController()
                              //                                           .videoPathFromAsset =
                              //                                       'assets/video/FAB_8.mp4';
                              //                                 });
                              //                                 // launchUrl(Uri.parse(SessionController().videoURl),
                              //                                 //     mode: LaunchMode.externalApplication);
                              //                                 await Get.to(() =>
                              //                                     RenewalTutorialVideo(
                              //                                         path: SessionController()
                              //                                             .videoPathFromAsset //SessionController().videoPath,
                              //                                         ));
                              //                               }),
                              //                   ],
                              //                 ),
                              //               ),
                              //             ),
                              //           )
                              //         : SizedBox();
                              //   }),
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  controller.isEnableScreen.value == false
                      ? ScreenDisableWidget()
                      : SizedBox()
                ]);
              }))),
    );
  }

  renewalVideoTutorial() {
    RxBool loading = true.obs;
    base64VideoPlayPathAvailable(String path) async {
      try {
        loading.value = true;
        videoCotroller = VideoPlayerController.network(path)
          ..initialize().then((_) async {
            await videoCotroller.play();
            setState(() {});
          });
        loading.value = false;
      } catch (e) {
        loading.value = false;
        print('Exception :::::: $e');
      }
    }

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          base64VideoPlayPathAvailable(SessionController().videoPath ?? "");
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(3.h))),
              title: Transform.scale(
                alignment: Alignment.bottomCenter,
                scale: 1,
                child: Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                      onTap: () {
                        if (videoCotroller.value.isPlaying) {
                          setState(() {
                            videoCotroller.pause();
                          });
                        }
                        Navigator.of(context, rootNavigator: true)
                            .pop('dialog');
                      },
                      child: Icon(
                        Icons.cancel,
                        size: Get.height * 0.03,
                      )),
                ),
              ),
              content: Container(
                height: Get.height * 0.35,
                decoration: BoxDecoration(
                  borderRadius: new BorderRadius.all(new Radius.circular(32.0)),
                  shape: BoxShape.rectangle,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(AppMetaLabels().renewalFlow,
                          style: AppTextStyle.semiBoldBlack14),
                      Obx(() {
                        return loading.value == true
                            ? Center(child: const CircularProgressIndicator())
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      videoCotroller.value.isPlaying
                                          ? videoCotroller.pause()
                                          : videoCotroller.play();
                                      if (videoCotroller.value.isPlaying) {
                                        setState(() {
                                          videoCotroller.pause();
                                        });
                                      }
                                      setState(() {});
                                    },
                                    child: AspectRatio(
                                        aspectRatio:
                                            videoCotroller.value.aspectRatio,
                                        child: VideoPlayer(videoCotroller)),
                                  ),
                                  Container(
                                    child: VideoProgressIndicator(
                                      videoCotroller,
                                      allowScrubbing: true,
                                      colors: VideoProgressColors(
                                        backgroundColor: Colors.white24,
                                        playedColor: Colors.blue,
                                        bufferedColor: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                ],
                              );
                      }),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  InkWell inkWell(int index, BuildContext context) {
    return InkWell(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 1.5.w, vertical: 0.5.h),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                SessionController()
                    .setContractID(controller.contractsList[index].contractid);
                SessionController()
                    .setContractNo(controller.contractsList[index].contractno);
                Get.to(() => ContractsDetailsTabs(
                      prevContractNo:
                          controller.contractsList[index].previousContractNo,
                    ));
              },
              child: Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SrNoWidget(text: index + 1, size: 4.h),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 1.h, left: 1.5.h, right: 0.5.h),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 40.0.w,
                                  child: Text(
                                    SessionController().getLanguage() == 1
                                        ? controller.contractsList[index]
                                                .propertyName ??
                                            ''
                                        : controller.contractsList[index]
                                                .propertyNameAr ??
                                            '',
                                    style: AppTextStyle.semiBoldBlack12,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "${controller.contractsList[index].contractno}",
                                  style: AppTextStyle.semiBoldBlack12,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 1.0.h,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${controller.contractsList[index].fromdate}",
                                      style: AppTextStyle.normalGrey10,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 0.5.w),
                                      child: Icon(Icons.arrow_forward,
                                          size: 10.sp,
                                          color: AppColors.greyColor),
                                    ),
                                    Text(
                                      "${controller.contractsList[index].toDate}",
                                      style: AppTextStyle.normalGrey10,
                                    ),
                                  ],
                                ),
                                Spacer(),
                                ConstrainedBox(
                                  constraints: BoxConstraints(maxWidth: 27.w),
                                  child: FittedBox(
                                    child: StatusWidget(
                                      text:
                                          SessionController().getLanguage() == 1
                                              ? controller
                                                  .contractsList[index].status
                                              : controller.contractsList[index]
                                                  .statusAr,
                                      valueToCompare: controller
                                          .contractsList[index].status,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            if (controller.contractsList[index]
                                        .previousContractNo !=
                                    null &&
                                controller.contractsList[index].contractno !=
                                    controller.contractsList[index]
                                        .previousContractNo)
                              controller.contractsList[index].stageId < 4
                                  ? SizedBox()
                                  : Padding(
                                      padding: EdgeInsets.only(top: 5.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            AppMetaLabels().prevContractNo,
                                            style: AppTextStyle.normalGrey10,
                                          ),
                                          Text(
                                            controller.contractsList[index]
                                                .previousContractNo,
                                            style: AppTextStyle.semiBoldBlack10,
                                          ),
                                        ],
                                      ),
                                    )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 2.5.h),
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
              ),
            ),

            // Steps for Contracts
            Container(
              height: 7.h,
              margin: EdgeInsets.only(top: 0.h),
              padding: EdgeInsets.only(top: 2.5.h),
              // margin: EdgeInsets.only(top: 4.h),
              child: showActions(index, context),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: index == controller.contractsList.length - 1
                  ? SizedBox()
                  : SizedBox(),
            ),
          ],
        ),
      ),
    );
  }

  // Actions
  Widget showActions(int index, BuildContext context) {
    int stageId = controller.contractsList[index].stageId;
    print('Stage ID ::: $stageId at : $index');
    switch (stageId) {
      case 1:
        return expiringContractActions(index);
        break;
      case 10:
        return checkIn(index);
        break;
      default:
        return renewalActions(index, context);
    }
  }

  // Expiry
  Widget expiringContractActions(int index) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Renew
          Padding(
            padding: EdgeInsets.all(0.0.h),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3.0.sp),
                        side: BorderSide(
                          color: AppColors.blueColor,
                          width: 1.0,
                        )),
                    backgroundColor: AppColors.whiteColor,
                    shadowColor: AppColors.blueColor),
                onPressed: () {
                  Get.to(() => ContractRenewel(
                        contractNo: controller.contractsList[index].contractno,
                        contractId: controller.contractsList[index].contractid,
                        caller: 'contracts_with_actions',
                        dueActionid:
                            controller.contractsList[index].dueActionid,
                      ));
                },
                child: Text(
                  AppMetaLabels().renew,
                  style: AppTextStyle.normalBlue11,
                )),
          ),
          SizedBox(
            width: 3,
          ),
          // if (controller.contractsList[index].showExtend)
          //   Padding(
          //       padding: EdgeInsets.all(0.0.h),
          //       child: CustomButtonWithoutBackgroud(
          //         text: AppMetaLabels().extend,
          //         onPressed: () {
          //           Get.to(() => ContractExtend(
          //                 contractNo:
          //                     controller.contractsList[index].contractno,
          //                 contractId:
          //                     controller.contractsList[index].contractid,
          //                 caller: 'contracts_with_actions',
          //                 dueActionId:
          //                     controller.contractsList[index].dueActionid,
          //               ));
          //         },
          //         borderColor: AppColors.blueColor,
          //       )),
          // SizedBox(
          //   width: 3,
          // ),
          // // Vacant
          // Padding(
          //     padding: EdgeInsets.all(0.0.h),
          //     child: CustomButtonWithoutBackgroud(
          //       text: AppMetaLabels().terminate,
          //       onPressed: () {
          //         Get.to(() => ContractTerminate(
          //               contractNo: controller.contractsList[index].contractno,
          //               contractId: controller.contractsList[index].contractid,
          //               caller: 'contracts_with_actions',
          //               dueActionid:
          //                   controller.contractsList[index].dueActionid,
          //             ));
          //       },
          //       borderColor: AppColors.blueColor,
          //     )),
          // SizedBox(
          //   width: 3,
          // ),

          // showOfferLetter

          if (controller.contractsList[index].showOfferLetter == 1)
            Padding(
                padding: EdgeInsets.all(0.0.h),
                child: Obx(() {
                  return CustomButtonWithoutBackgroud(
                    loading: controller.contractsList[index].downloading.value,
                    text: AppMetaLabels().offerLetter,
                    onPressed: () async {
                      controller.isEnableScreen.value = false;
                      SnakBarWidget.getLoadingWithColor();
                      await controller
                          .downloadOfferLetter(controller.contractsList[index]);

                      setState(() {
                        controller.isEnableScreen.value = true;
                      });
                    },
                    borderColor: AppColors.blueColor,
                  );
                })),
        ]);
  }

  Widget checkIn(int index) {
    return Padding(
        padding: EdgeInsets.all(0.5.h),
        child: CustomButton(
            text: AppMetaLabels().checkin,
            onPressed: () {
              SessionController().setCaseNo(
                controller.contractsList[index].caseId.toString(),
              );
              Get.to(() => ContractCheckin(
                    contractNo: controller.contractsList[index].contractno,
                    contractId: controller.contractsList[index].contractid,
                    caller: 'contracts_with_actions',
                    dueActionId: controller.contractsList[index].dueActionid,
                    caseId: controller.contractsList[index].caseId,
                  ));
            }));
  }

  Widget renewalActions(int index, BuildContext context) {
    final ItemScrollController itemScrollController = ItemScrollController();

    int dueActionIndex = 0;
    switch (controller.contractsList[index].stageId) {
      case 2:
        dueActionIndex = 0;
        break;
      case 3:
        dueActionIndex = 1;
        break;
      case 4:
        dueActionIndex = 2;
        break;
      case 5:
        dueActionIndex = 3;
        break;
      case 6:
        dueActionIndex = 4;
        break;
      case 7:
        dueActionIndex = 5;
        break;
      case 8:
        dueActionIndex = 6;
        break;
      case 9:
        dueActionIndex = 7;
        break;
    }

    final actionList = [
      Padding(
          padding: EdgeInsets.all(0.5.h),
          child: controller.contractsList[index].stageId == 2
              // upload document contracts
              ? DueActionListButton(
                  text: AppMetaLabels().uploadDocs,
                  srNo: '1',
                  onPressed: controller.contractsList[index].isCanceled == 1 ||
                          controller.contractsList[index].isClosed == 1
                      ? () {
                          SnakBarWidget.getSnackBarErrorBlue(
                              AppMetaLabels().alert,
                              AppMetaLabels().yourRequestCancelled);
                        }
                      : () {
                          SessionController().setCaseNo(
                            controller.contractsList[index].caseId.toString(),
                          );
                          Get.to(
                            () => TenantServiceRequestTabs(
                              requestNo: controller.contractsList[index].caseId
                                  .toString(),
                              caller: 'contracts_with_actions',
                              title: AppMetaLabels().renewalReq,
                              initialIndex: 1,
                            ),
                          );
                        })
              : StepNoWidget(label: '1', tooltip: AppMetaLabels().uploadDocs)),
      Padding(
          padding: EdgeInsets.all(0.5.h),
          child: controller.contractsList[index].stageId == 3
              ? DueActionListButton(
                  text: AppMetaLabels().docsSubmitted,
                  srNo: '2',
                  onPressed: controller.contractsList[index].isCanceled == 1 ||
                          controller.contractsList[index].isClosed == 1
                      ? () {
                          SnakBarWidget.getSnackBarErrorBlue(
                              AppMetaLabels().alert,
                              AppMetaLabels().yourRequestCancelled);
                        }
                      : () {
                          SessionController().setCaseNo(
                            controller.contractsList[index].caseId.toString(),
                          );
                          Get.to(() => TenantServiceRequestTabs(
                                requestNo: controller
                                    .contractsList[index].caseId
                                    .toString(),
                                caller: 'contracts_with_actions',
                                title: AppMetaLabels().renewalReq,
                                initialIndex: 1,
                              ));
                        })
              : StepNoWidget(
                  label: '2', tooltip: AppMetaLabels().docsSubmitted)),
      Padding(
          padding: EdgeInsets.all(0.5.h),
          child: controller.contractsList[index].stageId == 4
              ? DueActionListButton(
                  text: AppMetaLabels().docsApproved,
                  srNo: '3',
                  onPressed: controller.contractsList[index].isCanceled == 1 ||
                          controller.contractsList[index].isClosed == 1
                      ? () {
                          SnakBarWidget.getSnackBarErrorBlue(
                              AppMetaLabels().alert,
                              AppMetaLabels().yourRequestCancelled);
                        }
                      : () {
                          SessionController().setCaseNo(
                            controller.contractsList[index].caseId.toString(),
                          );
                          Get.to(() => TenantServiceRequestTabs(
                                requestNo: controller
                                    .contractsList[index].caseId
                                    .toString(),
                                caller: 'contracts_with_actions',
                                title: AppMetaLabels().renewalReq,
                                initialIndex: 1,
                              ));
                        })
              : StepNoWidget(
                  label: '3', tooltip: AppMetaLabels().docsApproved)),
      Padding(
          padding: EdgeInsets.all(0.5.h),
          child: controller.contractsList[index].stageId == 5
              ? DueActionListButton(
                  text: AppMetaLabels().makePayment,
                  srNo: '4',
                  onPressed: controller.contractsList[index].isCanceled == 1 ||
                          controller.contractsList[index].isClosed == 1
                      ? () {
                          SnakBarWidget.getSnackBarErrorBlue(
                              AppMetaLabels().alert,
                              AppMetaLabels().yourRequestCancelled);
                        }
                      : () {
                          SessionController().setContractID(
                              controller.contractsList[index].contractid);
                          SessionController().setContractNo(
                              controller.contractsList[index].contractno);
                          print(
                              'Status :::::::: ${controller.contractsList[index].status}');
                          Get.to(() => OutstandingPayments(
                                contractNo:
                                    controller.contractsList[index].contractno,
                                contractId:
                                    controller.contractsList[index].contractid,
                              ));
                        })
              : StepNoWidget(label: '4', tooltip: AppMetaLabels().makePayment)),
      Padding(
          padding: EdgeInsets.all(0.5.h),
          child: controller.contractsList[index].stageId == 6
              ? Obx(() {
                  return DueActionListButton(
                      text: AppMetaLabels().signContract2,
                      srNo: '5',
                      loading: contractDownloadController.downloading.value,
                      onPressed: controller.contractsList[index].isCanceled ==
                                  1 ||
                              controller.contractsList[index].isClosed == 1
                          ? () {
                              SnakBarWidget.getSnackBarErrorBlue(
                                  AppMetaLabels().alert,
                                  AppMetaLabels().yourRequestCancelled);
                            }
                          : () async {
                              controller.isEnableScreen.value = false;

                              SessionController().setContractID(
                                  controller.contractsList[index].contractid);
                              SessionController().setContractNo(
                                  controller.contractsList[index].contractno);
                              SnakBarWidget.getLoadingWithColor();

                              await Future.delayed(Duration(seconds: 0));
                              SnakBarWidget.getSnackBarErrorBlueWith20Sec(
                                AppMetaLabels().loading,
                                AppMetaLabels().generatingContractInfo,
                              );

                              String path = await contractDownloadController
                                  .downloadContract(
                                      controller
                                          .contractsList[index].contractno,
                                      false);

                              controller.isEnableScreen.value = true;
                              if (path != null) {
                                Get.closeAllSnackbars();
                                setState(() {});
                                Get.to(() => AuthenticateContract(
                                    contractNo: controller
                                        .contractsList[index].contractno,
                                    contractId: controller
                                        .contractsList[index].contractid,
                                    filePath: path,
                                    dueActionId: controller
                                        .contractsList[index].dueActionid,
                                    stageId:
                                        controller.contractsList[index].stageId,
                                    caller: 'contracts_with_actions',
                                    caseId: controller
                                        .contractsList[index].caseId));
                              }
                            });
                })
              : StepNoWidget(
                  label: '5', tooltip: AppMetaLabels().signContract2)),
      Padding(
          padding: EdgeInsets.all(0.5.h),
          child: controller.contractsList[index].stageId == 7
              ? DueActionListButton(
                  text: AppMetaLabels().contractSigned,
                  srNo: '6',
                  onPressed: controller.contractsList[index].isCanceled == 1 ||
                          controller.contractsList[index].isClosed == 1
                      ? () {
                          SnakBarWidget.getSnackBarErrorBlue(
                              AppMetaLabels().alert,
                              AppMetaLabels().yourRequestCancelled);
                        }
                      : () {})
              : StepNoWidget(
                  label: '6', tooltip: AppMetaLabels().contractSigned)),
      Padding(
          padding: EdgeInsets.all(0.5.h),
          child: controller.contractsList[index].stageId == 8
              ? DueActionListButton(
                  text: AppMetaLabels().approveMunicipal,
                  srNo: '7',
                  onPressed: controller.contractsList[index].isCanceled == 1 ||
                          controller.contractsList[index].isClosed == 1
                      ? () {
                          SnakBarWidget.getSnackBarErrorBlue(
                              AppMetaLabels().alert,
                              AppMetaLabels().yourRequestCancelled);
                        }
                      : () {
                          Get.to(() => MunicipalApproval(
                                caller: 'contracts_with_actions',
                                dueActionId:
                                    controller.contractsList[index].dueActionid,
                                contractId:
                                    controller.contractsList[index].contractid,
                              ));
                        })
              : StepNoWidget(
                  label: '7', tooltip: AppMetaLabels().approveMunicipal)),
      Padding(
          padding: EdgeInsets.all(0.5.h),
          child: controller.contractsList[index].stageId == 9
              ? DueActionListButton(
                  text: AppMetaLabels().downloadContract,
                  srNo: '8',
                  onPressed: controller.contractsList[index].isCanceled == 1 ||
                          controller.contractsList[index].isClosed == 1
                      ? () {
                          SnakBarWidget.getSnackBarErrorBlue(
                              AppMetaLabels().alert,
                              AppMetaLabels().yourRequestCancelled);
                        }
                      : () {
                          SessionController().setContractID(
                              controller.contractsList[index].contractid);
                          Get.to(() => ContractsDetailsTabs(
                                prevContractNo: controller
                                    .contractsList[index].previousContractNo,
                              ));
                        })
              : StepNoWidget(
                  label: '8', tooltip: AppMetaLabels().downloadContract)),
    ];
    return ScrollablePositionedList.builder(
      key: SessionController().getLanguage() == 1
          ? null
          : const PageStorageKey(0),
      physics: SessionController().getLanguage() == 1
          ? NeverScrollableScrollPhysics()
          : null,
      itemScrollController: itemScrollController,
      scrollDirection: Axis.horizontal,
      itemCount: 8,
      itemBuilder: (context, index2) {
        // assing 4 if dueActionIndex > 4 because
        // dueActionIndex 6 , 7 ,8  are creating problem in ios but working in android
        // This below work will only for the english because in arabic
        // can not handle for now
        // will work on it later
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          if (itemScrollController.isAttached &&
              SessionController().getLanguage() == 1)
            itemScrollController.scrollTo(
              index: dueActionIndex > 3 ? 3 : dueActionIndex,
              duration: Duration(milliseconds: 500),
              curve: Curves.easeIn,
            );
        });
        return actionList[index2];
      },
    );
  }
}
