import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class TenantFeedback extends StatelessWidget {
  const TenantFeedback({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
          ),
          iconSize: 2.0.h,
          onPressed: () {
            Get.back();
          },
        ),
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
        title: Text(
          AppMetaLabels().feedback,
          style: AppTextStyle.semiBoldWhite14,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 4.0.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 3.0.h, right: 3.0.h),
            child: Text(
              AppMetaLabels().rateExperience,
              style: AppTextStyle.semiBoldBlack12,
            ),
          ),
          SizedBox(
            height: 1.0.h,
          ),
          Padding(
            padding: EdgeInsets.all(2.0.h),
            child: Container(
              width: 100.0.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(2.0.h),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 0.5.h,
                    spreadRadius: 0.1.h,
                    offset: Offset(0.1.h, 0.1.h),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(1.5.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 3.0.h,
                    ),
                    Text(
                      AppMetaLabels().areYouSatisfied,
                      style: AppTextStyle.semiBoldBlack10,
                    ),
                    SizedBox(
                      height: 3.0.h,
                    ),
                    Center(
                      child: RatingBar.builder(
                        itemSize: 5.5.h,
                        initialRating: 3,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        itemCount: 5,
                        glowColor: AppColors.blueColor,
                        unratedColor: Colors.grey,
                        itemPadding: EdgeInsets.symmetric(horizontal: 0.0.w),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: AppColors.blueColor,
                        ),
                        onRatingUpdate: (rating) {},
                      ),
                    ),
                    SizedBox(
                      height: 7.0.h,
                    ),
                    Text(
                      AppMetaLabels().tellUs,
                      style: AppTextStyle.semiBoldGrey10,
                    ),
                    SizedBox(
                      height: 2.0.h,
                    ),
                    Container(
                      width: 100.0.w,
                      height: 10.0.h,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(246, 248, 249, 1),
                        borderRadius: BorderRadius.circular(1.0.h),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(1.0.h),
                        child: TextField(
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintText: AppMetaLabels().enterRemarks),
                          keyboardType: TextInputType.multiline,
                          style: AppTextStyle.normalGrey10,
                          maxLines: 5,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12.0.h,
                    ),
                    Center(
                      child: Container(
                        width: 100.0.w,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(1.3.h),
                            ), backgroundColor: Color.fromRGBO(0, 61, 166, 1),
                            padding: EdgeInsets.symmetric(
                                horizontal: 2.0.h, vertical: 1.8.h),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            AppMetaLabels().submit,
                            style: AppTextStyle.semiBoldWhite11,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
