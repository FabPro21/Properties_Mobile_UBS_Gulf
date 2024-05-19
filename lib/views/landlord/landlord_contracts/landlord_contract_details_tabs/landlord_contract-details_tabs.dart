import 'package:contained_tab_bar_view_with_custom_page_navigator/contained_tab_bar_view_with_custom_page_navigator.dart';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/landlord/landlord_contracts/landlord_contract_details_tabs/landlord_contract_payments/contract_payments.dart';
import 'package:fap_properties/views/landlord/landlord_contracts/landlord_contract_details_tabs/landlord_contracts_charges/landlord_charges.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/widgets/custom_app_bar2.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'landlord_contract_main_info/landlord_contract_main_info.dart';
import 'landlord_contract_unit_info/landlord_contract_unit_info.dart';
import 'dart:ui' as ui;

class LandlordContractDetailsTabs extends StatefulWidget {
  final String contractNo;
  final int contractId;
  final String prevContractNo;
  const LandlordContractDetailsTabs(
      {Key key,
      @required this.contractNo,
      @required this.contractId,
      this.prevContractNo})
      : super(key: key);

  @override
  _LandlordContractDetailsTabsState createState() =>
      _LandlordContractDetailsTabsState();
}

class _LandlordContractDetailsTabsState
    extends State<LandlordContractDetailsTabs> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: SessionController().getLanguage() == 1
          ? ui.TextDirection.ltr
          : ui.TextDirection.rtl,
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              CustomAppBar2(
                title: AppMetaLabels().contracts,
              ),
              Padding(
                padding: EdgeInsets.all(2.0.h),
                child: Row(
                  children: [
                    Text(
                      AppMetaLabels().contractNo,
                      style: AppTextStyle.semiBoldBlack12,
                    ),
                    Spacer(),
                    Text(
                      widget.contractNo,
                      style: AppTextStyle.semiBoldBlack12,
                    ),
                  ],
                ),
              ),
              AppDivider(),
              Expanded(
                child: ContainedTabBarView(
                  tabs: [
                    Tab(text: AppMetaLabels().maininfo),
                    Tab(text: AppMetaLabels().unitinfo),
                    Tab(text: AppMetaLabels().contractsPayments),
                    Tab(text: AppMetaLabels().charges),
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
                    LandlordContractMainInfo(
                      contractId: widget.contractId,
                      previousContactNo: widget.contractNo,
                    ),
                    LandlordContractUnitInfo(
                      contractId: widget.contractId,
                    ),
                    LandlordPaymentsScreen(),
                    LandlordChargesScreen()
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
