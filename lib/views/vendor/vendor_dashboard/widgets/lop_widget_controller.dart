import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/vendor_models/get_all_lpos_model.dart';
import 'package:fap_properties/data/repository/vendor_repository.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:get/get.dart';

class GetAllLpoWidgetController extends GetxController {
  var getAllLposModel = GetAllLpoModel().obs;

  var loadingData = true.obs;
  var error = ''.obs;

  int lpoWidgetListLength = 0;

  @override
  void onInit() {
    // getData();
    super.onInit();
  }

  getData() async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }
    // try {
    loadingData.value = true;
    error.value = '';
    var result = await VendorRepository.getAllLpos();
    if (result is GetAllLpoModel) {
      getAllLposModel.value = result;
      print('Result :::::::::::::: ${result.lpos.length}');
      print('Result :::::::::::::: ${getAllLposModel.value.status}');
      if (getAllLposModel.value.status != 'Ok') {
        print('Inside the IF::::::::');
        // if (getAllLposModel.value.status == AppMetaLabels().notFound) {
        error.value = AppMetaLabels().noDatafound;
        loadingData.value = false;
      } else {
        print('Inside the Else::::::::');
        getAllLposModel.value = result;
        if (getAllLposModel.value.lpos.length > 3)
          lpoWidgetListLength = 3;
        else
          lpoWidgetListLength = getAllLposModel.value.lpos.length;
        print(lpoWidgetListLength);
        loadingData.value = false;
      }
    } else {
      error.value = AppMetaLabels().noDatafound;
      loadingData.value = false;
    }
  }

  getDataPagination(String pageNo, searchtext) async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }
    // try {
    loadingData.value = true;
    error.value = '';
    var result = await VendorRepository.getAllLposPagination(pageNo, '');
    if (result is GetAllLpoModel) {
      getAllLposModel.value = result;
      print('Result :::::::::::::: ${result.lpos.length}');
      print('Result :::::::::::::: ${getAllLposModel.value.status}');
      if (getAllLposModel.value.status != 'Ok') {
        print('Inside the IF::::::::');
        // if (getAllLposModel.value.status == AppMetaLabels().notFound) {
        error.value = AppMetaLabels().noDatafound;
        loadingData.value = false;
      } else {
        print('Inside the Else::::::::');
        getAllLposModel.value = result;
        if (getAllLposModel.value.lpos.length > 3)
          lpoWidgetListLength = 3;
        else
          lpoWidgetListLength = getAllLposModel.value.lpos.length;
        print(lpoWidgetListLength);
        loadingData.value = false;
      }
    } else {
      error.value = AppMetaLabels().noDatafound;
      loadingData.value = false;
    }
  }
}
