import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/widgets/common_widgets/custom_error_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:fap_properties/views/public_views/search_properties_services/search_properties_services_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'services_categories_controller.dart';

class SearchPropertiesServices extends StatefulWidget {
  const SearchPropertiesServices({Key? key}) : super(key: key);

  @override
  _SearchPropertiesServicesState createState() =>
      _SearchPropertiesServicesState();
}

class _SearchPropertiesServicesState extends State<SearchPropertiesServices> {
  var _controller = Get.put(PublicGetServicesController());

// @override
//   void initState() {
//     _controller.getServiceCategories();
//     super.initState();
//   }

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
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
          title: Text(
            AppMetaLabels().ourServices,
            // "Services",
            style: AppTextStyle.semiBoldWhite14,
          ),
        ),
        body: Obx(() {
          return _controller.loadingData.value
              ? Center(
                  child: LoadingIndicatorBlue(),
                )
              : _controller.length == 0
                  ? CustomErrorWidget(
                      errorText: AppMetaLabels().noDatafound,
                      errorImage: AppImagesPath.noServicesFound,
                    )
                  : Container(
                      child: ListView.builder(
                          padding: EdgeInsets.only(top: 1.5.h),
                          shrinkWrap: true,
                          itemCount: _controller.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                  left: 5.0.w, top: 3.0.h, right: 5.0.w),
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Get.to(() =>
                                          SearchPropertiesServiceDetails(
                                            categoryId: _controller
                                                    .getServicesCatg
                                                    .value
                                                    .serviceCategories?[index]
                                                    .categoryId ??
                                                0,
                                          ));
                                    },
                                    child: Row(children: [
                                      Container(
                                        width: Get.width * 0.8,
                                        child: Text(
                                            _controller.getServicesCatg.value
                                                        .serviceCategories ==
                                                    null
                                                ? ''
                                                : SessionController()
                                                            .getLanguage() ==
                                                        1
                                                    ? _controller
                                                            .getServicesCatg
                                                            .value
                                                            .serviceCategories![
                                                                index]
                                                            .title ??
                                                        ""
                                                    : _controller
                                                            .getServicesCatg
                                                            .value
                                                            .serviceCategories![
                                                                index]
                                                            .titleAr ??
                                                        "",
                                            //   "title",
                                            maxLines: 3,
                                            style:
                                                AppTextStyle.semiBoldBlack13),
                                      ),
                                      Spacer(),
                                      Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        size: 2.0.h,
                                        color: AppColors.grey1,
                                      )
                                    ]),
                                  ),
                                ],
                              ),
                            );
                          }));
        }),
      ),
    );
  }
}
