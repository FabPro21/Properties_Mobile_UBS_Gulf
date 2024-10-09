// ignore_for_file: deprecated_member_use

import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/data/models/tenant_models/contract_payable/outstanding_payments_model.dart';
import 'package:fap_properties/data/models/tenant_models/contract_payable/register_payment_response.dart';
import 'package:fap_properties/data/repository/tenant_repository.dart';
import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:fap_properties/views/tenant/tenant_contracts/tenant_contracts_tabs.dart/tenant_contracts_details.dart/tenant_contracts_detail_controller.dart';
import 'package:fap_properties/views/tenant/tenant_dashboard/tenant_dashboard_tabs/tenant_dashboard_tabs.dart';
import 'package:fap_properties/views/tenant/tenant_New_contract/make_payment/outstanding_payments_new/outstanding_payments_new_controller.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:fap_properties/views/widgets/snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:webviewx/webviewx.dart';

import 'online_payments_new/online_payments_new_controller.dart';

class MakePaymentNewContract extends StatefulWidget {
  final RegisterPaymentResponse? data;
  final String? contractNo;
  const MakePaymentNewContract({Key? key, this.data, this.contractNo})
      : super(key: key);

  @override
  State<MakePaymentNewContract> createState() => _MakePaymentNewContractState();
}

class _MakePaymentNewContractState extends State<MakePaymentNewContract> {
  bool showProgress = true;

  final outstandingPaymentsController =
      Get.put(OutstandingPaymentsNewContractController());
  final onlinePaymentsController =
      Get.put(OnlinePaymentsNewContractController());
  bool showBack = false;
  int? noOfPaymentsLeft;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (showBack) {
          getBack();
        } else {
          Get.back();
        }
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            AppMetaLabels().makePayment,
            style: AppTextStyle.semiBoldWhite15,
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () async {
                if (showBack) {
                  getBack();
                } else {
                  Get.back();
                }
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              )),
          actions: [
            IconButton(
                icon: Image.asset(AppImagesPath.contracts),
                onPressed: () {
                  onlinePaymentsController.getOnlinePayable();
                  Get.put(GetContractsDetailsController())
                      .getContractPayables();
                  outstandingPaymentsController.getOutstandingPayments();
                  Navigator.pop(context);
                  Navigator.pop(context);
                }),
          ],
          flexibleSpace: Image(
            image: AssetImage(AppImagesPath.appbarimg),
            fit: BoxFit.cover,
          ),
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          top: false,
          child: Stack(
            children: [
              WebViewX(
                width: double.maxFinite,
                height: double.maxFinite,
                initialContent:
                    """<body><form action=${widget.data!.url} method="post" id="paymentForm"><input type="Hidden" name="TransactionID" value= "${widget.data!.transactionId}"/><script>document.getElementById('paymentForm').submit();</script></body>""",
                initialSourceType: SourceType.HTML,
                onPageFinished: (url) {
                  print(url);
                  if (url.contains('Finalize')) {
                    setState(() {
                      showBack = true;
                    });
                  }
                  setState(() {
                    showProgress = false;
                  });
                },
              ),
              if (showProgress) LoadingIndicatorBlue(),
              if (showBack)
                Padding(
                  padding: EdgeInsets.only(top: 75.0.h),
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () {
                        getBack();
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 36.0.w),
                        child: Text(AppMetaLabels().back),
                      ),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3.0.sp),
                              side: BorderSide(
                                color: AppColors.blueColor,
                                width: 1.0,
                              )),
                          backgroundColor: AppColors.greyBG,
                          foregroundColor: AppColors.blueColor,
                          shadowColor: Colors.transparent),
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  void getBack() {
    getOnlinePayable();
  }

  Future getOnlinePayable() async {
    try {
      bool _isIntenetConnected = await BaseClientClass.isInternetConnected();
      if (!_isIntenetConnected) {
        Get.to(() => NoInternetScreen());
      }
      SnakBarWidget.getLoadingWithColor();
      var resp = await TenantRepository.getContractOnlinePayable(
          SessionController().getContractID());
      print(resp);
      print(AppMetaLabels().noDatafound);
      Get.back();
      if (resp is OutstandingPaymentsModel) {
        onlinePaymentsController.getOnlinePayable();
        Get.back();
      } else if (resp == AppMetaLabels().noDatafound) {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                contentPadding: EdgeInsets.zero,
                backgroundColor: Colors.transparent,
                content: showDialogData(),
              );
            });
      } else {
        SnakBarWidget.getSnackBarError(AppMetaLabels().error, resp.toString());
      }
    } catch (e) {
      print('Controller Exception $e');
    }
  }

  Widget showDialogData() {
    return Container(
        padding: EdgeInsets.all(3.0.w),
        // height: 45.0.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(2.0.h),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 0.5.h,
              spreadRadius: 0.3.h,
              offset: Offset(0.1.h, 0.1.h),
            ),
          ],
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 3.0.h,
              ),
              Text(
                AppMetaLabels().collierStage5_12,
                textAlign: TextAlign.center,
                style: AppTextStyle.semiBoldBlack13,
              ),
              SizedBox(
                height: 3.0.h,
              ),
              Padding(
                padding: EdgeInsets.only(top: 0.0.h, bottom: 3.0.h),
                child: Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: 4.0.h,
                    width: 65.0.w,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          elevation: WidgetStateProperty.all<double>(0.0.h),
                          backgroundColor: WidgetStateProperty.all<Color>(
                              AppColors.whiteColor),
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(2.0.w),
                                side: BorderSide(
                                  color: AppColors.blueColor,
                                  width: 1.0,
                                )),
                          )),
                      onPressed: () {
                        Get.back();
                        Get.off(() => TenantDashboardTabs(
                              initialIndex: 0,
                            ));
                      },
                      child: Text(
                        AppMetaLabels().ok,
                        style: AppTextStyle.semiBoldWhite11
                            .copyWith(color: Colors.blue),
                      ),
                    ),
                  ),
                ),
              ),
            ]));
  }
}
