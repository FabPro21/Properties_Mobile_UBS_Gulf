import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/error_text_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:fap_properties/views/vendor/vendor_profile/vendor_contact/vendor_get_contact_persons_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../data/helpers/session_controller.dart';

class VendorContact extends StatefulWidget {
  VendorContact({Key? key}) : super(key: key);

  @override
  State<VendorContact> createState() => _VendorContactState();
}

class _VendorContactState extends State<VendorContact> {
  String name = "";

  var getContactPersonsController =
      Get.put(VendorGetContactPersonsController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          AppDivider(),
          Obx(() {
            return getContactPersonsController.loadingData.value == true
                ? Padding(
                    padding: EdgeInsets.only(top: 25.0.h),
                    child: LoadingIndicatorBlue(),
                  )
                : getContactPersonsController.error.value != ''
                    ? Padding(
                        padding: EdgeInsets.only(top: 25.0.h),
                        child: AppErrorWidget(
                          errorText: getContactPersonsController.error.value,
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: getContactPersonsController
                              .vendorContact.value.contactPersons?.length,
                          itemBuilder: (BuildContext context, int index) {
                            String mystring = getContactPersonsController
                                .vendorContact.value.contactPersons?[index].name??"";

                            name = mystring[0];

                            return Padding(
                              padding: EdgeInsets.all(2.0.h),
                              child: Container(
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
                                child: Padding(
                                  padding: EdgeInsets.all(2.0.h),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  72, 88, 106, 1),
                                              shape: BoxShape.circle,
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(2.0.h),
                                              child: Text(
                                                name,
                                                style: AppTextStyle
                                                    .semiBoldWhite14,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(left: 3.0.h),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                   SessionController()
                                                              .getLanguage() ==
                                                          1
                                                      ? getContactPersonsController
                                                          .vendorContact
                                                          .value
                                                          .contactPersons![index]
                                                          .name ??
                                                      ""
                                                      : getContactPersonsController
                                                          .vendorContact
                                                          .value
                                                          .contactPersons![index]
                                                          .nameAr ??
                                                      "",
                                                  
                                                  style: AppTextStyle
                                                      .semiBoldBlack12,
                                                ),
                                                SizedBox(
                                                  height: 0.7.h,
                                                ),
                                                Text(
                                                  SessionController()
                                                              .getLanguage() ==
                                                          1
                                                      ? getContactPersonsController
                                                          .vendorContact
                                                          .value
                                                          .contactPersons![index]
                                                          .positionAR ??
                                                      ""
                                                      : getContactPersonsController
                                                          .vendorContact
                                                          .value
                                                          .contactPersons![index]
                                                          .positionAR ??
                                                      "",
                                                  style:
                                                      AppTextStyle.normalGrey10,
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 2.0.h,
                                      ),
                                      rowList(
                                        AppMetaLabels().mobileNumber,
                                        getContactPersonsController
                                                .vendorContact
                                                .value
                                                .contactPersons![index]
                                                .mobile ??
                                            "",
                                      ),
                                      SizedBox(
                                        height: 2.0.h,
                                      ),
                                      rowList(
                                        AppMetaLabels().faxNumber,
                                        getContactPersonsController
                                                .vendorContact
                                                .value
                                                .contactPersons![index]
                                                .faxNumber ??
                                            "",
                                      ),
                                      SizedBox(
                                        height: 2.0.h,
                                      ),
                                      rowList(
                                        AppMetaLabels().phoneNumber,
                                        getContactPersonsController
                                                .vendorContact
                                                .value
                                                .contactPersons![index]
                                                .phone ??
                                            "",
                                      ),
                                      SizedBox(
                                        height: 2.0.h,
                                      ),
                                      rowList(
                                        AppMetaLabels().emailAddress,
                                        getContactPersonsController
                                                .vendorContact
                                                .value
                                                .contactPersons![index]
                                                .email ??
                                            "",
                                      ),
                                      SizedBox(
                                        height: 2.0.h,
                                      ),
                                      rowList(
                                        AppMetaLabels().isAuthorizedSignatory,
                                        SessionController()
                                                              .getLanguage() ==
                                                          1
                                                      ? getContactPersonsController
                                                          .vendorContact
                                                          .value
                                                          .contactPersons![index]
                                                          .isAuthorizedSignatory ??
                                                      ""
                                                      : getContactPersonsController
                                                          .vendorContact
                                                          .value
                                                          .contactPersons![index]
                                                          .isAuthorizedSignatoryAR ??
                                                      "",
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
          }),
        ],
      ),
    );
  }

  Row rowList(String t1, t2) {
    return Row(
      children: [
        Text(
          t1,
          style: AppTextStyle.normalGrey10,
        ),
        Spacer(),
        Text(
          t2,
          style: AppTextStyle.semiBoldBlack9,
        ),
      ],
    );
  }
}
