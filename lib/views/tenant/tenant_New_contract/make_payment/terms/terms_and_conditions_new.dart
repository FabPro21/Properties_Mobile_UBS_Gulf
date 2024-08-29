import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/tenant/tenant_New_contract/make_payment/terms/terms_and_conditions_new_controller.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class TermsAndConditionsNewContract extends StatelessWidget {
  final String? title;
  TermsAndConditionsNewContract({
    Key? key,
    this.title,
  }) : super(key: key);

  final controller = Get.put(TermsAndConditionsNewController());

  @override
  Widget build(BuildContext context) {
    controller.getData(title??"");
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            title??"",
            style: AppTextStyle.semiBoldWhite15,
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              )),
          flexibleSpace: Image(
            image: AssetImage(AppImagesPath.appbarimg),
            fit: BoxFit.cover,
          ),
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          top: false,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.0.w, vertical: 2.0.h),
            child: Obx(() {
              return controller.loadingData.value
                  ? LoadingIndicatorBlue()
                  : controller.errorLoadingData != ''
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(controller.errorLoadingData),
                              IconButton(
                                onPressed: () {
                                  controller.getData(title??"");
                                },
                                icon: Icon(Icons.refresh),
                              )
                            ],
                          ),
                        )
                      : Html(data: controller.data);
            }),
          ),
        ),
      ),
    );
  }
}
