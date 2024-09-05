import 'dart:convert';

import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/vendor_models/amc-drop_dpwn_model.dart';
import 'package:fap_properties/data/models/vendor_models/installmment_drop_sown_model.dart';
import 'package:fap_properties/data/models/vendor_models/lpo_drop_down.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import "package:http/http.dart" as http;

class SaveServiceRequestServices {
  static Future<dynamic> saveData(
      String paymenFor,
      srNo,
      instNo,
      invoiceAmount,
      trn,
      workCompletion,
      remrks,
      invoiceNo,
      invoiceDate,
      paymentTermID) async {
    var url = AppConfig().vendorSaveInvoiceServiceRequest;
    trn = 0.toString();
    var data = {
      "ServiceType": paymenFor.toString(),
      "ServiceNo": srNo.toString(),
      "InstNo": instNo.toString(),
      "InvoiceAmount": invoiceAmount,
      "TRNofLandlord": trn,
      "WorkCompletionDate": workCompletion,
      "Description": remrks,
      "InvoiceNumber": invoiceNo,
      "InvoiceDate": invoiceDate,
      "PaymentTermID": paymentTermID
    };
    print("Invoice ::::: add ::::: $data");
    try {
      var response = await BaseClientClass.post(url ?? "", data);
      if (response is http.Response) {
        var json = jsonDecode(response.body);
        print('JSON Response :::: $json');
        return json;
      }
      return response;
    } catch (e) {
      return e;
    }
  }

  static Future<dynamic> getData(String caseNo) async {
    var url = AppConfig().vendorGetInvoiceServiceRequest;
    var data = {"CaseNo": caseNo};
    try {
      var response = await BaseClientClass.post(url ?? "", data);
      print(response);
      if (response is http.Response) {
        var json = jsonDecode(response.body);
        print('JSON Response :::: $json');
        return json;
      }
      return response;
    } catch (e) {
      return e;
    }
  }

  static Future<dynamic> getLpoDropDownForInvoice() async {
    var url = AppConfig().getLpoDropdownForIvoice;
    var data = {};
    try {
      var response = await BaseClientClass.post(url ?? "", data);
      print(response);
      if (response is http.Response) {
        var lpoDropDown = LpoDropDownModel.fromJson(jsonDecode(response.body));
        // var json = jsonDecode(response.body);
        return lpoDropDown;
      }
      return response;
    } catch (e) {
      return e;
    }
  }

  static Future<dynamic> getAMCropDownForInvoice() async {
    var url = AppConfig().getAMCDropdownForInvoice;
    var data = {};
    try {
      var response = await BaseClientClass.post(url ?? "", data);
      print(response);
      if (response is http.Response) {
        var json = AmcDropDownModel.fromJson(jsonDecode(response.body));
        return json;
      }
      return response;
    } catch (e) {
      return e;
    }
  }

  static Future<dynamic> getAMCInstDropDownForInvoice(
      String contractRefNo, contractID) async {
    var url = AppConfig().getAmcInstallmentForInvoice;
    var data = {
      "ContractRefNo": contractRefNo.toString(),
      "ContractID": contractID
    };
    try {
      var response = await BaseClientClass.post(url ?? "", data);
      print(response);
      if (response is http.Response) {
        var json = InstallmentDropDownModel.fromJson(jsonDecode(response.body));
        print('Json ::::: $json');
        return json;
      }
      return response;
    } catch (e) {
      print('Exception :::: $e');
      return e;
    }
  }
}
