// ignore_for_file: unnecessary_null_comparison

import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/vendor_models/get_all_lpos_model.dart';
import 'package:fap_properties/data/repository/vendor_repository.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:fap_properties/views/vendor/lpos/vendor_lpo_filter/vendor_lpo_filter.dart';
import 'package:get/get.dart';

class GetAllLpoController extends GetxController {
  var getAllLpos = GetAllLpoModel().obs;
  LpoFilterData? filterDataVar;
  var loadingData = true.obs;
  RxString error = ''.obs;
  RxBool isFilter = false.obs;

  List<Lpo> lpos = [Lpo()].obs;

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
    loadingData.value = true;
    var result = await VendorRepository.getAllLpos();
    if (result is GetAllLpoModel) {
      // getAllLpos.value = result;
      if (getAllLpos.value.status == AppMetaLabels().notFound) {
        error.value = AppMetaLabels().noDatafound;
        loadingData.value = false;
      } else {
        print('***** ::::===>');
        getAllLpos.value = result;
        lpos = result.lpos!;
        update();
        loadingData.value = false;
      }
    } else {
      error.value = AppMetaLabels().noDatafound;
      loadingData.value = false;
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
    errorLoadMore.value = '';
    loadingData.value = true;
    var result =
        await VendorRepository.getAllLposPagination(pageNoP, searchtext);
    if (result is GetAllLpoModel) {
      if (getAllLpos.value.status == AppMetaLabels().notFound) {
        error.value = AppMetaLabels().noDatafound;
        loadingData.value = false;
      } else {
        getAllLpos.value = result;
        lpos = result.lpos!;
        update();
        loadingData.value = false;
      }
    } else {
      error.value = AppMetaLabels().noDatafound;
      loadingData.value = false;
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
    loadingDataLoadMore.value = true;
    var result =
        await VendorRepository.getAllLposPagination(pageNoP, searchtext);
    if (result is GetAllLpoModel) {
      // getAllLpos.value = result;
      if (getAllLpos.value.status == AppMetaLabels().notFound) {
        errorLoadMore.value = AppMetaLabels().noDatafound;
        loadingDataLoadMore.value = false;
      } else {
        getAllLpos.value = result;
        for (int i = 0; i < getAllLpos.value.lpos!.length; i++) {
          lpos.add(result.lpos![i]);
        }
        update();
        loadingDataLoadMore.value = false;
      }
    } else {
      errorLoadMore.value = AppMetaLabels().noDatafound;
      loadingDataLoadMore.value = false;
    }
  }

  void applyFilter() async {
    LpoFilterData filterData =
        await Get.to(() => VendorLpoFilter(clear: !isFilter.value));
    if (filterData != null) {
      getFilteredData(filterData);
    }
  }

  void getFilteredData(LpoFilterData filterData) async {
    isFilter.value = true;
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }
    error.value = '';
    loadingData.value = true;
    var result = await VendorRepository.getLpoWithFilter(filterData);
    loadingData.value = false;

    if (result is GetAllLpoModel) {
      getAllLpos.value = result;
      lpos = result.lpos!;
      if (getAllLpos.value.status == AppMetaLabels().notFound) {
        error.value = AppMetaLabels().noDatafound;
      } else {
        getAllLpos.value = result;
      }
    } else {
      error.value = AppMetaLabels().noDatafound;
    }
  }

  void applyFilterPagination(String pageNoP) async {
    LpoFilterData filterData =
        await Get.to(() => VendorLpoFilter(clear: !isFilter.value));
    if (filterData != null) {
      filterDataVar = filterData;
      getFilteredDataPagination(filterData, pageNoP);
    }
  }

  String pageNoFilter = '1';
  RxString errorLoadMoreFilter = ''.obs;
  Future<void> getFilteredDataPagination(
      LpoFilterData filterData, String pageNoP) async {
    isFilter.value = true;
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }
    error.value = '';
    loadingData.value = true;
    var result =
        await VendorRepository.getLpoWithFilterPagnination(filterData, pageNoP);
    loadingData.value = false;

    if (result is GetAllLpoModel) {
      if (getAllLpos.value.status == AppMetaLabels().notFound) {
        error.value = AppMetaLabels().noDatafound;
      } else {
        getAllLpos.value = result;
        lpos = getAllLpos.value.lpos!;
      }
    } else {
      error.value = AppMetaLabels().noDatafound;
    }
  }

  Future<void> getFilteredDataPaginationLoadMore(
      LpoFilterData filterData, String pageNoP) async {
    isFilter.value = true;
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }
    errorLoadMoreFilter.value = '';
    loadingDataLoadMore.value = true;
    var result =
        await VendorRepository.getLpoWithFilterPagnination(filterData, pageNoP);
    loadingDataLoadMore.value = false;
    if (result is GetAllLpoModel) {
      if (getAllLpos.value.status == AppMetaLabels().notFound) {
        errorLoadMoreFilter.value = AppMetaLabels().noDatafound;
      } else {
        getAllLpos.value = result;
        for (int i = 0; i < getAllLpos.value.lpos!.length; i++) {
          lpos.add(getAllLpos.value.lpos![i]);
        }
        update();
        loadingDataLoadMore.value = false;
      }
    } else {
      errorLoadMoreFilter.value = AppMetaLabels().noDatafound;
    }
  }

  searchData(String qry) {
    if (getAllLpos.value.lpos! != null) {
      qry.toLowerCase();
      loadingData.value = true;
      List<Lpo> _searchedLpos = [];
      for (int i = 0; i < getAllLpos.value.lpos!.length; i++) {
        if (getAllLpos.value.lpos![i].lpoReference!.contains(qry) ||
            getAllLpos.value.lpos![i].lpoStatus!.toLowerCase().contains(qry) ||
            getAllLpos.value.lpos![i].lpoStatusAr!.contains(qry)) {
          _searchedLpos.add(getAllLpos.value.lpos![i]);
        }
      }
      lpos = _searchedLpos;
      if (lpos.length == 0)
        error.value = AppMetaLabels().noLPOFound;
      else
        error.value = '';

      loadingData.value = false;
    }
  }
}
