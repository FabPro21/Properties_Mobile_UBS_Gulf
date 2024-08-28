import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/tenant_models/tenant_add_request/case_category_model.dart';
import 'package:fap_properties/data/repository/tenant_repository.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:get/get.dart';

class GetCaseCategoryController extends GetxController {
  var caseCategory = CaseCategoryModel().obs;

  var loadingData = true.obs;
  int length = 0;
  RxString onSearch = "".obs;
  RxString error = "".obs;

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  Future<void> getData() async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(() => NoInternetScreen());
    }
    // try {
    loadingData.value = true;
    var result = await TenantRepository.getCaseCategory();
    loadingData.value = false;
    if (result is CaseCategoryModel) {
      caseCategory.value = result;
      length = caseCategory.value.caseCategories!.length;
      if (length == 0) error.value = AppMetaLabels().notFound;
      update();
    } else {
      error.value = result;
    }
  }
}
