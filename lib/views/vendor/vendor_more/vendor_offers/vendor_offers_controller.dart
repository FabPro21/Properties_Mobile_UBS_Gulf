import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/vendor_models/vendor_offers/vendor_offers_details_model.dart';
import 'package:fap_properties/data/models/vendor_models/vendor_offers/vendor_offers_model.dart';

import 'package:fap_properties/data/repository/vendor_repository.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:get/get.dart';

class VendorOffersController extends GetxController {
  var offers = VendorOffersModel().obs;
  var offersDetails = VendorOffersDetailsModel().obs;

  var loadingOffers = true.obs;
  var loadingDetails = false.obs;
  RxString errorOffers = "".obs;
  RxString errorDetails = "".obs;
  int length = 0;

  getOffers() async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }
    try {
      loadingOffers.value = true;
      var result = await VendorRepository.getOffers();
      if (result is VendorOffersModel) {
        offers.value = result;
        length = offers.value.record!.length;
        if (length == 0) {
          errorOffers.value = AppMetaLabels().noDatafound;
        }

        loadingOffers.value = false;
      } else {
        errorOffers.value = AppMetaLabels().noDatafound;
        loadingOffers.value = false;
      }
    } catch (e) {
      loadingOffers.value = false;
      print("this is the error from controller= $e");
    }
  }

  getOffersDetails(String offerId) async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }
    try {
      loadingDetails.value = true;
      var result = await VendorRepository.getOffersDetails(offerId);
      if (result is VendorOffersDetailsModel) {
        offersDetails.value = result;
        loadingDetails.value = false;
      } else {
        errorDetails.value = AppMetaLabels().noDatafound;
        loadingDetails.value = false;
      }
    } catch (e) {
      loadingDetails.value = false;
      print("this is the error from controller= $e");
    }
  }
}
