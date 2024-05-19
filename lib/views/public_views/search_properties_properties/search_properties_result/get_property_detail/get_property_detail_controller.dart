import 'dart:typed_data';

import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/public_models/get_property_detail_model.dart';
import 'package:fap_properties/data/repository/tenant_repository.dart';
import 'package:fap_properties/data/repository/public_repository.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as Gm;
import 'package:apple_maps_flutter/apple_maps_flutter.dart' as Am;

class GetPropertyDetailController extends GetxController {
  var data = GetPropertyDetailModel().obs;
  var loadingData = true.obs;
  RxString error = "".obs;

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  Gm.CameraPosition cameraPosition = Gm.CameraPosition(
    target: Gm.LatLng(0.0,0.0),
    // target: Gm.LatLng(23.4241, 53.8478),
    zoom: 8.0,
  );
  Am.CameraPosition kApplePlex = Am.CameraPosition(
    target: Am.LatLng(0.0,0.0),
    zoom: 8.0,
  );
  Future<void> getData() async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(() => NoInternetScreen());
    }
    // try {
    loadingData.value = true;
    var result = await PublicRepositoryDrop2.getPropertyDetail();
    loadingData.value = false;
    if (result is GetPropertyDetailModel) {
      data.value = result;
      if (data.value.property.latitude != null &&
          data.value.property.longitude != null) {
        cameraPosition = Gm.CameraPosition(
          target: Gm.LatLng(double.parse(data.value.property.latitude),
              double.parse(data.value.property.longitude)),
          zoom: 8.0,
        );
        kApplePlex = Am.CameraPosition(
          target: Am.LatLng(double.parse(data.value.property.latitude),
              double.parse(data.value.property.longitude)),
          zoom: 8.0,
        );
      }

      update();
    } else {
      error.value = result;
    }
  }

  Stream<Uint8List> getImage() async* {
    var resp = await TenantRepository.getUnitImage(data.value.property.unitID);
    if (resp is Uint8List) {
      yield resp;
    } else {
      throw Exception();
    }
  }
}
