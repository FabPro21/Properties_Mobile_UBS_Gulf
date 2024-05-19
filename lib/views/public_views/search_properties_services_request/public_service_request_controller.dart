import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/public_models/public_services_myrequest/public_services_myrequest_model.dart';
import 'package:fap_properties/data/repository/public_repository.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:get/get.dart';

class PublicServiceRequestController extends GetxController {
  var publicServiceRequest = PublicServiceMyRequestModel().obs;
  var loadingData = true.obs;
  RxString onSearch = "".obs;
  RxString error = "".obs;
  var isSearching = true.obs;
  List<ServiceRequest> serviceReq = [ServiceRequest()].obs;

  Future<void> getSericeRequest() async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(() => NoInternetScreen());
    }
    // try {
    loadingData.value = true;
    var result = await PublicRepositoryDrop2.getServiceRequest();
    loadingData.value = false;
    if (result is PublicServiceMyRequestModel) {
      publicServiceRequest.value = result;
      serviceReq = result.serviceRequests.toList();
    } else {
      error.value = result;
    }
  }

  searchData(String qry) {
    qry = qry.toLowerCase();
    loadingData.value = true;
    serviceReq.clear();
    for (int i = 0;
        i < publicServiceRequest.value.serviceRequests.length;
        i++) {
      if (publicServiceRequest.value.serviceRequests[i].requestNo
              .toString()
              .contains(qry) ||
          publicServiceRequest.value.serviceRequests[i].category
              .toLowerCase()
              .contains(qry) ||
          publicServiceRequest.value.serviceRequests[i].subCategory
              .toLowerCase()
              .contains(qry) ||
          publicServiceRequest.value.serviceRequests[i].propertyName
              .toLowerCase()
              .contains(qry)) {
        serviceReq.add(publicServiceRequest.value.serviceRequests[i]);
      }
    }
    if (serviceReq.length == 0)
      error.value = AppMetaLabels().noServiceRequestsFound;
    else
      error.value = '';

    loadingData.value = false;
  }
}
