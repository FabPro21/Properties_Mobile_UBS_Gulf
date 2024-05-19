import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/public_models/public_location/public_location_model.dart';
import 'package:fap_properties/data/repository/public_repository.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:get/get.dart';

class PublicLocationController extends GetxController {
  Rx<PublicLocationModel> data = PublicLocationModel().obs;
  RxBool loading = false.obs;
  RxString error = "".obs;
  RxInt length = 0.obs;

  Future<void> getLocation() async {
    loading.value = true;
    bool _isIntenetConnected = await BaseClientClass.isInternetConnected();
    if (!_isIntenetConnected) {
      await Get.to(() => NoInternetScreen());
    }
    var resp = await PublicRepositoryDrop2.getPublicLocation();
    print(resp);
    loading.value = false;
    if (resp is PublicLocationModel) {
      data.value = resp;
      length.value = data.value.locationVm.length;
      print(
          'Latitude and Longitude at index 0 :::: ${data.value.locationVm[0].latLog}');
      print(
          'Latitude and Longitude at index 1 :::: ${data.value.locationVm[1].latLog}');
      print(
          'Lat And lng at index 0 :::: ${data.value.locationVm[0].lat} , ${data.value.locationVm[0].lng}');
      print(
          'Lat And lng  at index 1 :::: ${data.value.locationVm[1].lat} , ${data.value.locationVm[0].lng}');
      print(
          'Camera Position at index 0  :::: ${data.value.locationVm[0].cameraPositionAm}');
      print(
          'Camera Position at index 1 :::: ${data.value.locationVm[1].cameraPositionAm}');
    } else {
      loading.value = false;
      error.value = resp;
    }
  }
}
