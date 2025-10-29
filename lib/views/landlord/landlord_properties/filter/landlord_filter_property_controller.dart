// ignore_for_file: unnecessary_null_comparison

import 'package:fap_properties/data/models/landlord_models/filter_property_category_model.dart';
import 'package:fap_properties/data/models/landlord_models/filter_property_emirate_model.dart';
import 'package:fap_properties/data/models/landlord_models/filter_property_type_model.dart';
import 'package:fap_properties/data/models/landlord_models/property_filter.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:get/get.dart';

class LandLordFilterPropController extends GetxController {
  String propertyName = '';
  Rx<PropertyType> propType = PropertyType().obs;
  Rx<PropertyEmirate> emirateName = PropertyEmirate().obs;
  Rx<ProppertyCategoris> propCategory = ProppertyCategoris().obs;
  var filterError = "".obs;
  void resetValues() {
    propertyName = '';
    propType.value = PropertyType();
    emirateName.value = PropertyEmirate();
    propCategory.value = ProppertyCategoris();
  }


  void goBack() {
    if (propertyName == '' &&
        propType.value.propertyTypeID == null &&
        emirateName.value.emirateName == null &&
        propCategory.value.propertyCategory == null) {
      filterError.value = AppMetaLabels().selectAtleastOne;
    } else {
      filterError.value = '';
      dynamic pti = propType.value.propertyTypeID;
      dynamic csi = emirateName.value.emirateID;
      dynamic cti = propCategory.value.propertyCategoryID;

      pti ??= "-1";
      csi ??= "-1";
      cti ??= "-1";
      Get.back(
        result: PFilterData(propertyName, pti, csi, cti),
      );
    }
  }
}
