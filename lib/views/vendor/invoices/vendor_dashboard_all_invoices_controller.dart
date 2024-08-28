import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/vendor_models/vendor_dashboard_all_invoices/vendor_dashboard_all_invoices_model.dart';
import 'package:fap_properties/data/repository/vendor_repository.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:get/get.dart';

class VendorDashboardAllInvoicesController extends GetxController {
  var allInvoicesData = VendorDashboardAllInvoicesModel().obs;

  var loadingData = true.obs;
  int length = 0;
  RxString onSearch = "".obs;
  RxString error = "".obs;

  List<Invoice> allInvoice = [Invoice()].obs;

  getAllInvoicse() async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(() => NoInternetScreen());
    }
    // try {
    loadingData.value = true;
    var result = await VendorRepository.getVendorAllInvoices();
    if (result is VendorDashboardAllInvoicesModel) {
      allInvoicesData.value = result;
      if (allInvoicesData.value.status == AppMetaLabels().notFound) {
        error.value = AppMetaLabels().noDatafound;
        loadingData.value = false;
      } else {
        allInvoicesData.value = result;
        allInvoice = result.invoice!.toList();
        length = allInvoicesData.value.invoice!.length;
        update();
        loadingData.value = false;
      }
    } else {
      error.value = AppMetaLabels().noDatafound;
      loadingData.value = false;
    }
    // } catch (e) {
    //   loadingData.value = false;
    //   print("this is the error from controller= $e");
    // }
  }

  String pageNo = '1';
  getAllInvoicsePagination(String pageNoP, searchtext) async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(() => NoInternetScreen());
    }
    try {
      error.value = '';
      loadingData.value = true;
      var result = await VendorRepository.getVendorAllInvoicesPagination(
          pageNoP, searchtext);
      if (result is VendorDashboardAllInvoicesModel) {
        allInvoicesData.value = result;
        if (allInvoicesData.value.status == AppMetaLabels().notFound) {
          error.value = AppMetaLabels().noDatafound;
          loadingData.value = false;
        } else {
          allInvoicesData.value = result;
          allInvoice = result.invoice!.toList();
          length = allInvoicesData.value.invoice!.length;
          update();
          loadingData.value = false;
        }
      } else {
        error.value = AppMetaLabels().noDatafound;
        loadingData.value = false;
      }
    } catch (e) {
      loadingData.value = false;
       error.value = AppMetaLabels().someThingWentWrong;
      print("this is the error from controller= $e");
    }
  }

  RxString errorLoadMore = ''.obs;
  var loadingDataLoadMore = true.obs;
  getAllInvoicsePaginationLoadMore(String pageNoP, searchtext) async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(() => NoInternetScreen());
    }
    // try {
    loadingDataLoadMore.value = true;
    var result = await VendorRepository.getVendorAllInvoicesPagination(
        pageNoP, searchtext);

    if (result is VendorDashboardAllInvoicesModel) {
      allInvoicesData.value = result;
      if (allInvoicesData.value.status == AppMetaLabels().notFound) {
        errorLoadMore.value = AppMetaLabels().noDatafound;
        loadingDataLoadMore.value = false;
      } else {
        for (int i = 0; i < allInvoicesData.value.invoice!.length; i++) {
          allInvoice.add(allInvoicesData.value.invoice![i]);
        }
        length = allInvoice.length;
        update();
        loadingDataLoadMore.value = false;
      }
    } else {
      errorLoadMore.value = AppMetaLabels().noDatafound;
      loadingDataLoadMore.value = false;
    }
    // } catch (e) {
    //   loadingData.value = false;
    //   print("this is the error from controller= $e");
    // }
  }

  searchData(String qry) {
    if (allInvoicesData.value.invoice!.isNotEmpty) {
    // if (allInvoicesData.value.invoice != null) { #1
      qry.toLowerCase();
      loadingData.value = true;
      allInvoice.clear();
      for (int i = 0; i < allInvoicesData.value.invoice!.length; i++) {
        if (allInvoicesData.value.invoice![i].invoiceNumber!.contains(qry) ||
            allInvoicesData.value.invoice![i].statusName!
                .toLowerCase()
                .contains(qry)) {
          allInvoice.add(allInvoicesData.value.invoice![i]);
        }
      }
      if (allInvoice.length == 0)
        error.value = AppMetaLabels().noInvoicesFound;
      else
        error.value = '';

      loadingData.value = false;
    }
  }
}
