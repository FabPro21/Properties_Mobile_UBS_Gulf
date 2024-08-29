import 'package:contained_tab_bar_view_with_custom_page_navigator/contained_tab_bar_view_with_custom_page_navigator.dart';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/vendor/vendor_contracts/vendor_contracts_tabs.dart/vendor_contracts_details.dart/vendor_contracts_invoices/vendor_contracts_invoices.dart';
import 'package:fap_properties/views/vendor/vendor_contracts/vendor_contracts_tabs.dart/vendor_financial_terms/vendor_financial_terms_screen.dart';
import 'package:fap_properties/views/vendor/vendor_contracts/vendor_contracts_tabs.dart/vendor_property/vendor_property_screen.dart';
import 'package:fap_properties/views/widgets/custom_app_bar2.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'vendor_contract_info.dart';

class VendorContractsDetailsTabs extends StatelessWidget {
  VendorContractsDetailsTabs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: SessionController().getLanguage() == 1
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              CustomAppBar2(title: AppMetaLabels().contract),
              Padding(
                padding: EdgeInsets.all(2.0.h),
                child: Row(
                  children: [
                    Text(
                      AppMetaLabels().contractNo,
                      style: AppTextStyle.semiBoldBlack12,
                    ),
                    const Spacer(),
                    Text(
                     SessionController().getContractNo()??'',
                      style: AppTextStyle.semiBoldBlack12,
                    ),
                  ],
                ),
              ),
              const AppDivider(),
              Expanded(
                child: ContainedTabBarView(
                  tabs: [
                    Tab(text: AppMetaLabels().info),
                    Tab(text: AppMetaLabels().vendorProperties),
                    Tab(text: AppMetaLabels().financial),
                    Tab(text: AppMetaLabels().lposInvoices),
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
                    VendorInfo(),
                    VendorPropertyScreen(),
                    VendorFinancialTerms(),
                    ContractInvoices(),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
