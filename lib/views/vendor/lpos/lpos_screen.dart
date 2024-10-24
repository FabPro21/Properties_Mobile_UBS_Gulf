import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/widgets/common_widgets/custom_error_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:fap_properties/views/widgets/srno_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/status_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:sizer/sizer.dart';
import 'lpo_details/lpo_details.dart';
import 'lpos_screen_controller.dart';

class LposScreen extends StatefulWidget {
  const LposScreen({Key? key}) : super(key: key);

  @override
  _LposScreenState createState() => _LposScreenState();
}

class _LposScreenState extends State<LposScreen> {
  final GetAllLpoController getAllLpoController = Get.find();
  // final getAllLpoController getAllLpoController = Get.find();
  final TextEditingController searchControler = TextEditingController();

  @override
  void initState() {
    // getAllLpoController.getData();
    getAllLpoController.pageNo = '1';
    getAllLpoController.pageNoFilter = '1';
    getAllLpoController.errorLoadMore.value = '';
    getAllLpoController.loadingDataLoadMore.value = false;
    getAllLpoController.getDataPagination(getAllLpoController.pageNo, '');
    super.initState();
  }

  String gAmount = "";
  String dAmount = "";
  String nAmount = "";

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: SessionController().getLanguage() == 1
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 3.0.h),
                child: Text(
                  AppMetaLabels().lpos,
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
                            // inputFormatters: TextInputFormatter()
                            //     .searchPropertyNameContractNoIF,
                            controller: searchControler,
                            onChanged: (value) async {
                              // getAllLpoController.searchData(value);
                              getAllLpoController.pageNo = '1';
                              await getAllLpoController.getDataPagination(
                                  getAllLpoController.pageNo, value.trim());
                              setState(() {});

                              if (value.isEmpty) {
                                await getAllLpoController.getDataPagination(
                                    getAllLpoController.pageNo, '');
                                setState(() {});
                              }
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
                              hintText: AppMetaLabels().searchLpos,
                              hintStyle: AppTextStyle.normalBlack10
                                  .copyWith(color: Colors.grey),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            searchControler.clear();
                            // getAllLpoController.getData();
                            getAllLpoController.getDataPagination(
                                getAllLpoController.pageNo, '');
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
                    top: 4.0.h,
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
                              blurRadius: 0.4.h,
                              spreadRadius: 0.5.h,
                              offset: Offset(0.1.h, 0.1.h),
                            ),
                          ],
                        ),
                        child: Obx(() {
                          return getAllLpoController.loadingData.value == true
                              ? LoadingIndicatorBlue()
                              : getAllLpoController.error.value != ''
                                  ? CustomErrorWidget(
                                      errorText:
                                          AppMetaLabels().noLPOFound + '',
                                      errorImage: AppImagesPath.nolpos,
                                    )
                                  : Column(
                                      children: [
                                        ListView.builder(
                                          shrinkWrap: true,
                                          padding: EdgeInsets.zero,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount:
                                              getAllLpoController.lpos.length,
                                          itemBuilder: (context, index) {
                                            double ga = getAllLpoController
                                                .lpos[index].grossAmount;
                                            final gaFormatter =
                                                intl.NumberFormat(
                                                    '#,##0.00', 'AR');
                                            gAmount = gaFormatter.format(ga);

                                            double da = getAllLpoController
                                                .lpos[index].discountAmount;
                                            final daFormatter =
                                                intl.NumberFormat(
                                                    '#,##0.00', 'AR');
                                            dAmount = daFormatter.format(da);

                                            double na = getAllLpoController
                                                .lpos[index].netAmount;
                                            final naFormatter =
                                                intl.NumberFormat(
                                                    '#,##0.00', 'AR');
                                            nAmount = naFormatter.format(na);
                                            return inkWell(index);
                                          },
                                        ),
                                        getAllLpoController.lpos.length < 20
                                            ? SizedBox()
                                            : getAllLpoController
                                                        .isFilter.value ==
                                                    false
                                                ? getAllLpoController
                                                            .errorLoadMore
                                                            .value !=
                                                        ''
                                                    ? SizedBox()
                                                    : InkWell(
                                                        onTap: () async {
                                                          int pageSize = int.parse(
                                                              getAllLpoController
                                                                  .pageNo);
                                                          int naePageNo =
                                                              pageSize + 1;
                                                          getAllLpoController
                                                                  .pageNo =
                                                              naePageNo
                                                                  .toString();
                                                          await getAllLpoController
                                                              .getDataPaginationLoadMore(
                                                                  getAllLpoController
                                                                      .pageNo,
                                                                  searchControler
                                                                      .text);

                                                          setState(() {});
                                                        },
                                                        child: Container(
                                                          height: 5.h,
                                                          width: 88.w,
                                                          child: Row(
                                                            children: [
                                                              Spacer(),
                                                              RichText(
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                text: TextSpan(
                                                                  children: [
                                                                    TextSpan(
                                                                        text: AppMetaLabels()
                                                                            .loadMoreData,
                                                                        style: AppTextStyle
                                                                            .boldBlue),
                                                                    WidgetSpan(
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .arrow_forward_ios,
                                                                        size:
                                                                            15,
                                                                        color: AppColors
                                                                            .blueColor,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 1.w,
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                : getAllLpoController
                                                            .errorLoadMoreFilter
                                                            .value !=
                                                        ''
                                                    ? SizedBox()
                                                    : InkWell(
                                                        onTap: () async {
                                                          int pageSize = int.parse(
                                                              getAllLpoController
                                                                  .pageNoFilter);
                                                          int naePageNo =
                                                              pageSize + 1;
                                                          getAllLpoController
                                                                  .pageNoFilter =
                                                              naePageNo
                                                                  .toString();
                                                          await getAllLpoController
                                                              .getFilteredDataPaginationLoadMore(
                                                            getAllLpoController
                                                                .filterDataVar!,
                                                            getAllLpoController
                                                                .pageNoFilter,
                                                          );

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
                                                                text: TextSpan(
                                                                  children: [
                                                                    TextSpan(
                                                                        text: AppMetaLabels()
                                                                            .loadMoreData,
                                                                        style: AppTextStyle
                                                                            .boldBlue),
                                                                    WidgetSpan(
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .arrow_forward_ios,
                                                                        size:
                                                                            15,
                                                                        color: Colors
                                                                            .blue,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 1.w,
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                      ],
                                    );
                        }),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Obx(() {
            return Padding(
              padding: EdgeInsets.only(bottom: 2.0.h),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: 100.0.w,
                  height: 4.0.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 4.0.h,
                        width: 28.0.w,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white, // background
                            // onPrimary: Colors.yellow, // foreground
                          ),
                          onPressed: () async {
                            // getAllLpoController.applyFilter();
                            getAllLpoController.applyFilterPagination(
                                getAllLpoController.pageNoFilter);
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
                      getAllLpoController.isFilter.value == false
                          ? Container()
                          : Padding(
                              padding: EdgeInsets.symmetric(horizontal: 1.0.h),
                              child: Container(
                                height: 4.0.h,
                                width: 28.0.w,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white, // background
                                    // onPrimary: Colors.yellow, // foreground
                                  ),
                                  onPressed: () async {
                                    // getAllLpoController.getData();
                                    getAllLpoController.pageNo = '1';
                                    getAllLpoController.getDataPagination(
                                        getAllLpoController.pageNo, '');
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                            ),
                    ],
                  ),
                ),
              ),
            );
          }),
          Obx(() {
            return getAllLpoController.loadingDataLoadMore.value
                ? Container(
                    height: double.infinity,
                    width: double.infinity,
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: LoadingIndicatorBlue(),
                    )),
                  )
                : SizedBox();
          })
        ],
      ),
    );
  }

  InkWell inkWell(int index) {
    return InkWell(
      onTap: () {
        SessionController().setLpoId(
          getAllLpoController.lpos[index].lpoId.toString(),
        );
        SessionController().setLpoRefNo(
          getAllLpoController.lpos[index].lpoReference.toString(),
        );
        Get.to(
          () => LpoDetails(
            lpo: getAllLpoController.lpos[index],
          ),
        );
      },
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 2.0.h,
              right: 2.0.h,
              top: 2.0.h,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SrNoWidget(text: index + 1, size: 4.h),
                Row(
                  children: [
                    Container(
                      width: 70.w,
                      child: Padding(
                        padding: EdgeInsets.only(left: 2.0.h, right: 0.5.h),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  AppMetaLabels().lpoRefNo,
                                  style: AppTextStyle.semiBoldBlack11,
                                ),
                                Spacer(),
                                Text(
                                  getAllLpoController.lpos[index].lpoReference
                                      .toString(),
                                  style: AppTextStyle.semiBoldBlack11,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 1.5.h,
                            ),
                            rowList(
                              AppMetaLabels().docRefNo,
                              getAllLpoController.lpos[index].docReference ??
                                  'N/A',
                            ),
                            SizedBox(
                              height: 1.0.h,
                            ),
                            rowList(
                              AppMetaLabels().lPOType,
                              SessionController().getLanguage() == 1
                                  ? getAllLpoController.lpos[index].lpoType ??
                                      ""
                                  : getAllLpoController.lpos[index].lpoTypeAr ??
                                      "",
                            ),
                            SizedBox(
                              height: 1.0.h,
                            ),
                            rowList(
                              AppMetaLabels().lpoDate,
                              getAllLpoController.lpos[index].lpoDate ?? "",
                            ),
                            SizedBox(
                              height: 1.0.h,
                            ),
                            rowList(
                              AppMetaLabels().grossAmount,
                              "${AppMetaLabels().aed} $gAmount",
                            ),
                            SizedBox(
                              height: 1.0.h,
                            ),
                            rowList(
                              AppMetaLabels().discountAmount,
                              "${AppMetaLabels().aed} $dAmount",
                            ),
                            SizedBox(
                              height: 1.0.h,
                            ),
                            rowList(AppMetaLabels().netAmount,
                                "${AppMetaLabels().aed} $nAmount"),
                            SizedBox(
                              height: 1.0.h,
                            ),
                            Row(
                              children: [
                                Text(
                                  AppMetaLabels().lPOStatus,
                                  style: AppTextStyle.semiBoldBlack11,
                                ),
                                Spacer(),
                                ConstrainedBox(
                                    constraints: BoxConstraints(maxWidth: 40.w),
                                    child: FittedBox(
                                      child: StatusWidgetVendor(
                                        text:
                                            SessionController().getLanguage() ==
                                                    1
                                                ? getAllLpoController
                                                        .lpos[index]
                                                        .lpoStatus ??
                                                    ''
                                                : getAllLpoController
                                                        .lpos[index]
                                                        .lpoStatusAr ??
                                                    '',
                                        valueToCompare: getAllLpoController
                                            .lpos[index].lpoStatus,
                                      ),
                                    ))
                              ],
                            ),
                            SizedBox(
                              height: 1.0.h,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 1.0.h, left: 1.h),
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
              ],
            ),
          ),
          index == getAllLpoController.lpos.length - 1
              ? Container()
              : AppDivider(),
        ],
      ),
    );
  }

  Row rowList(String t1, String t2) {
    return Row(
      children: [
        Text(
          t1,
          style: AppTextStyle.normalGrey11,
        ),
        Spacer(),
        Text(
          t2,
          style: AppTextStyle.normalGrey11,
        ),
      ],
    );
  }
}
