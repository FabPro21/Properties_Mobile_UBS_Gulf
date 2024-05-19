import 'package:fap_properties/data/models/landlord_models/landlord_contract_units_model.dart';
import 'package:fap_properties/data/repository/landlord_repository.dart';
import 'package:get/get.dart';

class LandlordUnitInfoController extends GetxController {
  LandlordContractUnitsModel contractUnits;
  RxBool loadingUnits = false.obs;
  String errorLoadingUnits = '';

  void getUnits(int contractId) async {
    errorLoadingUnits = '';
    loadingUnits.value = true;
    final response = await LandlordRepository.getContractUnits(contractId);
    if (response is LandlordContractUnitsModel)
      contractUnits = response;
    else
      errorLoadingUnits = response;
    loadingUnits.value = false;
  }
}
