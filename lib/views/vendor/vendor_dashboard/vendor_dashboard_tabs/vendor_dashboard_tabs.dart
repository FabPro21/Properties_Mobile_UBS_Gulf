import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/views/vendor/vendor_dashboard/vendor_dashboard_screen/vendor_db_technicane.dart';
import 'package:fap_properties/views/vendor/vendor_more/vendor_offers/vendor_offers.dart';
import 'package:fap_properties/views/vendor/vendor_services/vendor_request_list/vendor_request_list.dart';
import 'package:fap_properties/views/widgets/common_widgets/backbround_concave.dart';
import 'package:fap_properties/views/vendor/invoices/invoices_screen.dart';
import 'package:fap_properties/views/vendor/lpos/lpos_screen.dart';
import 'package:fap_properties/views/vendor/vendor_contracts/vendor_contracts.dart';
import 'package:fap_properties/views/vendor/vendor_dashboard/vendor_dashboard_screen/vendor_dashboard_screen.dart';
import 'package:fap_properties/views/vendor/vendor_dashboard/vendor_dashboard_tabs/vendor_dashboard_tabs_controller.dart';
import 'package:fap_properties/views/vendor/vendor_more/vendor_more.dart';
import 'package:fap_properties/views/widgets/custom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class VendorDashboardTabs extends StatefulWidget {
  const VendorDashboardTabs({Key key}) : super(key: key);

  @override
  _VendorDashboardTabsState createState() => _VendorDashboardTabsState();
}

class _VendorDashboardTabsState extends State<VendorDashboardTabs> {
  // ignore: unused_field
  VendorDashboardTabsController _dashboardTabsController =
      Get.put(VendorDashboardTabsController());
  int _selectedIndex = 0;
  @override
  void initState() {
    print('User Type :::::: ${SessionController().vendorUserType}');
    super.initState();
  }

  List<Widget> _buildScreens;

  @override
  Widget build(BuildContext context) {
    _buildScreens = SessionController().vendorUserType == 'Technician'
        ? [
            VendorDashboardTechnicane(
              parentContext: context,
              manageServiceReq: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
            VendorRequestList(),
            VendorOffers(),
            VendorMoreScreen(
              manageMenu: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ]
        : [
            VendorDashboard(
              parentContext: context,
              manageLpos: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
            VendorContractsScreen(),
            LposScreen(),
            InvoicesScreen(),
            VendorMoreScreen(
              manageMenu: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ];

    // _buildScreens = [
    //         VendorDashboard(
    //           parentContext: context,
    //           manageLpos: (index) {
    //             setState(() {
    //               _selectedIndex = index;
    //             });
    //           },
    //           // manageContracts: (index) {
    //           //   setState(() {
    //           //     _selectedIndex = index;
    //           //   });
    //           // },
    //         ),
    //         VendorContractsScreen(),
    //         LposScreen(),
    //         InvoicesScreen(),
    //         VendorMoreScreen(
    //           manageMenu: (index) {
    //             setState(() {
    //               _selectedIndex = index;
    //             });
    //           },
    //         ),
    //       ];

    return WillPopScope(
        onWillPop: () async =>
            SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
        child: Directionality(
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
                      SessionController().vendorUserType == 'Technician'
                          ? CustomNavBar(
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
                                      ? AppImagesPath.services2
                                      : AppImagesPath.services,
                                  title: AppMetaLabels().serviceRequest,
                                  onTap: (pos) {
                                    setState(() {
                                      _selectedIndex = pos;
                                    });
                                  },
                                  position: 1,
                                ),
                                NavBarItem(
                                  icon: _selectedIndex == 2
                                      ? "IconBlue"
                                      : "IconGrey",
                                  title: AppMetaLabels().offers,
                                  onTap: (pos) {
                                    setState(() {
                                      _selectedIndex = pos;
                                    });
                                  },
                                  position: 2,
                                ),
                                NavBarItem(
                                  icon: AppImagesPath.menu,
                                  title: AppMetaLabels().more,
                                  onTap: (pos) async {
                                    int _res =
                                        await Get.to(() => VendorMoreScreen(
                                              manageMenu: (index) {
                                                setState(() {
                                                  _selectedIndex = index;
                                                });
                                              },
                                            ));
                                    if (_res != null)
                                      setState(() {
                                        _selectedIndex = _res;
                                      });
                                  },
                                  position: 3,
                                )
                              ],
                            )
                          : CustomNavBar(
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
                                      ? AppImagesPath.contracts2
                                      : AppImagesPath.contracts,
                                  title: AppMetaLabels().contracts,
                                  onTap: (pos) {
                                    setState(() {
                                      _selectedIndex = pos;
                                    });
                                  },
                                  position: 1,
                                ),
                                NavBarItem(
                                  icon: _selectedIndex == 2
                                      ? AppImagesPath.lpos2
                                      : AppImagesPath.lpos,
                                  title: AppMetaLabels().lpos,
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
                                  title: AppMetaLabels().invoices,
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
                                    int _res =
                                        await Get.to(() => VendorMoreScreen(
                                              manageMenu: (index) {
                                                setState(() {
                                                  _selectedIndex = index;
                                                });
                                              },
                                            ));
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
        ));
  }
}
