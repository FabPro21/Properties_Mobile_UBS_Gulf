import 'dart:typed_data';

import 'package:fap_properties/data/models/vendor_models/get_all_lpos_model.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/error_text_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:fap_properties/views/widgets/bottom_shadow.dart';
import 'package:fap_properties/views/widgets/common_widgets/status_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:sizer/sizer.dart';

import '../../../../../data/helpers/session_controller.dart';
import 'lpo_proretries_controller.dart';

class LpoPropertiesScreen extends StatefulWidget {
  final Lpo? lpo;
  const LpoPropertiesScreen({Key? key, this.lpo}) : super(key: key);

  @override
  _LpoPropertiesScreenState createState() => _LpoPropertiesScreenState();
}

class _LpoPropertiesScreenState extends State<LpoPropertiesScreen> {
  final getLpoPropertiesController = Get.put(GetLpoPropertiesController());
  String amount = "";
  // _getData() async {
  //   await getLpoPropertiesController.getData();
  // }

  @override
  void initState() {
    // _getData();
    super.initState();
  }

  String propertyName = "";

  String gAmount = "";
  String dAmount = "";
  String nAmount = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Directionality(
        textDirection: SessionController().getLanguage() == 1
            ? TextDirection.ltr
            : TextDirection.rtl,
        child: Stack(
          children: [
            Obx(() {
              return getLpoPropertiesController.loadingData.value == true
                  ? LoadingIndicatorBlue()
                  : getLpoPropertiesController.error.value != ''
                      ? AppErrorWidget(
                          errorText: getLpoPropertiesController.error.value,
                        )
                      : SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: 4.0.h,
                            ),
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 2.w),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(2.0.h),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey[200] ?? Colors.grey,
                                        blurRadius: 0.4.h,
                                        spreadRadius: 0.8.h,
                                        offset: Offset(0.1.h, 0.1.h),
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 2.0.h, right: 2.0.h, top: 2.h),
                                    child: Column(
                                      children: [
                                        rowList(AppMetaLabels().lpoDate,
                                            " ${widget.lpo?.lpoDate}"),
                                        SizedBox(
                                          height: 1.0.h,
                                        ),
                                        rowList(AppMetaLabels().lPOType,
                                            "${widget.lpo?.lpoType}"),
                                        SizedBox(
                                          height: 1.0.h,
                                        ),
                                        rowList(AppMetaLabels().amount,
                                            "${AppMetaLabels().aed} ${intl.NumberFormat('#,##0.00', 'AR').format(widget.lpo?.grossAmount)}"),
                                        SizedBox(
                                          height: 1.0.h,
                                        ),
                                        rowList(AppMetaLabels().discountAmount,
                                            "${AppMetaLabels().aed} ${intl.NumberFormat('#,##0.00', 'AR').format(widget.lpo?.discountAmount)}"),
                                        SizedBox(
                                          height: 1.0.h,
                                        ),
                                        rowList(
                                            AppMetaLabels().discountPercentage,
                                            "${widget.lpo?.discountPercentage?.toStringAsFixed(2)}%"),
                                        SizedBox(
                                          height: 1.0.h,
                                        ),
                                        rowList(AppMetaLabels().netAmount,
                                            "${AppMetaLabels().aed} ${intl.NumberFormat('#,##0.00', 'AR').format(widget.lpo?.netAmount)}"),
                                        SizedBox(
                                          height: 1.0.h,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              AppMetaLabels().lPOStatus,
                                              style:
                                                  AppTextStyle.semiBoldBlack11,
                                            ),
                                            Spacer(),
                                            StatusWidget(
                                              text: SessionController()
                                                          .getLanguage() ==
                                                      1
                                                  ? widget.lpo?.lpoStatus ?? ""
                                                  : widget.lpo?.lpoStatusAr ??
                                                      "",
                                              valueToCompare:
                                                  widget.lpo?.lpoStatus,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 1.0.h,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 3.0.h,
                                ),
                                Container(
                                  // height: widget.lpo?.caseNo != 0 ? 75.h : 85.h,
                                  margin: EdgeInsets.symmetric(horizontal: 2.w),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(2.0.h),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey[200] ?? Colors.grey,
                                        blurRadius: 0.4.h,
                                        spreadRadius: 0.8.h,
                                        offset: Offset(0.1.h, 0.1.h),
                                      ),
                                    ],
                                  ),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    itemCount:
                                        getLpoPropertiesController.length,
                                    itemBuilder: (context, index) {
                                      String propName =
                                          SessionController().getLanguage() == 1
                                              ? getLpoPropertiesController
                                                      .lpoProperties
                                                      .value
                                                      .lpoProperties![index]
                                                      .propertyName ??
                                                  ""
                                              : getLpoPropertiesController
                                                      .lpoProperties
                                                      .value
                                                      .lpoProperties![index]
                                                      .propertyNameAr ??
                                                  "";
                                      if (propName.contains(" ")) {
                                        List<String> mystring =
                                            propName.split(" ");
                                        String a = mystring[0] + mystring[1];
                                        String b = mystring[1];
                                        propertyName = a[0] + b[0];
                                      } else {
                                        String mystring = propName;
                                        propertyName = mystring[0];
                                      }
                                      double am = getLpoPropertiesController
                                          .lpoProperties
                                          .value
                                          .lpoProperties![index]
                                          .amount;
                                      final paidFormatter =
                                          intl.NumberFormat('#,##0.00', 'AR');
                                      amount = paidFormatter.format(am);
                                      return Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 1.8.h,
                                                vertical: 1.5.h),
                                            child: Row(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          1.0.h),
                                                  child: Container(
                                                    width: 22.0.w,
                                                    height: 13.0.h,
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey[300],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              1.0.h),
                                                    ),
                                                    child: StreamBuilder<
                                                        Uint8List>(
                                                      stream:
                                                          getLpoPropertiesController
                                                              .getImage(index),
                                                      builder: (
                                                        BuildContext context,
                                                        AsyncSnapshot<Uint8List>
                                                            snapshot,
                                                      ) {
                                                        if (snapshot.hasData) {
                                                          return Image.memory(
                                                              snapshot.data!,
                                                              fit:
                                                                  BoxFit.cover);
                                                        } else {
                                                          return Center(
                                                            child: Text(
                                                              propertyName,
                                                              style: AppTextStyle
                                                                  .semiBoldBlack16
                                                                  .copyWith(
                                                                color: Colors
                                                                    .black,
                                                                fontSize:
                                                                    30.0.sp,
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 2.0.h,
                                                      vertical: 0.0.h),
                                                  child: SizedBox(
                                                    height: 10.0.h,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          width: 50.0.w,
                                                          child: Text(
                                                            SessionController()
                                                                        .getLanguage() ==
                                                                    1
                                                                ? getLpoPropertiesController
                                                                        .lpoProperties
                                                                        .value
                                                                        .lpoProperties![
                                                                            index]
                                                                        .propertyName ??
                                                                    ""
                                                                : getLpoPropertiesController
                                                                        .lpoProperties
                                                                        .value
                                                                        .lpoProperties![
                                                                            index]
                                                                        .propertyNameAr ??
                                                                    "",
                                                            style: AppTextStyle
                                                                .semiBoldBlack11,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                        Text(
                                                          "${AppMetaLabels().aed}" +
                                                              " $amount",
                                                          style: AppTextStyle
                                                              .normalGrey10,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        Text(
                                                          SessionController()
                                                                      .getLanguage() ==
                                                                  1
                                                              ? getLpoPropertiesController
                                                                      .lpoProperties
                                                                      .value
                                                                      .lpoProperties![
                                                                          index]
                                                                      .propertyAddress ??
                                                                  ""
                                                              : getLpoPropertiesController
                                                                      .lpoProperties
                                                                      .value
                                                                      .lpoProperties![
                                                                          index]
                                                                      .propertyAddressAr ??
                                                                  "",
                                                          style: AppTextStyle
                                                              .normalGrey10,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          index ==
                                                  getLpoPropertiesController
                                                          .length -
                                                      1
                                              ? Container()
                                              : Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 1.0.h,
                                                      right: 1.0.h),
                                                  child: AppDivider(),
                                                ),
                                        ],
                                      );
                                    },
                                  ),
                                ),

                                // commented this 16 March 2024
                                // jb hum funcionality implement karain gay tb uncomment kar lain gay
                                // if (widget.lpo?.caseNo != '0')
                                // if (widget.lpo?.caseNo != '')
                                //     Container(
                                //       margin: EdgeInsets.only(top: 2.h),
                                //       height: 13.0.h,
                                //       width: double.maxFinite,
                                //       padding: EdgeInsets.symmetric(
                                //           horizontal: 4.w, vertical: 2.5.h),
                                //       decoration: BoxDecoration(
                                //           color: Colors.white,
                                //           boxShadow: [
                                //             BoxShadow(
                                //               color: Colors.black12,
                                //               blurRadius: 0.9.h,
                                //               spreadRadius: 0.4.h,
                                //               offset: Offset(0.1.h, 0.1.h),
                                //             ),
                                //           ]),
                                //       child: ElevatedButton(
                                //         onPressed: () {
                                //           print(
                                //               'Case No :::: ${(widget.lpo?.caseNo != '0')}');
                                //           print(
                                //               'Case No :::: ${(widget.lpo?.caseNo != null)}');
                                //           print(
                                //               'Case No :::: ${widget.lpo?.caseNo}');
                                //           Get.to(() => UploadDocs(
                                //                 caseNo: int.parse(widget
                                //                     .lpo?.caseNo
                                //                     .toString()),
                                //                 title: AppMetaLabels().lpoAck,
                                //                 docCode: 91,
                                //               ));
                                //         },
                                //         child: Text(
                                //           AppMetaLabels().lpoAck,
                                //           style: AppTextStyle.semiBoldWhite12,
                                //         ),
                                //         style: ElevatedButton.styleFrom(
                                //           shape: RoundedRectangleBorder(
                                //             borderRadius:
                                //                 BorderRadius.circular(1.3.h),
                                //           ),
                                //           backgroundColor:
                                //               Color.fromRGBO(0, 61, 166, 1),
                                //         ),
                                //       ),
                                //     )
                              ],
                            ),
                          ),
                        );
            }),
            BottomShadow(),
          ],
        ),
      ),
    );
  }

  Row rowList(String t1, String t2) {
    return Row(
      children: [
        Text(
          t1,
          style: AppTextStyle.normalGrey11,
        ),
        Spacer(),
        SizedBox(
          width: 42.w,
          child: Text(
            t2,
            style: AppTextStyle.normalGrey11,
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}
