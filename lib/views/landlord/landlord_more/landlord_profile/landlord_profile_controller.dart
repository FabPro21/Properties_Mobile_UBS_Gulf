import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/landlord_models/landlord_profile/ladlord_profile_model.dart';
import 'package:fap_properties/data/models/landlord_models/landlord_profile/landlord_profile_update.dart';
import 'package:fap_properties/data/repository/landlord_repository.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:get/get.dart';

class LandLordProfileController extends GetxController {
  var landLordProfile = LandLordProfileModel().obs;
  var updateProfiledata = LandlordUpdateProfileModel().obs;

  var loadingData = true.obs;
  RxString error = "".obs;
  var loadingUpdate = false.obs;
  RxString errorUpdate = "".obs;

  RxBool loadingCanEdit = true.obs;
  int? caseNo;

  getData() async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }
    try {
      loadingData.value = true;
      var result = await LandlordRepository.landLordProfile();
      print('Result 1 ::::: $result');
      if (result is LandLordProfileModel) {
        if (landLordProfile.value.statusCode == 200) {
          error.value = AppMetaLabels().noDatafound;
        } else {
          landLordProfile.value = result;
          print('Result 2 ::::: ${landLordProfile.value.data![0]}');
          update();
        }
      } else {
        error.value = AppMetaLabels().noDatafound;
      }
    } catch (e) {
      loadingData.value = false;
      print("this is the error from controller Get Profile= $e");
    } finally {
      loadingData.value = false;
    }
  }

  void canEditProfile() async {
    try {
      loadingCanEdit.value = true;
      var resp = await LandlordRepository.canEditProfile();
      if (resp is int) {
        caseNo = resp;
      }
    } catch (e) {
      print("this is the error from controller= $e");
    } finally {
      loadingCanEdit.value = false;
    }
  }

  Future<bool> updateProfile(
      String name, String mobileNo, String email, String address) async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }
    try {
      loadingUpdate.value = true;

      var result = await LandlordRepository.updateProfile(
          name, mobileNo, email, address);

      loadingUpdate.value = false;
      if (result is LandlordUpdateProfileModel) {
        if (result.status == "Ok") {
          updateProfiledata.value = result;
          caseNo = result.addServiceRequest!.caseNo;
          loadingCanEdit.value = true;
          loadingCanEdit.value = false;
          return true;
        } else {
          Get.snackbar(AppMetaLabels().error, result.message??"");
          return false;
        }
      } else {
        Get.snackbar(AppMetaLabels().error, AppMetaLabels().someThingWentWrong);
        errorUpdate.value = AppMetaLabels().noDatafound;
        return false;
      }
    } catch (e) {
      loadingUpdate.value = false;
      print("this is the error from controller= $e");
      return false;
    }
  }
}
