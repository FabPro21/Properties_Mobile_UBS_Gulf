import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/data/models/auth_models/country_picker_model.dart';
import 'package:fap_properties/data/repository/auth_repository.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:get/get.dart';

class CountryPickerController extends GetxController {
  var countryPicker = CountryPickerModel().obs;

  var loadingData = false.obs;
  int length = 0;
  RxString onSearch = "".obs;
  RxString error = "".obs;

  RxInt selectedIndex = (-1).obs;
  RxString selectedDialingCode = '+971'.obs;

  @override
  void onInit() {
    if (countryPicker.value.countries == null ||
        countryPicker.value.countries!.isEmpty) getData();
    super.onInit();
  }

  Future<void> getData() async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(() => NoInternetScreen());
    }
    try {
      error.value = '';
      loadingData.value = true;
      countryPicker.value = CountryPickerModel();
      var result = await CommonRepository.countryPicker();
      loadingData.value = false;
      if (result is CountryPickerModel) {
        countryPicker.value = result;
        // adding this
        countryPicker.value.countries!.add(Country(
          countryId: 1,
          countryName: 'pk',
          countryCode: '+92',
          dialingCode: '+92',
          flag: '',
        ));
        length = countryPicker.value.countries!.length;
        Country selectedCountry =
            countryPicker.value.countries!.firstWhere((country) {
          return country.dialingCode == selectedDialingCode.value;
        });
        selectedIndex.value =
            countryPicker.value.countries!.indexOf(selectedCountry);
        update();
      } else {
        error.value = result;
      }
    } catch (e) {
      getData();
    }
  }

  void selectCountry(int index) {
    selectedIndex.value = index;
    selectedDialingCode.value =
        countryPicker.value.countries![index].dialingCode!;
    SessionController().setDialingCode(
      countryPicker.value.countries![index].dialingCode.toString(),
    );
    SessionController().setSelectedFlag(
      countryPicker.value.countries![index].flag.toString(),
    );
    selectedIndex.value = index;
  }
}
