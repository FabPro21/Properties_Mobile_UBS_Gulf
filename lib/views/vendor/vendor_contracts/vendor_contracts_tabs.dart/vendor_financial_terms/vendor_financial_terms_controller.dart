import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/vendor_models/vendor_financial_terms_model.dart';
import 'package:fap_properties/data/repository/vendor_repository.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class GetContractFinancialTermsController extends GetxController {
  var getFinalcialTerms = GetContractFinancialTermsModel().obs;

  var loadingData = true.obs;
  int length = 0;
  RxString onSearch = "".obs;
  RxString amountCurrency = "".obs;
  RxString error = "".obs;
  RxDouble totalAmountSum = 0.0.obs;
  RxDouble totalPaid = 0.0.obs;
  RxDouble balance = 0.0.obs;

  RxString totalPaidFormat = "".obs;
  RxString balanceFormat = "".obs;
  RxString totalAmountSumFormat = "".obs;

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  getData() async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }
    // try {

    loadingData.value = true;
    var result = await VendorRepository.financialTerms();
    loadingData.value = false;

    if (result is GetContractFinancialTermsModel) {
      getFinalcialTerms.value = result;
      if (getFinalcialTerms.value.status == AppMetaLabels().notFound) {
        error.value = AppMetaLabels().noDatafound;
        loadingData.value = false;
      } else {
        getFinalcialTerms.value = result;
        /////////
        /// total amount is sum of all amount
        /////////

        totalAmountSum.value = 0.0;

        getFinalcialTerms.value.contractFinancialTerms!.forEach((element) {
          totalAmountSum.value = totalAmountSum.value + element.amount;
        });
        /////////
        /// balance = total -paid;
        /////////
        totalPaid.value = getFinalcialTerms.value.paid!.paid;
        balance.value = totalAmountSum.value - totalPaid.value;

        ///////////////////////////////
        /// total paid currency format
        ///////////////////////////////
        var tp = totalPaid.value;
        final tpFormatter = NumberFormat('#,##0.00', 'AR');
        totalPaidFormat.value = tpFormatter.format(tp);
        ///////////////////////////////
        /// total paid currency format
        ///////////////////////////////
        var tb = balance.value;
        final tbFormatter = NumberFormat('#,##0.00', 'AR');
        balanceFormat.value = tbFormatter.format(tb);
        ///////////////////////////////
        /// total paid currency format
        ///////////////////////////////
        var tas = totalAmountSum.value;
        final tacFormatter = NumberFormat('#,##0.00', 'AR');
        totalAmountSumFormat.value = tacFormatter.format(tas);

        length = getFinalcialTerms.value.contractFinancialTerms!.length;
        update();
        loadingData.value = false;
      }
    } else {
      error.value = AppMetaLabels().noDatafound;
      loadingData.value = false;
    }

    // } catch (e) {
    //   loadingData.value = false;
    //   print("this is the error from controller= $e");
    // }
  }
}
