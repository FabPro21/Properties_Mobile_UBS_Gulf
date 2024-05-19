import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:fap_properties/utils/styles/fonts.dart';
import 'package:fap_properties/views/widgets/step_no_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../utils/styles/colors.dart';
import '../../utils/styles/text_styles.dart';

class DueActionListButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  final bool loading;
  final String srNo;
  const DueActionListButton(
      {Key key, this.onPressed, this.text, this.loading = false, this.srNo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: loading
          ? null
          : () {
              onPressed();
            },
      child: Row(
        children: <Widget>[
          StepNoWidget(
            label: srNo,
            tooltip: text,
            color: AppColors.blueColor2,
            textColor: AppColors.blueColor,
          ),
          Container(
            height: 8.h,
            child: RotatedBox(
              quarterTurns: 1,
              child: Arc(
                arcType: ArcType.CONVEY,
                height: 4.5.sp,
                child: new Container(
                  padding: EdgeInsets.symmetric(vertical: 3.w),
                  width: 20.sp,
                  decoration: BoxDecoration(
                    color: AppColors.blueColor2,
                    borderRadius: new BorderRadius.only(
                      topLeft: new Radius.circular(10.sp),
                      topRight: new Radius.circular(10.sp),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: RotatedBox(
                    quarterTurns: 3,
                    child: loading
                        ? AnimatedTextKit(
                            isRepeatingAnimation: true,
                            repeatForever: true,
                            pause: Duration(milliseconds: 10),
                            animatedTexts: [
                              ColorizeAnimatedText(text ?? '',
                                  textStyle: AppTextStyle.normalBlue11,
                                  colors: [
                                    AppColors.blueColor,
                                    AppColors.blueColor2,
                                    AppColors.blueColor
                                  ],
                                  speed: Duration(milliseconds: 200)),
                            ],
                          )
                        : Text(
                            text ?? '',
                            // style: AppTextStyle.normalBlue11,
                            //  style: AppTextStyle.semiBoldGrey12.copyWith(color: AppColors.blueColor),
                            style: TextStyle(
                              color: AppColors.blueColor,
                              fontFamily: AppFonts.graphikSemibold,
                              fontSize: 12.0.sp,
                            ),
                          ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
