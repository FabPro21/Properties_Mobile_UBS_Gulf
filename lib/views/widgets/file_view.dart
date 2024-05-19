import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/data/models/tenant_models/service_request/doc_file.dart';
import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class FileView extends StatelessWidget {
  final DocFile file;
  final Function onPressed;
  final Function onDelete;
  final bool canDelete;
  const FileView(
      {Key key,
      this.file,
      this.onPressed,
      this.onDelete,
      this.canDelete = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String details = '';
    if (file.size != null) details += '${file.size}';
    if (file.size != null && file.expiry != null) details += ', ';
    if (file.expiry != null)
      details +=
          '${SessionController().getLanguage() == 1 ? 'Expiry Date:' : 'تاريخ الانتهاء: '}  ${file.expiry}';
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            AppImagesPath.pdfimg,
            width: 10.w,
            height: 10.w,
            fit: BoxFit.contain,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    if (!file.loading.value) onPressed();
                  },
                  child: Obx(() {
                    return file.loading.value
                        ? AnimatedTextKit(
                            isRepeatingAnimation: true,
                            repeatForever: true,
                            pause: Duration(milliseconds: 10),
                            animatedTexts: [
                              ColorizeAnimatedText(
                                  SessionController().getLanguage() == 1
                                      ? file.name ?? ''
                                      : file.nameAr ?? "",
                                  textStyle: AppTextStyle.semiBoldBlue11,
                                  colors: [
                                    AppColors.blueColor,
                                    AppColors.blueColor2,
                                    AppColors.blueColor
                                  ],
                                  speed: Duration(milliseconds: 200)),
                            ],
                          )
                        : Text(
                            SessionController().getLanguage() == 1
                                ? file.name ?? ''
                                : file.nameAr ?? '',
                            style: AppTextStyle.semiBoldBlue11,
                          );
                  }),
                ),
                SizedBox(
                  height: 0.5.h,
                ),
                Text(
                  details,
                  style: AppTextStyle.normalGrey9,
                ),
              ],
            ),
          ),
          Spacer(),
          if (canDelete)
            Obx(() {
              return file.removing.value
                  ? SizedBox(
                      height: 24, width: 24, child: LoadingIndicatorBlue())
                  : file.errorRemoving
                      ? InkWell(
                          onTap: () {
                            onDelete();
                          },
                          child: Icon(
                            Icons.refresh,
                            color: Colors.red,
                          ))
                      : InkWell(
                          onTap: () {
                            onDelete();
                          },
                          child: Image.asset(
                            AppImagesPath.deleteimg,
                            width: 5.w,
                            height: 5.w,
                            fit: BoxFit.contain,
                          ),
                        );
            }),
        ],
      ),
    );
  }
}
