import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:contained_tab_bar_view_with_custom_page_navigator/contained_tab_bar_view_with_custom_page_navigator.dart';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/utils/styles/tooltip_custom.dart';
import 'package:fap_properties/video/renewal_tutorial.dart';
import 'package:fap_properties/views/tenant/contract_flows/contract_flows_controller.dart';
import 'package:fap_properties/views/tenant/tenant_contracts/contracts_with_action/contracts_with_actions.dart';
import 'package:fap_properties/views/tenant/tenant_contracts/contracts_with_action/contracts_with_actions_controller.dart';
import 'package:fap_properties/views/tenant/tenant_New_contract/contracts_new_action/contracts_new_actions_controller.dart';
import 'package:fap_properties/views/widgets/common_widgets/backbround_concave.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/gestures.dart';

class ContractsFLowTabs extends StatefulWidget {
  final String? prevContractNo;
  const ContractsFLowTabs({
    super.key,
    this.prevContractNo,
  });

  @override
  State<ContractsFLowTabs> createState() => _ContractsFLowTabsState();
}

class _ContractsFLowTabsState extends State<ContractsFLowTabs> {
  final controller = Get.put(ContractFlowsTabsController());
  final ContractsWithActionsController controllerRenewalController =
      Get.put(ContractsWithActionsController());
  final ContractEndActionsController contractEndActionsController =
      Get.put(ContractEndActionsController());

  @override
  Widget build(BuildContext context) {
    setState(() {});
    return Directionality(
      textDirection: SessionController().getLanguage() == 1
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              const AppBackgroundConcave(),
              Obx((() => SafeArea(
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: 2.0.h,
                                left: 4.w,
                                right: 4.w,
                                bottom: 0.5.h,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Get.back();
                                    },
                                    child: const Icon(
                                      Icons.arrow_back_ios,
                                      color: Colors.white,
                                    ),
                                  ),
                                  // Contracts
                                  Text(
                                    AppMetaLabels().contracts,
                                    style: AppTextStyle.semiBoldWhite15,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (controller.tabIndex.value == 0) {
                                        WidgetsBinding.instance
                                            .addPostFrameCallback((_) {
                                          controllerRenewalController
                                              .getContracts();
                                        });
                                      } else {
                                        contractEndActionsController
                                            .getContractsNew();
                                      }
                                    },
                                    child: const Icon(
                                      Icons.refresh_rounded,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            if (controller.tabIndex.value == 0)
                              controllerRenewalController
                                          .loadingContracts.value ==
                                      true
                                  ? SizedBox(
                                      height: 3.h,
                                    )
                                  : controllerRenewalController
                                              .errorLoadingContracts !=
                                          ''
                                      ? const SizedBox()
                                      : SessionController().isFabApp == 2
                                          ? const SizedBox()
                                          : Padding(
                                              padding: EdgeInsets.only(
                                                  left: 0.5.w, right: 4.5.w),
                                              child: Align(
                                                alignment: SessionController()
                                                            .getLanguage() ==
                                                        1
                                                    ? Alignment.topRight
                                                    : Alignment.topLeft,
                                                child: InkWell(
                                                  onTap: () async {
                                                    setState(() {
                                                      SessionController()
                                                              .videoURl =
                                                          'https://vimeo.com/829328299/8b66d7dc3f';
                                                      SessionController()
                                                              .videoPathFromAsset =
                                                          'assets/video/FAB_8.mp4';
                                                    });
                                                    // launchUrl(Uri.parse(SessionController().videoURl),
                                                    //     mode: LaunchMode.externalApplication);
                                                    await Get.to(() =>
                                                        RenewalTutorialVideo(
                                                          path: SessionController()
                                                              .videoPathFromAsset,
                                                        ));
                                                  },
                                                  child: Container(
                                                    width: SessionController()
                                                                .getLanguage() ==
                                                            1
                                                        ? 48.w
                                                        : 40.w,
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Colors.transparent,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4)),
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons.play_arrow,
                                                          color: Colors.white,
                                                          size: 3.h,
                                                        ),
                                                        InkWell(
                                                          onTap: () async {
                                                            setState(() {
                                                              SessionController()
                                                                      .videoURl =
                                                                  'https://vimeo.com/829328299/8b66d7dc3f';
                                                              SessionController()
                                                                      .videoPathFromAsset =
                                                                  'assets/video/FAB_8.mp4';
                                                            });
                                                            // launchUrl(Uri.parse(SessionController().videoURl),
                                                            //     mode: LaunchMode.externalApplication);
                                                            await Get.to(() =>
                                                                RenewalTutorialVideo(
                                                                  path: SessionController()
                                                                      .videoPathFromAsset,
                                                                ));
                                                          },
                                                          child: SizedBox(
                                                            height: 2.h,
                                                            width: SessionController()
                                                                        .getLanguage() ==
                                                                    1
                                                                ? 41.w
                                                                : 33.w,
                                                            child: Center(
                                                              child:
                                                                  AnimatedTextKit(
                                                                isRepeatingAnimation:
                                                                    true,
                                                                repeatForever:
                                                                    true,
                                                                onTap:
                                                                    () async {
                                                                  setState(() {
                                                                    SessionController()
                                                                            .videoURl =
                                                                        'https://vimeo.com/829328299/8b66d7dc3f';
                                                                    SessionController()
                                                                            .videoPathFromAsset =
                                                                        'assets/video/FAB_8.mp4';
                                                                  });
                                                                  // launchUrl(Uri.parse(SessionController().videoURl),
                                                                  //     mode: LaunchMode.externalApplication);
                                                                  await Get.to(() =>
                                                                      RenewalTutorialVideo(
                                                                        path: SessionController()
                                                                            .videoPathFromAsset,
                                                                      ));
                                                                },
                                                                pause:const Duration(
                                                                    milliseconds:
                                                                        3),
                                                                animatedTexts: [
                                                                  ColorizeAnimatedText(
                                                                      AppMetaLabels()
                                                                          .renewalTutorialForContract,
                                                                      textStyle:
                                                                          AppTextStyle
                                                                              .normalWhite10,
                                                                      colors: [
                                                                        Colors
                                                                            .white,
                                                                        Colors
                                                                            .grey,
                                                                        Colors
                                                                            .white,
                                                                      ],
                                                                      speed:const Duration(
                                                                          milliseconds:
                                                                              100)),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                            if (controller.tabIndex.value == 1)
                              contractEndActionsController
                                          .loadingContracts.value ==
                                      true
                                  ? SizedBox(
                                      height: 3.h,
                                    )
                                  : contractEndActionsController
                                              .errorLoadingContracts !=
                                          ''
                                      ? const SizedBox()
                                      : Padding(
                                          padding: EdgeInsets.only(
                                              left: 0.5.w, right: 4.5.w),
                                          child: Align(
                                            alignment: SessionController()
                                                        .getLanguage() ==
                                                    1
                                                ? Alignment.topRight
                                                : Alignment.topLeft,
                                            child: InkWell(
                                              onTap: () async {
                                                setState(() {
                                                  SessionController().videoURl =
                                                      'https://vimeo.com/829328299/8b66d7dc3f';
                                                  SessionController()
                                                          .videoPathFromAsset =
                                                      'assets/video/FAB_8.mp4';
                                                });
                                                // launchUrl(Uri.parse(SessionController().videoURl),
                                                //     mode: LaunchMode.externalApplication);
                                                await Get.to(
                                                    () => RenewalTutorialVideo(
                                                          path: SessionController()
                                                              .videoPathFromAsset,
                                                        ));
                                              },
                                              child: Container(
                                                width: SessionController()
                                                            .getLanguage() ==
                                                        1
                                                    ? 48.w
                                                    : 50.w,
                                                decoration: BoxDecoration(
                                                    color: Colors.transparent,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4)),
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.play_arrow,
                                                      color: Colors.white,
                                                      size: 3.h,
                                                    ),
                                                    InkWell(
                                                      onTap: () async {
                                                        setState(() {
                                                          SessionController()
                                                                  .videoURl =
                                                              'https://vimeo.com/829328299/8b66d7dc3f';
                                                          SessionController()
                                                                  .videoPathFromAsset =
                                                              'assets/video/FAB_8.mp4';
                                                        });
                                                        // launchUrl(Uri.parse(SessionController().videoURl),
                                                        //     mode: LaunchMode.externalApplication);
                                                        await Get.to(() =>
                                                            RenewalTutorialVideo(
                                                              path: SessionController()
                                                                  .videoPathFromAsset,
                                                            ));
                                                      },
                                                      child: SizedBox(
                                                        height: 2.h,
                                                        width: SessionController()
                                                                    .getLanguage() ==
                                                                1
                                                            ? 41.w
                                                            : 33.w,
                                                        child: Center(
                                                          child:
                                                              AnimatedTextKit(
                                                            isRepeatingAnimation:
                                                                true,
                                                            repeatForever: true,
                                                            onTap: () async {
                                                              setState(() {
                                                                SessionController()
                                                                        .videoURl =
                                                                    'https://vimeo.com/829328299/8b66d7dc3f';
                                                                SessionController()
                                                                        .videoPathFromAsset =
                                                                    'assets/video/FAB_8.mp4';
                                                              });
                                                              // launchUrl(Uri.parse(SessionController().videoURl),
                                                              //     mode: LaunchMode.externalApplication);
                                                              await Get.to(() =>
                                                                  RenewalTutorialVideo(
                                                                    path: SessionController()
                                                                        .videoPathFromAsset,
                                                                  ));
                                                            },
                                                            pause: const Duration(
                                                                milliseconds:
                                                                    3),
                                                            animatedTexts: [
                                                              ColorizeAnimatedText(
                                                                  AppMetaLabels()
                                                                      .newTutorialForContract,
                                                                  textStyle:
                                                                      AppTextStyle
                                                                          .semiBoldWhite10,
                                                                  colors: [
                                                                    Colors
                                                                        .white,
                                                                    Colors.grey,
                                                                    Colors
                                                                        .white,
                                                                  ],
                                                                  speed: const Duration(
                                                                      milliseconds:
                                                                          100)),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                            Expanded(
                              child: Stack(
                                children: [
                                  Column(
                                    children: [
                                      Expanded(
                                        child: ContainedTabBarView(
                                          tabBarViewProperties:
                                              const TabBarViewProperties(
                                                  physics:
                                                      NeverScrollableScrollPhysics()),
                                          tabs: [
                                            Tab(
                                                text: AppMetaLabels()
                                                    .renewalFlowText),
                                            // Tab(text: 'New Flow'),
                                          ],
                                          tabBarProperties: TabBarProperties(
                                            height: 4.0.h,
                                            indicatorColor:
                                                AppColors.whiteColor,
                                            indicatorWeight: 0.5.h,
                                            labelColor: AppColors.whiteColor,
                                            unselectedLabelColor:
                                                AppColors.whiteColor,
                                            unselectedLabelStyle: const TextStyle(
                                                fontWeight: FontWeight.normal),
                                            isScrollable: false,
                                            labelStyle:
                                                AppTextStyle.semiBoldBlack11,
                                          ),
                                          views: const [
                                            ContractsWithAction(),
                                            // ContractNewAction(),
                                          ],
                                          onChange: (value) {
                                            setState(() {
                                              controller.tabIndex.value = value;
                                            });
                                            print(
                                                'value :::: ${controller.tabIndex}');
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  controller.tabIndex.value == 0
                                      ? Align(
                                          alignment: SessionController()
                                                      .getLanguage() ==
                                                  1
                                              ? Alignment.topRight
                                              : Alignment.topLeft,
                                          child: Obx(() {
                                            // Tooltip Conditions
                                            // for hidding tooltip i just change the seconds from 5 to -1
                                            // if we want to show it we just need to udate seconds in ContractsWithActionsController
                                            // will show always but just for 10 or 5 seconds
                                            return controllerRenewalController
                                                            .loadingContracts
                                                            .value !=
                                                        true &&
                                                    controllerRenewalController
                                                            .isShowCustomToolTip
                                                            .value ==
                                                        true &&
                                                    controllerRenewalController
                                                            .errorLoadingContracts ==
                                                        ''
                                                ? Transform.translate(
                                                    offset: const Offset(0, -5),
                                                    child: Container(
                                                      width: 50.w,
                                                      height:
                                                          Get.height * 0.075,
                                                      margin: EdgeInsets.only(
                                                        right: SessionController()
                                                                    .getLanguage() ==
                                                                1
                                                            ? 2.h
                                                            : 0.h,
                                                        left: SessionController()
                                                                    .getLanguage() ==
                                                                1
                                                            ? 0.h
                                                            : 2.h,
                                                      ),
                                                      decoration:
                                                          const ShapeDecoration(
                                                        color: Colors.white,
                                                        shape:
                                                            MessageBorderForVideoTutorial(),
                                                        shadows: [
                                                          BoxShadow(
                                                              color:
                                                                  Colors.black,
                                                              blurRadius: 4.0,
                                                              offset:
                                                                  Offset(2, 2)),
                                                        ],
                                                      ),
                                                      alignment:
                                                          Alignment.center,
                                                      padding: EdgeInsets.only(
                                                        left: 1.w,
                                                        right: 1.w,
                                                        top: 0.5.h,
                                                      ),
                                                      child: RichText(
                                                        textAlign:
                                                            TextAlign.center,
                                                        text: TextSpan(
                                                          children: [
                                                            TextSpan(
                                                              text: "${AppMetaLabels()
                                                                      .clickabovebtnForContractRenewalTutorial}  ",
                                                              style: AppTextStyle
                                                                  .normalBlack9
                                                                  .copyWith(
                                                                      height:
                                                                          1),
                                                            ),
                                                            TextSpan(
                                                                text: AppMetaLabels()
                                                                    .clickHere,
                                                                style: AppTextStyle
                                                                    .semiBoldBlue9ul
                                                                    .copyWith(
                                                                        height:
                                                                            1.2),
                                                                recognizer:
                                                                    TapGestureRecognizer()
                                                                      ..onTap =
                                                                          () async {
                                                                        setState(
                                                                            () {
                                                                          SessionController().videoURl =
                                                                              'https://vimeo.com/829328299/8b66d7dc3f';
                                                                          SessionController().videoPathFromAsset =
                                                                              'assets/video/FAB_8.mp4';
                                                                        });
                                                                        // launchUrl(Uri.parse(SessionController().videoURl),
                                                                        //     mode: LaunchMode.externalApplication);
                                                                        await Get.to(() => RenewalTutorialVideo(
                                                                            path:
                                                                                SessionController().videoPathFromAsset //SessionController().videoPath,
                                                                            ));
                                                                      }),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : const SizedBox();
                                          }),
                                        )
                                      : Align(
                                          alignment: SessionController()
                                                      .getLanguage() ==
                                                  1
                                              ? Alignment.topRight
                                              : Alignment.topLeft,
                                          child: Obx(() {
                                            // Tooltip Conditions
                                            // will show always but just for 10 or 5 seconds
                                            return contractEndActionsController
                                                            .loadingContracts
                                                            .value !=
                                                        true &&
                                                    contractEndActionsController
                                                            .isShowCustomToolTip
                                                            .value ==
                                                        true &&
                                                    contractEndActionsController
                                                            .errorLoadingContracts ==
                                                        ''
                                                ? Transform.translate(
                                                    offset: const Offset(0, -5),
                                                    child: Container(
                                                      width: 50.w,
                                                      height:
                                                          Get.height * 0.075,
                                                      margin: EdgeInsets.only(
                                                        right: SessionController()
                                                                    .getLanguage() ==
                                                                1
                                                            ? 2.h
                                                            : 0.h,
                                                        left: SessionController()
                                                                    .getLanguage() ==
                                                                1
                                                            ? 0.h
                                                            : 2.h,
                                                      ),
                                                      decoration:
                                                          const ShapeDecoration(
                                                        color: Colors.white,
                                                        shape:
                                                            MessageBorderForVideoTutorial(),
                                                        shadows: [
                                                          BoxShadow(
                                                              color:
                                                                  Colors.black,
                                                              blurRadius: 4.0,
                                                              offset:
                                                                  Offset(2, 2)),
                                                        ],
                                                      ),
                                                      alignment:
                                                          Alignment.center,
                                                      padding: EdgeInsets.only(
                                                        left: 1.w,
                                                        right: 1.w,
                                                        top: 0.5.h,
                                                      ),
                                                      child: RichText(
                                                        textAlign:
                                                            TextAlign.center,
                                                        text: TextSpan(
                                                          children: [
                                                            TextSpan(
                                                              text: "${AppMetaLabels()
                                                                      .clickabovebtnForContractNewTutorial}  ",
                                                              style: AppTextStyle
                                                                  .normalBlack9
                                                                  .copyWith(
                                                                      height:
                                                                          1),
                                                            ),
                                                            TextSpan(
                                                                text: AppMetaLabels()
                                                                    .clickHere,
                                                                style: AppTextStyle
                                                                    .semiBoldBlue9ul
                                                                    .copyWith(
                                                                        height:
                                                                            1.2),
                                                                recognizer:
                                                                    TapGestureRecognizer()
                                                                      ..onTap =
                                                                          () async {
                                                                        setState(
                                                                            () {
                                                                          SessionController().videoURl =
                                                                              'https://vimeo.com/829328299/8b66d7dc3f';
                                                                          SessionController().videoPathFromAsset =
                                                                              'assets/video/FAB_8.mp4';
                                                                        });
                                                                        // launchUrl(Uri.parse(SessionController().videoURl),
                                                                        //     mode: LaunchMode.externalApplication);
                                                                        await Get.to(() => RenewalTutorialVideo(
                                                                            path:
                                                                                SessionController().videoPathFromAsset //SessionController().videoPath,
                                                                            ));
                                                                      }),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : const SizedBox();
                                          }),
                                        ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ))),
            ],
          )),
    );
  }
}
