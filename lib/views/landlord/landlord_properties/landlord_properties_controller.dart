import 'dart:typed_data';
import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/landlord_models/landlord_properties_model.dart';
import 'package:fap_properties/data/models/landlord_models/property_filter.dart';
import 'package:fap_properties/data/repository/landlord_repository.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:fap_properties/views/landlord/landlord_properties/filter/landlord_filter_property.dart';
import 'package:get/get.dart';

class LandlordPropertiesController extends GetxController {
  LandlordPropertiesModel? propsModel;
  RxBool loadingProperties = false.obs;
  RxString errorLoadingProperties = ''.obs;
  // String errorLoadingProperties.value = '';
  List<ServiceRequests> props = [];

  @override
  void onInit() {
    // getProperties();
    super.onInit();
  }

  Future<void> getProperties() async {
    loadingProperties.value = true;
    errorLoadingProperties.value = '';
    final response = await LandlordRepository.getProperties();
    if (response is LandlordPropertiesModel) {
      propsModel = response;
      props = propsModel!.serviceRequests!.toList();
    } else
      errorLoadingProperties.value = response;
    loadingProperties.value = false;
  }

  String pageNo = '1';
  Future<void> getPropertiesPagination(String pageNoP, searchtext) async {
    isFilter.value = false;
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }
    errorLoadingProperties.value = '';
    try {
      loadingProperties.value = true;
      final result =
          await LandlordRepository.getPropertiespagination(pageNoP, searchtext);
      if (result is LandlordPropertiesModel) {
        if (result.status == AppMetaLabels().notFound) {
          errorLoadingProperties.value = AppMetaLabels().noDatafound;
          loadingProperties.value = false;
        } else {
          propsModel = result;
          props = propsModel!.serviceRequests!.toList();
          update();
          loadingProperties.value = false;
        }
      } else {
        errorLoadingProperties.value = AppMetaLabels().noDatafound;
        loadingProperties.value = false;
      }
    } catch (e) {
      loadingProperties.value = false;
      print("this is the error from controller= $e");
    }
  }

  RxString errorLoadMore = ''.obs;
  var loadingDataLoadMore = false.obs;
  getPropertiesPaginationLoadMore(String pageNoP, searchtext) async {
    isFilter.value = false;
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }
    errorLoadMore.value = '';
    try {
      loadingDataLoadMore.value = true;
      final response =
          await LandlordRepository.getPropertiespagination(pageNoP, searchtext);
      if (response is LandlordPropertiesModel) {
        print('Inside :::::: 11');
        propsModel = response;
        if (propsModel!.totalRecord == 0) {
          print('Inside :::::: 22');
          errorLoadMore.value = AppMetaLabels().noDatafound;
          loadingDataLoadMore.value = false;
        } else {
          for (int i = 0; i < propsModel!.serviceRequests!.length; i++) {
            props.add(propsModel!.serviceRequests![i]);
          }
          update();
          loadingDataLoadMore.value = false;
        }
      } else {
        print('Inside :::::: 33');
        errorLoadMore.value = AppMetaLabels().noDatafound;
        loadingDataLoadMore.value = false;
      }
    } catch (e) {
      print('Inside :::::: 44');
      loadingDataLoadMore.value = false;
      print("this is the error from controller= $e");
    }
  }

  searchData(String qry) {
    loadingProperties.value = true;
    List<ServiceRequests> _searchedProps = [];
    for (int i = 0; i < propsModel!.serviceRequests!.length; i++) {
      if (propsModel!.serviceRequests![i].propertyName!
              .contains(qry.toLowerCase()) ||
          propsModel!.serviceRequests![i].propertyType!
              .toLowerCase()
              .contains(qry.toLowerCase())) {
        _searchedProps.add(propsModel!.serviceRequests![i]);
      }
    }
    props = _searchedProps.toList();
    if (props.length == 0)
      errorLoadingProperties.value = AppMetaLabels().noPropertiesFound;
    else
      errorLoadingProperties.value = '';

    loadingProperties.value = false;
  }

  Stream<Uint8List> getImage(int index) async* {
    var resp = await LandlordRepository.getImages(
        propsModel!.serviceRequests![index].buildingRefNo);
    if (resp is Uint8List) {
      yield resp;
    } else {}
  }

  RxBool isFilter = false.obs;
  PFilterData? filterData;
  applyFilter() async {
    filterData =
        await Get.to(() => LandLordFilterProperties(clear: !isFilter.value));

    if (filterData != null) {
      getFilteredData(pageNoFilter, filterData);
      update();
    }
  }

  getFilteredData(String pageNo, searchText) async {
    isFilter.value = true;
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }
    errorLoadingProperties.value = '';
    loadingProperties.value = true;
    var response =
        await LandlordRepository.getPropertyWithFilter(filterData!, pageNo);
    print('Result  ;;;;  $response');
    loadingProperties.value = false;
    if (response is LandlordPropertiesModel) {
      if (response.status != 'NotFound') {
        props = response.serviceRequests!.toList();
      } else {
        errorLoadingProperties.value = AppMetaLabels().notFound;
      }
    } else
      errorLoadingProperties.value = response;
    loadingProperties.value = false;
  }

  void applyFilterPagination(String pageNoP) async {
    filterData =
        await Get.to(() => LandLordFilterProperties(clear: !isFilter.value));
    if (filterData != null) {
      getFilteredDataPagiation(pageNoFilter, filterData);
    }
  }

  String pageNoFilter = '1';
  RxString errorLoadMoreFilter = ''.obs;
  getFilteredDataPagiation(String pageNoP, searchText) async {
    isFilter.value = true;
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }
    try {
      errorLoadingProperties.value = '';
      loadingProperties.value = true;
      var response =
          await LandlordRepository.getPropertyWithFilter(filterData!, pageNoP);
      loadingProperties.value = false;

      if (response is LandlordPropertiesModel) {
        propsModel = response;

        if (response.status == AppMetaLabels().notFound ||
            response.totalRecord == 0) {
          errorLoadingProperties.value = AppMetaLabels().noDatafound;
          loadingProperties.value = false;
        } else {
          props = propsModel!.serviceRequests!.toList();
          update();
          loadingProperties.value = false;
        }
      } else {
        errorLoadMoreFilter.value = AppMetaLabels().noDatafound;
        loadingProperties.value = false;
      }
    } catch (e) {
      loadingProperties.value = false;
      print("this is the error from controller= $e");
    }
  }

  Future<void> getFilteredDataPagiationLoadMore(
      String pageNoP, searchText) async {
    isFilter.value = true;
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }
    try {
      errorLoadMoreFilter.value = '';
      loadingDataLoadMore.value = true;
      var response =
          await LandlordRepository.getPropertyWithFilter(filterData!, pageNoP);
      loadingDataLoadMore.value = false;

      if (response is LandlordPropertiesModel) {
        propsModel = response;
        if (propsModel!.status == AppMetaLabels().notFound) {
          errorLoadMoreFilter.value = AppMetaLabels().noDatafound;
          loadingDataLoadMore.value = false;
        } else {
          for (int i = 0; i < propsModel!.serviceRequests!.length; i++) {
            props.add(propsModel!.serviceRequests![i]);
          }
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
