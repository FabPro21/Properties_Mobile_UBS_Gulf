import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/tenant_models/tenant_contracts_filter/filter_data.dart';
import 'package:fap_properties/data/models/tenant_models/get_contracts_model.dart';
import 'package:fap_properties/data/repository/tenant_repository.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:fap_properties/views/tenant/tenant_contracts/tenant_contracts_filter/tenant_contracts_filter.dart';
import 'package:get/get.dart';

class GetContractsController extends GetxController {
  Rx<GetContractsModel> getContracts = GetContractsModel().obs;
  FilterData filterData;
  RxBool scrolling = false.obs;

  var loadingData = true.obs;
  RxString error = "".obs;

  int length = 0;
  RxBool isFilter = false.obs;

  List<Contract> contracts = [Contract()].obs;

  @override
  void onInit() {
    // getData();
    super.onInit();
  }

  searchDataWithoutAPi(String qry) {
    if (getContracts.value.contracts != null) {
      qry.toLowerCase();
      loadingData.value = true;
      List<Contract> _searchedCont = [];
      for (int i = 0; i < getContracts.value.contracts.length; i++) {
        if (getContracts.value.contracts[i].contractno.contains(qry) ||
            getContracts.value.contracts[i].contractStatus
                .toLowerCase()
                .contains(qry) ||
            getContracts.value.contracts[i].contractStatusAr.contains(qry) ||
            getContracts.value.contracts[i].propertyName
                .toLowerCase()
                .contains(qry) ||
            getContracts.value.contracts[i].propertyNameAr.contains(qry)) {
          _searchedCont.add(getContracts.value.contracts[i]);
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

  getData() async {
    isFilter.value = false;
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }
    error.value = '';
    try {
      loadingData.value = true;
      var result = await TenantRepository.getContracts();
      loadingData.value = false;
      if (result is GetContractsModel) {
        getContracts.value = result;
        if (getContracts.value.status == AppMetaLabels().notFound) {
          error.value = AppMetaLabels().noDatafound;
        } else {
          contracts = result.contracts;
          length = getContracts.value.contracts.length;
        }
      } else {
        error.value = AppMetaLabels().noDatafound;
      }
    } catch (e) {
      print("this is the error from controller= $e");
    }
  }

  // now calling getDataPagination() and getDataPaginationLoadMore() instead of
  // getData() because we implmented pagination
  String pageNo = '1';
  getDataPagination(String pageNoP, String search) async {
    isFilter.value = false;
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }
    error.value = '';
    try {
      loadingData.value = true;
      var result =
          await TenantRepository.getContractsPagination(pageNoP, search);
      loadingData.value = false;
      if (result is GetContractsModel) {
        getContracts.value = result;
        if (getContracts.value.status == AppMetaLabels().notFound) {
          error.value = AppMetaLabels().noDatafound;
        } else {
          contracts = result.contracts;
          length = getContracts.value.contracts.length;
        }
      } else {
        error.value = AppMetaLabels().noDatafound;
      }
    } catch (e) {
      print("this is the error from controller= $e");
    }
  }

  RxString errorLoadMore = ''.obs;
  RxBool loadingDataMoreData = false.obs;
  getDataPaginationLoadMore(String pageNoP, String search) async {
    isFilter.value = false;
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }
    errorLoadMore.value = '';
    try {
      loadingDataMoreData.value = true;
      var result =
          await TenantRepository.getContractsPagination(pageNoP, search);
      loadingDataMoreData.value = false;
      if (result is GetContractsModel) {
        getContracts.value = result;
        if (getContracts.value.status == AppMetaLabels().notFound) {
          errorLoadMore.value = AppMetaLabels().noDatafound;
          loadingDataMoreData.value = false;
        } else {
          if (result.contracts.isNotEmpty) {
            for (int i = 0; i < getContracts.value.contracts.length; i++) {
              contracts.add(result.contracts[i]);
            }
            length = contracts.length;
          }
          loadingDataMoreData.value = false;
        }
      } else {
        errorLoadMore.value = AppMetaLabels().noDatafound;
        loadingDataMoreData.value = false;
      }
    } catch (e) {
      print("this is the error from controller= $e");
      loadingDataMoreData.value = false;
    }
  }

  applyFilter() async {
    filterData =
        await Get.to(() => TenantContracrsFilter(clear: !isFilter.value));
    if (filterData != null) {
      getFilteredData();
    }
  }

  getFilteredData() async {
    isFilter.value = true;
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }
    error.value = '';
    loadingData.value = true;
    var result = await TenantRepository.getContractsWithFilter(filterData);
    loadingData.value = false;
    if (result is GetContractsModel) {
      getContracts.value = result;
      contracts = result.contracts;
      if (getContracts.value.status == AppMetaLabels().notFound ||
          getContracts.value.status == 'NotFound') {
        error.value = AppMetaLabels().noDatafound;
      } else {
        length = getContracts.value.contracts.length;
      }
    } else {
      error.value = AppMetaLabels().noDatafound;
    }
  }

  String pageNoFilter = '1';
  RxString errorLoadMoreFilter = ''.obs;
  getFilteredDataPagination(String pageNo, searchText) async {
    isFilter.value = true;
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }
    error.value = '';
    loadingData.value = true;
    var result = await TenantRepository.getContractsWithFilterPagination(
        filterData, pageNo, searchText);
    loadingData.value = false;
    if (result is GetContractsModel) {
      getContracts.value = result;
      contracts = result.contracts;
      if (getContracts.value.status == AppMetaLabels().notFound ||
          getContracts.value.status == 'NotFound') {
        error.value = AppMetaLabels().noDatafound;
      } else {
        length = getContracts.value.contracts.length;
      }
    } else {
      error.value = AppMetaLabels().noDatafound;
    }
  }

  getFilteredDataLoadMore(String pageNo, searchText) async {
    isFilter.value = true;
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }
    errorLoadMoreFilter.value = '';
    loadingDataMoreData.value = true;
    var result = await TenantRepository.getContractsWithFilterPagination(
        filterData, pageNo, searchText);
    loadingDataMoreData.value = false;
    if (result is GetContractsModel) {
      getContracts.value = result;
      if (getContracts.value.status == AppMetaLabels().notFound ||
          getContracts.value.status == 'NotFound') {
        errorLoadMoreFilter.value = AppMetaLabels().noDatafound;
      } else {
        for (int i = 0; i < getContracts.value.contracts.length; i++) {
          contracts.add(getContracts.value.contracts[i]);
        }
        length = contracts.length;
      }
    } else {
      errorLoadMoreFilter.value = AppMetaLabels().noDatafound;
    }
  }

  searchData(String qry, pageNoP) async {
    qry.toLowerCase();
    loadingData.value = true;
    isFilter.value = false;
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }
    error.value = '';
    try {
      loadingData.value = true;
      var result = await TenantRepository.getContractsPagination(pageNoP, qry);
      loadingData.value = false;
      if (result is GetContractsModel) {
        getContracts.value = result;
        if (getContracts.value.status == AppMetaLabels().notFound) {
          error.value = AppMetaLabels().noDatafound;
        } else {
          contracts = result.contracts;
          length = getContracts.value.contracts.length;
          update();
        }
      } else {
        error.value = AppMetaLabels().noDatafound;
      }
    } catch (e) {
      print("this is the error from controller= $e");
    }
  }

  searchDataFilter(String pageNoP, searchText) async {
    searchText.toLowerCase();
    loadingData.value = true;
    isFilter.value = false;
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }
    error.value = '';
    try {
      loadingData.value = true;
      var result = await TenantRepository.getContractsWithFilterPagination(
          filterData, pageNo, searchText);
      loadingData.value = false;
      if (result is GetContractsModel) {
        getContracts.value = result;
        contracts = result.contracts;
        if (getContracts.value.status == AppMetaLabels().notFound ||
            getContracts.value.status == 'NotFound') {
          errorLoadMoreFilter.value = AppMetaLabels().noDatafound;
        } else {
          length = getContracts.value.contracts.length;
        }
      } else {
        errorLoadMoreFilter.value = AppMetaLabels().noDatafound;
      }
    } catch (e) {
      print("this is the error from controller= $e");
    }
  }
}
