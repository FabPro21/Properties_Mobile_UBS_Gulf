import 'package:fap_properties/data/repository/tenant_repository.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:get/get.dart';

class TermsAndConditionsNewController extends GetxController {
  RxBool loadingData = false.obs;
  String errorLoadingData = '';
  String data = '';

  void getData(String dataType) async {
    errorLoadingData = '';
    loadingData.value = true;
    final resp = await TenantRepository.getPaymentPolicyData(
        dataType == AppMetaLabels().refundPolicy
            ? 'RefundPolicy'
            : 'PrivacyPolicy');
    loadingData.value = false;
    if (resp is String) {
      errorLoadingData = resp;
    } else {
      data = resp["data"]["value"];
      data =
          """<html>
      <head><meta name="viewport" content="width=device-width, initial-scale=1.0"></head>
      <body style='"margin: 0; padding: 0;'>""" +
              data +
              """</body></html>""";
    }
  }
}
