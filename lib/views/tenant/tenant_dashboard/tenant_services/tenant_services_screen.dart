import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/widgets/common_widgets/custom_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:shape_of_view_null_safe/shape_of_view_null_safe.dart';
import 'package:sizer/sizer.dart';

class TenantServicesScreen extends StatefulWidget {
  TenantServicesScreen({Key key}) : super(key: key);

  @override
  State<TenantServicesScreen> createState() => _TenantServicesScreenState();
}

class _TenantServicesScreenState extends State<TenantServicesScreen> {
  final TextEditingController searchControler = TextEditingController();

  bool tooltip;

  @override
  void initState() {
    tooltip = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          tooltip = false;
        });
      },
      child: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 3.0.h),
                child: Text(
                  AppMetaLabels().serviceRequests,
                  style: AppTextStyle.semiBoldWhite15,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 2.0.h, right: 2.0.h, top: 6.0.h),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(1.0.h),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(0.3.h),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: searchControler,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey.withOpacity(0.1),
                              prefixIcon: Icon(
                                Icons.search,
                                size: 2.0.h,
                                color: Colors.grey,
                              ),
                              contentPadding: EdgeInsets.only(left: 5.0.w),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0.5.h),
                                borderSide: BorderSide(
                                    color: AppColors.whiteColor, width: 0.1.h),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0.5.h),
                                borderSide: BorderSide(
                                    color: AppColors.whiteColor, width: 0.1.h),
                              ),
                              hintText: AppMetaLabels().searchServices,
                              hintStyle: AppTextStyle.normalBlack10
                                  .copyWith(color: Colors.grey),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            // _getData();
                            searchControler.clear();
                          },
                          icon: Icon(
                            Icons.refresh,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 4.0.h,
                  ),
                  child: SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minHeight: 50.h),
                      child: Container(
                          width: 92.0.w,
                          margin: EdgeInsets.all(1.5.h),
                          // height: 70.5.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(2.0.h),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 0.5.h,
                                spreadRadius: 0.8.h,
                                offset: Offset(0.1.h, 0.1.h),
                              ),
                            ],
                          ),
                          child: CustomErrorWidget(
                            errorImage: AppImagesPath.noServicesFound,
                            errorText: AppMetaLabels().noServiceRequestsFound,
                          )),
                    ),
                  ),
                ),
              ),
            ],
          ),
          tooltip == false
              ? Container()
              : Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(left: 3.0.h),
                    child: ShapeOfView(
                      shape: BubbleShape(
                          position: BubblePosition.Bottom,
                          arrowPositionPercent: 0.5,
                          borderRadius: 20,
                          arrowHeight: 10,
                          arrowWidth: 10),
                      child: Container(
                        color: AppColors.blueColor,
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 1.0.h,
                              bottom: 2.0.h,
                              left: 1.0.h,
                              right: 1.0.h),
                          child: Text(
                            AppMetaLabels().serviceRequests,
                            style: AppTextStyle.semiBoldWhite10,
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
