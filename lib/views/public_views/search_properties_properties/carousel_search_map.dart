import 'package:carousel_slider/carousel_slider.dart';
import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CarouselSearchMap extends StatelessWidget {
  CarouselSearchMap({Key key}) : super(key: key);
  final CarouselController buttonCarouselController = CarouselController();

  @override
  Widget build(BuildContext context) => CarouselSlider.builder(
        options: CarouselOptions(
          enlargeStrategy: CenterPageEnlargeStrategy.scale,
          aspectRatio: 10 / 2,
          enlargeCenterPage: false,
          viewportFraction: 0.83,
          initialPage: 0,
          enableInfiniteScroll: false,
          reverse: false,
          autoPlay: false,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          autoPlayCurve: Curves.ease,
          // onPageChanged: callbackFunction,
          scrollDirection: Axis.horizontal,
        ),
        itemCount: 4,
        itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
            Container(
          decoration: BoxDecoration(
            color: const Color.fromRGBO(237, 238, 239, 1),
            borderRadius: BorderRadius.circular(1.0.h),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 0.5.h,
                spreadRadius: 0.1.h,
                offset: Offset(0.0.h, 0.0.h),
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  AppImagesPath.building1,
                  height: 12.0.h,
                  width: 18.0.w,
                  fit: BoxFit.fill,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 1.0.h),
                child: Container(
                  width: 62.0.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 1.0.h,
                      ),
                      Container(
                        width: 57.0.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 37.0.w,
                              child: Text(
                                AppMetaLabels().discoveyGarden,
                                style: AppTextStyle.semiBoldBlack11,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              "${AppMetaLabels().unit} 12",
                              style: AppTextStyle.normalBlack10,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 1.0.h,
                      ),
                      // Text(
                      //   "AED 45,000 per month",
                      //   style: AppTextStyle.normalBlack10,
                      // ),
                      // SizedBox(
                      //   height: 1.0.h,
                      // ),
                      // Container(
                      //   width: 57.0.w,
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       Text(
                      //         "2 Bed Apartment",
                      //         style: AppTextStyle.normalBlack10,
                      //       ),
                      //       Text(
                      //         "980sqft",
                      //         style: AppTextStyle.normalBlack10,
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
