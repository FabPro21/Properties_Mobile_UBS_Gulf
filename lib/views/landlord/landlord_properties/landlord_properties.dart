import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/landlord/landlord_properties/landlord_properties_controller.dart';
import 'package:fap_properties/views/landlord/landlord_properties/landlord_property_details_tab/landlord_property_details_tabs.dart';
import 'package:fap_properties/views/widgets/common_widgets/custom_error_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class LandLordProperties extends StatefulWidget {
  const LandLordProperties({Key? key}) : super(key: key);

  @override
  _LandLordPropertiesState createState() => _LandLordPropertiesState();
}

class _LandLordPropertiesState extends State<LandLordProperties> {
  final searchTextController = TextEditingController();
  final controller = Get.put(LandlordPropertiesController());
  @override
  void initState() {
    // controller.getProperties();
    controller.pageNo = '1';
    controller.pageNoFilter = '1';
    controller.loadingDataLoadMore.value = false;
    controller.errorLoadMore.value = '';
    controller.loadingProperties.value = false;
    controller.errorLoadingProperties.value = '';
    controller.errorLoadMoreFilter.value = '';
    controller.getPropertiesPagination(controller.pageNo, '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Column(children: [
        Padding(
          padding: EdgeInsets.only(top: 3.0.h),
          child: Text(
            AppMetaLabels().propertiessLand,
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
                      controller: searchTextController,
                      // inputFormatters:
                      //     TextInputFormatter().searchPropertyNameContractNoIF,
                      onChanged: (value) async {
                        // controller.searchData(value);
                        setState(() {});
                        controller.pageNo = '1';
                        controller.pageNoFilter = '1';
                        controller.errorLoadMore.value = '';
                        controller.errorLoadMoreFilter.value = '';
                        await controller.getPropertiesPagination(
                            controller.pageNo, value.trim());
                        if (value.isEmpty) {
                          controller.getPropertiesPagination(
                              controller.pageNo, '');
                          setState(() {});
                        }
                        setState(() {});
                        setState(() {});
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.withOpacity(0.1),
                        prefixIcon: Icon(
                          Icons.search,
                          size: 2.0.h,
                          color: Colors.grey,
                        ),
                        contentPadding:
                            EdgeInsets.only(left: 5.0.w, right: 5.0.w),
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
                        hintText: AppMetaLabels().search,
                        hintStyle: AppTextStyle.normalBlack10
                            .copyWith(color: Colors.grey),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      FocusScope.of(context).unfocus();
                      searchTextController.clear();
                      // controller.getProperties();
                      controller.pageNo = '1';
                      controller.pageNoFilter = '1';
                      controller.errorLoadMore.value = '';
                      controller.errorLoadMoreFilter.value = '';
                      await controller.getPropertiesPagination(
                          controller.pageNo, '');
                      setState(() {});
                      setState(() {});
                    },
                    icon: Icon(
                      Icons.refresh,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Expanded(
            child: Padding(
                padding: EdgeInsets.only(
                  top: 2.0.h,
                ),
                child: SingleChildScrollView(
                    child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: 50.h),
                  child: Container(
                    width: 92.0.w,
                    margin: EdgeInsets.all(1.5.h),
                    padding: EdgeInsets.only(top: 0.5.h),
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
                    child: Obx(() {
                      return controller.loadingProperties.value == true
                          ? LoadingIndicatorBlue()
                          : controller.errorLoadingProperties.value != ''
                              ? CustomErrorWidget(
                                  errorText:
                                      controller.errorLoadingProperties.value,
                                  errorImage: AppImagesPath.noContractsFound,
                                )
                              : Container(
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: controller.props.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          inkWell(index),
                                          index == controller.props.length - 1
                                              ? Container()
                                              : AppDivider(),
                                          index != controller.props.length - 1
                                              ? SizedBox()
                                              : controller.props.length < 19
                                                  ? SizedBox()
                                                  : controller.isFilter.value ==
                                                          false
                                                      ? controller.errorLoadMore
                                                                  .value !=
                                                              ''
                                                          ? Container(
                                                              height: 1.h,
                                                            )
                                                          : Container(
                                                              height: 5.h,
                                                              width: 87.w,
                                                              child: Row(
                                                                children: [
                                                                  Spacer(),
                                                                  Obx(() {
                                                                    return controller.errorLoadMore.value !=
                                                                            ''
                                                                        ? SizedBox()
                                                                        : InkWell(
                                                                            onTap:
                                                                                () async {
                                                                              int pageSize = int.parse(controller.pageNo);
                                                                              int naePageNo = pageSize + 1;
                                                                              controller.pageNo = naePageNo.toString();
                                                                              if (searchTextController.text == '') {
                                                                                await controller.getPropertiesPaginationLoadMore(controller.pageNo, '');
                                                                              } else {
                                                                                await controller.getPropertiesPaginationLoadMore(controller.pageNo, searchTextController.text);
                                                                              }
                                                                              setState(() {});
                                                                            },
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsets.only(top: 0.5.h),
                                                                              child: SizedBox(
                                                                                  width: 85.w,
                                                                                  height: 3.h,
                                                                                  child: RichText(
                                                                                    textAlign: TextAlign.right,
                                                                                    text: TextSpan(
                                                                                      children: [
                                                                                        TextSpan(
                                                                                          text: AppMetaLabels().loadMoreData,
                                                                                          style: TextStyle(
                                                                                            color: Colors.blue,
                                                                                            fontWeight: FontWeight.bold,
                                                                                          ),
                                                                                        ),
                                                                                        WidgetSpan(
                                                                                          child: Icon(
                                                                                            Icons.arrow_forward_ios,
                                                                                            size: 15,
                                                                                            color: Colors.blue,
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  )),
                                                                            ),
                                                                          );
                                                                  }),
                                                                ],
                                                              ),
                                                            )
                                                      : controller.errorLoadMoreFilter
                                                                  .value !=
                                                              ''
                                                          ? Container(
                                                              height: 1.h,
                                                            )
                                                          : InkWell(
                                                              onTap: () async {
                                                                int pageSize =
                                                                    int.parse(
                                                                        controller
                                                                            .pageNoFilter);
                                                                int naePageNo =
                                                                    pageSize +
                                                                        1;
                                                                controller
                                                                        .pageNoFilter =
                                                                    naePageNo
                                                                        .toString();
                                                                await controller.getFilteredDataPagiationLoadMore(
                                                                    controller
                                                                        .pageNoFilter,
                                                                    searchTextController
                                                                        .text);
                                                                setState(() {});
                                                                setState(() {});
                                                              },
                                                              child: Container(
                                                                height: 5.h,
                                                                width: 95.w,
                                                                child: Row(
                                                                  children: [
                                                                    Spacer(),
                                                                    RichText(
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      text:
                                                                          TextSpan(
                                                                        children: [
                                                                          TextSpan(
                                                                            text:
                                                                                AppMetaLabels().loadMoreData,
                                                                            style:
                                                                                TextStyle(
                                                                              color: Colors.blue,
                                                                              fontWeight: FontWeight.bold,
                                                                            ),
                                                                          ),
                                                                          WidgetSpan(
                                                                            child:
                                                                                Icon(
                                                                              Icons.arrow_forward_ios,
                                                                              size: 15,
                                                                              color: Colors.blue,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width:
                                                                          1.w,
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            )
                                        ],
                                      );
                                    },
                                  ),
                                );
                    }),
                  ),
                ))))
      ]),
      Padding(
        padding: EdgeInsets.only(bottom: 2.0.h),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: 100.0.w,
            height: 4.0.h,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                height: 4.0.h,
                width: 30.0.w,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // background
                    // onPrimary: Colors.yellow, // foreground
                  ),
                  onPressed: () async {
                    setState(() {
                      controller.errorLoadMore.value = '';
                      controller.errorLoadMoreFilter.value = '';
                      controller.pageNoFilter = '1';
                    });
                    controller.applyFilterPagination(controller.pageNoFilter);
                    // await controller.applyFilter();
                    setState(() {});
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.format_align_center,
                        size: 2.0.h,
                        color: Colors.black,
                      ),
                      Text(
                        AppMetaLabels().filter,
                        style: AppTextStyle.semiBoldBlack11,
                      ),
                    ],
                  ),
                ),
              ),
              Obx(() {
                return controller.isFilter.value == false
                    ? Container()
                    : Padding(
                        padding: EdgeInsets.symmetric(horizontal: 1.0.h),
                        child: Container(
                          height: 4.0.h,
                          width: SessionController().getLanguage() == 1
                              ? 30.0.w
                              : 40.0.w,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                            ),
                            onPressed: () async {
                              setState(() {
                                controller.isFilter.value = false;
                                controller.errorLoadMore.value = '';
                                controller.errorLoadMoreFilter.value = '';
                              });
                              // controller.getProperties();
                              controller.pageNo = '1';
                              controller.getPropertiesPagination(
                                  controller.pageNo, '');
                              setState(() {});
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.close,
                                  size: 2.0.h,
                                  color: Colors.black,
                                ),
                                Text(
                                  AppMetaLabels().clear,
                                  style: AppTextStyle.semiBoldBlack11,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
              })
            ]),
          ),
        ),
      ),
      Obx(() {
        return controller.loadingDataLoadMore.value
            ? Container(
                height: double.infinity,
                width: double.infinity,
                child: Center(child: LoadingIndicatorBlue()),
              )
            : SizedBox();
      })
    ]);
  }

  InkWell inkWell(int index) {
    final property = controller.props[index];
    return InkWell(
      onTap: () {
        Get.to(() => LandlordPropertDetailsTabs(
              propertyId: controller.props[index].propertyID.toString(),
              propertyNo: SessionController().getLanguage() == 1
                  ? controller.propsModel?.serviceRequests![index].emirateName
                      .toString()
                  : controller.propsModel?.serviceRequests![index].emirateNameAR
                      .toString(),
            ));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 1.0.h,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding:
                    EdgeInsets.only(left: 1.0.h, bottom: 1.h, right: 1.0.h),
                child: Row(
                  children: [
                    SizedBox(
                      width: 4.w,
                    ),
                    Container(
                      width: 78.0.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            alignment: SessionController().getLanguage() == 1
                                ? Alignment.topLeft
                                : Alignment.topRight,
                            child: Text(
                              SessionController().getLanguage() == 1
                                  ? property.propertyName ?? ""
                                  : property.propertyNameAR ?? "",
                              maxLines: 1,
                              style: AppTextStyle.semiBoldBlack12,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(
                            height: 1.0.h,
                          ),
                          Row(
                            children: [
                              Text(
                                AppMetaLabels().emirate,
                                style: AppTextStyle.normalGrey11,
                              ),
                              Spacer(),
                              Container(
                                alignment: Alignment.centerRight,
                                width: 58.w,
                                child: Text(
                                  SessionController().getLanguage() == 1
                                      ? property.emirateName ?? ""
                                      : property.emirateNameAR ?? "",
                                  style: AppTextStyle.semiBoldBlack11,
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                          // SizedBox(
                          //   height: 1.0.h,
                          // ),
                          // Row(
                          //   children: [
                          //     Text(
                          //       AppMetaLabels().sector,
                          //       style: AppTextStyle.semiBoldBlack11,
                          //     ),
                          //     Spacer(),
                          //     Container(
                          //       alignment: Alignment.centerRight,
                          //       width: 58.w,
                          //       child: Text(
                          //         SessionController().getLanguage() == 1
                          //             ? property.sector ?? ""
                          //             : property.sectorAR ?? "",
                          //         style: AppTextStyle.normalGrey10,
                          //         maxLines: 1,
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          SizedBox(
                            height: 1.0.h,
                          ),
                          Row(
                            children: [
                              Text(
                                AppMetaLabels().type,
                                style: AppTextStyle.normalGrey11,
                              ),
                              Spacer(),
                              Container(
                                alignment: Alignment.centerRight,
                                width: 58.w,
                                child: Text(
                                  SessionController().getLanguage() == 1
                                      ? property.propertyType ?? ""
                                      : property.propertyTypeAR ?? "",
                                  style: AppTextStyle.normalGrey10,
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 1.2.h,
                          ),
                          Row(
                            children: [
                              Text(
                                AppMetaLabels().category,
                                style: AppTextStyle.normalGrey11,
                              ),
                              Spacer(),
                              Container(
                                alignment: Alignment.centerRight,
                                width: 58.w,
                                child: Text(
                                  SessionController().getLanguage() == 1
                                      ? property.propertyCategory ?? ""
                                      : property.propertyCategoryAR ?? "",
                                  style: AppTextStyle.normalGrey10,
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: SessionController().getLanguage() == 1
                          ? EdgeInsets.only(right: 1.0.h, left: 0.5.h)
                          : EdgeInsets.only(right: 0.5.h, left: 1.0.h),
                      child: SizedBox(
                        width: 0.15.w,
                        child: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: AppColors.grey1,
                          size: 20,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
