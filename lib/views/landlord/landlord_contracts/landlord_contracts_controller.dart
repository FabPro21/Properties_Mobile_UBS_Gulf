import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/landlord_models/landlord_contracts_model.dart';
import 'package:fap_properties/data/models/tenant_models/tenant_contracts_filter/filter_data.dart';
import 'package:fap_properties/data/repository/landlord_repository.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:fap_properties/views/landlord/landlord_contracts/landlord_contract_filter/landlord_filter_contract.dart';
import 'package:get/get.dart';

class LandlordContractsController extends GetxController {
  LandlordContractsModel contractsModel;
  RxBool loadingContracts = false.obs;
  RxBool loadingDataLoadMore = false.obs;
  RxString errorLoadingContracts = ''.obs;
  List<Data> contracts = [];

  @override
  void onInit() {
    super.onInit();
  }

  String pageNo = '1';
  getContracts(String pageNoP, searchText) async {
    errorLoadingContracts.value = '';
    isFilter.value = false;
    loadingContracts.value = true;
    final response = await LandlordRepository.getContracts(pageNoP, searchText);
    if (response is LandlordContractsModel) {
      if (response.totalRecord != 0) {
        contractsModel = response;
        contracts = contractsModel.data.toList();
      } else {
        errorLoadingContracts.value = AppMetaLabels().notFound;
      }
    } else
      errorLoadingContracts.value = response;
    loadingContracts.value = false;
  }

  RxString errorLoadMore = ''.obs;
  getContractsLoadMore(String pageNoP, searchText) async {
    errorLoadMore.value = '';
    isFilter.value = false;
    loadingDataLoadMore.value = true;
    final response = await LandlordRepository.getContracts(pageNoP, searchText);
    print('Response :::::: $response');
    if (response is LandlordContractsModel) {
      if (response.totalRecord != 0) {
        contractsModel = response;
        for (int i = 0; i < contractsModel.data.length; i++) {
          contracts.add(contractsModel.data[i]);
        }
      } else {
        errorLoadMore.value = AppMetaLabels().notFound;
      }
    } else
      errorLoadMore.value = response;
    loadingDataLoadMore.value = false;
  }

  RxBool isFilter = false.obs;
  FilterData filterData;
  applyFilter() async {
    filterData =
        await Get.to(() => LandLordFilterContract(clear: !isFilter.value));
    if (filterData != null) {
      getFilteredData(pageNoFilter, '');
    }
  }

  String pageNoFilter = '1';
  RxString errorLoadMoreFilter = ''.obs;
  getFilteredData(String pageNo, searchText) async {
    isFilter.value = true;
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }
    errorLoadingContracts.value = '';
    loadingContracts.value = true;
    var result = await LandlordRepository.getContractsWithFilter(
        filterData, pageNoFilter);
    loadingContracts.value = false;
    if (result is LandlordContractsModel) {
      if (result.totalRecord != 0) {
        contractsModel = result;
        contracts = contractsModel.data.toList();
      } else {
        errorLoadingContracts.value = AppMetaLabels().noDatafound;
      }
    } else
      errorLoadingContracts = result;
    loadingContracts.value = false;
  }

  getFilteredDataLoadMore(String pageNoP, searchText) async {
    isFilter.value = true;
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }
    errorLoadMoreFilter.value = '';
    loadingDataLoadMore.value = true;
    var result =
        await LandlordRepository.getContractsWithFilter(filterData, pageNoP);
    loadingDataLoadMore.value = false;
    if (result is LandlordContractsModel) {
      contractsModel = result;
      if (result.data.length != 0 || result.data.isNotEmpty) {
        for (int i = 0; i < result.data.length; i++) {
          contracts.add(result.data[i]);
        }
      } else {
        errorLoadMoreFilter.value = AppMetaLabels().notFound;
      }
    } else
      errorLoadMoreFilter = result;
    loadingContracts.value = false;
  }

  searchData(String qry) {
    loadingContracts.value = true;
    List<Data> _searchedCont = [];
    for (int i = 0; i < contractsModel.data.length; i++) {
      if (contractsModel.data[i].contractno.contains(qry) ||
          contractsModel.data[i].contractStatus
              .toLowerCase()
              .contains(qry.toLowerCase())) {
        _searchedCont.add(contractsModel.data[i]);
      }
    }
    contracts = _searchedCont.toList();
    if (contracts.length == 0)
      errorLoadingContracts.value = AppMetaLabels().noContractsFound;
    else
      errorLoadingContracts.value = '';

    loadingContracts.value = false;
  }
}
