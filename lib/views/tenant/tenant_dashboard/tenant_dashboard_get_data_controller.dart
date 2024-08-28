// ignore_for_file: unused_local_variable
import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/data/models/auth_models/verify_user_otp_model.dart';
import 'package:fap_properties/data/models/tenant_models/expiring_in_30days.dart';
import 'package:fap_properties/data/models/tenant_models/get_contracts_model.dart';
import 'package:fap_properties/data/models/tenant_models/tenant_dashboard_get_data_model.dart';
import 'package:fap_properties/data/models/tenant_models/tenant_dashboard_popup/tenant_dashboard_notification_popup_model.dart';
import 'package:fap_properties/data/models/tenant_models/to_be_paid_in_30days_model.dart';
import 'package:fap_properties/data/repository/tenant_repository.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../data/models/tenant_models/contract_payment_model.dart';

class TenantDashboardGetDataController extends GetxController {
  var dashboardData = TenantDashboardGetDataModel().obs;
  var bottomSheetData = ToBePaidIn30DaysModel().obs;

  var notificationdata = TenantDashboardNotificationPopupModel().obs;
  var loadingNotification = false.obs;
  RxString errorNotification = "".obs;
  RxInt lengthNotiification = 0.obs;
  bool notificationsDialogShown = false;
  var loadingData = false.obs;
  int length = 0;
  RxString onSearch = "".obs;
  // var paid = 0.0.obs;
  var rentalVal = 0.0.obs;
  var rentOutstanding = 0.0.obs;
  RxString contractExpiringIn30Days = "".obs;
  RxBool loadingBottomSheetData = false.obs;
  int toBePaidIn30DaysLength = 0;
  RxString paymentCurrency = "0.0".obs;
  RxString paidCurrency = "0.0".obs;
  RxString toBePaidCurrency = "0.0".obs;
  RxString balanceCurrency = "0.0".obs;
  RxString error = "".obs;
  RxString errorSheet = "".obs;
  RxString nameAr = "".obs;
  RxString name = "".obs;

  RxBool showRenewalButton = false.obs;

  //------------------ dashboard! contracts
  Rx<GetContractsModel> getContracts = GetContractsModel().obs;
  var loadingContractsData = false.obs;
  RxInt contractsLength = 0.obs;
  RxString contractsError = "".obs;
  int listLength = 0;

  //------------------ dashboard! payments
  var payments = ContractPaymentModel().obs;

  var loadingPaymentsData = false.obs;
  int paymentsLength = 0;
  int paymentsLength2 = 0;
  RxString errorPayments = "".obs;

  @override
  void onInit() {
    // getDashboardData();
    // Get.put(TenantContracrsFilterController());
    // Get.put(FilterPropertyController());
    // 112233 removed Get.find(FilterContractsStatusController());
    super.onInit();
  }

  getDashboardData() async {
    String mystring1 = SessionController().getUserName() ?? "";
    var a1 = mystring1.trim();
    if (a1.isEmpty == false) {
      name.value = a1[0];
    } else {
      name.value = '-';
    }

    getData();
    getContractsData();
    getDashboardNotifications();
  }

  void updateNotifications(int noOfNotifications) {
    lengthNotiification.value = noOfNotifications;
    print(noOfNotifications);
    print(lengthNotiification.value);
    update();
  }

  getData() async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }
    loadingData.value = true;
    error.value = '';
    var result = await TenantRepository.tenantDashboardGetData();
    loadingData.value = false;
    if (result == 'No internet connection') {
      await Get.to(NoInternetScreen());
    } else if (result is TenantDashboardGetDataModel) {
      if (dashboardData.value.status == AppMetaLabels().notFound) {
        error.value = AppMetaLabels().noDatafound;
      } else {
        dashboardData.value = result;
        contractExpiringIn30Days.value =
            dashboardData.value.dashboard!.contractExpiringIn30Days.toString();
        rentalVal.value = dashboardData.value.dashboard!.rentalVal.toDouble();
        rentOutstanding.value =
            dashboardData.value.dashboard!.rentOutstanding.toDouble();

        //////////////////
        /// payment balance Currency
        //////////////////

        double pb = dashboardData.value.dashboard!.paymentBalance.toDouble();
        final pymentFormatter = NumberFormat('#,##0.00', 'AR');
        paymentCurrency.value = pymentFormatter.format(pb);

        //////////////////
        /// paid Currency
        //////////////////

        //////////////////
        /// to be paid Currency
        //////////////////
        double t = dashboardData.value.dashboard!.rentalVal.toDouble();
        final tobePaidFormatter = NumberFormat('#,##0.00', 'AR');
        toBePaidCurrency.value = tobePaidFormatter.format(t);

        //////////////////
        /// balance Currency
        //////////////////
        double b = dashboardData.value.dashboard!.rentOutstanding.toDouble();
        final balanceFormatter = NumberFormat('#,##0.00', 'AR');
        balanceCurrency.value = balanceFormatter.format(b);
        // no of notification on badge
        lengthNotiification.value = result.unreadNotifications??0;
        if (result.contractRenewalAction! > 0) {
          showRenewalButton.value = true;
        } else {
          showRenewalButton.value = false;
        }
        update();
      }
    } else {
      error.value = AppMetaLabels().noDatafound;
    }
    loadingData.value = false;
  }

  getContractsData() async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }
    contractsError.value = '';
    loadingContractsData.value = true;
    var result = await TenantRepository.getContracts();
    User user = SessionController().getUser();
    if (result == 'No internet connection') {
      await Get.to(NoInternetScreen());
    } else if (result is GetContractsModel) {
      print(result);
      getContracts.value = result;
      if (getContracts.value.status == AppMetaLabels().notFound) {
        contractsError.value = AppMetaLabels().noDatafound;
        loadingContractsData.value = false;
      } else {
        contractsLength.value = getContracts.value.contracts!.length;
        listLength = getContracts.value.contracts!.length;
        if (listLength > 3) listLength = 3;
        loadingContractsData.value = false;
      }
    } else if (result == AppMetaLabels().someThingWentWrong) {
      contractsError.value = AppMetaLabels().someThingWentWrong;
      loadingContractsData.value = false;
    } else if (result == AppMetaLabels().badRequest) {
      contractsError.value = AppMetaLabels().badRequest;
      loadingContractsData.value = false;
    } else {
      contractsError.value = AppMetaLabels().noDatafound;
      loadingContractsData.value = false;
    }
  }

  getContractsDataPagination(String pageNo, String search) async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }
    contractsError.value = '';
    loadingContractsData.value = true;
    var result = await TenantRepository.getContractsPagination(pageNo, search);
    User user = SessionController().getUser();

    if (result == 'No internet connection') {
      await Get.to(NoInternetScreen());
    } else if (result is GetContractsModel) {
      getContracts.value = result;
      if (getContracts.value.status == AppMetaLabels().notFound) {
        contractsError.value = AppMetaLabels().noDatafound;
        loadingContractsData.value = false;
      } else {
        contractsLength.value = getContracts.value.contracts!.length;
        listLength = getContracts.value.contracts!.length;
        if (listLength > 3) listLength = 3;
        loadingContractsData.value = false;
      }
    } else if (result == AppMetaLabels().someThingWentWrong) {
      contractsError.value = AppMetaLabels().someThingWentWrong;
      loadingContractsData.value = false;
    } else if (result == AppMetaLabels().badRequest) {
      contractsError.value = AppMetaLabels().badRequest;
      loadingContractsData.value = false;
    } else {
      contractsError.value = AppMetaLabels().noDatafound;
      loadingContractsData.value = false;
    }
  }

  getPaymentsData() async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }
    loadingPaymentsData.value = true;
    var result = await TenantRepository.payments();
    loadingPaymentsData.value = false;
    if (result == 'No internet connection') {
      await Get.to(NoInternetScreen());
    } else if (result is ContractPaymentModel) {
      payments.value = result;
      if (payments.value.status == AppMetaLabels().notFound) {
        errorPayments.value = AppMetaLabels().noDatafound;
      } else {
        paymentsLength = payments.value.payments!.length;
        paymentsLength2 = payments.value.payments!.length;
        if (paymentsLength2 > 3) paymentsLength2 = 3;
      }
    } else {
      errorPayments.value = AppMetaLabels().noDatafound;
    }
    update();
  }

  getDashboardNotifications() async {
    loadingNotification.value = true;
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      Get.to(() => NoInternetScreen());
    }
    try {
      var resp = await TenantRepository.getDashboardPopup();
      if (resp == 'No internet connection') {
        await Get.to(NoInternetScreen());
      } else if (resp is TenantDashboardNotificationPopupModel) {
        if (resp.status == AppMetaLabels().notFound) {
          error.value = AppMetaLabels().noDatafound;
        } else {
          notificationdata.value = resp;
          loadingNotification.value = false;
        }
      } else {
        errorNotification.value = resp;
        loadingNotification.value = false;
      }
    } catch (e) {
      print("This is the error from controller $e");
    }
  }

  void getBottomSheetData() async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }
    errorSheet.value = '';
    loadingBottomSheetData.value = true;
    var resp = await TenantRepository.toBePaidIn30Days();
    loadingBottomSheetData.value = false;

    if (resp == 'No internet connection') {
      await Get.to(NoInternetScreen());
    } else if (resp is ToBePaidIn30DaysModel) {
      if (resp.status == AppMetaLabels().notFound) {
        errorSheet.value = AppMetaLabels().noDatafound;
      } else {
        bottomSheetData.value = resp;
        toBePaidIn30DaysLength = resp.data!.length;
      }
    } else {
      errorSheet.value = resp;
    }
  }

  //////////////////////////////contracts expiring in 30 days////
  ContractExpire30Days? contractsExpiring;
  RxBool loadingContractsExpiring = false.obs;
  String errorLoadingExpiringContracts = '';

  void getExpiringContracts() async {
    errorLoadingExpiringContracts = '';
    loadingContractsExpiring.value = true;
    var resp = await TenantRepository.expiringIn30Days();
    if (resp == 'No internet connection') {
      await Get.to(NoInternetScreen());
    } else if (resp is ContractExpire30Days) {
      contractsExpiring = resp;
    } else
      errorLoadingExpiringContracts = resp;
    loadingContractsExpiring.value = false;
  }
}
