import 'package:contained_tab_bar_view_with_custom_page_navigator/contained_tab_bar_view_with_custom_page_navigator.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/error_text_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:fap_properties/views/vendor/vendor_profile/vendor_account/vendor_account.dart';
import 'package:fap_properties/views/vendor/vendor_profile/vendor_contact/vendor_contact.dart';
import 'package:fap_properties/views/vendor/vendor_profile/vendor_contractor/vendor_contractor.dart';
import 'package:fap_properties/views/widgets/custom_app_bar2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../data/helpers/session_controller.dart';
import 'vendor_profile_controller.dart';

// ignore: must_be_immutable
class VendorProfile extends StatefulWidget {
  VendorProfile({Key? key}) : super(key: key);

  @override
  State<VendorProfile> createState() => _VendorProfileState();
}

class _VendorProfileState extends State<VendorProfile> {
  final vendorProfileContrller = Get.put(VendorProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Directionality(
        textDirection: SessionController().getLanguage() == 1
            ? TextDirection.ltr
            : TextDirection.rtl,
        child: Column(
          children: [
            CustomAppBar2(
              title: AppMetaLabels().myProfile,
            ),
            Obx(() {
              return vendorProfileContrller.loadingData.value == true
                  ? Padding(
                      padding: EdgeInsets.only(top: 40.0.h),
                      child: LoadingIndicatorBlue(),
                    )
                  : vendorProfileContrller.error.value != ''
                      ? Padding(
                          padding: EdgeInsets.only(top: 40.0.h),
                          child: AppErrorWidget(
                            errorText: vendorProfileContrller.error.value,
                          ),
                        )
                      : Expanded(
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(2.0.h),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 50.0.w,
                                      child: Text(
                                                  SessionController()
                                                              .getLanguage() ==
                                                          1
                                                      ? vendorProfileContrller.vendorProfile
                                                .value.profile?.companyName ??
                                            ""
                                                      :  vendorProfileContrller.vendorProfile
                                                .value.profile?.companyNameAR ??
                                            "",

                                       
                                        style: AppTextStyle.semiBoldBlack12,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      vendorProfileContrller.vendorProfile.value
                                              .profile?.phone ??
                                          "",
                                      style: AppTextStyle.semiBoldBlack12,
                                    ),
                                  ],
                                ),
                              ),
                              AppDivider(),
                              Expanded(
                                child: ContainedTabBarView(
                                  tabs: [
                                    Tab(text: AppMetaLabels().contractor),
                                    Tab(text: AppMetaLabels().contacts),
                                    Tab(text: AppMetaLabels().accounts),
                                  ],
                                  tabBarProperties: TabBarProperties(
                                    height: 5.0.h,
                                    indicatorColor: AppColors.blueColor,
                                    indicatorWeight: 0.2.h,
                                    labelColor: AppColors.blueColor,
                                    unselectedLabelColor: AppColors.blackColor,
                                    labelStyle: AppTextStyle.semiBoldBlack10,
                                  ),
                                  views: [
                                    VendorContractor(),
                                    VendorContact(),
                                    VendorAcconut(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
            }),
          ],
        ),
      ),
    );
  }
}
