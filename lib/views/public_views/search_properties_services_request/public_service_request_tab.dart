import 'package:contained_tab_bar_view_with_custom_page_navigator/contained_tab_bar_view_with_custom_page_navigator.dart';
import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../data/helpers/session_controller.dart';
import 'public_main_info.dart';
import 'public_service_updates.dart';

class PublicServiceRequestTab extends StatefulWidget {
  final int? requestNo;
  final int? unitId;
  final bool? backToSearch;
  final bool? canCommunicate;
  const PublicServiceRequestTab(
      {Key? key,
      this.requestNo,
      this.unitId,
      this.backToSearch = false,
      this.canCommunicate})
      : super(key: key);

  @override
  _PublicServiceRequestTabState createState() =>
      _PublicServiceRequestTabState();
}

class _PublicServiceRequestTabState extends State<PublicServiceRequestTab> {
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
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppImagesPath.appbarimg),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            centerTitle: true,
            title: Text(AppMetaLabels().serviceRequests,
                style: AppTextStyle.semiBoldWhite14),
            leading: InkWell(
              onTap: () {
                if (widget.backToSearch!) {
                  Get.back();
                  Get.back();
                  Get.back();
                  Get.back();
                } else
                  Get.back();
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 6.0.w,
              ),
            ),
          ),
          body: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsets.all(2.0.h),
                child: Row(
                  children: [
                    Text(
                      AppMetaLabels().requestno,
                      style: AppTextStyle.semiBoldBlack12,
                    ),
                    const Spacer(),
                    Text(
                      "${widget.requestNo.toString()}",
                      style: AppTextStyle.semiBoldBlack12,
                    ),
                  ],
                ),
              ),
              const AppDivider(),
              Expanded(
                child: ContainedTabBarView(
                  tabs: [
                    Tab(text: AppMetaLabels().maininfo),
                    Tab(text: AppMetaLabels().updatesCapital),
                  ],
                  tabBarProperties: TabBarProperties(
                    height: 5.0.h,
                    indicatorColor: AppColors.blueColor,
                    indicatorWeight: 0.2.h,
                    labelColor: AppColors.blueColor,
                    unselectedLabelColor: AppColors.blackColor,
                    labelStyle: AppTextStyle.semiBoldBlack10,
                  ),
                  views: [
                    PublicMainInfo(
                      caseno: widget.requestNo,
                    ),
                    PublicServiceUpdates(
                      reqNo: widget.requestNo!,
                      canCommunicate: widget.canCommunicate!,
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
