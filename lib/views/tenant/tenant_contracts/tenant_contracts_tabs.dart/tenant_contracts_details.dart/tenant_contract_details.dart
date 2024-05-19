import 'package:contained_tab_bar_view_with_custom_page_navigator/contained_tab_bar_view_with_custom_page_navigator.dart';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/tenant/tenant_contracts/tenant_contracts_tabs.dart/tenant_contract_payments/contract_payments.dart';
import 'package:fap_properties/views/tenant/tenant_contracts/tenant_contracts_tabs.dart/tenant_contracts_charges/tenant_charges.dart';
import 'package:fap_properties/views/tenant/tenant_contracts/tenant_contracts_tabs.dart/tenant_contracts_details.dart/tenant_main_info.dart';
import 'package:fap_properties/views/tenant/tenant_contracts/tenant_contracts_tabs.dart/tenant_unit_info/tenant_unit_info.dart';
import 'package:fap_properties/views/widgets/custom_app_bar2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sizer/sizer.dart';

import '../../../../widgets/common_widgets/error_text_widget.dart';
import '../../../../widgets/common_widgets/loading_indicator_blue.dart';
import 'tenant_contracts_detail_controller.dart';

class ContractsDetailsTabs extends StatefulWidget {
  final String prevContractNo;
  ContractsDetailsTabs({
    Key key,
    this.prevContractNo,
  }) : super(key: key);

  @override
  State<ContractsDetailsTabs> createState() => _ContractsDetailsTabsState();
}

class _ContractsDetailsTabsState extends State<ContractsDetailsTabs> {
  final getCDController = Get.put(GetContractsDetailsController());

  @override
  Widget build(BuildContext context) {
    getCDController.getData();
    setState(() {});
    return Directionality(
      textDirection: SessionController().getLanguage() == 1
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              CustomAppBar2(
                title: AppMetaLabels().contract,
              ),
              Expanded(
                child: Obx(() {
                  return getCDController.loadingContract.value == true
                      ? LoadingIndicatorBlue()
                      : getCDController.errorLoadingContract.value != ''
                          ? AppErrorWidget(
                              errorText:
                                  getCDController.errorLoadingContract.value,
                            )
                          : Column(
                              children: [
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
                                        getCDController.getContractsDetails
                                            .value.contract.contractno,
                                        style: AppTextStyle.semiBoldBlack12,
                                      ),
                                    ],
                                  ),
                                ),
                                const AppDivider(),
                                // 112233 Contract Tabs
                                Expanded(
                                  child: ContainedTabBarView(
                                    tabs: [
                                      Tab(text: AppMetaLabels().maininfo),
                                      Tab(text: AppMetaLabels().unitinfo),
                                      Tab(
                                          text: AppMetaLabels()
                                              .contractsPayments),
                                      Tab(text: AppMetaLabels().charges),
                                    ],
                                    tabBarProperties: TabBarProperties(
                                      height: 5.0.h,
                                      indicatorColor: AppColors.blueColor,
                                      indicatorWeight: 0.2.h,
                                      labelColor: AppColors.blueColor,
                                      unselectedLabelColor:
                                          AppColors.blackColor,
                                      labelStyle: AppTextStyle.semiBoldBlack10,
                                    ),
                                    views: [
                                      MainInfo(
                                        prevContractNo: widget.prevContractNo,
                                      ),
                                      UnitInfo(),
                                      PaymentsScreen(),
                                      ChargesScreen(),
                                    ],
                                  ),
                                ),
                              ],
                            );
                }),
              ),
            ],
          )),
    );
  }
}
