import 'package:contained_tab_bar_view_with_custom_page_navigator/contained_tab_bar_view_with_custom_page_navigator.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/vendor/lpos/lpo_details/lpos_services/lpo_services.dart';
import 'package:fap_properties/views/vendor/lpos/lpo_details/lpos_terms/lpo_terms.dart';
import 'package:fap_properties/views/widgets/custom_app_bar2.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../data/helpers/session_controller.dart';
import '../../../../data/models/vendor_models/get_all_lpos_model.dart';
import 'lpo_invoices/lpo_invoices.dart';
import 'lpo_proretries/lpo_properties_screen.dart';

class LpoDetails extends StatefulWidget {
  final Lpo? lpo;

  LpoDetails({
    Key? key,
    this.lpo,
  }) : super(key: key);

  @override
  _LpoDetailsState createState() => _LpoDetailsState();
}

class _LpoDetailsState extends State<LpoDetails> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Directionality(
          textDirection: SessionController().getLanguage() == 1
              ? TextDirection.ltr
              : TextDirection.rtl,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              CustomAppBar2(title: AppMetaLabels().lpos),
              Padding(
                padding: EdgeInsets.fromLTRB(2.0.h, 2.0.h, 2.0.h, 1.5.h),
                child: Row(
                  children: [
                    Text(
                      AppMetaLabels().lpoRefNo,
                      style: AppTextStyle.semiBoldBlack12,
                    ),
                    const Spacer(),
                    Text(
                      '${widget.lpo!.lpoReference}',
                      style: AppTextStyle.semiBoldBlack12,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0.8.h, 0.0.h, 0.8.h, 0.h),
                  child: ContainedTabBarView(
                    tabs: [
                      Tab(text: AppMetaLabels().lposProperties),
                      Tab(text: AppMetaLabels().lposSvc),
                      Tab(text: AppMetaLabels().lposterms),
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
                      LpoPropertiesScreen(
                        lpo: widget.lpo,
                      ),
                      LpoServices(),
                      LpoTerms(),
                      LpoInvoicesSereen(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
