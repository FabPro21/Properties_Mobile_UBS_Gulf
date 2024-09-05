import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/landlord/landlord_properties/filter/landlord_filter_property_emirat/landlordlandlord_filter_emirate_controller.dart';
import 'package:fap_properties/views/widgets/common_widgets/custom_error_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'dart:ui' as ui;

class LandlordFilterEmirate extends StatefulWidget {
  const LandlordFilterEmirate({Key? key}) : super(key: key);

  @override
  _LandlordFilterEmiratetate createState() => _LandlordFilterEmiratetate();
}

class _LandlordFilterEmiratetate extends State<LandlordFilterEmirate> {
  final LandlordFilterEmirateController _filterContractsStatusController =
      Get.put(LandlordFilterEmirateController());

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
                      AppMetaLabels().emirate,
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
                        : _filterContractsStatusController.error.value != ''
                            ? CustomErrorWidget(
                                errorText: _filterContractsStatusController
                                    .error.value,
                                errorImage: AppImagesPath.noDataFound,
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                itemCount: _filterContractsStatusController
                                    .propertyEmirateModelLength,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      Get.back(
                                          result:
                                              _filterContractsStatusController
                                                  .propertyEmirateModel
                                                  .value
                                                  .propertyEmirate?[index]);
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 1.0.h),
                                        Text(
                                          _filterContractsStatusController
                                                      .propertyEmirateModel
                                                      .value
                                                      .propertyEmirate ==
                                                  null
                                              ? ''
                                              : SessionController()
                                                          .getLanguage() ==
                                                      1
                                                  ? _filterContractsStatusController
                                                          .propertyEmirateModel
                                                          .value
                                                          .propertyEmirate![
                                                              index]
                                                          .emirateName ??
                                                      ""
                                                  : _filterContractsStatusController
                                                          .propertyEmirateModel
                                                          .value
                                                          .propertyEmirate![
                                                              index]
                                                          .emirateNameAR ??
                                                      "",
                                        ),
                                        SizedBox(height: 2.0.h),
                                        index ==
                                                _filterContractsStatusController
                                                        .propertyEmirateModelLength -
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
