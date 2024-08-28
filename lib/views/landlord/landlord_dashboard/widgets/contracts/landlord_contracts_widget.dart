import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/landlord/landlord_contracts/landlord_contract_details_tabs/landlord_contract-details_tabs.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/error_text_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:fap_properties/views/widgets/common_widgets/status_widget.dart';
import 'package:fap_properties/views/widgets/srno_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'contracts_widget_controller.dart';

class YourContracts extends StatefulWidget {
  final Function(int)? manageContracts;
  YourContracts({Key? key, this.manageContracts}) : super(key: key);

  @override
  State<YourContracts> createState() => _YourContractsState();
}

class _YourContractsState extends State<YourContracts> {
  @override
  void initState() {
    super.initState();
  }

  final controller = Get.find<LandlordContractsWidgetController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(left: 2.0.h, right: 2.0.h, top: 2.0.h, bottom: 2.0.h),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(1.0.h),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 1.0.h,
              spreadRadius: 0.2.h,
              offset: Offset(0.0.h, 0.5.h),
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.5.w),
              child: Text(
                AppMetaLabels().yourContractsLand,
                style: AppTextStyle.semiBoldBlack13,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 2.h),
              child: AppDivider(),
            ),
            Container(
              child: Obx(() {
                return controller.loadingContracts.value == true
                    ? LoadingIndicatorBlue()
                    : controller.errorLoadingContracts != ''
                        ? AppErrorWidget(
                            errorText: controller.errorLoadingContracts,
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: controller.length,
                            itemBuilder: (context, index) {
                              final contract =
                                  controller.contractsModel!.data![index];
                              final bool isEng =
                                  SessionController().getLanguage() == 1;
                              return InkWell(
                                onTap: () {
                                  Get.to(() => LandlordContractDetailsTabs(
                                        contractId: int.parse(
                                            contract.contractID.toString()),
                                        contractNo: contract.contractno!,
                                        prevContractNo: '',
                                      ));
                                },
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 3.0.w, vertical: 1.5.h),
                                      child: Row(
                                        children: [
                                          SrNoWidget(
                                            text: (index + 1).toString(),
                                            size: 8.w,
                                          ),
                                          SizedBox(
                                            width: 2.0.w,
                                          ),
                                          Container(
                                            width: 62.0.w,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      width: 48.0.w,
                                                      child: Text(
                                                        isEng
                                                            ? contract
                                                                    .propertyName ??
                                                                ''
                                                            : contract
                                                                    .propertyNameAR ??
                                                                "",
                                                        style: AppTextStyle
                                                            .semiBoldBlack12,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                    Text(
                                                      '${contract.contractno}',
                                                      style: AppTextStyle
                                                          .normalBlack11,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 1.0.h,
                                                ),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      contract.contractStartDate ??
                                                          "",
                                                      style: AppTextStyle
                                                          .normalGrey10,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 1.w),
                                                      child: Icon(
                                                          Icons.arrow_forward,
                                                          size: 10.sp,
                                                          color: AppColors
                                                              .greyColor),
                                                    ),
                                                    Text(
                                                      contract.contractEndDate ??
                                                          "",
                                                      style: AppTextStyle
                                                          .normalGrey10,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 1.0.h,
                                                ),
                                                StatusWidget(
                                                  text: isEng
                                                      ? contract.contractStatus
                                                      : contract
                                                          .contractStatusAR,
                                                  valueToCompare:
                                                      contract.contractStatus ??
                                                          "",
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 1.0.h, right: 1.0.h),
                                      child: AppDivider(),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
              }),
            ),
            Padding(
              padding: EdgeInsets.only(top: 2.0.h, bottom: 2.0.h),
              child: TextButton(
                style: TextButton.styleFrom(
                  minimumSize: Size.zero,
                  padding: EdgeInsets.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: () {
                  //  widget.manageContracts(1);
                },
                child: Text(
                  AppMetaLabels().viewAllContracts,
                  style: AppTextStyle.semiBoldBlue9,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
