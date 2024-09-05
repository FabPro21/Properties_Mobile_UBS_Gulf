import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/widgets/common_widgets/background_image_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/button_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/error_text_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_white.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'get_language_controller.dart';
import 'update_user_language_controller.dart';

// ignore: must_be_immutable
class ChooseLanguage extends StatefulWidget {
  final bool? cont;
  final bool? loggedIn;
  ChooseLanguage({Key? key, this.cont = false, this.loggedIn})
      : super(key: key);

  @override
  State<ChooseLanguage> createState() => _ChooseLanguageState();
}

class _ChooseLanguageState extends State<ChooseLanguage> {
  final gLController = Get.put(GetLanguageController());
  final uULController = Get.put(UpdateUserLanguageController());

  @override
  void initState() {
    super.initState();
  }

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
            const AppBackgroundImage(),
            Obx(() {
              return SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 2.0.h),
                      child: Row(
                        mainAxisAlignment: widget.cont ?? false
                            ? MainAxisAlignment.center
                            : MainAxisAlignment.spaceBetween,
                        children: [
                          if (!widget.cont!)
                            SizedBox(
                              width: 12.w,
                            ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                AppMetaLabels().choose,
                                style: AppTextStyle.normalWhite9,
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 1.0.h),
                                child: Text(
                                  AppMetaLabels().language,
                                  style: AppTextStyle.semiBoldWhite13,
                                ),
                              ),
                            ],
                          ),
                          if (!widget.cont!)
                            IconButton(
                              padding: EdgeInsets.all(1.w),
                              iconSize: 7.w,
                              onPressed: () {
                                Get.back();
                              },
                              icon: Icon(
                                Icons.cancel_outlined,
                                color: Colors.white,
                              ),
                            ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: gLController.loadingData.value
                          ? LoadingIndicatorWhite()
                          : gLController.error.value != ''
                              ? AppErrorWidget(
                                  errorText: gLController.error.value,
                                  onRetry: () {
                                    gLController.getData();
                                  },
                                  color: AppMetaLabels().color,
                                )
                              : Padding(
                                  padding: EdgeInsets.only(top: 4.0.h),
                                  child: ListView.builder(
                                    // shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    itemCount: gLController
                                        .model.value.language?.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Column(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 1.0.h, bottom: 1.0.h),
                                            child: InkWell(
                                              onTap: () {
                                                gLController.changeLanguage(
                                                    gLController
                                                            .model
                                                            .value
                                                            .language?[index]
                                                            .langId ??
                                                        -1,
                                                    widget.loggedIn ?? false,
                                                    widget.cont ?? false);
                                                setState(() {});
                                              },
                                              child: Container(
                                                width: 90.0.w,
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      (gLController
                                                                  .model
                                                                  .value
                                                                  .language?[
                                                                      index]
                                                                  .title ==
                                                              "Arabic")
                                                          ? "العربية"
                                                          : gLController
                                                                  .model
                                                                  .value
                                                                  .language?[
                                                                      index]
                                                                  .title ??
                                                              "",
                                                      style: AppTextStyle
                                                          .normalWhite15,
                                                    ),
                                                    Spacer(),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          right: 3.0.h),
                                                      child: gLController
                                                                  .selectedLang
                                                                  .value ==
                                                              gLController
                                                                  .model
                                                                  .value
                                                                  .language?[
                                                                      index]
                                                                  .langId
                                                          // index
                                                          ? Icon(
                                                              Icons.check,
                                                              color:
                                                                  Colors.white,
                                                              size: 2.5.h,
                                                            )
                                                          : SizedBox(),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          index ==
                                                  gLController.model.value
                                                          .language!.length -
                                                      1
                                              ? SizedBox()
                                              : AppDivider(),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                    ),
                  ],
                ),
              );
            }),
            if (widget.cont!)
              Padding(
                padding: EdgeInsets.only(bottom: 4.0.h),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: uULController.loadingData.value
                      ? LoadingIndicatorWhite()
                      : gLController.error.value != ''
                          ? SizedBox()
                          : ButtonWidget(
                              buttonText: AppMetaLabels().cont,
                              onPress: () async {
                                await gLController.countinueBtn();
                              },
                            ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
