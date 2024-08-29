import 'dart:convert';
import 'dart:developer';

import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/helpers/encription.dart';
import 'package:fap_properties/data/services/tenant_services/response_of_multipart.dart';
import 'package:fap_properties/utils/constants/app_config.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class UploadSvcReqFile {
  static Future<dynamic> uploadFile(String reqNo, String filePath,
      String fileType, String exp, String docTypeId) async {
    var url = AppConfig().uploadServiceRequestFiles;
    print(url);

    if (exp == '') {
      var now = DateTime.now();
      var formatter = DateFormat('dd-MM-yyyy');
      String foramteDate = formatter.format(now);
      exp = foramteDate;
    }
    var data = {
      'CaseNo': encriptdatasingle(reqNo).toString(),
      'AttachmentType': encriptdatasingle(fileType).toString(),
      'ExpireDate': encriptdatasingle(exp).toString(),
      'DocumentTypeId': encriptdatasingle(docTypeId).toString(),
    };
    log(data.toString());
    log(filePath.toString());

    var response;
    response = await BaseClientClass.uploadFile(url ?? "", data, 'File', filePath);
    if (response is StreamedResponse) {
      print('Response :::::respStr:: '); 
      // print(await response.stream.bytesToString());
      // 112233 HTML NEW
      // 112233 will show only when error come like a HTML
      if (response.statusCode == 404) {
        final respStr = await response.stream.bytesToString();
        print('Response :::::respStr:: $respStr');        // 112233 convert HTML page will work
        if (response.statusCode == 404 && respStr.contains('HTML') == true ||
            respStr.contains(
                    '!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN') ==
                true) {
          print(respStr);
          Get.to(() => ResponseInText(
                respose: respStr,
              ));
        }
      }
      print('Response Status Code ::::: ${response.statusCode}');
      if (response.statusCode == 200) {
        var res = json.decode(await response.stream.bytesToString());
        print('Response After DeCode ::::: $res');
        return res;
        // return
      } else {
        log("else 1 uploadFile  ");
        log(response.reasonPhrase!);
        return response.statusCode;
      }
    } else {
      log("else 2 uploadFile");
      return response;
    }
  }

  // uploadDocWithEIDParameter this func created because we want to send name,nationaity,ID after
  // scanne the emirate ID
  static Future<dynamic> uploadDocWithEIDParameter(
    String reqNo,
    String filePath,
    String fileType,
    String exp,
    String docTypeId,
    String emirateIdNumber,
    nationality,
    nameEng,
    nameAr,
    issueDate,
    dOB,
    // DateTime dOB,
  ) async {
    var url = AppConfig().uploadEIDFilesDetail;
    print(url);

    if (exp == '') {
      var now = DateTime.now();
      var formatter = DateFormat('dd-MM-yyyy');
      String foramteDate = formatter.format(now);
      exp = foramteDate;
    }
    print('EID :::: $emirateIdNumber');
    print('nationality :::: $nationality');
    print('nameEng :::: $nameEng');
    print('nameAr :::: $nameAr');
    print('issueDate :::: $issueDate');
    print('dOB :::: $dOB');
    print('exp :::: $exp');

    var dOBString;
    // if (dOB != null) {
    //   var formatter = DateFormat('dd-MM-yyyy');
    //   String foramteDate = formatter.format(dOB);
    //   dOBString = foramteDate;
    // }

    if (dOB == '' || dOB == null) {
      dOBString = '01-01-1900';
    } else {
      dOBString = dOB;
    }

    print('dOBString :::: $dOBString');

    var data = {
      'CaseNo': encriptdatasingle(reqNo).toString(),
      'AttachmentType': encriptdatasingle(fileType).toString(),
      'ExpireDate': encriptdatasingle(exp).toString(),
      'DocumentTypeId': encriptdatasingle(docTypeId).toString(),
      'EmirateIdNumber':
          encriptdatasingle(emirateIdNumber.toString()).toString(),
      'Nationality': encriptdatasingle(nationality.toString()).toString(),
      'NameEng': encriptdatasingle(nameEng.toString()).toString(),
      'NameAr': encriptdatasingle(nameAr.toString()).toString(),
      'IssueDate': '',
      'DOB': encriptdatasingle(dOBString.toString()).toString(),
    };
    var dataWithoutEncrp = {
      'CaseNo': reqNo,
      'AttachmentType': fileType,
      'ExpireDate': exp,
      'DocumentTypeId': docTypeId,
      'EmirateIdNumber': emirateIdNumber.toString(),
      'Nationality': nationality.toString(),
      'NameEng': nameEng.toString(),
      'NameAr': nameAr.toString(),
      'IssueDate': '',
      'DOB': dOBString.toString(),
    };
    log(dataWithoutEncrp.toString());
    var response;
    response = await BaseClientClass.uploadFile(url ?? "", data, 'File', filePath);
    if (response is StreamedResponse) {
      log(response.statusCode.toString());
      // final respStr = await response.stream.bytesToString();
      // print(respStr);
      if (response.statusCode == 200) {
        return json.decode(await response.stream.bytesToString());
      } else {
        log("else 1");
        log(response.reasonPhrase!);
        return response.statusCode;
      }
    } else {
      log("else 2 ");
      return response;
    }
  }
}
class UploadSvcReqFileNew {
  static Future<dynamic> uploadFileNew(String reqNo, String filePath,
      String fileType, String exp, String docTypeId) async {
    var url = AppConfig().uploadServiceRequestFilesNew;
    print(url);

    if (exp == '') {
      var now = DateTime.now();
      var formatter = DateFormat('dd-MM-yyyy');
      String foramteDate = formatter.format(now);
      exp = foramteDate;
    }
    var data = {
      'CaseNo': encriptdatasingle(reqNo).toString(),
      'AttachmentType': encriptdatasingle(fileType).toString(),
      'ExpireDate': encriptdatasingle(exp).toString(),
      'DocumentTypeId': encriptdatasingle(docTypeId).toString(),
    };
    log(data.toString());
    log(filePath.toString());

    var response;
    response = await BaseClientClass.uploadFile(url ?? "", data, 'File', filePath);
    if (response is StreamedResponse) {
      // print(await response.stream.bytesToString());
      // 112233 HTML NEW
      // 112233 will show only when error come like a HTML
      if (response.statusCode == 404) {
        final respStr = await response.stream.bytesToString();
        // 112233 convert HTML page will work
        if (response.statusCode == 404 && respStr.contains('HTML') == true ||
            respStr.contains(
                    '!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN') ==
                true) {
          print(respStr);
          Get.to(() => ResponseInText(
                respose: respStr,
              ));
        }
      }
      print('Response Status Code ::::: ${response.statusCode}');
      if (response.statusCode == 200) {
        var res = json.decode(await response.stream.bytesToString());
        print('Response After DeCode ::::: $res');
        return res;
        // return
      } else {
        log("else 1 uploadFile  ");
        log(response.reasonPhrase!);
        return response.statusCode;
      }
    } else {
      log("else 2 uploadFile");
      return response;
    }
  }

  // uploadDocWithEIDParameter this func created because we want to send name,nationaity,ID after
  // scanne the emirate ID
  static Future<dynamic> uploadDocWithEIDParameter(
    String reqNo,
    String filePath,
    String fileType,
    String exp,
    String docTypeId,
    String emirateIdNumber,
    nationality,
    nameEng,
    nameAr,
    issueDate,
    dOB,
    // DateTime dOB,
  ) async {
    var url = AppConfig().uploadEIDFilesDetail;
    print(url);

    if (exp == '') {
      var now = DateTime.now();
      var formatter = DateFormat('dd-MM-yyyy');
      String foramteDate = formatter.format(now);
      exp = foramteDate;
    }
    print('EID :::: $emirateIdNumber');
    print('nationality :::: $nationality');
    print('nameEng :::: $nameEng');
    print('nameAr :::: $nameAr');
    print('issueDate :::: $issueDate');
    print('dOB :::: $dOB');
    print('exp :::: $exp');

    var dOBString;
    // if (dOB != null) {
    //   var formatter = DateFormat('dd-MM-yyyy');
    //   String foramteDate = formatter.format(dOB);
    //   dOBString = foramteDate;
    // }

    if (dOB == '' || dOB == null) {
      dOBString = '01-01-1900';
    } else {
      dOBString = dOB;
    }

    print('dOBString :::: $dOBString');

    var data = {
      'CaseNo': encriptdatasingle(reqNo).toString(),
      'AttachmentType': encriptdatasingle(fileType).toString(),
      'ExpireDate': encriptdatasingle(exp).toString(),
      'DocumentTypeId': encriptdatasingle(docTypeId).toString(),
      'EmirateIdNumber':
          encriptdatasingle(emirateIdNumber.toString()).toString(),
      'Nationality': encriptdatasingle(nationality.toString()).toString(),
      'NameEng': encriptdatasingle(nameEng.toString()).toString(),
      'NameAr': encriptdatasingle(nameAr.toString()).toString(),
      'IssueDate': '',
      'DOB': encriptdatasingle(dOBString.toString()).toString(),
    };
    var dataWithoutEncrp = {
      'CaseNo': reqNo,
      'AttachmentType': fileType,
      'ExpireDate': exp,
      'DocumentTypeId': docTypeId,
      'EmirateIdNumber': emirateIdNumber.toString(),
      'Nationality': nationality.toString(),
      'NameEng': nameEng.toString(),
      'NameAr': nameAr.toString(),
      'IssueDate': '',
      'DOB': dOBString.toString(),
    };
    log(dataWithoutEncrp.toString());
    var response;
    response = await BaseClientClass.uploadFile(url ?? "", data, 'File', filePath);
    if (response is StreamedResponse) {
      log(response.statusCode.toString());
      // final respStr = await response.stream.bytesToString();
      // print(respStr);
      if (response.statusCode == 200) {
        return json.decode(await response.stream.bytesToString());
      } else {
        log("else 1");
        log(response.reasonPhrase!);
        return response.statusCode;
      }
    } else {
      log("else 2 ");
      return response;
    }
  }
}
