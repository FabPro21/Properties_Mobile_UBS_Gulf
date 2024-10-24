// // =====================>
// // // For uat (Maintaince)
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/widgets/common_widgets/custom_error_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:fap_properties/views/widgets/common_widgets/status_widget.dart';
import 'package:fap_properties/views/tenant/tenant_services_request/tenant_request/add_new_service_request/tenant_add_request.dart';
import 'package:fap_properties/views/tenant/tenant_services_request/tenant_request/tenant_request_list/tenant_request_list_controller.dart';
import 'package:fap_properties/views/tenant/tenant_services_request/tenant_request_details/tenant_service_request_tab/tenant_service_request_tab.dart';
import 'package:fap_properties/views/widgets/snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../../../data/models/tenant_models/get_tenant_service_requests_model.dart';

class TenantRequestList extends StatefulWidget {
  const TenantRequestList({Key? key}) : super(key: key);

  @override
  _TenantRequestListState createState() => _TenantRequestListState();
}

class _TenantRequestListState extends State<TenantRequestList> {
  var getTSRController = Get.put(GetTenantServiceRequestsController());
  final TextEditingController searchControler = TextEditingController();
  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();
  GlobalKey _toolTipKey = GlobalKey();
  int tabIndex = 0;
  bool? filterApplied;
  @override
  void initState() {
    super.initState();
    filterApplied = false;
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final dynamic _toolTip = _toolTipKey.currentState;
      _toolTip.ensureTooltipVisible();
    });

    return Directionality(
      textDirection: SessionController().getLanguage() == 1
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 2.0.h),
              child: Row(
                children: [
                  SizedBox(
                    width: 12.2.w,
                  ),
                  Spacer(),
                  Text(
                    AppMetaLabels().serviceRequests,
                    style: AppTextStyle.semiBoldWhite15,
                  ),
                  Spacer(),
                  Tooltip(
                    key: _toolTipKey,
                    message: AppMetaLabels().createNewServiceRequest,
                    verticalOffset: 2.h,
                    margin: EdgeInsets.only(right: 2.h, left: 2.h),
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                        color: AppColors.chartBlueColor,
                        borderRadius: BorderRadius.only(
                            topLeft: SessionController().getLanguage() == 1
                                ? Radius.circular(8)
                                : Radius.zero,
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                            topRight: SessionController().getLanguage() == 1
                                ? Radius.zero
                                : Radius.circular(8))),
                    child: IconButton(
                      icon: Icon(Icons.add_circle_outline_outlined),
                      iconSize: 4.0.h,
                      color: Colors.white,
                      onPressed: () async {
                        Get.to(() => TenantAddServicesRequest());
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 2.0.h, right: 2.0.h, top: 4.0.h),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(1.0.h),
                ),
                child: Padding(
                  padding: EdgeInsets.all(0.3.h),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: searchControler,
                          onChanged: (value) async {
                            //*
                            if (tabIndex == 0) {
                              await getTSRController.getDataFM(value.trim());
                              setState(() {});
                            } else {
                              await getTSRController.getDataPM(value.trim());
                              setState(() {});
                            }
                            if (value.isEmpty == true) {
                              if (tabIndex == 0) {
                                await getTSRController.getDataFM('');
                                setState(() {});
                              } else {
                                await getTSRController.getDataPM('');
                                setState(() {});
                              }
                            }
                            //*

                            // await getTSRController.getDataPM(value.trim());
                            // setState(() {});

                            // if (value.isEmpty == true) {
                            //   await getTSRController.getDataPM('');
                            //   setState(() {});
                            // }

                            // setState(() {});
                            //*
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.withOpacity(0.1),
                            prefixIcon: Icon(
                              Icons.search,
                              size: 2.0.h,
                              color: Colors.grey,
                            ),
                            contentPadding:
                                EdgeInsets.only(left: 4.0.w, right: 4.0.h),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(0.5.h),
                              borderSide: BorderSide(
                                  color: AppColors.whiteColor, width: 0.1.h),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(0.5.h),
                              borderSide: BorderSide(
                                  color: AppColors.whiteColor, width: 0.1.h),
                            ),
                            hintText: AppMetaLabels().searchServicesby,
                            hintStyle: AppTextStyle.normalBlack9
                                .copyWith(color: Colors.grey),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          searchControler.clear();
                          setState(() {
                            getTSRController.fromDate = null;
                            getTSRController.toDate = null;
                          });
                          // *
                          if (tabIndex == 0) {
                            getTSRController.getDataFM('');
                          } else {
                            getTSRController.getDataPM('');
                          }
                          // *
                          // getTSRController.getDataPM('');
                          //*
                        },
                        icon: Icon(
                          Icons.refresh,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            // Maintaince and Leasing
            Expanded(
                child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: 4.0.h, right: 4.0.w, left: 4.0.w, bottom: 2.h),
                  child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(2.0.h),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 0.5.h,
                            spreadRadius: 0.1.h,
                            offset: Offset(0.1.h, 0.1.h),
                          ),
                        ],
                      ),
                      child: DefaultTabController(
                        length: 2, //1,
                        child: Column(
                          children: [
                            TabBar(
                              onTap: (index) {
                                tabIndex = index;
                              },
                              indicatorColor: AppColors.blueColor,
                              tabs: [
                                // *
                                Tab(
                                  child: Text(
                                    AppMetaLabels().maintenance,
                                    style: AppTextStyle.normalBlue12,
                                  ),
                                ),
                                // *
                                Tab(
                                  child: Text(
                                    AppMetaLabels().leasing,
                                    style: AppTextStyle.normalBlue12,
                                  ),
                                )
                              ],
                            ),
                            Expanded(
                              child: TabBarView(
                                children: [
                                  //*
                                  FMServiceRequests(),
                                  //*
                                  PMServiceRequests()
                                ],
                              ),
                            )
                          ],
                        ),
                      )),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 2.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 4.0.h,
                          width: 30.0.w,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                            ),
                            onPressed: () async {
                              setState(() {
                                getTSRController.filterError.value = '';
                                getTSRController.fromController.text = '';
                                getTSRController.toController.text = '';
                                getTSRController.fromController.clear();
                                getTSRController.toController.clear();
                                getTSRController.toDateN.value = '';
                                getTSRController.fromDateN.value = '';
                              });
                              showFiltersDialog(context);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.format_align_center,
                                  size: 2.0.h,
                                  color: Colors.black,
                                ),
                                Text(
                                  AppMetaLabels().filter,
                                  style: AppTextStyle.semiBoldBlack11,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 1.h,
                        ),
                        if (filterApplied!)
                          SizedBox(
                            height: 4.0.h,
                            width: SessionController().getLanguage() == 1
                                ? 30.0.w
                                : 40.0.w,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                              ),
                              onPressed: () async {
                                setState(() {
                                  getTSRController.fromDate = null;
                                  getTSRController.toDate = null;
                                  fromController.clear();
                                  toController.clear();
                                  getTSRController.toDateN.value = '';
                                  getTSRController.fromDateN.value = '';
                                });
                                //*
                                if (tabIndex == 0) {
                                  getTSRController.getDataFM('');
                                } else {
                                  getTSRController.getDataPM('');
                                }
                                //*

                                getTSRController.getDataPM('');
                                Get.back();
                                setState(() {
                                  filterApplied = false;
                                });
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.close,
                                    size: 2.0.h,
                                    color: Colors.black,
                                  ),
                                  Text(
                                    AppMetaLabels().clear,
                                    style: AppTextStyle.semiBoldBlack11,
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }

  void showFiltersDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Obx(() {
            return Directionality(
              textDirection: SessionController().getLanguage() == 1
                  ? TextDirection.ltr
                  : TextDirection.rtl,
              child: AlertDialog(
                title: Text(AppMetaLabels().filterSR),
                content: SizedBox(
                  height: getTSRController.filterError.value != '' ? 15.h : 8.h,
                  width: 90.w,
                  child: Column(
                    children: [
                      Center(
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                  controller: getTSRController.fromController,
                                  style: TextStyle(fontSize: 11.sp),
                                  decoration: InputDecoration(
                                      labelText: AppMetaLabels().from,
                                      prefixIcon: SizedBox(
                                        height: 1.h,
                                        child: Icon(
                                          Icons.calendar_month,
                                        ),
                                      )),
                                  readOnly: true,
                                  onTap: () async {
                                    final dT = await showRoundedDatePicker(
                                      theme: ThemeData(
                                          primaryColor: AppColors.blueColor),
                                      height: 50.0.h,
                                      context: context,
// locale: Locale('en'),
                                      locale:
                                          SessionController().getLanguage() == 1
                                              ? Locale('en', '')
                                              : Locale('ar', ''),
                                      initialDate: DateTime.now(),
                                      firstDate:
                                          DateTime(DateTime.now().year - 10),
                                      lastDate:
                                          DateTime(DateTime.now().year + 10),
                                      borderRadius: 2.0.h,
                                      styleDatePicker:
                                          MaterialRoundedDatePickerStyle(
                                              decorationDateSelected:
                                                  BoxDecoration(
                                                      color: AppColors
                                                          .blueColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100)),
                                              textStyleButtonPositive:
                                                  TextStyle(
                                                color: AppColors.blueColor,
                                              ),
                                              textStyleButtonNegative:
                                                  TextStyle(
                                                color: AppColors.blueColor,
                                              ),
                                              backgroundHeader:
                                                  Colors.grey.shade300,
                                              // Appbar year like '2023' button
                                              textStyleYearButton: AppTextStyle
                                                  .boldBlue30
                                                  .copyWith(
                                                      backgroundColor:
                                                          Colors.grey.shade100,
                                                      leadingDistribution:
                                                          TextLeadingDistribution
                                                              .even),
                                              // Appbar day like 'Thu, Mar 16' button
                                              textStyleDayButton:
                                                  AppTextStyle.normalWhite16

                                              // Heading year like 'S M T W TH FR SA ' button
                                              // textStyleDayHeader: TextStyle(
                                              //   fontSize: 30.sp,
                                              //   color: Colors.white,
                                              //   backgroundColor: Colors.red,
                                              //   decoration: TextDecoration.overline,
                                              //   decorationColor: Colors.pink,
                                              // ),
                                              ),
                                    );
                                    if (!getTSRController.setFromDate(dT!)) {
                                      getTSRController.filterError.value =
                                          AppMetaLabels().validDateRange;
                                    } else {
                                      setState(() {
                                        getTSRController.filterError.value = '';
                                      });
                                    }
                                  }),
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            Expanded(
                              child: TextField(
                                  controller: getTSRController.toController,
                                  style: TextStyle(fontSize: 11.sp),
                                  decoration: InputDecoration(
                                      labelText: AppMetaLabels().to,
                                      prefixIcon: SizedBox(
                                        height: 1.h,
                                        child: Icon(
                                          Icons.calendar_month,
                                        ),
                                      )),
                                  readOnly: true,
                                  onTap: () async {
                                    final dT = await showRoundedDatePicker(
                                      theme: ThemeData(
                                          primaryColor: AppColors.blueColor),
                                      height: 50.0.h,
                                      context: context,
                                      // locale: Locale('en'),
                                      locale:
                                          SessionController().getLanguage() == 1
                                              ? Locale('en', '')
                                              : Locale('ar', ''),
                                      initialDate: DateTime.now(),
                                      firstDate:
                                          DateTime(DateTime.now().year - 10),
                                      lastDate:
                                          DateTime(DateTime.now().year + 10),
                                      borderRadius: 2.0.h,
                                      styleDatePicker:
                                          MaterialRoundedDatePickerStyle(
                                              decorationDateSelected:
                                                  BoxDecoration(
                                                      color: AppColors
                                                          .blueColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100)),
                                              textStyleButtonPositive:
                                                  TextStyle(
                                                color: AppColors.blueColor,
                                              ),
                                              textStyleButtonNegative:
                                                  TextStyle(
                                                color: AppColors.blueColor,
                                              ),
                                              backgroundHeader:
                                                  Colors.grey.shade300,
                                              // Appbar year like '2023' button
                                              textStyleYearButton: AppTextStyle
                                                  .boldBlue30
                                                  .copyWith(
                                                      backgroundColor:
                                                          Colors.grey.shade100,
                                                      leadingDistribution:
                                                          TextLeadingDistribution
                                                              .even),
                                              // Appbar day like 'Thu, Mar 16' button
                                              textStyleDayButton:
                                                  AppTextStyle.normalWhite16

                                              // Heading year like 'S M T W TH FR SA ' button
                                              // textStyleDayHeader: TextStyle(
                                              //   fontSize: 30.sp,
                                              //   color: Colors.white,
                                              //   backgroundColor: Colors.red,
                                              //   decoration: TextDecoration.overline,
                                              //   decorationColor: Colors.pink,
                                              // ),
                                              ),
                                    );

                                    if (!getTSRController.setToDate(dT!)) {
                                      getTSRController.filterError.value =
                                          AppMetaLabels().validDateRange;
                                    } else {
                                      setState(() {
                                        getTSRController.filterError.value = '';
                                      });
                                    }
                                  }),
                            )
                          ],
                        ),
                      ),
                      Obx(() {
                        return getTSRController.filterError.value == ""
                            ? Container()
                            : Padding(
                                padding: EdgeInsets.only(top: 1.0.h),
                                child: Container(
                                  width: 85.0.w,
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(255, 59, 48, 0.6),
                                    borderRadius: BorderRadius.circular(1.0.h),
                                    border: Border.all(
                                      color: Color.fromRGBO(255, 59, 48, 1),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(0.7.h),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.info_outline,
                                          color: Colors.white,
                                          size: 3.5.h,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 1.0.h),
                                          child: Text(
                                            getTSRController.filterError.value,
                                            style: AppTextStyle.semiBoldWhite11,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                      }),
                    ],
                  ),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
                actions: [
                  TextButton(
                    style: ButtonStyle(
                      foregroundColor:
                          WidgetStateProperty.all(AppColors.blueColor),
                      textStyle:
                          WidgetStateProperty.all(AppTextStyle.boldBlack10),
                    ),
                    onPressed: () {
                      if (getTSRController.filterError.value != '') {
                        return;
                      }
                      if (getTSRController.fromDateN.value == '' &&
                          getTSRController.toDateN.value == '') {
                        SnakBarWidget.getSnackBarErrorBlue(
                          AppMetaLabels().alert,
                          AppMetaLabels().pleaseSelectDatesFirst,
                        );
                        return;
                      }

                      if (tabIndex == 0) {
                        getTSRController.getDataFM('');
                        Get.back();
                        setState(() {
                          filterApplied = true;
                        });
                      } else {
                        getTSRController.getDataPM('');
                        Get.back();
                        setState(() {
                          filterApplied = true;
                        });
                      }
                      // getTSRController.getDataPM('');
                      // Get.back();
                      // setState(() {
                      //   filterApplied = true;
                      // });
                    },
                    child: Text(AppMetaLabels().apply),
                  ),
                  // TextButton(
                  //   onPressed: () {
                  //     setState(() {
                  //       getTSRController.fromDate = null;
                  //       getTSRController.toDate = null;
                  //       getTSRController.fromController.clear();
                  //       getTSRController.toController.clear();
                  //       getTSRController.fromController.text = '';
                  //       getTSRController.toController..text = '';
                  //       searchControler.clear();
                  //       getTSRController.toDateN.value = '';
                  //       getTSRController.fromDateN.value = '';
                  //     });
                  //     if (tabIndex == 0) {
                  //       getTSRController.getDataFM('');
                  //     } else {
                  //       getTSRController.getDataPM('');
                  //     }
                  //     Get.back();
                  //     setState(() {
                  //       filterApplied = false;
                  //     });
                  //   },
                  //   child: Text(AppMetaLabels().clear),
                  // ),
                  TextButton(
                    style: ButtonStyle(
                      foregroundColor:
                          WidgetStateProperty.all(AppColors.blueColor),
                      textStyle:
                          WidgetStateProperty.all(AppTextStyle.boldBlack10),
                    ),
                    onPressed: () {
                      setState(() {
                        getTSRController.fromDate = null;
                        getTSRController.toDate = null;
                        getTSRController.fromController.clear();
                        getTSRController.toController.clear();
                        getTSRController.fromController.text = '';
                        getTSRController.toController..text = '';
                        getTSRController.toDateN.value = '';
                        getTSRController.fromDateN.value = '';
                        searchControler.clear();
                      });
                      // if (tabIndex == 0) {
                      //   getTSRController.getDataFM('');
                      // } else {
                      //   getTSRController.getDataPM('');
                      // }
                      getTSRController.getDataPM('');
                      Get.back();
                      setState(() {
                        filterApplied = true;
                      });
                    },
                    child: Text(AppMetaLabels().cancel),
                  ),
                ],
              ),
            );
          });
        });
  }
}

class FMServiceRequests extends StatefulWidget {
  FMServiceRequests({Key? key}) : super(key: key);

  @override
  State<FMServiceRequests> createState() => _FMServiceRequestsState();
}

class _FMServiceRequestsState extends State<FMServiceRequests> {
  final getTSRController = Get.find<GetTenantServiceRequestsController>();

  @override
  void initState() {
    getTSRController.getDataFM('');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return getTSRController.loadingDataFM.value == true
          ? LoadingIndicatorBlue()
          : getTSRController.errorFM.value != ''
              ? Center(
                  child: CustomErrorWidget(
                    errorText: AppMetaLabels().noServiceRequestsFound,
                    errorImage: AppImagesPath.noServicesFound,
                  ),
                )
              : ServiceRequestsList(
                  serviceRequests: getTSRController.serviceRequestsFM,
                  type: 'FM',
                );
    });
  }
}

class PMServiceRequests extends StatefulWidget {
  PMServiceRequests({Key? key}) : super(key: key);

  @override
  State<PMServiceRequests> createState() => _PMServiceRequestsState();
}

class _PMServiceRequestsState extends State<PMServiceRequests> {
  final getTSRController = Get.find<GetTenantServiceRequestsController>();

  @override
  void initState() {
    getTSRController.getDataPM('');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return getTSRController.loadingDataPM.value == true
          ? LoadingIndicatorBlue()
          : getTSRController.errorPM.value != ''
              ? Center(
                  child: CustomErrorWidget(
                    errorText: AppMetaLabels().noServiceRequestsFound,
                    errorImage: AppImagesPath.noServicesFound,
                  ),
                )
              : ServiceRequestsList(
                  serviceRequests: getTSRController.serviceRequestsPM,
                  type: 'PM',
                );
    });
  }
}

class ServiceRequestsList extends StatelessWidget {
  final String? type;
  final List<ServiceRequest>? serviceRequests;
  const ServiceRequestsList({Key? key, this.serviceRequests, this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: serviceRequests!.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(left: 2.0.h, right: 1.0.h),
            child: InkWell(
              onTap: () {
                SessionController().setCaseNo(
                  serviceRequests![index].requestNo.toString(),
                );
                Get.to(
                  () => TenantServiceRequestTabs(
                    requestNo: serviceRequests![index].requestNo.toString(),
                    title: serviceRequests![index].caseType ?? "",
                  ),
                );
              },
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 2.0.h,
                        ),
                        Row(
                          children: [
                            Text(
                              SessionController().getLanguage() == 1
                                  ? serviceRequests![index].category ?? ""
                                  : serviceRequests![index].categoryAR ?? "",
                              style: AppTextStyle.semiBoldGrey10,
                            ),
                            Spacer(),
                            Text(
                              serviceRequests![index].requestNo.toString(),
                              style: AppTextStyle.semiBoldGrey10,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          SessionController().getLanguage() == 1
                              ? serviceRequests![index].subCategory ?? ""
                              : serviceRequests![index].subCategoryAR ?? "",
                          style: AppTextStyle.normalGrey10,
                        ),
                        if (serviceRequests![index].propertyName != null)
                          Padding(
                            padding: EdgeInsets.only(top: 1.0.h),
                            child: Text(
                              SessionController().getLanguage() == 1
                                  ? serviceRequests![index].propertyName ?? ""
                                  : serviceRequests![index].propertyNameAr ??
                                      "",
                              style: AppTextStyle.normalGrey10,
                            ),
                          ),
                        if (serviceRequests![index].unitRefNo != null)
                          Text(
                            serviceRequests![index].unitRefNo ?? '',
                            style: AppTextStyle.semiBoldGrey10,
                          ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Row(
                          children: [
                            Text(
                              serviceRequests![index].date ?? "",
                              style: AppTextStyle.semiBoldGrey10,
                            ),
                            Spacer(),
                            serviceRequests![index].status == ''
                                ? SizedBox()
                                : StatusWidget(
                                    text: SessionController().getLanguage() == 1
                                        ? serviceRequests![index].status ??
                                            "" + ' '
                                        : serviceRequests![index].statusAR ??
                                            '',
                                    valueToCompare:
                                        serviceRequests![index].status,
                                  )
                          ],
                        ),
                        SizedBox(
                          height: 1.0.h,
                        ),
                        index == serviceRequests!.length - 1
                            ? Container()
                            : AppDivider(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 1.8.h, left: 2.w),
                    child: SizedBox(
                      width: 0.15.w,
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: AppColors.grey1,
                        size: 20,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}

// // =====================>
// For Production (Leasing)
// import 'package:fap_properties/data/helpers/session_controller.dart';
// import 'package:fap_properties/utils/constants/assets_path.dart';
// import 'package:fap_properties/utils/constants/meta_labels.dart';
// import 'package:fap_properties/utils/styles/colors.dart';
// import 'package:fap_properties/utils/styles/text_styles.dart';
// import 'package:fap_properties/views/widgets/common_widgets/custom_error_widget.dart';
// import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
// import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
// import 'package:fap_properties/views/widgets/common_widgets/status_widget.dart';
// import 'package:fap_properties/views/tenant/tenant_services_request/tenant_request/tenant_request_list/tenant_request_list_controller.dart';
// import 'package:fap_properties/views/tenant/tenant_services_request/tenant_request_details/tenant_service_request_tab/tenant_service_request_tab.dart';
// import 'package:fap_properties/views/widgets/snackbar_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
// import 'package:get/get.dart';
// import 'package:sizer/sizer.dart';
// import '../../../../../data/models/tenant_models/get_tenant_service_requests_model.dart';

// class TenantRequestList extends StatefulWidget {
//   const TenantRequestList({Key? key}) : super(key: key);

//   @override
//   _TenantRequestListState createState() => _TenantRequestListState();
// }

// class _TenantRequestListState extends State<TenantRequestList> {
//   var getTSRController = Get.put(GetTenantServiceRequestsController());
//   final TextEditingController searchControler = TextEditingController();

//   // should uncomment this for add new request
//   // GlobalKey _toolTipKey = GlobalKey();
//   int tabIndex = 1;
//   bool filterApplied;
//   @override
//   void initState() {
//     super.initState();
//     filterApplied = false;
//   }

//   @override
//   Widget build(BuildContext context) {
//     // should uncomment this for add new request
//     // WidgetsBinding.instance.addPostFrameCallback((_) {
//     //   final dynamic _toolTip = _toolTipKey.currentState;
//     //   _toolTip.ensureTooltipVisible();
//     // });

//     return Directionality(
//       textDirection: SessionController().getLanguage() == 1
//           ? TextDirection.ltr
//           : TextDirection.rtl,
//       child: Scaffold(
//         resizeToAvoidBottomInset: false,
//         backgroundColor: Colors.transparent,
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             Padding(
//               padding: EdgeInsets.only(top: 2.0.h),
//               child: Row(
//                 children: [
//                   SizedBox(
//                     width: 12.2.w,
//                   ),
//                   Spacer(),
//                   Text(
//                     AppMetaLabels().serviceRequests,
//                     style: AppTextStyle.semiBoldWhite15,
//                   ),
//                   Spacer(),
//                   // should uncomment this for add new request
//                   // Tooltip(
//                   //   key: _toolTipKey,
//                   //   message: AppMetaLabels().createNewServiceRequest,
//                   //   verticalOffset: 2.h,
//                   //   margin: EdgeInsets.only(right: 2.h, left: 2.h),
//                   //   padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
//                   //   decoration: BoxDecoration(
//                   //       color: AppColors.chartBlueColor,
//                   //       borderRadius: BorderRadius.only(
//                   //           topLeft: SessionController().getLanguage() == 1
//                   //               ? Radius.circular(8)
//                   //               : Radius.zero,
//                   //           bottomLeft: Radius.circular(8),
//                   //           bottomRight: Radius.circular(8),
//                   //           topRight: SessionController().getLanguage() == 1
//                   //               ? Radius.zero
//                   //               : Radius.circular(8))),
//                   //   child: IconButton(
//                   //     icon: Icon(Icons.add_circle_outline_outlined),
//                   //     iconSize: 4.0.h,
//                   //     color: Colors.white,
//                   //     onPressed: () async {
//                   //       Get.to(() => TenantAddServicesRequest());
//                   //     },
//                   //   ),
//                   // ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.only(left: 2.0.h, right: 2.0.h, top: 4.0.h),
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(1.0.h),
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.all(0.3.h),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: TextField(
//                           controller: searchControler,
//                           onChanged: (value) async {
//                             if (value.isEmpty == false) {
//                               await getTSRController.getDataPM(value.trim());
//                               setState(() {});
//                             }
//                             if (value.isEmpty == true) {
//                               await getTSRController.getDataPM('');
//                               setState(() {});
//                             }
//                           },
//                           decoration: InputDecoration(
//                             filled: true,
//                             fillColor: Colors.grey.withOpacity(0.1),
//                             prefixIcon: Icon(
//                               Icons.search,
//                               size: 2.0.h,
//                               color: Colors.grey,
//                             ),
//                             contentPadding:
//                                 EdgeInsets.only(left: 5.0.w, right: 5.0.h),
//                             focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(0.5.h),
//                               borderSide: BorderSide(
//                                   color: AppColors.whiteColor, width: 0.1.h),
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(0.5.h),
//                               borderSide: BorderSide(
//                                   color: AppColors.whiteColor, width: 0.1.h),
//                             ),
//                             hintText: AppMetaLabels().searchServicesby,
//                             hintStyle: AppTextStyle.normalBlack10
//                                 .copyWith(color: Colors.grey),
//                           ),
//                         ),
//                       ),
//                       IconButton(
//                         onPressed: () {
//                           FocusScope.of(context).unfocus();
//                           setState(() {
//                             searchControler.clear();
//                             getTSRController.fromController.clear();
//                             getTSRController.toController.clear();
//                             getTSRController.fromDate = null;
//                             getTSRController.toDate = null;
//                           });
//                           getTSRController.getDataPM('');
//                         },
//                         icon: Icon(
//                           Icons.refresh,
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             // Maintaince and Leasing
//             Expanded(
//                 child: Stack(
//               children: [
//                 Padding(
//                   padding: EdgeInsets.only(
//                       top: 4.0.h, right: 4.0.w, left: 4.0.w, bottom: 2.h),
//                   child: Container(
//                       width: double.infinity,
//                       height: double.infinity,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(2.0.h),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black12,
//                             blurRadius: 0.5.h,
//                             spreadRadius: 0.1.h,
//                             offset: Offset(0.1.h, 0.1.h),
//                           ),
//                         ],
//                       ),
//                       child: DefaultTabController(
//                         length: 1,
//                         child: Column(
//                           children: [
//                             Padding(
//                               padding: EdgeInsets.only(top: 2.h, bottom: 2.h),
//                               child: Text(
//                                 AppMetaLabels().leasing,
//                                 style: AppTextStyle.normalBlue12,
//                               ),
//                             ),
//                             Divider(
//                               color: AppColors.blueColor,
//                               thickness: 0.25.h,
//                               height: 1.0.h,
//                             ),
//                             SizedBox(
//                               height: 7,
//                             ),
//                             Expanded(
//                               child: TabBarView(
//                                 children: [PMServiceRequests()],
//                               ),
//                             )
//                           ],
//                         ),
//                       )),
//                 ),
//                 Align(
//                   alignment: Alignment.bottomCenter,
//                   child: Padding(
//                     padding: EdgeInsets.only(bottom: 2.h),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         SizedBox(
//                           height: 4.0.h,
//                           width: 25.0.w,
//                           child: ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.white,
//                             ),
//                             onPressed: () async {
//                               setState(() {
//                                 getTSRController.filterError.value = '';
//                                 getTSRController.fromController.text = '';
//                                 getTSRController.toController.text = '';
//                                 getTSRController.fromController.clear();
//                                 getTSRController.toController.clear();
//                               });

//                               searchControler.clear();
//                               showFiltersDialog(context);
//                             },
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Icon(
//                                   Icons.format_align_center,
//                                   size: 2.0.h,
//                                   color: Colors.black,
//                                 ),
//                                 Text(
//                                   AppMetaLabels().filter,
//                                   style: AppTextStyle.semiBoldBlack11,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           width: 1.h,
//                         ),
//                         if (filterApplied)
//                           SizedBox(
//                             height: 4.0.h,
//                             width: SessionController().getLanguage() == 1
//                                 ? 25.0.w
//                                 : 40.0.w,
//                             child: ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.white,
//                               ),
//                               onPressed: () async {
//                                 setState(() {
//                                   getTSRController.fromDate = null;
//                                   getTSRController.toDate = null;
//                                   getTSRController.fromController.clear();
//                                   getTSRController.toController.clear();
//                                   searchControler.clear();
//                                   getTSRController.fromDateN.value = '';
//                                   getTSRController.toDateN.value = '';
//                                 });
//                                 getTSRController.getDataPM('');
//                                 Get.back();
//                                 setState(() {
//                                   filterApplied = false;
//                                 });
//                               },
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceAround,
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   Icon(
//                                     Icons.close,
//                                     size: 2.0.h,
//                                     color: Colors.black,
//                                   ),
//                                   Text(
//                                     AppMetaLabels().clear,
//                                     style: AppTextStyle.semiBoldBlack11,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             )),
//           ],
//         ),
//       ),
//     );
//   }

//   void showFiltersDialog(BuildContext context) {
//     showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return Obx(() {
//             return Directionality(
//               textDirection: SessionController().getLanguage() == 1
//                   ? TextDirection.ltr
//                   : TextDirection.rtl,
//               child: AlertDialog(
//                 title: Text(AppMetaLabels().filterSR),
//                 content: SizedBox(
//                   height: getTSRController.filterError.value != '' ? 15.h : 8.h,
//                   width: 90.w,
//                   child: Column(
//                     children: [
//                       Center(
//                         child: Row(
//                           children: [
//                             Expanded(
//                               child: TextField(
//                                   controller: getTSRController.fromController,
//                                   style: TextStyle(fontSize: 11.sp),
//                                   decoration: InputDecoration(
//                                       labelText: AppMetaLabels().from,
//                                       prefixIcon: SizedBox(
//                                         height: 1.h,
//                                         child: Icon(
//                                           Icons.calendar_month,
//                                         ),
//                                       )),
//                                   readOnly: true,
//                                   onTap: () async {
//                                     final dT = await showRoundedDatePicker(
//                                       height: 50.0.h,
//                                       context: context,
//                                       // locale: Locale('en'),
//                                       locale:
//                                           SessionController().getLanguage() == 1
//                                               ? Locale('en', '')
//                                               : Locale('ar', ''),
//                                       initialDate: DateTime.now(),
//                                       firstDate:
//                                           DateTime(DateTime.now().year - 10),
//                                       lastDate:
//                                           DateTime(DateTime.now().year + 10),
//                                       borderRadius: 2.0.h,
//          styleDatePicker:
//                                         MaterialRoundedDatePickerStyle(
//                                       backgroundHeader: Colors.grey.shade300,
//                                       // Appbar year like '2023' button
//                                       textStyleYearButton: AppTextStyle
                                                  // .boldBlue30
                                                  // .copyWith(
                                                  //     backgroundColor:
                                                  //         Colors.grey.shade100,
                                                  //     leadingDistribution:
                                                  //         TextLeadingDistribution
                                                  //             .even),
//                                       // Appbar day like 'Thu, Mar 16' button
//                                       textStyleDayButton: AppTextStyle.normalWhite16

//                                       // Heading year like 'S M T W TH FR SA ' button
//                                       // textStyleDayHeader: TextStyle(
//                                       //   fontSize: 30.sp,
//                                       //   color: Colors.white,
//                                       //   backgroundColor: Colors.red,
//                                       //   decoration: TextDecoration.overline,
//                                       //   decorationColor: Colors.pink,
//                                       // ),
//                                     ),
//                                     );
//                                     if (!getTSRController.setFromDate(dT)) {
//                                       getTSRController.filterError.value =
//                                           AppMetaLabels().validDateRange;
//                                     } else {
//                                       setState(() {
//                                         getTSRController.filterError.value = '';
//                                       });
//                                     }
//                                   }),
//                             ),
//                             SizedBox(
//                               width: 2.w,
//                             ),
//                             Expanded(
//                               child: TextField(
//                                   controller: getTSRController.toController,
//                                   style: TextStyle(fontSize: 11.sp),
//                                   decoration: InputDecoration(
//                                       labelText: AppMetaLabels().to,
//                                       prefixIcon: SizedBox(
//                                         height: 1.h,
//                                         child: Icon(
//                                           Icons.calendar_month,
//                                         ),
//                                       )),
//                                   readOnly: true,
//                                   onTap: () async {
//                                     final dT = await showRoundedDatePicker(
//                                       height: 50.0.h,
//                                       context: context,
//                                       // locale: Locale('en'),
//                                       locale:
//                                           SessionController().getLanguage() == 1
//                                               ? Locale('en', '')
//                                               : Locale('ar', ''),
//                                       initialDate: DateTime.now(),
//                                       firstDate:
//                                           DateTime(DateTime.now().year - 10),
//                                       lastDate:
//                                           DateTime(DateTime.now().year + 10),
//                                       borderRadius: 2.0.h,
//          styleDatePicker:
//                                         MaterialRoundedDatePickerStyle(
//                                       backgroundHeader: Colors.grey.shade300,
//                                       // Appbar year like '2023' button
//                                       textStyleYearButton: AppTextStyle
                                                  // .boldBlue30
                                                  // .copyWith(
                                                  //     backgroundColor:
                                                  //         Colors.grey.shade100,
                                                  //     leadingDistribution:
                                                  //         TextLeadingDistribution
                                                  //             .even),
//                                       // Appbar day like 'Thu, Mar 16' button
//                                       textStyleDayButton: AppTextStyle.normalWhite16

//                                       // Heading year like 'S M T W TH FR SA ' button
//                                       // textStyleDayHeader: TextStyle(
//                                       //   fontSize: 30.sp,
//                                       //   color: Colors.white,
//                                       //   backgroundColor: Colors.red,
//                                       //   decoration: TextDecoration.overline,
//                                       //   decorationColor: Colors.pink,
//                                       // ),
//                                     ),
//                                     );

//                                     if (!getTSRController.setToDate(dT)) {
//                                       getTSRController.filterError.value =
//                                           AppMetaLabels().validDateRange;
//                                     } else {
//                                       setState(() {
//                                         getTSRController.filterError.value = '';
//                                       });
//                                     }
//                                   }),
//                             )
//                           ],
//                         ),
//                       ),
//                       Obx(() {
//                         return getTSRController.filterError.value == ""
//                             ? Container()
//                             : Padding(
//                                 padding: EdgeInsets.only(top: 1.0.h),
//                                 child: Container(
//                                   width: 85.0.w,
//                                   decoration: BoxDecoration(
//                                     color: Color.fromRGBO(255, 59, 48, 0.6),
//                                     borderRadius: BorderRadius.circular(1.0.h),
//                                     border: Border.all(
//                                       color: Color.fromRGBO(255, 59, 48, 1),
//                                     ),
//                                   ),
//                                   child: Padding(
//                                     padding: EdgeInsets.all(0.7.h),
//                                     child: Row(
//                                       children: [
//                                         Icon(
//                                           Icons.info_outline,
//                                           color: Colors.white,
//                                           size: 3.5.h,
//                                         ),
//                                         Padding(
//                                           padding: EdgeInsets.only(left: 1.0.h),
//                                           child: Text(
//                                             getTSRController.filterError.value,
//                                             style: AppTextStyle.semiBoldWhite11,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               );
//                       }),
//                     ],
//                   ),
//                 ),
//                 contentPadding:
//                     EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
//                 actions: [
//                   TextButton(
//  style: ButtonStyle(
//                       foregroundColor:
//                           WidgetStateProperty.all(AppColors.blueColor),
//                       textStyle: WidgetStateProperty.all(
//                           AppTextStyle.boldBlack10
                         
//                           ),
//                     ),
//                     onPressed: () {
//                       if (getTSRController.fromDateN.value == '' &&
//                           getTSRController.toDateN.value == '') {
//                         SnakBarWidget.getSnackBarErrorBlue(
//                           AppMetaLabels().alert,
//                           AppMetaLabels().pleaseSelectDatesFirst,
//                         );
//                         return;
//                       }
//                       getTSRController.getDataPM('');

//                       Get.back();
//                       setState(() {
//                         filterApplied = true;
//                       });
//                     },
//                     child: Text(AppMetaLabels().apply),
//                   ),
//                   // TextButton(
//                   //   onPressed: () {
//                   //     setState(() {
//                   //       getTSRController.fromDate = null;
//                   //       getTSRController.toDate = null;
//                   //       getTSRController.fromController.clear();
//                   //       getTSRController.toController.clear();
//                   //       getTSRController.fromDateN.value = '';
//                   //       getTSRController.toDateN.value = '';
//                   //       searchControler.clear();
//                   //     });
//                   //     // getTSRController.getDataPM('');
//                   //     // Get.back();
//                   //     setState(() {
//                   //       filterApplied = false;
//                   //     });
//                   //   },
//                   //   child: Text(AppMetaLabels().clear),
//                   // ),
//                   TextButton(
// style: ButtonStyle(
//                       foregroundColor:
//                           WidgetStateProperty.all(AppColors.blueColor),
//                       textStyle:
//                           WidgetStateProperty.all(AppTextStyle.boldBlack10),
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         getTSRController.fromDate = null;
//                         getTSRController.toDate = null;
//                         getTSRController.fromController.clear();
//                         getTSRController.toController.clear();
//                         searchControler.clear();
//                         getTSRController.fromDateN.value = '';
//                         getTSRController.toDateN.value = '';
//                       });
//                       getTSRController.getDataPM('');
//                       Get.back();
//                     },
//                     child: Text(AppMetaLabels().cancel),
//                   ),
//                 ],
//               ),
//             );
//           });
//         });
//   }
// }

// class FMServiceRequests extends StatefulWidget {
//   FMServiceRequests({Key? key}) : super(key: key);

//   @override
//   State<FMServiceRequests> createState() => _FMServiceRequestsState();
// }

// class _FMServiceRequestsState extends State<FMServiceRequests> {
//   final getTSRController = Get.find<GetTenantServiceRequestsController>();

//   @override
//   void initState() {
//     getTSRController.getDataPM('');
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       return getTSRController.loadingDataFM.value == true
//           ? LoadingIndicatorBlue()
//           : getTSRController.errorFM.value != ''
//               ? Center(
//                   child: CustomErrorWidget(
//                     errorText: AppMetaLabels().noServiceRequestsFound,
//                     errorImage: AppImagesPath.noServicesFound,
//                   ),
//                 )
//               : ServiceRequestsList(
//                   serviceRequests: getTSRController.serviceRequestsFM,
//                   type: 'FM',
//                 );
//     });
//   }
// }

// class PMServiceRequests extends StatefulWidget {
//   PMServiceRequests({Key? key}) : super(key: key);

//   @override
//   State<PMServiceRequests> createState() => _PMServiceRequestsState();
// }

// class _PMServiceRequestsState extends State<PMServiceRequests> {
//   final getTSRController = Get.find<GetTenantServiceRequestsController>();

//   @override
//   void initState() {
//     getTSRController.getDataPM('');
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       return getTSRController.loadingDataPM.value == true
//           ? LoadingIndicatorBlue()
//           : getTSRController.errorPM.value != ''
//               ? Center(
//                   child: CustomErrorWidget(
//                     errorText: AppMetaLabels().noServiceRequestsFound,
//                     errorImage: AppImagesPath.noServicesFound,
//                   ),
//                 )
//               : ServiceRequestsList(
//                   serviceRequests: getTSRController.serviceRequestsPM,
//                   type: 'PM',
//                 );
//     });
//   }
// }

// class ServiceRequestsList extends StatelessWidget {
//   final String type;
//   final List<ServiceRequest> serviceRequests;
//   const ServiceRequestsList({Key key, this.serviceRequests, this.type})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//         padding: EdgeInsets.zero,
//         shrinkWrap: true,
//         itemCount: serviceRequests.length,
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: EdgeInsets.only(left: 2.0.h, right: 1.0.h),
//             child: InkWell(
//               onTap: () {
//                 print(
//                     'Req No :::: ${serviceRequests[index].requestNo.toString()}');
//                 SessionController().setCaseNo(
//                   serviceRequests[index].requestNo.toString(),
//                 );
//                 Get.to(
//                   () => TenantServiceRequestTabs(
//                     requestNo: serviceRequests[index].requestNo.toString(),
//                     title: serviceRequests[index].caseType,
//                     caller: 'ServiceRequestTab',
//                   ),
//                 );
//               },
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SizedBox(
//                           height: 2.0.h,
//                         ),
//                         Row(
//                           children: [
//                             Text(
//                               SessionController().getLanguage() == 1
//                                   ? serviceRequests[index].category ?? ""
//                                   : serviceRequests[index].categoryAR ?? "",
//                               style: AppTextStyle.semiBoldGrey10,
//                             ),
//                             Spacer(),
//                             Text(
//                               serviceRequests[index].requestNo.toString() ?? "",
//                               style: AppTextStyle.semiBoldGrey10,
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: 1.h,
//                         ),
//                         Text(
//                           SessionController().getLanguage() == 1
//                               ? serviceRequests[index].subCategory ?? ""
//                               : serviceRequests[index].subCategoryAR ?? "",
//                           style: AppTextStyle.normalGrey10,
//                         ),
//                         if (serviceRequests[index].propertyName != null)
//                           Padding(
//                             padding: EdgeInsets.only(top: 1.0.h),
//                             child: Text(
//                               SessionController().getLanguage() == 1
//                                   ? serviceRequests[index].propertyName ?? ""
//                                   : serviceRequests[index].propertyNameAr ?? "",
//                               style: AppTextStyle.normalGrey10,
//                             ),
//                           ),
//                         if (serviceRequests[index].unitRefNo != null)
//                           Text(
//                             serviceRequests[index].unitRefNo ?? '',
//                             style: AppTextStyle.semiBoldGrey10,
//                           ),
//                         SizedBox(
//                           height: 1.h,
//                         ),
//                         Row(
//                           children: [
//                             Text(
//                               serviceRequests[index].date ?? "",
//                               style: AppTextStyle.semiBoldGrey10,
//                             ),
//                             Spacer(),
//                             // status null 112233
//                             serviceRequests[index].status == ''
//                                 ? SizedBox()
//                                 : StatusWidget(
//                                     text: SessionController().getLanguage() == 1
//                                         ? serviceRequests[index].status + '' ??
//                                             ""
//                                         : serviceRequests[index].statusAR ?? '',
//                                     valueToCompare:
//                                         serviceRequests[index].status,
//                                   )
//                           ],
//                         ),
//                         SizedBox(
//                           height: 1.0.h,
//                         ),
//                         index == serviceRequests.length - 1
//                             ? Container()
//                             : AppDivider(),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(right: 1.8.h, left: 2.w),
//                     child: SizedBox(
//                       width: 0.15.w,
//                       child: Icon(
//                         Icons.arrow_forward_ios_rounded,
//                         color: AppColors.grey1,
//                         size: 20,
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           );
//         });
//   }
// }
