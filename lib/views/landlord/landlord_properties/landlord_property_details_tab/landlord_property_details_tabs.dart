import 'package:contained_tab_bar_view_with_custom_page_navigator/contained_tab_bar_view_with_custom_page_navigator.dart';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/landlord/landlord_properties/landlord_property_details_tab/landlord_property_info/landlord_property_info.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/widgets/custom_app_bar2.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'landlord_property_unit_info/landlord_property_unit_info.dart';

class LandlordPropertDetailsTabs extends StatefulWidget {
  final String propertyId;
  final String propertyNo;
  const LandlordPropertDetailsTabs({Key key, this.propertyId, this.propertyNo})
      : super(key: key);

  @override
  _LandlordPropertDetailsTabsState createState() =>
      _LandlordPropertDetailsTabsState();
}

class _LandlordPropertDetailsTabsState
    extends State<LandlordPropertDetailsTabs> {
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
              CustomAppBar2(
                title: AppMetaLabels().propertiessLand,
              ),
              Padding(
                padding: EdgeInsets.all(2.0.h),
                child: Row(
                  children: [
                    Text(
                      AppMetaLabels().property,
                      style: AppTextStyle.semiBoldBlack12,
                    ),
                    Spacer(),
                    Text(
                      widget.propertyNo == 'null'
                          ? ''
                          : widget.propertyNo??"",
                      style: AppTextStyle.semiBoldBlack11,
                    ),
                  ],
                ),
              ),
              AppDivider(),
              Expanded(
                child: ContainedTabBarView(
                  tabs: [
                    Tab(text: AppMetaLabels().propertyInfoCapLand),
                    Tab(text: AppMetaLabels().unitinfo),
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
                    LandlordPropertyInfo(
                      propertID: widget.propertyId,
                    ),
                    LandlordPropertyUnitInfo(
                      propertID: widget.propertyId,
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
