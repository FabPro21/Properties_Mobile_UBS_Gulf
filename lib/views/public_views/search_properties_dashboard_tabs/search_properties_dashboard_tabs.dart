import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/views/widgets/custom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../data/helpers/session_controller.dart';
import '../../../utils/styles/colors.dart';
import '../public_notifications/public_count_notifications_controlller.dart';
import '../public_offers/public_offers.dart';
import '../search_properties_location/search_properties_location.dart';
import '../search_properties_more/search_properties_more.dart';
import '../search_properties_search/search_properties_search.dart';
import '../search_properties_services_request/public_service_request_list.dart';

class SearchPropertiesDashboardTabs extends StatefulWidget {
  const SearchPropertiesDashboardTabs({
    Key key,
  }) : super(key: key);
// class SearchPropertiesDashboardTabs extends StatefulWidget {
//   const SearchPropertiesDashboardTabs({Key key}) : super(key: key);

  @override
  _SearchPropertiesDashboardTabsState createState() =>
      _SearchPropertiesDashboardTabsState();
}

class _SearchPropertiesDashboardTabsState
    extends State<SearchPropertiesDashboardTabs> {
  final _countController = Get.put(PublicCountNotificationsController());
  GlobalKey _toolTipKey = GlobalKey();
  @override
  void initState() {
    // _countController.countNotifications();
    super.initState();
  }

  List<Widget> _buildScreens;
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    _countController.countNotifications();
    _buildScreens = [
      SearchPropertiesSearch(),
      PublicServiceRequestList(),
      SearchPropertiesLocation(),
      PublicOffers()
    ];

    return WillPopScope(
        onWillPop: () async =>
            SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
        child: Directionality(
          textDirection: SessionController().getLanguage() == 1
              ? TextDirection.ltr
              : TextDirection.rtl,
          child: Container(
            color: Colors.white,
            child: SafeArea(
              left: false,
              right: false,
              top: false,
              child: Scaffold(
                backgroundColor: Colors.white,
                resizeToAvoidBottomInset: false,
                body: Column(
                  children: [
                    Expanded(
                      child: _buildScreens[_selectedIndex],
                    ),
                    CustomNavBar(
                      items: [
                        NavBarItem(
                          icon: _selectedIndex == 0
                              ? AppImagesPath.home2
                              : AppImagesPath.home,
                          title: (AppMetaLabels().search),
                          onTap: (pos) {
                            setState(() {
                              _selectedIndex = pos;
                            });
                          },
                          position: 0,
                        ),
                        Tooltip(
                          key: _toolTipKey,
                          message: AppMetaLabels().serviceRequests,
                          showDuration: Duration(seconds: 3),
                          verticalOffset: 4.h,
                          padding:
                              EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                          decoration: BoxDecoration(
                              color: AppColors.chartBlueColor,
                              borderRadius: BorderRadius.circular(8)),
                          child: NavBarItem(
                            icon: _selectedIndex == 1
                                ? AppImagesPath.services2
                                : AppImagesPath.services,
                            title: AppMetaLabels().services,
                            onTap: (pos) {
                              final dynamic _toolTip = _toolTipKey.currentState;
                              _toolTip.ensureTooltipVisible();
                              setState(() {
                                _selectedIndex = pos;
                              });
                            },
                            position: 1,
                          ),
                        ),
                        NavBarItem(
                          icon: _selectedIndex == 2
                              ? AppImagesPath.location2
                              : AppImagesPath.location,
                          title: (AppMetaLabels().offices),
                          onTap: (pos) {
                            setState(() {
                              _selectedIndex = pos;
                            });
                          },
                          position: 2,
                        ),
                        NavBarItem(
                          icon: _selectedIndex == 3
                              ? AppImagesPath.payments2
                              : AppImagesPath.payments,
                          title: (AppMetaLabels().promotions),
                          onTap: (pos) {
                            setState(() {
                              _selectedIndex = pos;
                            });
                          },
                          position: 3,
                        ),
                        NavBarItem(
                          icon: AppImagesPath.menu,
                          title: AppMetaLabels().more,
                          onTap: (pos) async {
                            Get.to(
                              () => SearchPropertiesMore(),
                            );
                          },
                          position: 4,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
