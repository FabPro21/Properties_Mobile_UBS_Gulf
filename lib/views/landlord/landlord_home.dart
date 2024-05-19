import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/views/landlord/landlord_invoice/invoices_screen.dart';
import 'package:fap_properties/views/widgets/common_widgets/backbround_concave.dart';
import 'package:fap_properties/views/widgets/custom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'landlord_contracts/landlord_contracts.dart';
import 'landlord_dashboard/landlord_dashboard.dart';
import 'landlord_more/landlord_more.dart';
import 'landlord_properties/landlord_properties.dart';

class LandlordHome extends StatefulWidget {
  const LandlordHome({Key key}) : super(key: key);

  @override
  _LandlordHomeState createState() => _LandlordHomeState();
}

class _LandlordHomeState extends State<LandlordHome> {
  List<Widget> _buildScreens;
  int _selectedIndex = 0;

  @override
  void initState() {
    _buildScreens = [
      LandlordDashboard(
        parentContext: context,
        manageProperties: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        manageContracts: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      LandLordProperties(),
      LandLordContracts(),
      // LandLordReports(),
      InvoicesScreenLandlord()
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: SessionController().getLanguage() == 1
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            AppBackgroundConcave(),
            SafeArea(
              child: Column(
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
                        title: AppMetaLabels().dashboard,
                        onTap: (pos) {
                          setState(() {
                            _selectedIndex = pos;
                          });
                        },
                        position: 0,
                      ),
                      NavBarItem(
                        icon: _selectedIndex == 1
                            ? AppImagesPath.propertiesBlueLand
                            : AppImagesPath.propertiesImgLand,
                        title: AppMetaLabels().propertiessLand,
                        onTap: (pos) {
                          setState(() {
                            _selectedIndex = pos;
                          });
                        },
                        position: 1,
                      ),
                      NavBarItem(
                        icon: _selectedIndex == 2
                            ? AppImagesPath.contracts2
                            : AppImagesPath.contracts,
                        title: AppMetaLabels().contracts,
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
                        title: AppMetaLabels().invoice,
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
                          int _res = await Get.to(() => LandLordMore());
                          if (_res != null)
                            setState(() {
                              _selectedIndex = _res;
                            });
                        },
                        position: 4,
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
