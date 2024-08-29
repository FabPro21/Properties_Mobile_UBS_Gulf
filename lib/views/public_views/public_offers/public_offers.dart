import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/public_views/public_offers/public_offers_controller.dart';
import 'package:fap_properties/views/public_views/public_offers/public_offers_detail.dart';
import 'package:fap_properties/views/widgets/common_widgets/error_text_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../data/helpers/session_controller.dart';
import '../../../../utils/constants/assets_path.dart';

class PublicOffers extends StatefulWidget {
  const PublicOffers({Key? key}) : super(key: key);

  @override
  _PublicOffersState createState() => _PublicOffersState();
}

class _PublicOffersState extends State<PublicOffers> {
  var _controller = Get.put(PublicOffersController());
  @override
  void initState() {
    _controller.getOffers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: SizedBox(),
          title: Text(
            AppMetaLabels().promotions,
            style: AppTextStyle.semiBoldWhite14,
          ),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                image: AssetImage(
                  AppImagesPath.appbarimg,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        body: Directionality(
          textDirection: SessionController().getLanguage() == 1
              ? TextDirection.ltr
              : TextDirection.rtl,
          child: Obx(() {
            return _controller.loadingOffers.value
                ? Center(
                    child: LoadingIndicatorBlue(),
                  )
                : _controller.length == 0
                    ? AppErrorWidget(
                        errorText: _controller.errorOffers.value,
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
                                        Get.to(() => PublicOfferDetails(
                                            offerId: _controller.offers.value
                                                .record?[index].offerid
                                                .toString()));
                                      },
                                      child: Row(children: [
                                        Text(
                                            _controller.offers.value.record ==
                                                    null
                                                ? ''
                                                : SessionController()
                                                            .getLanguage() ==
                                                        1
                                                    ? _controller
                                                            .offers
                                                            .value
                                                            .record![index]
                                                            .title ??
                                                        "".trim()
                                                    : _controller
                                                            .offers
                                                            .value
                                                            .record?[index]
                                                            .titleAr ??
                                                        "".trim(),
                                            style:
                                                AppTextStyle.semiBoldBlack13),
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
        ));
  }
}
