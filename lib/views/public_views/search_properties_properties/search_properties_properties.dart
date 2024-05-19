import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/widgets/common_widgets/custom_error_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../data/helpers/session_controller.dart';
import 'search_properties_management_controller.dart';

class SearchPropertiesProperties extends StatefulWidget {
  const SearchPropertiesProperties({Key key}) : super(key: key);

  @override
  _SearchPropertiesPropertiesState createState() =>
      _SearchPropertiesPropertiesState();
}

class _SearchPropertiesPropertiesState
    extends State<SearchPropertiesProperties> {
  var _controller = Get.put(PublicGetpropertyMangementController());

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: SessionController().getLanguage() == 1
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                image: AssetImage(
                  AppImagesPath.appbarimg,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            AppMetaLabels().propertyMgt,
            style: AppTextStyle.semiBoldWhite14,
          ),
        ),
        body: Obx(() {
          return _controller.loadingData.value
              ? LoadingIndicatorBlue()
              : _controller.length == 0
                  ? CustomErrorWidget(
                      errorImage: AppImagesPath.noServicesFound,
                      errorText: AppMetaLabels().noDatafound,
                    )
                  : Padding(
                      padding: EdgeInsets.all(2.0.h),
                      child: Container(
                        // height: double.maxFinite,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(2.0.h),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[200],
                              blurRadius: 0.5.h,
                              spreadRadius: 0.8.h,
                              offset: Offset(0.1.h, 0.1.h),
                            ),
                          ],
                        ),
                        child: ListView.builder(
                          itemCount: _controller.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 2.0.h, horizontal: 3.0.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    SessionController().getLanguage() == 1
                                        ? _controller.getdata.value
                                                .record[index].title ??
                                            ""
                                        : _controller.getdata.value
                                                .record[index].titileAr ??
                                            "",
                                    style: AppTextStyle.semiBoldBlack13,
                                  ),
                                  SizedBox(
                                    height: 1.0.h,
                                  ),
                                  Html(
                                    customTextAlign: (_) =>
                                        SessionController().getLanguage() == 1
                                            ? TextAlign.left
                                            : TextAlign.right,
                                    data: SessionController().getLanguage() == 1
                                        ? _controller.getdata.value
                                                .record[index].description ??
                                            ""
                                        : _controller.getdata.value
                                                .record[index].descriptionAR ??
                                            "",
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    );
        }),
      ),
    );
  }
}
