import 'dart:typed_data';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/landlord/landlord_contracts/landlord_contract_details_tabs/landlord_contract_unit_info/landlord_unit_info_controller.dart';
import 'package:fap_properties/views/landlord/landlord_properties/landlord_property_details_tab/landlord_property_unit_info/landlord_property_unit_Info_details.dart';
import 'package:fap_properties/views/widgets/bottom_shadow.dart';
import 'package:fap_properties/views/widgets/common_widgets/custom_error_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class LandlordContractUnitInfo extends StatefulWidget {
  final int contractId;
  const LandlordContractUnitInfo({ Key? key, required this.contractId})
      : super(key: key);

  @override
  _LandlordContractUnitInfoState createState() =>
      _LandlordContractUnitInfoState();
}

class _LandlordContractUnitInfoState extends State<LandlordContractUnitInfo> {
  final controller = Get.put(LandlordUnitInfoController());
  @override
  void initState() {
    controller.getUnits(widget.contractId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Obx(() {
          return controller.loadingUnits.value
              ? LoadingIndicatorBlue()
              : controller.errorLoadingUnits != ''
                  ? CustomErrorWidget(
                      errorText: controller.errorLoadingUnits,
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(vertical: 2.h),
                      itemCount: controller.contractUnits.contractUnits?.length,
                      itemBuilder: (context, index) {
                        String unitShortName;
                        final unit =
                            controller.contractUnits.contractUnits![index];
                        if (unit.propertyName!.contains(" ")) {
                          List<String> mystring = unit.propertyName!.split(" ");
                          unitShortName = mystring[0][0] + mystring[1][0];
                        } else {
                          unitShortName = unit.propertyName?[0]??"";
                        }

                        final paidFormatter = NumberFormat('#,##0.00', 'AR');
                        String amount = paidFormatter.format(unit.amount);

                        return InkWell(
                          onTap: () {},
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
                                            // stream: controller.getUnitImage(contractId),
                                            builder: (
                                              BuildContext context,
                                              AsyncSnapshot<Uint8List> snapshot,
                                            ) {
                                              if (snapshot.hasData) {
                                                return Image.memory(
                                                  snapshot.data!,
                                                  fit: BoxFit.cover,
                                                );
                                              } else {
                                                return Center(
                                                  child: Text(
                                                    unitShortName ,
                                                    style: AppTextStyle
                                                        .semiBoldBlack16
                                                        .copyWith(
                                                      color: Colors.black,
                                                      fontSize: 30.0.sp,
                                                    ),
                                                  ),
                                                );
                                              }
                                            }, stream: null,
                                          ),
                                        )),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.to(
                                        () => LandlordPropertyUnitInfoDetails(
                                          unitID: controller.contractUnits
                                              .contractUnits?[index].unitId
                                              .toString()??"",
                                        ),
                                      );
                                    },
                                    child: Padding(
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
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: 80.0.w,
                                                  child: Text(
                                                    SessionController()
                                                                .getLanguage() ==
                                                            1
                                                        ? unit.propertyName ??
                                                            ''
                                                        : unit.propertyNameAr ??
                                                            "",
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
                                                      "${unit.unitRefNo}",
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
                                                          ? unit.unitType ?? ''
                                                          : unit.unitTypeAr ??
                                                              '',
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
                                                      '${AppMetaLabels().aed} $amount',
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
                                            padding: SessionController()
                                                        .getLanguage() ==
                                                    1
                                                ? EdgeInsets.only(
                                                    right: 0.3.h, left: 1.2.h)
                                                : EdgeInsets.only(
                                                    right: 1.2.h, left: 0.2.h),
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
