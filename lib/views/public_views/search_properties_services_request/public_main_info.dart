// ignore_for_file: deprecated_member_use

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/utils/text_validator.dart';
import 'package:fap_properties/views/widgets/common_widgets/custom_error_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:fap_properties/views/widgets/common_widgets/status_widget.dart';
import 'package:fap_properties/views/public_views/search_properties_properties/search_properties_result/search_properties_result_controller.dart';
import 'package:fap_properties/views/public_views/search_properties_services_request/public_save_feedback_controller.dart';
import 'package:fap_properties/views/widgets/bottom_shadow.dart';
import 'package:fap_properties/views/widgets/snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import 'public_get_feedback_controller.dart';
import 'public_services_maininfo_controller.dart';

class PublicMainInfo extends StatefulWidget {
  final int caseno;
  final int unitId;
  const PublicMainInfo({
    Key key,
    this.caseno,
    this.unitId,
  }) : super(key: key);

  @override
  _PublicMainInfoState createState() => _PublicMainInfoState();
}

class _PublicMainInfoState extends State<PublicMainInfo> {
  final sPRController = Get.put(SearchPropertiesResultController());
  TextEditingController remarkEditingController = TextEditingController();
  PublicServiceMaininfoController _mainInfoController =
      PublicServiceMaininfoController();
  PublicSaveFeedbackController _feedbackController =
      Get.put(PublicSaveFeedbackController());
  PublicGetFeedbackController _getFeedbackController =
      Get.put(PublicGetFeedbackController());
  @override
  void initState() {
    _mainInfoController.getServiceMaininfo(widget.caseno);
    _getFeedbackController.getFeedback(widget.caseno);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Stack(children: [
          BottomShadow(),
          Obx(() {
            return _mainInfoController.loadingData.value == true
                ? LoadingIndicatorBlue()
                : _mainInfoController.error.value != ''
                    ? CustomErrorWidget(
                        errorText: _mainInfoController.error.value,
                        errorImage: AppImagesPath.noServicesFound,
                      )
                    : Column(
                        children: [
                          Expanded(
                              child: SingleChildScrollView(
                                  child: Padding(
                                      padding: EdgeInsets.only(
                                        left: 2.0.w,
                                        top: 2.0.h,
                                        right: 2.0.w,
                                      ),
                                      child: Column(children: [
                                        Container(
                                          width: 100.0.w,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
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
                                          child: Padding(
                                            padding: EdgeInsets.all(2.0.h),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      AppMetaLabels()
                                                          .requestDetails,
                                                      style: AppTextStyle
                                                          .semiBoldBlack12,
                                                    ),
                                                    Spacer(),
                                                    Text(
                                                      _mainInfoController
                                                          .publicMaininfoDetails
                                                          .value
                                                          .detail
                                                          .caseNo
                                                          .toString(),
                                                      style: AppTextStyle
                                                          .semiBoldBlack10,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 1.0.h,
                                                ),
                                                Text(
                                                  SessionController()
                                                              .getLanguage() ==
                                                          1
                                                      ? _mainInfoController
                                                              .publicMaininfoDetails
                                                              .value
                                                              .detail
                                                              .category ??
                                                          ""
                                                      : _mainInfoController
                                                              .publicMaininfoDetails
                                                              .value
                                                              .detail
                                                              .categoryAr ??
                                                          "",
                                                  style:
                                                      AppTextStyle.normalGrey10,
                                                ),
                                                SizedBox(
                                                  height: 1.h,
                                                ),
                                                Text(
                                                  SessionController()
                                                              .getLanguage() ==
                                                          1
                                                      ? _mainInfoController
                                                              .publicMaininfoDetails
                                                              .value
                                                              .detail
                                                              .subCategory ??
                                                          ""
                                                      : _mainInfoController
                                                              .publicMaininfoDetails
                                                              .value
                                                              .detail
                                                              .subCategoryAR ??
                                                          "",
                                                  style:
                                                      AppTextStyle.normalGrey10,
                                                ),
                                                SizedBox(
                                                  height: 1.h,
                                                ),
                                                Text(
                                                  SessionController()
                                                              .getLanguage() ==
                                                          1
                                                      ? _mainInfoController
                                                              .publicMaininfoDetails
                                                              .value
                                                              .detail
                                                              .propertyName ??
                                                          ""
                                                      : _mainInfoController
                                                              .publicMaininfoDetails
                                                              .value
                                                              .detail
                                                              .propertyNameAr ??
                                                          "",
                                                  style:
                                                      AppTextStyle.normalGrey10,
                                                ),
                                                SizedBox(
                                                  height: 1.h,
                                                ),
                                                Text(
                                                  _mainInfoController
                                                          .publicMaininfoDetails
                                                          .value
                                                          .detail
                                                          .unitRefNo ??
                                                      "",
                                                  style: AppTextStyle
                                                      .semiBoldGrey10,
                                                ),
                                                SizedBox(
                                                  height: 1.h,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      _mainInfoController
                                                              .publicMaininfoDetails
                                                              .value
                                                              .detail
                                                              .date ??
                                                          "",
                                                      style: AppTextStyle
                                                          .normalGrey10,
                                                    ),
                                                    SizedBox(
                                                      width: 2.w,
                                                    ),
                                                    Text(
                                                      _mainInfoController
                                                              .publicMaininfoDetails
                                                              .value
                                                              .detail
                                                              .time ??
                                                          "",
                                                      style: AppTextStyle
                                                          .normalGrey10,
                                                    ),
                                                    Spacer(),
                                                    StatusWidget(
                                                      text: SessionController()
                                                                  .getLanguage() ==
                                                              1
                                                          ? _mainInfoController
                                                                  .publicMaininfoDetails
                                                                  .value
                                                                  .detail
                                                                  .status ??
                                                              ""
                                                          : _mainInfoController
                                                                  .publicMaininfoDetails
                                                                  .value
                                                                  .detail
                                                                  .statusAR ??
                                                              "",
                                                      valueToCompare:
                                                          _mainInfoController
                                                              .publicMaininfoDetails
                                                              .value
                                                              .detail
                                                              .status,
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 3.0.h,
                                        ),
                                        Container(
                                            width: 100.0.w,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
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
                                            child: Padding(
                                                padding: EdgeInsets.all(2.0.h),
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        AppMetaLabels()
                                                            .contactPersonDetails,
                                                        style: AppTextStyle
                                                            .semiBoldBlack12,
                                                      ),
                                                      SizedBox(
                                                        height: 2.0.h,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            '${AppMetaLabels().name}: ',
                                                            style: AppTextStyle
                                                                .normalGrey10,
                                                          ),
                                                          Spacer(),
                                                          Text(
                                                            _mainInfoController
                                                                    .publicMaininfoDetails
                                                                    .value
                                                                    .detail
                                                                    .otherContactPersonName ??
                                                                '',
                                                            style: AppTextStyle
                                                                .normalGrey10,
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 1.h,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            '${AppMetaLabels().phoneNumber}: ',
                                                            style: AppTextStyle
                                                                .normalGrey10,
                                                          ),
                                                          Spacer(),
                                                          Directionality(
                                                            textDirection:
                                                                TextDirection
                                                                    .ltr,
                                                            child: Text(
                                                              _mainInfoController
                                                                      .publicMaininfoDetails
                                                                      .value
                                                                      .detail
                                                                      .otherContactPersonMobile ??
                                                                  '-',
                                                              style: AppTextStyle
                                                                  .normalGrey10,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ]))),
                                        SizedBox(
                                          height: 3.0.h,
                                        ),
                                        Container(
                                          width: 100.0.w,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
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
                                          child: Padding(
                                            padding: EdgeInsets.all(2.0.h),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  AppMetaLabels().description,
                                                  style: AppTextStyle
                                                      .semiBoldBlack12,
                                                ),
                                                SizedBox(
                                                  height: 1.0.h,
                                                ),
                                                Text(
                                                  _mainInfoController
                                                          .publicMaininfoDetails
                                                          .value
                                                          .detail
                                                          .description ??
                                                      "-",
                                                  style:
                                                      AppTextStyle.normalGrey10,
                                                ),
                                                SizedBox(
                                                  height: 2.0.h,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 2.5.h,
                                        ),
                                        _getFeedbackController.getPublicfeedback.value
                                                        .feedback !=
                                                    null &&
                                                _getFeedbackController
                                                        .getPublicfeedback
                                                        .value
                                                        .feedback
                                                        .rating !=
                                                    0.0 &&
                                                _getFeedbackController
                                                        .getPublicfeedback
                                                        .value
                                                        .feedback
                                                        .rating !=
                                                    null
                                            ? Container(
                                                width: 100.0.w,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          2.0.h),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black12,
                                                      blurRadius: 0.5.h,
                                                      spreadRadius: 0.1.h,
                                                      offset:
                                                          Offset(0.1.h, 0.1.h),
                                                    ),
                                                  ],
                                                ),
                                                child: Padding(
                                                  padding:
                                                      EdgeInsets.all(2.0.h),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        AppMetaLabels()
                                                            .feedback,
                                                        style: AppTextStyle
                                                            .semiBoldBlack12,
                                                      ),
                                                      SizedBox(
                                                        height: 1.5.h,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 0.5.w,
                                                                right: 2.0.w),
                                                        child: SmoothStarRating(
                                                          color: AppColors
                                                              .blueColor,
                                                          borderColor: AppColors
                                                              .blueColor,
                                                          rating: _getFeedbackController
                                                                  .getPublicfeedback
                                                                  .value
                                                                  .feedback
                                                                  .rating ??
                                                              0,
                                                          isReadOnly: true,
                                                          size: 5.5.h,
                                                          filledIconData:
                                                              Icons.star,
                                                          halfFilledIconData:
                                                              Icons.star_half,
                                                          defaultIconData:
                                                              Icons.star_border,
                                                          starCount: 5,
                                                          allowHalfRating: true,
                                                          spacing: 2.0.w,
                                                          onRated: (value) {
                                                            _getFeedbackController
                                                                .getPublicfeedback
                                                                .value
                                                                .feedback
                                                                .rating = value;
                                                            print(
                                                                "rating value -> $value");

                                                            // print("rating value dd -> ${value.truncate()}");
                                                          },
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 2.0.h,
                                                                left: 2.0.w),
                                                        child: Text(
                                                          _getFeedbackController
                                                                  .getPublicfeedback
                                                                  .value
                                                                  .feedback
                                                                  .description ??
                                                              "-",
                                                          style: AppTextStyle
                                                              .normalGrey10,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            : SizedBox(height: 2.0.h),
                                        _mainInfoController
                                                    .publicMaininfoDetails
                                                    .value
                                                    .caseStatus
                                                    .canCancel ==
                                                true
                                            ? Padding(
                                                padding:
                                                    EdgeInsets.only(top: 2.5.h),
                                                child: Obx(() {
                                                  return _mainInfoController
                                                          .cancellingRequest
                                                          .value
                                                      ? LoadingIndicatorBlue()
                                                      : SizedBox(
                                                          height: 6.5.h,
                                                          width: 90.0.w,
                                                          child: ElevatedButton(
                                                              style:
                                                                  ElevatedButton
                                                                      .styleFrom(
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              1.3.h),
                                                                ),
                                                                backgroundColor:
                                                                    Color
                                                                        .fromRGBO(
                                                                            255,
                                                                            36,
                                                                            27,
                                                                            1),
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            6.0
                                                                                .h,
                                                                        vertical:
                                                                            1.8.h),
                                                              ),
                                                              onPressed: () {
                                                                AwesomeDialog(
                                                                  context:
                                                                      context,
                                                                  animType:
                                                                      AnimType
                                                                          .SCALE,
                                                                  dialogType:
                                                                      DialogType
                                                                          .NO_HEADER,
                                                                  body: Center(
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        Padding(
                                                                          padding:
                                                                              EdgeInsets.all(2.0.h),
                                                                          child:
                                                                              Container(
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: Color.fromRGBO(255, 36, 27, 0.1),
                                                                              shape: BoxShape.circle,
                                                                            ),
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsets.all(1.7.h),
                                                                              child: Icon(
                                                                                Icons.info_outline,
                                                                                color: Colors.red,
                                                                                size: 3.5.h,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding:
                                                                              EdgeInsets.all(2.0.h),
                                                                          child:
                                                                              Text(
                                                                            AppMetaLabels().areYouSure,
                                                                            style:
                                                                                AppTextStyle.semiBoldBlack12,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  dialogBorderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              2.0.h),
                                                                  btnOk: Column(
                                                                    children: [
                                                                      Center(
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              EdgeInsets.all(1.0.h),
                                                                          child:
                                                                              ElevatedButton(
                                                                            style:
                                                                                ElevatedButton.styleFrom(
                                                                              shape: RoundedRectangleBorder(
                                                                                borderRadius: BorderRadius.circular(1.3.h),
                                                                              ),
                                                                              backgroundColor: Color.fromRGBO(255, 36, 27, 1),
                                                                              padding: EdgeInsets.symmetric(horizontal: 11.0.h, vertical: 1.8.h),
                                                                            ),
                                                                            onPressed:
                                                                                () {
                                                                              _mainInfoController.cancelRequest(widget.caseno);
                                                                              Navigator.pop(context);
                                                                            },
                                                                            child:
                                                                                Text(
                                                                              AppMetaLabels().yes,
                                                                              style: AppTextStyle.semiBoldWhite11,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Center(
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              EdgeInsets.all(1.0.h),
                                                                          child:
                                                                              OutlinedButton(
                                                                            onPressed:
                                                                                () {
                                                                              Navigator.pop(context);
                                                                            },
                                                                            style:
                                                                                OutlinedButton.styleFrom(
                                                                              side: BorderSide(
                                                                                width: 0.2.w,
                                                                                color: Color.fromRGBO(0, 61, 166, 1),
                                                                                style: BorderStyle.solid,
                                                                              ),
                                                                              shape: RoundedRectangleBorder(
                                                                                borderRadius: new BorderRadius.circular(1.3.h),
                                                                              ),
                                                                            ),
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsets.symmetric(horizontal: 9.0.h, vertical: 1.7.h),
                                                                              child: Text(
                                                                                AppMetaLabels().no,
                                                                                style: AppTextStyle.semiBoldWhite12.copyWith(
                                                                                  color: Color.fromRGBO(0, 61, 166, 1),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                )..show();

                                                                // Get.to(() => TenantFeedback());
                                                              },
                                                              child: Text(
                                                                AppMetaLabels()
                                                                    .cancelRequest,
                                                                style: AppTextStyle
                                                                    .semiBoldWhite12,
                                                              )));
                                                }))
                                            : SizedBox(),
                                        SizedBox(
                                          height: 2.5.h,
                                        ),
                                        if (_mainInfoController
                                                    .publicMaininfoDetails
                                                    .value
                                                    .caseStatus
                                                    .canAddFeedback ==
                                                true &&
                                            _getFeedbackController
                                                    .getPublicfeedback
                                                    .value
                                                    .feedback
                                                    .rating ==
                                                0.0)
                                          Container(
                                            height: 6.5.h,
                                            width: 90.0.w,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                FocusScope.of(context)
                                                    .unfocus();
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return SizedBox(
                                                        width: 100.w,
                                                        child: AlertDialog(
                                                            contentPadding:
                                                                EdgeInsets
                                                                    .fromLTRB(
                                                                        1.0.w,
                                                                        1.0.h,
                                                                        1.0.w,
                                                                        1.0.h),
                                                            backgroundColor:
                                                                Colors
                                                                    .transparent,
                                                            content:
                                                                showDialogData()),
                                                      );
                                                    });
                                                // Get.to(()=>ContractTerminate());
                                              },
                                              child: Text(
                                                AppMetaLabels().addFeedback,
                                                style: AppTextStyle
                                                    .semiBoldWhite12,
                                              ),
                                              style: ButtonStyle(
                                                  elevation:
                                                      MaterialStateProperty.all<
                                                          double>(0.0),
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                              Color>(
                                                          AppColors.blueColor),
                                                  shape:
                                                      MaterialStateProperty.all<
                                                          RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              2.0.w),
                                                      // side: BorderSide(
                                                      //   color: AppColors.blueColor,
                                                      //   width: 1.0,
                                                      // )
                                                    ),
                                                  )),
                                            ),
                                          ),
                                      ])))),
                        ],
                      );

            // :SizedBox()
          })
        ]));
  }

  Widget showDialogData() {
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppMetaLabels().rateExperience,
                    style: AppTextStyle.semiBoldBlack12,
                  ),
                  InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(
                        Icons.cancel_outlined,
                        size: 3.5.h,
                        color: AppColors.greyColor,
                      ))
                  // Image.asset(
                  //  AppImagesPath.cancelimg,
                  //   height: 4.0.h,
                  //   fit: BoxFit.contain,
                  // ),
                ],
              ),
              SizedBox(
                height: 3.0.h,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  AppMetaLabels().areyouSatisfied,
                  style: AppTextStyle.normalBlack10,
                ),
              ),
              SizedBox(
                height: 5.0.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 2.0.w, right: 2.0.w),
                child: SmoothStarRating(
                  color: AppColors.blueColor,
                  borderColor: AppColors.blueColor,
                  rating: 0,
                  isReadOnly: false,
                  size: 6.0.h,
                  filledIconData: Icons.star,
                  halfFilledIconData: Icons.star_half,
                  defaultIconData: Icons.star_border,
                  starCount: 5,
                  allowHalfRating: true,
                  spacing: 2.0.w,
                  onRated: (value) {
                    _feedbackController.rating.value = value;
                    print("rating value -> $value");
                    // print("rating value dd -> ${value.truncate()}");
                  },
                ),
              ),
              SizedBox(
                height: 3.0.h,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  AppMetaLabels().tellUs,
                  style: AppTextStyle.semiBoldBlack10
                      .copyWith(color: AppColors.renewelgreyclr1),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 3.0.h,
              ),
              SizedBox(
                height: 12.0.h,
                width: 90.0.w,
                child: TextFormField(
                    maxLines: 3,
                    textAlign: TextAlign.start,
                    controller: remarkEditingController,
                    validator: (value) {
                      var feedBack = value;
                      feedBack = feedBack.replaceAll('\n', ' ');
                      print('FeedBack :::: $feedBack');
                      if (feedBack.isEmpty) {
                        return AppMetaLabels().requiredField;
                      } else if (!textValidator
                          .hasMatch(feedBack.replaceAll('\n', ' '))) {
                        return AppMetaLabels().invalidText;
                      } else if (feedBack.isEmpty == true) {
                        return AppMetaLabels().invalidText;
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      hintText: AppMetaLabels().enterRemarks,
                      hintStyle: AppTextStyle.normalGrey9,
                      border: InputBorder.none,
                      fillColor: AppColors.greyBG,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: AppColors.whiteColor,
                          width: 1.0,
                        ),
                      ),
                    )),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5.0.h, bottom: 2.0.h),
                child: Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: 6.0.h,
                    width: 65.0.w,
                    child: Obx(() {
                      return _feedbackController.loadingData.value
                          ? LoadingIndicatorBlue()
                          : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(1.3.h),
                                ),
                                backgroundColor: Color.fromRGBO(0, 61, 166, 1),
                              ),
                              onPressed: () async {
                                if (remarkEditingController.text != "" &&
                                    _feedbackController.rating.value != 0.0) {
                                  bool feedbackAdded =
                                      await _feedbackController.saveFeedback(
                                          remarkEditingController.text,
                                          widget.caseno);
                                  if (feedbackAdded) {
                                    Get.snackbar(
                                      AppMetaLabels().added,
                                      _feedbackController
                                          .savePublicfeedback.value.message,
                                      backgroundColor: Colors.white,
                                    );
                                    Navigator.pop(context);
                                  } else {
                                    SnakBarWidget.getSnackBarErrorBlue(
                                      AppMetaLabels().error,
                                      AppMetaLabels().anyError,
                                    );
                                  }
                                }
                              },
                              child: Text(
                                AppMetaLabels().submit,
                                style: AppTextStyle.semiBoldWhite12,
                              ),
                            );
                    }),
                  ),
                ),
              )
            ]));
  }
}
