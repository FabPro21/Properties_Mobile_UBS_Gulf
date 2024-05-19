import 'dart:convert';

import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/helpers/encription.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:http/http.dart';

import '../../../models/tenant_models/contract_payable/outstanding_payments_model.dart';

class UpdatePaymentMethodService {
  static Future<dynamic> updatePaymentMethod(Record record) async {
    // *
    var url = AppConfig().updateContractPaymentMethod;
    print(url);
    var data = {
      'PaymentModeId':
          encriptdatasingle(record.defaultpaymentmethodtype.value.toString())
              .toString(),
      'PaymentSettingId':
          encriptdatasingle(record.paymentSettingId.toString()).toString(),
      'ChequeNo': record.chequeNo == ''
          ? record.chequeNo.toString()
          : encriptdatasingle(record.chequeNo.toString()).toString(),
      'Address': record.aramexAddress == ''
          ? record.aramexAddress.toString()
          : encriptdatasingle(record.aramexAddress.toString()).toString(),
    };
    var dataWithoutEncypt = {
      'PaymentModeId': record.defaultpaymentmethodtype.value.toString(),
      'PaymentSettingId': record.paymentSettingId.toString(),
      'ChequeNo': record.chequeNo == ''
          ? record.chequeNo.toString()
          : record.chequeNo.toString(),
      'Address': record.aramexAddress == ''
          ? record.aramexAddress.toString()
          : record.aramexAddress.toString(),
    };
    print('********** Data without encrypt ***********');
    print('**********${record.filePath}');
    print('Payment Medthod ID ${record.defaultpaymentmethodtype.value}');
    print(dataWithoutEncypt);
    print('********** Data after encrypt encrypt ***********');
    print(data);

    var response;

    response =
        await BaseClientClass.uploadFile(url, data, 'File', record.filePath);
    if (response is StreamedResponse) {
      print(response);
      print(response.statusCode);
      if (response.statusCode == 200) {
        return json.decode(await response.stream.bytesToString());
      } else
        return response.statusCode;
    } else {
      return response;
    }
  }
}

class UpdatePaymentMethodServiceNew {
  static Future<dynamic> updatePaymentMethodNew(Record record) async {
    // *
    var url = AppConfig().updateContractPaymentMethodNew;
    print(url);
    var data = {
      'PaymentModeId':
          encriptdatasingle(record.defaultpaymentmethodtype.value.toString())
              .toString(),
      'PaymentSettingId':
          encriptdatasingle(record.paymentSettingId.toString()).toString(),
      'ChequeNo': record.chequeNo == ''
          ? record.chequeNo.toString()
          : encriptdatasingle(record.chequeNo.toString()).toString(),
      'Address': record.aramexAddress == ''
          ? record.aramexAddress.toString()
          : encriptdatasingle(record.aramexAddress.toString()).toString(),
    };
    var dataWithoutEncypt = {
      'PaymentModeId': record.defaultpaymentmethodtype.value.toString(),
      'PaymentSettingId': record.paymentSettingId.toString(),
      'ChequeNo': record.chequeNo == ''
          ? record.chequeNo.toString()
          : record.chequeNo.toString(),
      'Address': record.aramexAddress == ''
          ? record.aramexAddress.toString()
          : record.aramexAddress.toString(),
    };
    print('********** Data without encrypt ***********');
    print('**********${record.filePath}');
    print('Payment Medthod ID ${record.defaultpaymentmethodtype.value}');
    print(dataWithoutEncypt);
    print('********** Data after encrypt encrypt ***********');
    print(data);

    var response;

    response =
        await BaseClientClass.uploadFile(url, data, 'File', record.filePath);
    if (response is StreamedResponse) {
      print(response);
      print(response.statusCode);
      // var res = json.decode(await response.stream.bytesToString());
      // print('Response:::: $res');
      if (response.statusCode == 200) {
        return json.decode(await response.stream.bytesToString());
      } else
        return response.statusCode;
    } else {
      return response;
    }
  }
}
