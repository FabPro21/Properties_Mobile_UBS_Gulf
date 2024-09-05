import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/error_text_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:fap_properties/views/vendor/vendor_profile/vendor_account/vendor_account_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../data/helpers/session_controller.dart';

// ignore: must_be_immutable
class VendorAcconut extends StatelessWidget {
  VendorAcconut({Key? key}) : super(key: key);

  final VendorAccountController _vendorAccountController =
      Get.put(VendorAccountController());
  String name = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppDivider(),
        SingleChildScrollView(
          child: Obx(() {
            return _vendorAccountController.loading.value
                ? Column(
                    children: [
                      AppDivider(),
                      Padding(
                        padding: EdgeInsets.only(top: 25.0.h),
                        child: LoadingIndicatorBlue(),
                      ),
                    ],
                  )
                : _vendorAccountController.error.value != ''
                    ? InkWell(
                        onTap: () {
                          _vendorAccountController.getVendorAccounts();
                        },
                        child: Padding(
                          padding: EdgeInsets.only(top: 25.0.h),
                          child: AppErrorWidget(
                            errorImage: AppImagesPath.noDataFound,
                            errorText: _vendorAccountController.error.value,
                          ),
                        ),
                      )
                    : Container(
                        width: 92.0.w,
                        margin: EdgeInsets.all(2.0.h),
                        // height: 70.5.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(2.0.h),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 0.5.h,
                              spreadRadius: 0.8.h,
                              offset: Offset(0.1.h, 0.1.h),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 2.h),
                              child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: _vendorAccountController
                                      .getVendorAccountsModel
                                      .value
                                      .accounts?.length,
                                  itemBuilder: (context, index) {
                                    String mystring = _vendorAccountController
                                        .getVendorAccountsModel
                                        .value
                                        .accounts?[index]
                                        .bankName??"";

                                    name = mystring[0];

                                    return Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(4.w, 0, 4.w, 2.h),
                                      child: Wrap(
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                height: 6.h,
                                                width: 6.h,
                                                margin:
                                                    EdgeInsets.only(right: 3.w),
                                                decoration: BoxDecoration(
                                                    color:
                                                        _vendorAccountController
                                                            .colors[index % 5],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.h)),
                                                alignment: Alignment.center,
                                                child: Text(name,
                                                    style: AppTextStyle
                                                        .semiBoldWhite14),
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    SessionController()
                                                                .getLanguage() ==
                                                            1
                                                        ? _vendorAccountController
                                                                .getVendorAccountsModel
                                                                .value
                                                                .accounts![index].bankName ??
                                                            'N/A'
                                                        : _vendorAccountController
                                                                .getVendorAccountsModel
                                                                .value
                                                                .accounts![index]
                                                                .bankNameAr ??
                                                            'N/A',
                                                    style: AppTextStyle
                                                        .semiBoldBlack12,
                                                  ),
                                                  SizedBox(
                                                    height: 1.h,
                                                  ),
                                                  Container(
                                                    width: 62.0.w,
                                                    child: Text(
                                                      // ignore: unrelated_type_equality_checks
                                                      AppMetaLabels()
                                                              .accountTitle +
                                                          "${SessionController().getLanguage() == 1 ? _vendorAccountController.getVendorAccountsModel.value.accounts![index].accountTitle ?? '' : _vendorAccountController.getVendorAccountsModel.value.accounts![index].accountTitleAR ?? ''}",

                                                      style: AppTextStyle
                                                          .normalGrey12,
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 3.h,
                                              ),
                                              Text(
                                                AppMetaLabels().accountNo,
                                                style: AppTextStyle.normalGrey9,
                                              ),
                                              Text(
                                                _vendorAccountController
                                                    .getMaskedString(
                                                        _vendorAccountController
                                                            .getVendorAccountsModel
                                                            .value
                                                            .accounts![index]
                                                            .accountNumber??""),
                                                style:
                                                    AppTextStyle.semiBoldGrey10,
                                              ),
                                              SizedBox(
                                                height: 1.h,
                                              ),
                                              Text(
                                                AppMetaLabels().ibanNo,
                                                style: AppTextStyle.normalGrey9,
                                              ),
                                              Text(
                                                _vendorAccountController
                                                    .getMaskedString(
                                                        _vendorAccountController
                                                            .getVendorAccountsModel
                                                            .value
                                                            .accounts![index]
                                                            .iban??""),
                                                style:
                                                    AppTextStyle.semiBoldGrey10,
                                              ),
                                              SizedBox(
                                                height: 1.h,
                                              ),
                                              Text(
                                                _vendorAccountController
                                                            .getVendorAccountsModel
                                                            .value
                                                            .accounts![index]
                                                            .swiftCode ==
                                                        ''
                                                    ? ''
                                                    : AppMetaLabels().swiftCode,
                                                style: AppTextStyle.normalGrey9,
                                              ),
                                              Text(
                                                _vendorAccountController
                                                        .getVendorAccountsModel
                                                        .value
                                                        .accounts![index]
                                                        .swiftCode ??
                                                    '',
                                                style:
                                                    AppTextStyle.semiBoldGrey10,
                                              ),
                                            ],
                                          ),
                                          index ==
                                                  _vendorAccountController
                                                          .getVendorAccountsModel
                                                          .value
                                                          .accounts!
                                                          .length -
                                                      1
                                              ? SizedBox()
                                              : AppDivider()
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      );
          }),
        ),
      ],
    );
  }
}
