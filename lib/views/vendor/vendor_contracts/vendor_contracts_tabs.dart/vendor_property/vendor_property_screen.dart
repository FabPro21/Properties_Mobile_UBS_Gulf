import 'dart:typed_data';

import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/widgets/common_widgets/error_text_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:fap_properties/views/vendor/vendor_contracts/vendor_contracts_tabs.dart/vendor_property/vendor_property_controller.dart';
import 'package:fap_properties/views/widgets/bottom_shadow.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class VendorPropertyScreen extends StatefulWidget {
  const VendorPropertyScreen({Key? key}) : super(key: key);

  @override
  _UnitInfoState createState() => _UnitInfoState();
}

class _UnitInfoState extends State<VendorPropertyScreen> {
  final vendorPropertiesController = Get.put(VendorPropertiesController());

  @override
  void initState() {
    super.initState();
  }

  String amount = "";
  String propertyName = "";
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BottomShadow(),
        Obx(() {
          return vendorPropertiesController.loadingData.value == true
              ? Padding(
                  padding: EdgeInsets.only(top: 0.0.h),
                  child: LoadingIndicatorBlue(),
                )
              : vendorPropertiesController.error.value != ''
                  ? Padding(
                      padding: EdgeInsets.only(top: 0.0.h),
                      child: AppErrorWidget(
                        errorText: vendorPropertiesController.error.value,
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: vendorPropertiesController.length,
                      itemBuilder: (context, index) {
                        if (vendorPropertiesController.vendorProperty.value
                            .contractProperties![index].propertyName!
                            .contains(" ")) {
                          List<String> mystring =
                              SessionController().getLanguage() == 1
                                  ? vendorPropertiesController
                                      .vendorProperty
                                      .value
                                      .contractProperties![index]
                                      .propertyName!
                                      .split(" ")
                                  : vendorPropertiesController
                                      .vendorProperty
                                      .value
                                      .contractProperties![index]
                                      .propertyNameAr!
                                      .split(" ");

                          String a = mystring[0] + mystring[1];
                          String b = mystring[1];
                          propertyName = a[0] + b[0];
                        } else {
                          String mystring = vendorPropertiesController
                                  .vendorProperty
                                  .value
                                  .contractProperties?[index]
                                  .propertyName ??
                              "";
                          propertyName = mystring[0];
                        }
                        //////////////////////////
                        /// Amount
                        //////////////////////////
                        var a = vendorPropertiesController.vendorProperty.value
                            .contractProperties?[index].amount;
                        final dFormatter = NumberFormat('#,##0.00', 'AR');
                        amount = dFormatter.format(a);
                        return InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: EdgeInsets.all(2.0.h),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(2.0.h),
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
                                          topLeft: Radius.circular(2.0.h),
                                          topRight: Radius.circular(2.0.h),
                                        ),
                                        child: Container(
                                          height: 36.0.h,
                                          width: 100.0.w,
                                          color: Colors.grey[300],
                                          child: StreamBuilder<Uint8List>(
                                            stream: vendorPropertiesController
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
                                                    snapshot.data!,
                                                    fit: BoxFit.cover);
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
                                    padding: EdgeInsets.all(2.0.h),
                                    child: Container(
                                      // height: 14.0.h,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: 50.0.w,
                                                // color: Colors.green,
                                                child: Text(
                                                  SessionController()
                                                              .getLanguage() ==
                                                          1
                                                      ? vendorPropertiesController
                                                              .vendorProperty
                                                              .value
                                                              .contractProperties![
                                                                  index]
                                                              .propertyName ??
                                                          ""
                                                      : vendorPropertiesController
                                                              .vendorProperty
                                                              .value
                                                              .contractProperties![
                                                                  index]
                                                              .propertyNameAr ??
                                                          "",
                                                  style: AppTextStyle
                                                      .semiBoldBlack11,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              // const Spacer(),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 7.0.w),
                                                child: Text(
                                                  vendorPropertiesController
                                                      .vendorProperty
                                                      .value
                                                      .contractProperties![
                                                          index]
                                                      .propertyId
                                                      .toString(),
                                                  style:
                                                      AppTextStyle.normalBlack9,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 2.0.h, bottom: 2.0.h),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: 40.0.w,
                                                  // color: Colors.green,
                                                  child: Text(
                                                    AppMetaLabels().totalAmount,
                                                    style: AppTextStyle
                                                        .semiBoldBlack11,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                // const Spacer(),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 7.0.w),
                                                  child: Text(
                                                    "${AppMetaLabels().aed} $amount",
                                                    style: AppTextStyle
                                                        .normalBlack9,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
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
      ],
    );
  }
}
