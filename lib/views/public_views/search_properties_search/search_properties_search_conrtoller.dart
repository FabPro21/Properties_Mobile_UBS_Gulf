import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:get/get.dart';

class SearchPropertiesSearchConrtoller extends GetxController {
  RxString cityName = AppMetaLabels().pleaseSelect.obs;
  RxString cityId = AppMetaLabels().pleaseSelect.obs;
  RxString categoryName = AppMetaLabels().pleaseSelect.obs;
  RxString categoryNameAR = ''.obs;
  RxString categoryId = AppMetaLabels().pleaseSelect.obs;
  RxString unitType = AppMetaLabels().pleaseSelect.obs;
  RxString unitTypeId = AppMetaLabels().pleaseSelect.obs;
  RxBool showArea = true.obs;

  // Future<void> submitBtn(
  //     caseResult,
  //     caseCategoryResult,
  //     caseSubCategoryResult,
  //     propertyResult,
  //     locationResult,
  //     contactTimeResult,
  //     languageResult,
  //     String text) async {}
}
