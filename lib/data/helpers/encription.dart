// // ignore_for_file: unused_local_variable

// import 'dart:convert';
// import 'dart:core';
// import 'package:encrypt/encrypt.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';

// encriptdata(payload) {
//   String jsonData = jsonEncode(payload);
//   print('jsonData for encription : $jsonData');
//   final key = Key.fromUtf8(dotenv.env['Key'] ?? "");
//   String strIv = dotenv.env['strIv'] ?? "";
//   var iv = IV.fromUtf8(utf8.decode((strIv).codeUnits));
//   final encrypter = Encrypter(AES(key, mode: AESMode.gcm, padding: 'PKCS7'));
//   final encrypted = encrypter.encrypt(
//     jsonData,
//     iv: iv,
//   );
//   print('encrypted for encription : ${encrypted.base64}');
//   final decrypted = encrypter.decrypt(encrypted, iv: iv);
//   print('decrypted for decrypte : $decrypted');
//   return encrypted.base64;
// }

// encriptdatasingle(payload) {
//   final key = Key.fromUtf8(dotenv.env['Key'] ?? "");
//   String strIv = dotenv.env['strIv'] ?? "";
//   var iv = IV.fromUtf8(utf8.decode((strIv).codeUnits));
//   final encrypter = Encrypter(AES(key, mode: AESMode.gcm, padding: 'PKCS7'));
//   final encrypted = encrypter.encrypt(
//     payload,
//     iv: iv,
//   );
//   final decrypted = encrypter.decrypt(encrypted, iv: iv);
//   return encrypted.base64;
// }

// with mode AESMode.cbc which was using from start to 4-sep-2024
// update mode when we get issue from security like
// The App uses the encryption mode CBC with PKCS5/PKCS7 padding. This configuration is vulnerable to padding oracle attacks.
import 'dart:convert';
import 'dart:core';
import 'package:encrypt/encrypt.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

encriptdata(payload) {
  String jsonUser = jsonEncode(payload);
  // print(jsonUser);
  final key = Key.fromUtf8(dotenv.env['Key'] ?? "");
  String strIv = dotenv.env['strIv'] ?? "";
  var iv = IV.fromUtf8(utf8.decode((strIv).codeUnits));
  final encrypter = Encrypter(AES(key, mode: AESMode.cbc, padding: 'PKCS7'));
  final encrypted = encrypter.encrypt(
    jsonUser,
    iv: iv,
  );
  
  final decrypted = encrypter.decrypt(encrypted, iv: iv);
  print('decrypted for encrypt $decrypted');
  return encrypted.base64;
}

encriptdatasingle(payload) {
  //String jsonUser = jsonEncode(payload);
  final key = Key.fromUtf8(dotenv.env['Key'] ?? "");
  String strIv = dotenv.env['strIv'] ?? "";
  var iv = IV.fromUtf8(utf8.decode((strIv).codeUnits));
  final encrypter = Encrypter(AES(key, mode: AESMode.cbc, padding: 'PKCS7'));
  final encrypted = encrypter.encrypt(
    payload,
    iv: iv,
  );
  final decrypted = encrypter.decrypt(encrypted, iv: iv);
  // print("ans is------");
  print(decrypted); // Lorem ipsum dolor sit amet, consectetur adipiscing elit
  // print(encrypted.base64);
  return encrypted.base64;
}
