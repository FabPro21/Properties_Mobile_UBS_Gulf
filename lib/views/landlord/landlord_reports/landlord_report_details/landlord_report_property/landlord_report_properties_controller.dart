import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/landlord_models/filter_property_type_model.dart';
import 'package:fap_properties/data/models/landlord_models/landlord_properties_model.dart';
import 'package:fap_properties/data/repository/landlord_repository.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:get/get.dart';
import 'package:fap_properties/data/models/landlord_models/report/get_dropdown_model.dart'
    as dropDownModel;

class LandLordReportPropertiesController extends GetxController {
  Rx<GetLandLordPropertiesTypesModel> propertyTypesModel =
      GetLandLordPropertiesTypesModel().obs;
  RxBool loading = false.obs;
  RxString error = ''.obs;
  int proppertyTypesLength = 0;

  @override
  void onInit() {
    super.onInit();
  }

  LandlordPropertiesModel propsModel;
  List<ServiceRequests> listOfProperties;
  void getProperties() async {
    loading.value = true;
    error.value = '';
    final response = await LandlordRepository.getProperties();
    print(response);
    if (response is LandlordPropertiesModel) {
      propsModel = response;
      if (propsModel.serviceRequests.length < 1) {
        error.value = AppMetaLabels().noDatafound;
      } else {
        listOfProperties = propsModel.serviceRequests.toSet().toList();
        proppertyTypesLength = listOfProperties.length;
      }
    } else
      error.value = response;
    loading.value = false;
  }

  // getDropdownType
  RxBool isLoadingDropdownType = false.obs;
  RxString errorDropdownType = ''.obs;
  // Rx<dropDownModel.GetDropDownModel> getDropDownModel =
  //     dropDownModel.GetDropDownModel().obs;
  RxList<dropDownModel.ServiceRequests> getDropDownModelList = <dropDownModel.ServiceRequests>[].obs;
  getDropdownType(String type) async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(() => NoInternetScreen());
    }
    try {
      errorDropdownType.value = '';
      loading.value = true;
      var result = await LandlordRepository.getDropDownType(type);
      if (result is dropDownModel.GetDropDownModel) {
        // getDropDownModel.value = result;
        getDropDownModelList.value = result.serviceRequests;
        print('DropDownReponse::::::::: ${getDropDownModelList[0]}');
        // if (getDropDownModel.value.status == AppMetaLabels().notFound) {
        //   errorDropdownType.value = AppMetaLabels().noDatafound;
        //   loading.value = false;
        // } else
        if (getDropDownModelList.isEmpty) {
          errorDropdownType.value = AppMetaLabels().noDatafound;
          loading.value = false;
        } else {
          update();
          loading.value = false;
        }
      } else {
        errorDropdownType.value = result; //AppMetaLabels().noDatafound;
        loading.value = false;
      }
    } catch (e) {
      loading.value = false;
      errorDropdownType.value = AppMetaLabels().someThingWentWrong;
      print("this is the error from controller= $e");
    }
  }

  void getPropertyTypes() async {
    if (propertyTypesModel.value.message == null) {
      bool _isInternetConnected = await BaseClientClass.isInternetConnected();
      if (!_isInternetConnected) {
        await Get.to(NoInternetScreen());
      }
      loading.value = true;
      var resp = await LandlordRepository.getPropertyTypes();
      loading.value = false;
      print('Response :::::::: $resp');
      if (resp == 'No data found') {
        error.value = AppMetaLabels().noDatafound;
      } else if (resp == 'Bad Request') {
        error.value = AppMetaLabels().someThingWentWrong;
      } else if (resp.status == 'Ok') {
        propertyTypesModel.value = resp;
        proppertyTypesLength = resp.propertyType.length;
      } else {
        error.value = resp;
      }
    }
  }
}
