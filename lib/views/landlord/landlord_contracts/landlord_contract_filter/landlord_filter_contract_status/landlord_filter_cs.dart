import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/landlord/landlord_contracts/landlord_contract_filter/landlord_filter_contract_status/landlordlandlord_filter_cs_controller.dart';
import 'package:fap_properties/views/widgets/common_widgets/custom_error_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'dart:ui' as ui;

class LandlordFilterCS extends StatefulWidget {
  const LandlordFilterCS({Key key}) : super(key: key);

  @override
  _LandlordFilterCSState createState() => _LandlordFilterCSState();
}

class _LandlordFilterCSState extends State<LandlordFilterCS> {
  final LandlordFilterCSController _filterContractsStatusController =
      Get.put(LandlordFilterCSController());

  @override
  void initState() {
    super.initState();
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
                      AppMetaLabels().contractStatus,
                      style: AppTextStyle.semiBoldBlack16,
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        Get.back();
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
                    return _filterContractsStatusController.loading.value
                        ? Center(
                            child: LoadingIndicatorBlue(),
                          )
                        : _filterContractsStatusController.error.value != '' ||
                                _filterContractsStatusController
                                        .contractsStatusLength ==
                                    0
                            ? CustomErrorWidget(
                                errorText: AppMetaLabels().noDatafound,
                                errorImage: AppImagesPath.noDataFound,
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                itemCount: _filterContractsStatusController
                                    .contractsStatusLength,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      Get.back(
                                          result:
                                              _filterContractsStatusController
                                                  .contractsStatusModel
                                                  .value
                                                  .data[index]);
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 1.0.h),
                                        Text(
                                          _filterContractsStatusController
                                                      .contractsStatusModel
                                                      .value
                                                      .data[index]
                                                      .contractType ==
                                                  'Active'
                                              ? SessionController()
                                                          .getLanguage() ==
                                                      1
                                                  ? '${_filterContractsStatusController.contractsStatusModel.value.data[index].contractType} / Expired'
                                                  : '${_filterContractsStatusController.contractsStatusModel.value.data[index].contractTypeAR} / منتهي الصلاحية'
                                              : SessionController()
                                                          .getLanguage() ==
                                                      1
                                                  ? _filterContractsStatusController
                                                          .contractsStatusModel
                                                          .value
                                                          .data[index]
                                                          .contractType ??
                                                      ""
                                                  : _filterContractsStatusController
                                                          .contractsStatusModel
                                                          .value
                                                          .data[index]
                                                          .contractTypeAR ??
                                                      "",
                                        ),
                                        SizedBox(height: 2.0.h),
                                        index ==
                                                _filterContractsStatusController
                                                        .contractsStatusLength -
                                                    1
                                            ? Container()
                                            : AppDivider(),
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
