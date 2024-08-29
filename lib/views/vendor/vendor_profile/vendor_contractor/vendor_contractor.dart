import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/error_text_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:fap_properties/views/vendor/upload_docs/upload_docs.dart';
import 'package:fap_properties/views/widgets/common_widgets/status_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../vendor_profile_controller.dart';

class VendorContractor extends StatefulWidget {
  VendorContractor({Key? key}) : super(key: key);

  @override
  State<VendorContractor> createState() => _VendorContractorState();
}

class _VendorContractorState extends State<VendorContractor> {
  final vendorProfileContrller = Get.put(VendorProfileController());
  // _getData() async {
  //   await vendorProfileContrller.getData();
  // }

  @override
  void initState() {
    // WidgetsBinding.instance.addPostFrameCallback((_) {});
    // _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          AppDivider(),
          Expanded(
            child: Obx(() {
              return vendorProfileContrller.loadingData.value == true
                  ? Center(child: LoadingIndicatorBlue())
                  : vendorProfileContrller.error.value != ''
                      ? AppErrorWidget(
                          errorText: vendorProfileContrller.error.value,
                        )
                      : Wrap(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 2.0.h),
                              padding: EdgeInsets.all(2.0.h),
                              width: 90.0.w,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  rowList(
                                    AppMetaLabels().emailAddress,
                                    vendorProfileContrller.vendorProfile.value
                                            .profile!.email ??
                                        "",
                                  ),
                                  SizedBox(
                                    height: 2.0.h,
                                  ),
                                  rowList(
                                    AppMetaLabels().mobileNumber,
                                    vendorProfileContrller.vendorProfile.value
                                            .profile!.mobileNo ??
                                        "",
                                  ),
                                  SizedBox(
                                    height: 2.0.h,
                                  ),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          AppMetaLabels().address,
                                          style: AppTextStyle.normalGrey10,
                                        ),
                                        Spacer(),
                                        Container(
                                          width: 45.0.w,
                                          child: Text(
                                            SessionController().getLanguage() ==
                                                    1
                                                ? vendorProfileContrller
                                                        .vendorProfile
                                                        .value
                                                        .profile!
                                                        .address ??
                                                    ""
                                                : vendorProfileContrller
                                                        .vendorProfile
                                                        .value
                                                        .profile!
                                                        .addressAR ??
                                                    "",
                                            style: AppTextStyle.semiBoldBlack9,
                                            textAlign: TextAlign.right,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2.0.h,
                                  ),
                                  rowList(
                                    AppMetaLabels().tradeLicenseNo,
                                    vendorProfileContrller.vendorProfile.value
                                            .profile!.tradeLicenseNo ??
                                        "",
                                  ),
                                  SizedBox(
                                    height: 2.0.h,
                                  ),
                                  rowList(
                                    AppMetaLabels().supplierTRN,
                                    vendorProfileContrller.vendorProfile.value
                                            .profile!.supplierTrn ??
                                        "",
                                  ),
                                  SizedBox(
                                    height: 4.0.h,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        AppMetaLabels().status,
                                        style: AppTextStyle.normalGrey10,
                                      ),
                                      Spacer(),
                                      StatusWidget(
                                        text:
                                            SessionController().getLanguage() ==
                                                    1
                                                ? vendorProfileContrller
                                                        .vendorProfile
                                                        .value
                                                        .profile!
                                                        .lpoStatusName ??
                                                    ""
                                                : vendorProfileContrller
                                                        .vendorProfile
                                                        .value
                                                        .profile!
                                                        .lpoStatusNameAr ??
                                                    "",
                                        valueToCompare: vendorProfileContrller
                                            .vendorProfile
                                            .value
                                            .profile!
                                            .lpoStatusName,
                                      )
                                      // Container(
                                      //   decoration: BoxDecoration(
                                      //     color:
                                      //         Color.fromRGBO(241, 241, 245, 1),
                                      //     borderRadius:
                                      //         BorderRadius.circular(0.5.h),
                                      //   ),
                                      //   child: Padding(
                                      //     padding: EdgeInsets.fromLTRB(
                                      //         2.0.h, 0.8.h, 2.0.h, 0.8.h),
                                      //     child: Text(
                                      //       SessionController().getLanguage() ==
                                      //               1
                                      //           ? vendorProfileContrller
                                      //                   .vendorProfile
                                      //                   .value
                                      //                   .profile!
                                      //                   .lpoStatusName ??
                                      //               ""
                                      //           : vendorProfileContrller
                                      //                   .vendorProfile
                                      //                   .value
                                      //                   .profile!
                                      //                   .lpoStatusNameAr ??
                                      //               "",
                                      //       style: AppTextStyle.semiBoldBlack10,
                                      //       overflow: TextOverflow.ellipsis,
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
            }),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
            width: 50.w,
            height: 5.h,
            child: ElevatedButton(
              onPressed: () {
                Get.to(() => UploadDocs(
                      title: AppMetaLabels().uploadVendorDocs,
                      docCode: 44,
                    ));
              },
              child: Text(
                AppMetaLabels().uploadDocs,
                style: AppTextStyle.semiBoldWhite12,
              ),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(1.3.h),
                ),
                backgroundColor: Color.fromRGBO(0, 61, 166, 1),
              ),
            ),
          )
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
        Container(
          child: Text(
            t2,
            style: AppTextStyle.semiBoldBlack9,
          ),
        ),
      ],
    );
  }
}
