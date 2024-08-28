// ignore_for_file: unnecessary_null_comparison

import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/vendor_models/get_vendor_contracts_status_model.dart';
import 'package:fap_properties/data/models/vendor_models/vendor_get_contracts_model.dart';
import 'package:fap_properties/data/repository/vendor_repository.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:fap_properties/views/vendor/vendor_contracts/vendor_contracts_filter/vendor_contracts_filter.dart';
import 'package:get/get.dart';

class VendorContractsController extends GetxController {
  var getContracts = VendorContractsModel().obs;

  var loadingData = true.obs;
  RxString error = ''.obs;
  int length = 0;
  RxBool isFilter = false.obs;

  VendorContractFilterData? filterData;
  List<Contract> contracts = [Contract()].obs;

  @override
  void onInit() {
    // getData();
    super.onInit();
  }

  getData() async {
    isFilter.value = false;
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }
    error.value = '';
    try {
      loadingData.value = true;
      var result = await VendorRepository.getContracts();
      if (result is VendorContractsModel) {
        getContracts.value = result;
        if (getContracts.value.status == AppMetaLabels().notFound) {
          error.value = AppMetaLabels().noDatafound;
          loadingData.value = false;
        } else {
          getContracts.value = result;
          contracts = result.contracts!;
          update();
          loadingData.value = false;
        }
      } else {
        error.value = AppMetaLabels().noDatafound;
        loadingData.value = false;
      }
    } catch (e) {
      loadingData.value = false;
      print("this is the error from controller= $e");
    }
  }

  String pageNo = '1';
  getDataPagination(String pageNoP, searchtext) async {
    isFilter.value = false;
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }
    error.value = '';
    if (pageNoP == '1') {
      errorLoadMore.value = '';
    }
    try {
      loadingData.value = true;
      var result =
          await VendorRepository.getContractsPagination(pageNoP, searchtext);
      if (result is VendorContractsModel) {
        getContracts.value = result;
        if (getContracts.value.status == AppMetaLabels().notFound) {
          error.value = AppMetaLabels().noDatafound;
          loadingData.value = false;
        } else {
          getContracts.value = result;
          contracts = result.contracts!;
          update();
          loadingData.value = false;
        }
      } else {
        error.value = AppMetaLabels().noDatafound;
        loadingData.value = false;
      }
    } catch (e) {
      loadingData.value = false;
      print("this is the error from controller= $e");
    }
  }

  RxString errorLoadMore = ''.obs;
  var loadingDataLoadMore = true.obs;
  getDataPaginationLoadMore(String pageNoP, searchtext) async {
    isFilter.value = false;
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }
    errorLoadMore.value = '';
    try {
      loadingDataLoadMore.value = true;
      var result =
          await VendorRepository.getContractsPagination(pageNoP, searchtext);
      if (result is VendorContractsModel) {
        getContracts.value = result;
        if (getContracts.value.status == AppMetaLabels().notFound) {
          errorLoadMore.value = AppMetaLabels().noDatafound;
          loadingDataLoadMore.value = false;
        } else {
          getContracts.value = result;
          for (int i = 0; i < getContracts.value.contracts!.length; i++) {
            contracts.add(getContracts.value.contracts![i]);
          }
          update();
          loadingDataLoadMore.value = false;
        }
      } else {
        errorLoadMore.value = AppMetaLabels().noDatafound;
        loadingDataLoadMore.value = false;
      }
    } catch (e) {
      loadingDataLoadMore.value = false;
      print("this is the error from controller= $e");
    }
  }

  searchData(String qry) {
    if (getContracts.value.contracts != null) {
      qry.toLowerCase();
      loadingData.value = true;
      List<Contract> _searchedCont = [];
      for (int i = 0; i < getContracts.value.contracts!.length; i++) {
        if (getContracts.value.contracts![i].contractNo!.contains(qry) ||
            getContracts.value.contracts![i].contractStatus!
                .toLowerCase()
                .contains(qry) ||
            getContracts.value.contracts![i].contractStatusAr!.contains(qry)) {
          _searchedCont.add(getContracts.value.contracts![i]);
        }
      }
      contracts = _searchedCont;
      if (contracts.length == 0)
        error.value = AppMetaLabels().noContractsFound;
      else
        error.value = '';

      loadingData.value = false;
    }
  }

  void applyFilter() async {
    filterData =
        await Get.to(() => VendorContractsFilter(clear: !isFilter.value));
    if (filterData! != null) {
      getFilteredData();
    }
  }

  void getFilteredData() async {
    isFilter.value = true;
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }
    try {
      error.value = '';
      loadingData.value = true;
      var result = await VendorRepository.getContractsWithFilter(filterData!);
      if (result is VendorContractsModel) {
        getContracts.value = result;
        if (getContracts.value.status == AppMetaLabels().notFound) {
          error.value = AppMetaLabels().noDatafound;
          loadingData.value = false;
        } else {
          getContracts.value = result;
          length = getContracts.value.contracts!.length;
          contracts = result.contracts!;
          update();
          loadingData.value = false;
        }
      } else {
        error.value = AppMetaLabels().noDatafound;
        loadingData.value = false;
      }
    } catch (e) {
      loadingData.value = false;
      print("this is the error from controller= $e");
    }
  }

  void applyFilterPagination(String pageNoP) async {
    filterData =
        await Get.to(() => VendorContractsFilter(clear: !isFilter.value));
    if (filterData != null) {
      getFilteredDataPagiation(pageNoP);
    }
  }

  String pageNoFilter = '1';
  RxString errorLoadMoreFilter = ''.obs;
  void getFilteredDataPagiation(String pageNoP) async {
    isFilter.value = true;
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }
    try {
      error.value = '';
      loadingData.value = true;
      var result = await VendorRepository.getContractsWithFilterPagination(
          filterData!, pageNoP);
      if (result is VendorContractsModel) {
        getContracts.value = result;
        if (getContracts.value.status == AppMetaLabels().notFound) {
          error.value = AppMetaLabels().noDatafound;
          loadingData.value = false;
        } else {
          getContracts.value = result;
          length = getContracts.value.contracts!.length;
          contracts = result.contracts!;
          update();
          loadingData.value = false;
        }
      } else {
        error.value = AppMetaLabels().noDatafound;
        loadingData.value = false;
      }
    } catch (e) {
      loadingData.value = false;
      print("this is the error from controller= $e");
    }
  }

  Future<void> getFilteredDataPagiationLoadMore(
    String pageNoP,searchText
  ) async {
    isFilter.value = true;
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }
    try {
      errorLoadMoreFilter.value = '';
      loadingDataLoadMore.value = true;
      var result = await VendorRepository.getContractsWithFilterPagination(
          filterData!, pageNoP);
      if (result is VendorContractsModel) {
        getContracts.value = result;
        if (getContracts.value.status == AppMetaLabels().notFound) {
          errorLoadMoreFilter.value = AppMetaLabels().noDatafound;
          loadingDataLoadMore.value = false;
        } else {
          getContracts.value = result;
          for (int i = 0; i < getContracts.value.contracts!.length; i++) {
            contracts.add(getContracts.value.contracts![i]);
          }
          length = contracts.length;
          update();
          loadingDataLoadMore.value = false;
        }
      } else {
        errorLoadMoreFilter.value = AppMetaLabels().noDatafound;
        loadingDataLoadMore.value = false;
      }
    } catch (e) {
      loadingDataLoadMore.value = false;
      print("this is the error from controller= $e");
    }
  }
}
