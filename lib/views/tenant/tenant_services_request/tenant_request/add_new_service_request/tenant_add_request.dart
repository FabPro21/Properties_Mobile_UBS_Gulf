import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/text_field_style.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/utils/text_validator.dart';
import 'package:fap_properties/views/widgets/common_widgets/custom_error_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/error_text_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:fap_properties/views/tenant/tenant_services_request/tenant_request/add_new_service_request/get_contact_timing/get_contact_timing.dart';
import 'package:fap_properties/views/tenant/tenant_services_request/tenant_request/add_new_service_request/tenant_add_request_controller.dart';
import 'package:fap_properties/views/widgets/snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:sizer/sizer.dart';
import '../../../../../data/helpers/session_controller.dart';
import 'get_tenant_properties/get_tenant_properties.dart';
import 'get_tenant_properties/get_tenant_properties_controller.dart';
import 'tenant_case_category/tenant_case_category.dart';
import 'tenant_sub_case_category/tenant_sub_case_category.dart';
import 'package:flutter/services.dart';

class TenantAddServicesRequest extends StatefulWidget {
  const TenantAddServicesRequest({Key key}) : super(key: key);

  @override
  State<TenantAddServicesRequest> createState() =>
      _TenantAddServicesRequestState();
}

class _TenantAddServicesRequestState extends State<TenantAddServicesRequest> {
  final tASRController = Get.put(TenantAddServicesRequestController());
  GetTenantPropertiesController propertiesController =
      Get.put(GetTenantPropertiesController());
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  final FocusNode _nodeTextMobile = FocusNode();
  final FocusNode _nodeTextReqDetails = FocusNode();
  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
        keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
        keyboardBarColor: Colors.grey[200],
        nextFocus: true,
        actions: [
          KeyboardActionsItem(
            focusNode: _nodeTextMobile,
          ),
          KeyboardActionsItem(
            focusNode: _nodeTextReqDetails,
          ),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: SessionController().getLanguage() == 1
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Obx(() {
        return Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
              ),
              iconSize: 2.0.h,
              onPressed: () {
                Get.back();
              },
            ),
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  image: AssetImage(
                    AppImagesPath.appbarimg,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              AppMetaLabels().newRequestSmall,
              style: AppTextStyle.semiBoldWhite14,
            ),
          ),
          body: propertiesController.loadingData.value
              ? LoadingIndicatorBlue()
              : propertiesController.error.value != ''
                  ? AppErrorWidget(
                      errorText: propertiesController.error.value,
                    )
                  : propertiesController
                              .getTenantProperties.value.properties.length ==
                          0
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomErrorWidget(
                            errorText: AppMetaLabels().cannotAddSvcReq,
                          ),
                        )
                      : Form(
                          key: formKey,
                          child: Column(
                            children: [
                              Expanded(
                                child: KeyboardActions(
                                  config: _buildConfig(context),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(2.0.h),
                                        child: Container(
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
                                                /////////////////////////////
                                                ///
                                                /// Case Category
                                                ///
                                                /////////////////////////////
                                                if (tASRController
                                                        .serviceType.value !=
                                                    '')
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        AppMetaLabels().sRType,
                                                        style: AppTextStyle
                                                            .normalGrey10,
                                                      ),
                                                      SizedBox(
                                                        height: 1.h,
                                                      ),
                                                      Container(
                                                          width: 100.0.w,
                                                          height: 5.0.h,
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 1.5.h,
                                                                  right: 1.5.h),
                                                          decoration:
                                                              BoxDecoration(
                                                            color:
                                                                Color.fromRGBO(
                                                                    246,
                                                                    248,
                                                                    249,
                                                                    1),
                                                            border: tASRController
                                                                        .invalidInput
                                                                        .value &&
                                                                    tASRController
                                                                            .caseCategoryId
                                                                            .value ==
                                                                        ''
                                                                ? Border.all(
                                                                    color: Colors
                                                                        .red)
                                                                : null,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        0.5.h),
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                tASRController
                                                                    .serviceType
                                                                    .value,
                                                                style: AppTextStyle
                                                                    .normalGrey10,
                                                              ),
                                                            ],
                                                          )),
                                                      SizedBox(
                                                        height: 2.0.h,
                                                      ),
                                                    ],
                                                  ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      '${AppMetaLabels().category} *',
                                                      style: AppTextStyle
                                                          .normalGrey10,
                                                    ),
                                                    SizedBox(
                                                      height: 1.0.h,
                                                    ),
                                                    InkWell(
                                                      onTap: () async {
                                                        var caseCategoryResult =
                                                            await Get.to(() =>
                                                                TenantCaseCategory());
                                                        if (caseCategoryResult !=
                                                            null) {
                                                          tASRController
                                                                  .caseCategoryName
                                                                  .value =
                                                              caseCategoryResult[
                                                                  0];
                                                          tASRController
                                                                  .caseCategoryId
                                                                  .value =
                                                              caseCategoryResult[
                                                                  1];
                                                          tASRController
                                                                  .serviceType
                                                                  .value =
                                                              caseCategoryResult[
                                                                  2];
                                                          tASRController
                                                                  .caseSubCategoryName
                                                                  .value =
                                                              AppMetaLabels()
                                                                  .pleaseSelect;
                                                          tASRController
                                                              .caseSubCategoryId
                                                              .value = '';
                                                        }
                                                      },
                                                      child: Container(
                                                        width: 100.0.w,
                                                        height: 5.0.h,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Color.fromRGBO(
                                                              246, 248, 249, 1),
                                                          border: tASRController
                                                                      .invalidInput
                                                                      .value &&
                                                                  tASRController
                                                                          .caseCategoryId
                                                                          .value ==
                                                                      ''
                                                              ? Border.all(
                                                                  color: Colors
                                                                      .red)
                                                              : null,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      0.5.h),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 1.5.h,
                                                                  right: 1.5.h),
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                tASRController
                                                                        .caseCategoryName
                                                                        .value ??
                                                                    "",
                                                                style: AppTextStyle
                                                                    .normalGrey10,
                                                              ),
                                                              Spacer(),
                                                              Icon(
                                                                Icons
                                                                    .arrow_drop_down,
                                                                size: 3.0.h,
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    if (tASRController
                                                            .invalidInput
                                                            .value &&
                                                        tASRController
                                                            .caseCategoryId
                                                            .value
                                                            .isEmpty)
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 8.0,
                                                                top: 8),
                                                        child: Text(
                                                            AppMetaLabels()
                                                                .requiredField,
                                                            style: AppTextStyle
                                                                .normalErrorText2),
                                                      ),
                                                  ],
                                                ),
                                                /////////////////////////////
                                                ///
                                                /// Case Sub Category
                                                ///
                                                /////////////////////////////
                                                if (tASRController
                                                        .caseCategoryId.value !=
                                                    '')
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        height: 2.0.h,
                                                      ),
                                                      Text(
                                                        '${AppMetaLabels().subCategory} *',
                                                        style: AppTextStyle
                                                            .normalGrey10,
                                                      ),
                                                      SizedBox(
                                                        height: 1.0.h,
                                                      ),
                                                      InkWell(
                                                        onTap: () async {
                                                          var caseSubCategoryResult =
                                                              await Get.to(() =>
                                                                  TenantSubCaseCategory());
                                                          if (caseSubCategoryResult !=
                                                              null) {
                                                            tASRController
                                                                    .caseSubCategoryName
                                                                    .value =
                                                                caseSubCategoryResult[
                                                                    0];
                                                            tASRController
                                                                    .caseSubCategoryId
                                                                    .value =
                                                                caseSubCategoryResult[
                                                                    1];
                                                          } else {
                                                            caseSubCategoryResult =
                                                                AppMetaLabels()
                                                                    .pleaseSelect;
                                                          }
                                                        },
                                                        child: Container(
                                                          width: 100.0.w,
                                                          height: 5.0.h,
                                                          decoration:
                                                              BoxDecoration(
                                                            color:
                                                                Color.fromRGBO(
                                                                    246,
                                                                    248,
                                                                    249,
                                                                    1),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        0.5.h),
                                                            border: tASRController
                                                                        .invalidInput
                                                                        .value &&
                                                                    tASRController
                                                                            .caseSubCategoryId
                                                                            .value ==
                                                                        ''
                                                                ? Border.all(
                                                                    color: Colors
                                                                        .red)
                                                                : null,
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 1.5.h,
                                                                    right:
                                                                        1.5.h),
                                                            child: Row(
                                                              children: [
                                                                Container(
                                                                  width:
                                                                      Get.width *
                                                                          0.67,
                                                                  child: Text(
                                                                    tASRController
                                                                            .caseSubCategoryName
                                                                            .value ??
                                                                        "",
                                                                    style: AppTextStyle
                                                                        .normalGrey10,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                  ),
                                                                ),
                                                                Spacer(),
                                                                Icon(
                                                                  Icons
                                                                      .arrow_drop_down,
                                                                  size: 3.0.h,
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      if (tASRController
                                                              .invalidInput
                                                              .value &&
                                                          tASRController
                                                              .caseSubCategoryId
                                                              .value
                                                              .isEmpty)
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 8.0,
                                                                  top: 8),
                                                          child: Text(
                                                              AppMetaLabels()
                                                                  .requiredField,
                                                              style: AppTextStyle
                                                                  .normalErrorText2),
                                                        ),
                                                    ],
                                                  ),

                                                SizedBox(
                                                  height: 2.0.h,
                                                ),
                                                /////////////////////////////
                                                ///
                                                /// Property
                                                ///
                                                /////////////////////////////
                                                Text(
                                                  '${AppMetaLabels().property} *',
                                                  style:
                                                      AppTextStyle.normalGrey10,
                                                ),
                                                SizedBox(
                                                  height: 1.0.h,
                                                ),
                                                InkWell(
                                                  onTap: () async {
                                                    var result = await Get.to(() =>
                                                        GetTenantProperties());
                                                    if (result != null) {
                                                      tASRController
                                                          .contractUnitName
                                                          .value = result[0];
                                                      tASRController
                                                          .contractUnitId
                                                          .value = result[1];
                                                    } else {
                                                      result = AppMetaLabels()
                                                          .pleaseSelect;
                                                    }
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
                                                      border: tASRController
                                                                  .invalidInput
                                                                  .value &&
                                                              tASRController
                                                                      .contractUnitId
                                                                      .value ==
                                                                  ''
                                                          ? Border.all(
                                                              color: Colors.red)
                                                          : null,
                                                    ),
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 1.5.h,
                                                          right: 1.5.h),
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            tASRController
                                                                    .contractUnitName
                                                                    .value ??
                                                                "",
                                                            style: AppTextStyle
                                                                .normalGrey10,
                                                          ),
                                                          Spacer(),
                                                          Icon(
                                                            Icons
                                                                .arrow_drop_down,
                                                            size: 3.0.h,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                if (tASRController
                                                        .invalidInput.value &&
                                                    tASRController
                                                        .contractUnitId
                                                        .value
                                                        .isEmpty)
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0, top: 8),
                                                    child: Text(
                                                        AppMetaLabels()
                                                            .requiredField,
                                                        style: AppTextStyle
                                                            .normalErrorText2),
                                                  ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.all(2.0.h),
                                          child: Container(
                                            width: 100.0.w,
                                            padding: EdgeInsets.all(2.0.h),
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
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  AppMetaLabels()
                                                      .contactDetails,
                                                  style: AppTextStyle
                                                      .semiBoldGrey12,
                                                ),
                                                Row(
                                                  children: [
                                                    Checkbox(
                                                      onChanged: (bool value) {
                                                        tASRController
                                                            .otherThanTenant
                                                            .value = value;
                                                      },
                                                      value: tASRController
                                                          .otherThanTenant
                                                          .value,
                                                    ),
                                                    Text(
                                                      AppMetaLabels()
                                                          .otherthantenant,
                                                      style: AppTextStyle
                                                          .normalGrey10,
                                                    ),
                                                  ],
                                                ),
                                                if (tASRController
                                                    .otherThanTenant.value)
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        height: 1.0.h,
                                                      ),
                                                      Text(
                                                        '${AppMetaLabels().name} *',
                                                        style: AppTextStyle
                                                            .normalGrey10,
                                                      ),
                                                      SizedBox(
                                                        height: 1.0.h,
                                                      ),
                                                      TextFormField(
                                                        decoration: textFieldDecoration
                                                            .copyWith(
                                                                hintText:
                                                                    AppMetaLabels()
                                                                        .pleaseEnterName),
                                                        keyboardType:
                                                            TextInputType.name,
                                                        style: AppTextStyle
                                                            .normalGrey10,
                                                        maxLines: 1,
                                                        validator: (value) {
                                                          if (value.isEmpty)
                                                            return AppMetaLabels()
                                                                .requiredField;
                                                          else if (!nameValidator
                                                              .hasMatch(value))
                                                            return AppMetaLabels()
                                                                .invalidName;
                                                          else
                                                            return null;
                                                        },
                                                        onChanged: (value) {
                                                          tASRController
                                                                  .contactName =
                                                              value;
                                                        },
                                                      ),
                                                      SizedBox(
                                                        height: 2.0.h,
                                                      ),
                                                      Text(
                                                        "${AppMetaLabels().mobileNumber} *",
                                                        style: AppTextStyle
                                                            .normalGrey10,
                                                      ),
                                                      SizedBox(
                                                        height: 1.0.h,
                                                      ),
                                                      TextFormField(
                                                        inputFormatters: [
                                                          FilteringTextInputFormatter
                                                              .digitsOnly
                                                        ],
                                                        focusNode:
                                                            _nodeTextMobile,
                                                        decoration: textFieldDecoration
                                                            .copyWith(
                                                                hintText:
                                                                    AppMetaLabels()
                                                                        .pleaseEnterPhoneno),
                                                        keyboardType:
                                                            TextInputType.phone,
                                                        style: AppTextStyle
                                                            .normalGrey10,
                                                        maxLines: 1,
                                                        validator: (value) {
                                                          if (value.isEmpty)
                                                            return AppMetaLabels()
                                                                .requiredField;
                                                          else if (!phoneValidator
                                                              .hasMatch(value))
                                                            return AppMetaLabels()
                                                                .invalidPhone;
                                                          else
                                                            return null;
                                                        },
                                                        onChanged: (value) {
                                                          tASRController
                                                                  .contactMobile =
                                                              value;
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                if (tASRController
                                                        .serviceType.value ==
                                                    'FM')
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 2.h),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "${AppMetaLabels().contactTime} *",
                                                          style: AppTextStyle
                                                              .normalGrey10,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 1.h),
                                                          child: InkWell(
                                                            onTap: () async {
                                                              var contactTime =
                                                                  await Get.to(() =>
                                                                      GetContactTiming());
                                                              if (contactTime !=
                                                                  null) {
                                                                tASRController
                                                                        .preferredTime
                                                                        .value =
                                                                    contactTime[
                                                                        0];
                                                                tASRController
                                                                        .preferredTimeId
                                                                        .value =
                                                                    contactTime[
                                                                        1];
                                                              }
                                                            },
                                                            child: Container(
                                                              width: 100.0.w,
                                                              height: 5.0.h,
                                                              decoration: BoxDecoration(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          246,
                                                                          248,
                                                                          249,
                                                                          1),
                                                                  borderRadius:
                                                                      BorderRadius.circular(0.5
                                                                          .h),
                                                                  border: tASRController
                                                                              .invalidInput
                                                                              .value &&
                                                                          tASRController.preferredTimeId.value ==
                                                                              ''
                                                                      ? Border.all(
                                                                          color: Colors.red)
                                                                      : null),
                                                              child: Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left: 1.5
                                                                            .h,
                                                                        right: 1.5
                                                                            .h),
                                                                child: Row(
                                                                  children: [
                                                                    Text(
                                                                      tASRController
                                                                              .preferredTime
                                                                              .value ??
                                                                          "",
                                                                      style: AppTextStyle
                                                                          .normalGrey10,
                                                                    ),
                                                                    Spacer(),
                                                                    Icon(
                                                                      Icons
                                                                          .arrow_drop_down,
                                                                      size:
                                                                          3.0.h,
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        if (tASRController
                                                                .invalidInput
                                                                .value &&
                                                            tASRController
                                                                .preferredTimeId
                                                                .value
                                                                .isEmpty)
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 8.0,
                                                                    top: 8),
                                                            child: Text(
                                                                AppMetaLabels()
                                                                    .requiredField,
                                                                style: AppTextStyle
                                                                    .normalErrorText2),
                                                          ),
                                                      ],
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          )),
                                      Padding(
                                        padding: EdgeInsets.all(2.0.h),
                                        child: Container(
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
                                                  AppMetaLabels()
                                                      .requestDetails,
                                                  style: AppTextStyle
                                                      .semiBoldGrey12,
                                                ),
                                                SizedBox(
                                                  height: 2.0.h,
                                                ),
                                                Text(
                                                  '${AppMetaLabels().describeTheService} *',
                                                  style:
                                                      AppTextStyle.normalGrey10,
                                                ),
                                                SizedBox(
                                                  height: 1.0.h,
                                                ),
                                                TextFormField(
                                                  focusNode:
                                                      _nodeTextReqDetails,
                                                  decoration: textFieldDecoration
                                                      .copyWith(
                                                          hintText:
                                                              AppMetaLabels()
                                                                  .enterRemarks),
                                                  keyboardType:
                                                      TextInputType.multiline,
                                                  style:
                                                      AppTextStyle.normalGrey10,
                                                  maxLines: 5,
                                                  validator: (value) {
                                                    if (value.isEmpty)
                                                      return AppMetaLabels()
                                                          .requiredField;
                                                    else if (!textValidator
                                                        .hasMatch(
                                                            value.replaceAll(
                                                                '\n', ' ')))
                                                      return AppMetaLabels()
                                                          .invalidText;
                                                    else
                                                      return null;
                                                  },
                                                  onChanged: (value) {
                                                    tASRController.remarks =
                                                        value.trim();
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      // SizedBox(
                                      //   height: 14.0.h,
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  width: 100.0.w,
                                  height: 13.0.h,
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
                                    padding: EdgeInsets.all(3.5.h),
                                    child: tASRController.loadingData.value
                                        ? LoadingIndicatorBlue()
                                        : ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        1.3.h),
                                              ),
                                              backgroundColor:
                                                  Color.fromRGBO(0, 61, 166, 1),
                                            ),
                                            onPressed: () {
                                              FocusScope.of(context).unfocus();
                                              tASRController
                                                  .invalidInput.value = false;
                                              bool enableButton = false;
                                              if (tASRController.caseCategoryId
                                                          .value !=
                                                      '' &&
                                                  tASRController
                                                          .caseSubCategoryId.value !=
                                                      '' &&
                                                  tASRController.contractUnitId
                                                          .value !=
                                                      '' &&
                                                  (tASRController.serviceType
                                                              .value ==
                                                          'PM' ||
                                                      tASRController
                                                              .preferredTimeId
                                                              .value !=
                                                          '')) {
                                                enableButton = true;
                                              } else {
                                                enableButton = false;
                                              }
                                              if (enableButton &&
                                                  formKey.currentState
                                                      .validate()) {
                                                tASRController.submitRequest();
                                              } else {
                                                SnakBarWidget.getSnackBarErrorBlue(
                                                  AppMetaLabels().error,
                                                  AppMetaLabels().fillAllFields,
                                                );
                                                tASRController
                                                    .invalidInput.value = true;
                                              }
                                            },
                                            child: Text(
                                              AppMetaLabels().next,
                                              style:
                                                  AppTextStyle.semiBoldWhite12,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
        );
      }),
    );
  }
}
