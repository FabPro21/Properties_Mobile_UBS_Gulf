import 'dart:typed_data';
import 'package:fap_properties/data/models/landlord_models/landlord_properties_model.dart';
import 'package:fap_properties/data/models/landlord_models/landlord_property_details_model.dart';
import 'package:fap_properties/data/models/landlord_models/landlord_property_units_model.dart';
import 'package:fap_properties/data/models/landlord_models/landlord_unit_detail_model.dart';
import 'package:fap_properties/data/repository/landlord_repository.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as Gm;
import 'package:apple_maps_flutter/apple_maps_flutter.dart' as Am;

class LandlordPropertiesTabDetailController extends GetxController {
  LandLordUnitDetailModel propertyUnitDetailModel = LandLordUnitDetailModel();
  LandlordPropertyUnitsModel propertyUnitInfo;
  LandlordPropertiesDetailsModel propertyDetailInfo;
  RxBool loadingProperties = false.obs;
  String errorLoadingProperties = '';
  RxBool loadingPropertiesInfo = false.obs;
  String errorLoadingPropertiesInfo = '';
  RxBool loadingPropertiesDetail = false.obs;
  String errorLoadingPropertiesDetail = '';
  List<ServiceRequests> props = [];

  @override
  void onInit() {
    super.onInit();
  }

  void getPropertiesUnitInfo(String propertyID) async {
    loadingPropertiesInfo.value = true;
    errorLoadingPropertiesInfo = '';
    final response = await LandlordRepository.getPropertyUnits(propertyID);
    print('Response ::: $response');
    if (response is LandlordPropertyUnitsModel) {
      if (response.status == 'Ok') {
        if (response.cities.length >= 1) {
          propertyUnitInfo = response;
        } else {
          errorLoadingPropertiesInfo = AppMetaLabels().noDatafound;
        }
      }
    } else {
      errorLoadingPropertiesInfo = response;
    }
    loadingPropertiesInfo.value = false;
  }

  RxBool loadingPropertiesUnitDetail = false.obs;
  RxString errorLoadingPropertiesUnitDetail = ''.obs;
  Gm.CameraPosition kGooglePlex;
  Am.CameraPosition kApplePlex;
  getPropertyUnitDetail(String propertyID) async {
    loadingPropertiesUnitDetail.value = true;
    errorLoadingPropertiesUnitDetail.value = '';
    final response = await LandlordRepository.getPropertyUnitDetail(propertyID);
    print(response);
    print('******');
    if (response is LandLordUnitDetailModel) {
      if (response.status == 'Ok') {
        if (response.propertyUnitDetails.length >= 1) {
          propertyUnitDetailModel = response;
          print(
              'latitude  :::: ${propertyUnitDetailModel.propertyUnitDetails.first.latitude}');
          print(
              'longitude  :::: ${propertyUnitDetailModel.propertyUnitDetails.first.longitude}');
          if (propertyUnitDetailModel.propertyUnitDetails.first.latitude !=
                  "" &&
              propertyUnitDetailModel.propertyUnitDetails.first.longitude !=
                  "") {
            kGooglePlex = Gm.CameraPosition(
              target: Gm.LatLng(
                  double.parse(propertyUnitDetailModel
                      .propertyUnitDetails.first.latitude),
                  double.parse(propertyUnitDetailModel
                      .propertyUnitDetails.first.longitude)),
              zoom: 5.0,
            );
            kApplePlex = Am.CameraPosition(
              target: Am.LatLng(
                  double.parse(propertyUnitDetailModel
                      .propertyUnitDetails.first.latitude),
                  double.parse(propertyUnitDetailModel
                      .propertyUnitDetails.first.longitude)),
              zoom: 5.0,
            );
          } else {
            kGooglePlex = Gm.CameraPosition(
              target: Gm.LatLng(0.0, 0.0),
              zoom: 5.0,
            );
            kApplePlex = Am.CameraPosition(
              target: Am.LatLng(0.0, 0.0),
              zoom: 5.0,
            );
          }
          print('Response :::: IF :::: $response');
          loadingPropertiesUnitDetail.value = false;
        } else {
          print('Response :::: IF ELSE :::: $response');
          errorLoadingPropertiesUnitDetail.value = AppMetaLabels().noDatafound;
          loadingPropertiesUnitDetail.value = false;
        }
      }
    } else {
      print('Response :::: Else :::: $response');
      errorLoadingPropertiesUnitDetail.value = response;
      loadingPropertiesUnitDetail.value = false;
    }
  }

  void getPropertyDetail(String propertyID) async {
    loadingPropertiesDetail.value = true;
    errorLoadingPropertiesDetail = '';
    final response = await LandlordRepository.getPropertyDetail(propertyID);
    print(response);
    if (response is LandlordPropertiesDetailsModel) {
      if (response.status == 'Ok') {
        if (response.propertyDetails.length >= 1) {
          propertyDetailInfo = response;
        } else {
          errorLoadingPropertiesDetail = AppMetaLabels().noDatafound;
        }
      }
    } else {
      errorLoadingPropertiesDetail = response;
    }
    loadingPropertiesDetail.value = false;
  }

  Stream<Uint8List> getImage(int index) async* {
    var resp = await LandlordRepository.getImages(
        propertyUnitInfo.cities[index].unitID);
    if (resp is Uint8List) {
      yield resp;
    } else {}
  }
}
