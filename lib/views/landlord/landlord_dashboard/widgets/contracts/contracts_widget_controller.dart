import 'package:fap_properties/data/models/landlord_models/landlord_contracts_model.dart';
import 'package:fap_properties/data/repository/landlord_repository.dart';
import 'package:fap_properties/views/landlord/landlord_contracts/landlord_contracts_controller.dart';
import 'package:get/get.dart';

class LandlordContractsWidgetController extends GetxController {
  LandlordContractsModel? contractsModel;
  RxBool loadingContracts = false.obs;
  String errorLoadingContracts = '';
  int length = 0;

  @override
  void onInit() {
    getContracts();
    super.onInit();
  }

  final controller = Get.put(LandlordContractsController());
  void getContracts() async {
    errorLoadingContracts = '';
    loadingContracts.value = true;
    final response =
        await LandlordRepository.getContracts(controller.pageNo, '');
    if (response is LandlordContractsModel) {
      contractsModel = response;
      if (contractsModel!.data!.length <= 3)
        length = contractsModel!.data!.length;
      else
        length = 3;
    } else
      errorLoadingContracts = response;
    loadingContracts.value = false;
  }
}
