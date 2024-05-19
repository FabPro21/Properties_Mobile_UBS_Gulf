import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/landlord_models/landlord_invoice_model.dart';
import 'package:fap_properties/data/repository/landlord_repository.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:get/get.dart';

class LandlordInvoicesController extends GetxController {
  var allInvoicesData = LandlordInvoicesModel().obs;
  var loadingData = true.obs;
  int length = 0;
  RxString onSearch = "".obs;
  RxString error = "".obs;
  List<Invoice> allInvoice = [Invoice()].obs;

  String pageNo = '1';
  getAllInvoicsePagination(String pageNoP, searchtext) async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(() => NoInternetScreen());
    }
    var result;
    try {
      error.value = '';
      loadingData.value = true;
      result = await LandlordRepository.getAllInvoicesPagination(
          pageNoP, searchtext);
      print('Result ::: ${result.toString()}');
      if (result.toString() == AppMetaLabels().noDatafound) {
        error.value = AppMetaLabels().noDatafound;
        loadingData.value = false;
        return;
      }
      if (result is LandlordInvoicesModel) {
        allInvoicesData.value = result;
        if (allInvoicesData.value.status == AppMetaLabels().notFound) {
          error.value = AppMetaLabels().noDatafound;
          loadingData.value = false;
        } else {
          allInvoicesData.value = result;
          allInvoice = result.invoice.toList();
          length = allInvoicesData.value.invoice.length;
          update();
          loadingData.value = false;
        }
      } else {
        error.value = AppMetaLabels().noDatafound;
        loadingData.value = false;
      }
    } catch (e) {
      loadingData.value = false;
      error.value = result.toString();
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
    var result =
        await LandlordRepository.getAllInvoicesPagination(pageNoP, searchtext);

    if (result is LandlordInvoicesModel) {
      allInvoicesData.value = result;
      if (allInvoicesData.value.status == AppMetaLabels().notFound) {
        errorLoadMore.value = AppMetaLabels().noDatafound;
        loadingDataLoadMore.value = false;
      } else {
        for (int i = 0; i < allInvoicesData.value.invoice.length; i++) {
          allInvoice.add(allInvoicesData.value.invoice[i]);
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
    if (allInvoicesData.value.invoice != null) {
      qry.toLowerCase();
      loadingData.value = true;
      allInvoice.clear();
      for (int i = 0; i < allInvoicesData.value.invoice.length; i++) {
        if (allInvoicesData.value.invoice[i].invoiceNumber.contains(qry) ||
            allInvoicesData.value.invoice[i].statusName
                .toLowerCase()
                .contains(qry)) {
          allInvoice.add(allInvoicesData.value.invoice[i]);
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
