import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/widgets/common_widgets/custom_error_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:fap_properties/views/widgets/custom_app_bar2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../data/helpers/session_controller.dart';
import 'services_categories_controller.dart';

class SearchPropertiesServiceDetails extends StatefulWidget {
  final int categoryId;
  const SearchPropertiesServiceDetails({Key key, this.categoryId})
      : super(key: key);

  @override
  _SearchPropertiesServiceDetailsState createState() =>
      _SearchPropertiesServiceDetailsState();
}

class _SearchPropertiesServiceDetailsState
    extends State<SearchPropertiesServiceDetails> {
  var _controller = Get.put(PublicGetServicesController());

  @override
  void initState() {
    _getdata();
    super.initState();
  }

  _getdata() async {
    await _controller.getServiceCategoriesDetails(widget.categoryId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Directionality(
          textDirection: SessionController().getLanguage() == 1
              ? TextDirection.ltr
              : TextDirection.rtl,
          child: Column(children: [
            CustomAppBar2(
              title: AppMetaLabels().services,
            ),
            Obx(() {
              return _controller.loadingDetails.value
                  ? Padding(
                      padding: EdgeInsets.only(top: 40.0.h),
                      child: LoadingIndicatorBlue(),
                    )
                  : _controller.errorDetails.value != '' ||
                          _controller.lengthDetails == 0
                      ? Padding(
                          padding: EdgeInsets.only(top: 30.0.h),
                          child: CustomErrorWidget(
                            errorText: AppMetaLabels().noDatafound,
                            errorImage: AppImagesPath.noServicesFound,
                          ),
                        )
                      : ListView.builder(
                          padding: EdgeInsets.only(top: 1.0.h),
                          shrinkWrap: true,
                          itemCount: _controller.lengthDetails,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  EdgeInsets.only(left: 2.0.w, right: 2.0.w),
                              child: ExpansionTile(
                                  iconColor: AppColors.blueColor,
                                  title: Text(
                                      SessionController().getLanguage() == 1
                                          ? _controller.getServiceDetails.value
                                                  .services[index].title ??
                                              ""
                                          : _controller.getServiceDetails.value
                                                  .services[index].titleAr ??
                                              "",
                                      style: AppTextStyle.semiBoldBlack13),
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 4.0.w,
                                            bottom: 2.0.h,
                                            right: 4.0.w),
                                        child: Html(
                                          customTextAlign: (_) =>
                                              SessionController()
                                                          .getLanguage() ==
                                                      1
                                                  ? TextAlign.left
                                                  : TextAlign.right,
                                          data: SessionController()
                                                      .getLanguage() ==
                                                  1
                                              ? _controller
                                                      .getServiceDetails
                                                      .value
                                                      .services[index]
                                                      .description ??
                                                  ""
                                              : _controller
                                                      .getServiceDetails
                                                      .value
                                                      .services[index]
                                                      .descriptionAr ??
                                                  "",
                                          // style: AppTextStyle.normalBlack12,
                                        ),
                                      ),
                                    )
                                  ]),
                            );
                          });
            })
          ]),
        ));
  }
}
