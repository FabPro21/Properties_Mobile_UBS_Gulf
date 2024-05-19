import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/landlord/landlord_reports/landlord_report_details/landlord_report_property/landlord_report_properties_controller.dart';
import 'package:fap_properties/views/widgets/common_widgets/custom_error_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'dart:ui' as ui;

class LandlordReportProperties extends StatefulWidget {
  final String dropDownType;
  const LandlordReportProperties({Key key, @required this.dropDownType})
      : super(key: key);

  @override
  _LandlordReportPropertiesState createState() =>
      _LandlordReportPropertiesState();
}

class _LandlordReportPropertiesState extends State<LandlordReportProperties> {
  final LandLordReportPropertiesController _filterPropertyController =
      Get.put(LandLordReportPropertiesController());

  @override
  void initState() {
    // _filterPropertyController.getProperties();
    getData();
    super.initState();
  }

  getData() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print('DropDownType ::::::::: ${widget.dropDownType}');
      _filterPropertyController.getDropdownType(widget.dropDownType);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: SessionController().getLanguage() == 1
          ? ui.TextDirection.ltr
          : ui.TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        // backgroundColor: Colors.black,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(4.0.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      widget.dropDownType == '7'
                          ? AppMetaLabels().cheque +
                              ' ' +
                              AppMetaLabels().status
                          : widget.dropDownType == '6'
                              ? AppMetaLabels().unit +
                                  ' ' +
                                  AppMetaLabels().status
                              : widget.dropDownType == '5'
                                  ? AppMetaLabels().transactionID
                                  : widget.dropDownType == '4'
                                      ? AppMetaLabels().property
                                      : widget.dropDownType == '3'
                                          ? AppMetaLabels().contractor1
                                          : widget.dropDownType == '2'
                                              ? AppMetaLabels().contract +
                                                  ' ' +
                                                  AppMetaLabels().category
                                              : AppMetaLabels()
                                                  .servieContractStatus,
                      style: AppTextStyle.semiBoldBlack16,
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        Get.back(result: null);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromRGBO(118, 118, 128, 0.12),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(0.5.h),
                          child: Icon(Icons.close,
                              size: 2.0.h,
                              color: Color.fromRGBO(158, 158, 158, 1)),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 1.0.h,
                ),
                AppDivider(),
                ////////////////////////////////////
                ////   Property
                ////////////////////////////////////
                SizedBox(
                  height: 1.0.h,
                ),
                Expanded(
                  child: Obx(() {
                    return _filterPropertyController.loading.value
                        ? Center(
                            child: LoadingIndicatorBlue(),
                          )
                        : _filterPropertyController.errorDropdownType.value !=
                                    '' ||
                                _filterPropertyController
                                        .getDropDownModelList.length ==
                                    0
                            ? CustomErrorWidget(
                                errorText: _filterPropertyController
                                    .errorDropdownType.value,
                                errorImage: AppImagesPath.noDataFound,
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                itemCount: _filterPropertyController
                                    .getDropDownModelList.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      Get.back(
                                          result: _filterPropertyController
                                              .getDropDownModelList[index]);
                                      // Get.back(
                                      //     result: _filterPropertyController
                                      //         .listOfProperties[index]);9
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 1.0.h),
                                        Text(
                                          SessionController().getLanguage() == 1
                                              ? _filterPropertyController
                                                      .getDropDownModelList[
                                                          index]
                                                      .name ??
                                                  ""
                                              : _filterPropertyController
                                                      .getDropDownModelList[
                                                          index]
                                                      .nameAr ??
                                                  "",
                                          // SessionController().getLanguage() == 1
                                          //     ? _filterPropertyController
                                          //             .listOfProperties[index]
                                          //             .propertyName ??
                                          //         ""
                                          //     : _filterPropertyController
                                          //         .listOfProperties[index]
                                          //         .propertyNameAR,
                                        ),
                                        SizedBox(height: 2.0.h),
                                        index ==
                                                _filterPropertyController
                                                        .getDropDownModelList
                                                        .length -
                                                    1
                                            ? Container()
                                            : AppDivider(),
                                        // index ==
                                        //         _filterPropertyController
                                        //                 .proppertyTypesLength -
                                        //             1
                                        //     ? Container()
                                        //     : AppDivider(),
                                        SizedBox(height: 1.0.h),
                                      ],
                                    ),
                                  );
                                });
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// import 'package:fap_properties/data/helpers/session_controller.dart';
// import 'package:fap_properties/utils/constants/assets_path.dart';
// import 'package:fap_properties/utils/constants/meta_labels.dart';
// import 'package:fap_properties/utils/styles/text_styles.dart';
// import 'package:fap_properties/views/landlord/landlord_reports/landlord_report_details/landlord_report_property/landlord_report_properties_controller.dart';
// import 'package:fap_properties/views/widgets/common_widgets/custom_error_widget.dart';
// import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
// import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sizer/sizer.dart';
// import 'dart:ui' as ui;

// class LandlordReportProperties extends StatefulWidget {
//   const LandlordReportProperties({Key key}) : super(key: key);

//   @override
//   _LandlordReportPropertiesState createState() =>
//       _LandlordReportPropertiesState();
// }

// class _LandlordReportPropertiesState
//     extends State<LandlordReportProperties> {
//   final LandLordReportPropertiesController _filterPropertyController =
//       Get.put(LandLordReportPropertiesController());

//   @override
//   void initState() {
//     _filterPropertyController.getProperties();
//     // _filterPropertyController.getPropertyTypes();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: SessionController().getLanguage() == 1
//           ? ui.TextDirection.ltr
//           : ui.TextDirection.rtl,
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         // backgroundColor: Colors.black,
//         body: SafeArea(
//           child: Padding(
//             padding: EdgeInsets.all(4.0.h),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     Text(
//                       AppMetaLabels().propertyType,
//                       style: AppTextStyle.semiBoldBlack16,
//                     ),
//                     Spacer(),
//                     InkWell(
//                       onTap: () {
//                         Get.back();
//                       },
//                       child: Container(
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: Color.fromRGBO(118, 118, 128, 0.12),
//                         ),
//                         child: Padding(
//                           padding: EdgeInsets.all(0.5.h),
//                           child: Icon(Icons.close,
//                               size: 2.0.h,
//                               color: Color.fromRGBO(158, 158, 158, 1)),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 1.0.h,
//                 ),
//                 AppDivider(),
//                 ////////////////////////////////////
//                 ////   Property
//                 ////////////////////////////////////
//                 SizedBox(
//                   height: 1.0.h,
//                 ),
//                 Expanded(
//                   child: Obx(() {
//                     return _filterPropertyController.loading.value ||
// _filterPropertyController
//     .isLoadingDropdownType.value
//                         ? Center(
//                             child: LoadingIndicatorBlue(),
//                           )
//                         : _filterPropertyController.error.value != ''
//                             ?  CustomErrorWidget(
//                                 errorText: _filterPropertyController.error.value,
//                                 errorImage: AppImagesPath.noDataFound,
//                               )
//                             : ListView.builder(
//                                 shrinkWrap: true,
//                                 itemCount: _filterPropertyController
//                                     .proppertyTypesLength,
//                                 itemBuilder: (context, index) {
//                                   return InkWell(
//                                     onTap: () {
//                                       Get.back(
//                                           result: _filterPropertyController
//                                               .propertyTypesModel
//                                               .value
//                                               .propertyType[index]);
//                                     },
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         SizedBox(height: 1.0.h),
//                                         Text(
//                                           SessionController().getLanguage() == 1
//                                               ? _filterPropertyController
//                                                       .propertyTypesModel
//                                                       .value
//                                                       .propertyType[index]
//                                                       .propertyType ??
//                                                   ""
//                                               : _filterPropertyController
//                                                   .propertyTypesModel
//                                                   .value
//                                                   .propertyType[index]
//                                                   .propertyTypeAR,
//                                         ),
//                                         SizedBox(height: 2.0.h),
//                                         index ==
//                                                 _filterPropertyController
//                                                         .proppertyTypesLength -
//                                                     1
//                                             ? Container()
//                                             : AppDivider(),
//                                         SizedBox(height: 1.0.h),
//                                       ],
//                                     ),
//                                   );
//                                 });
//                   }),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
