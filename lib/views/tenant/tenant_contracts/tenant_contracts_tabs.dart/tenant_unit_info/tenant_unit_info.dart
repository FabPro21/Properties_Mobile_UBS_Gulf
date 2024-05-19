import 'dart:typed_data';

import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/widgets/common_widgets/custom_error_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:fap_properties/views/tenant/tenant_contracts/tenant_contracts_tabs.dart/tenant_unit_info/tenant_unit_info_controller.dart';
import 'package:fap_properties/views/tenant/tenant_contracts/tenant_contracts_tabs.dart/tenant_unit_info/tenant_unit_info_details.dart';
import 'package:fap_properties/views/widgets/bottom_shadow.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

class UnitInfo extends StatefulWidget {
  const UnitInfo({Key key}) : super(key: key);

  @override
  _UnitInfoState createState() => _UnitInfoState();
}

class _UnitInfoState extends State<UnitInfo> {
  final unitInfoController = Get.put(UnitInfoController());

  String propertyName = "";
  String amount = "";

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Obx(() {
          return unitInfoController.loadingData.value == true
              ? LoadingIndicatorBlue()
              : unitInfoController.error.value != ''
                  ? CustomErrorWidget(
                      errorText: unitInfoController.error.value,
                      errorImage: AppImagesPath.noServicesFound,
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(vertical: 2.h),
                      itemCount: unitInfoController.length,
                      itemBuilder: (context, index) {
                        String propName = SessionController().getLanguage() == 1
                            ? unitInfoController.unitInfo.value
                                .contractUnits[index].propertyName
                            : unitInfoController.unitInfo.value
                                .contractUnits[index].propertyNameAr;
                        if (propName.contains(" ")) {
                          List<String> mystring = propName.split(" ");
                          String a = mystring[0] + mystring[1];
                          String b = mystring[1];
                          propertyName = a[0] + b[0];
                        } else {
                          String mystring = propName;
                          propertyName = mystring[0];
                        }
                        double am = unitInfoController
                            .unitInfo.value.contractUnits[index].amount;
                        final paidFormatter = NumberFormat('#,##0.00', 'AR');
                        amount = paidFormatter.format(am);
                        // unitInfoController.getImage(index);
                        return InkWell(
                          onTap: () {
                            SessionController().setContractUnitID(
                                unitInfoController.unitInfo.value
                                    .contractUnits[index].unitId);
                            Get.to(() => UnitInfoDetails(
                                  unitRefNo: unitInfoController.unitInfo.value
                                      .contractUnits[index].unitRefNo,
                                ));
                          },
                          child: Padding(
                            padding: EdgeInsets.all(2.0.h),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4.0.h),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 0.5.h,
                                    spreadRadius: 0.3.h,
                                    offset: Offset(0.1.h, 0.1.h),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    color: Colors.transparent,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(4.0.h),
                                          topRight: Radius.circular(4.0.h),
                                        ),
                                        child: Container(
                                          height: 36.0.h,
                                          width: 100.0.w,
                                          color: Colors.grey[300],
                                          child: StreamBuilder<Uint8List>(
                                            stream: unitInfoController
                                                .getImage(index),
                                            builder: (
                                              BuildContext context,
                                              AsyncSnapshot<Uint8List> snapshot,
                                            ) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(2.0.h),
                                                    topRight:
                                                        Radius.circular(2.0.h),
                                                  ),
                                                  child: SizedBox(
                                                    height: 36.0.h,
                                                    width: 100.0.w,
                                                    child: Shimmer.fromColors(
                                                      baseColor: Colors.grey
                                                          .withOpacity(0.1),
                                                      highlightColor: Colors
                                                          .grey
                                                          .withOpacity(0.5),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  2.0.h),
                                                          topRight:
                                                              Radius.circular(
                                                                  2.0.h),
                                                        ),
                                                        child: Image.asset(
                                                            AppImagesPath
                                                                .thumbnail,
                                                            fit: BoxFit.cover),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }
                                              if (snapshot.hasData) {
                                                return Image.memory(
                                                  snapshot.data,
                                                  fit: BoxFit.cover,
                                                );
                                              } else {
                                                return Center(
                                                  child: Text(
                                                    propertyName,
                                                    style: AppTextStyle
                                                        .semiBoldBlack16
                                                        .copyWith(
                                                      color: Colors.black,
                                                      fontSize: 30.0.sp,
                                                    ),
                                                  ),
                                                );
                                              }
                                            },
                                          ),
                                        )),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: 2.0.h,
                                      bottom: 1.0.h,
                                      left: 2.0.h,
                                      right: 2.0.h,
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 76.0.w,
                                          // color: Colors.red,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 80.0.w,
                                                child: Text(
                                                  SessionController()
                                                              .getLanguage() ==
                                                          1
                                                      ? unitInfoController
                                                          .unitInfo
                                                          .value
                                                          .contractUnits[index]
                                                          .propertyName
                                                      : unitInfoController
                                                          .unitInfo
                                                          .value
                                                          .contractUnits[index]
                                                          .propertyNameAr,
                                                  style: AppTextStyle
                                                      .semiBoldGrey12,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              SizedBox(height: 1.0.h),
                                              Row(
                                                children: [
                                                  Text(
                                                    AppMetaLabels().unitRefNo,
                                                    style: AppTextStyle
                                                        .normalGrey11,
                                                  ),
                                                  Spacer(),
                                                  Text(
                                                    "${unitInfoController.unitInfo.value.contractUnits[index].unitRefNo}" ??
                                                        "",
                                                    style: AppTextStyle
                                                        .normalGrey11,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 1.0.h),
                                              Row(
                                                children: [
                                                  Text(
                                                    AppMetaLabels().unitType,
                                                    style: AppTextStyle
                                                        .normalGrey11,
                                                  ),
                                                  Spacer(),
                                                  Text(
                                                    SessionController()
                                                                .getLanguage() ==
                                                            1
                                                        ? unitInfoController
                                                                .unitInfo
                                                                .value
                                                                .contractUnits[
                                                                    index]
                                                                .unitType ??
                                                            ""
                                                        : unitInfoController
                                                                .unitInfo
                                                                .value
                                                                .contractUnits[
                                                                    index]
                                                                .unitTypeAr ??
                                                            "",
                                                    style: AppTextStyle
                                                        .normalGrey11,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 1.0.h),
                                              Row(
                                                children: [
                                                  Text(
                                                    AppMetaLabels().rent,
                                                    style: AppTextStyle
                                                        .normalGrey11,
                                                  ),
                                                  Spacer(),
                                                  Text(
                                                    "${AppMetaLabels().aed} ${amount ?? 0.0}",
                                                    style: AppTextStyle
                                                        .normalGrey11,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 1.0.h),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              right: 0.3.h, left: 1.2.h),
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
                                ],
                              ),
                            ),
                          ),
                        );
                      });
        }),
        BottomShadow(),
      ],
    );
  }
}
