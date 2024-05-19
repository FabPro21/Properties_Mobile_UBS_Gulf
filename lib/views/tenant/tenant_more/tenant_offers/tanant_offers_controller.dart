import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/tenant_models/tenant_offers/tenant_offer_details_model.dart';
import 'package:fap_properties/data/models/tenant_models/tenant_offers/tenant_offers_model.dart'
    as model;
import 'package:fap_properties/data/repository/tenant_repository.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:get/get.dart';

class TenantOffersController extends GetxController {
  var offers = model.TenantOffersModel().obs;
  var offersDetails = TenantOffersDetailsModel().obs;

  var loadingOffers = true.obs;
  var loadingDetails = false.obs;
  RxString errorOffers = "".obs;
  RxString errorDetails = "".obs;
  int length = 0;

  String pagaNo = '1';
  var loadingDetailsMore = false.obs;
  RxString errorDetailsMore = "".obs;
  List<model.Record> record;
  getOffers(String pageNo) async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }
    try {
      loadingOffers.value = true;
      var result = await TenantRepository.getOffers(pageNo);
      if (result is model.TenantOffersModel) {
        if (result.record.length == 0) {
          errorOffers.value = AppMetaLabels().noDatafound;
          loadingOffers.value = false;
        } else {
          offers.value = result;
          record = offers.value.record;
          length = offers.value.record.length;
          loadingOffers.value = false;
        }
      } else {
        errorOffers.value = AppMetaLabels().noDatafound;
        loadingOffers.value = false;
      }
    } catch (e) {
      loadingOffers.value = false;
      print("this is the error from controller= $e");
    }
  }

  getOffers1(String pageNo) async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }
    try {
      loadingOffers.value = true;
      var result = await TenantRepository.getOffers(pageNo);
      if (result is model.TenantOffersModel) {
        if (result.record.length == 0) {
          errorDetailsMore.value = AppMetaLabels().noDatafound;
          loadingOffers.value = false;
        } else {
          for (int i; i < result.record.length; i++) {
            record.add(result.record[i]);
          }
          length = record.length;
          loadingOffers.value = false;
        }
      } else {
        errorDetailsMore.value = AppMetaLabels().noDatafound;
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
      var result = await TenantRepository.getOffersDetails(offerId);
      if (result is TenantOffersDetailsModel) {
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
