import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/error_text_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:fap_properties/views/vendor/lpos/lpo_details/lpos_terms/lpo_terms_controller.dart';
import 'package:fap_properties/views/widgets/bottom_shadow.dart';
import 'package:fap_properties/views/widgets/srno_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class LpoTerms extends StatefulWidget {
  LpoTerms({Key key}) : super(key: key);

  @override
  _LpoTermsState createState() => _LpoTermsState();
}

class _LpoTermsState extends State<LpoTerms> {
  final LpoTermsController _controller = Get.put(LpoTermsController());
  // _getData() async {
  //   await _controller.getLpoTerms();
  // }

  @override
  void initState() {
    // _getData();
    super.initState();
  }

  String amount = "";

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BottomShadow(),
        Obx(() {
          return _controller.loadingData.value
              ? LoadingIndicatorBlue()
              : _controller.error.value != ''
                  ? AppErrorWidget(
                      errorText: _controller.error.value,
                    )
                  : Column(
                      children: [
                        SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 2.h, left: 2.0.w, right: 2.0.w),
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: 1.0.h,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(2.0.h),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey[200],
                                      blurRadius: 0.4.h,
                                      spreadRadius: 0.8.h,
                                      offset: Offset(0.1.h, 0.1.h),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    ListView.builder(
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        itemCount: _controller.getLpoTermsResp
                                            .value.lpoTerms.length,
                                        itemBuilder: (context, index) {
                                          //////////////////////////
                                          /// Amount
                                          //////////////////////////
                                          var a = _controller.getLpoTermsResp
                                              .value.lpoTerms[index].amount;
                                          final dFormatter =
                                              NumberFormat('#,##0.00', 'AR');
                                          amount = dFormatter.format(a);
                                          return Padding(
                                            padding: EdgeInsets.all(2.0.h),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SrNoWidget(
                                                    text: index + 1, size: 4.h),
                                                SizedBox(
                                                  width: 2.w,
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            AppMetaLabels()
                                                                .name,
                                                            style: AppTextStyle
                                                                .semiBoldBlack10,
                                                          ),
                                                          Spacer(),
                                                          Text(
                                                            SessionController()
                                                                        .getLanguage() ==
                                                                    1
                                                                ? _controller
                                                                        .getLpoTermsResp
                                                                        .value
                                                                        .lpoTerms[
                                                                            index]
                                                                        .termName ??
                                                                    ""
                                                                : _controller
                                                                        .getLpoTermsResp
                                                                        .value
                                                                        .lpoTerms[
                                                                            index]
                                                                        .termNameAr ??
                                                                    "",
                                                            style: AppTextStyle
                                                                .semiBoldBlack10,
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 1.0.h,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            AppMetaLabels()
                                                                .amount,
                                                            style: AppTextStyle
                                                                .normalBlack10,
                                                          ),
                                                          Spacer(),
                                                          Text(
                                                            "${AppMetaLabels().aed}" +
                                                                " $amount",
                                                            style: AppTextStyle
                                                                .normalBlack10,
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 1.0.h,
                                                      ),
                                                      index ==
                                                              _controller
                                                                      .getLpoTermsResp
                                                                      .value
                                                                      .lpoTerms
                                                                      .length -
                                                                  1
                                                          ? Container()
                                                          : AppDivider(),
                                                      index ==
                                                              _controller
                                                                      .getLpoTermsResp
                                                                      .value
                                                                      .lpoTerms
                                                                      .length -
                                                                  1
                                                          ? Container()
                                                          : SizedBox(
                                                              height: 1.0.h,
                                                            ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        }),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
        }),
      ],
    );
  }
}
