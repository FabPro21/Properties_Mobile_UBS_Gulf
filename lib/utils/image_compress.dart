import 'dart:typed_data';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:sizer/sizer.dart';

Future<Uint8List> compressImage(Uint8List list) async {
  var result = await FlutterImageCompress.compressWithList(
    list,
    minHeight: 100.h.round(),
    minWidth: 100.w.round(),
    quality: 96,
  );
  print(list.length);
  print(result.length);
  return result;
}

// Future<String> getFileSize(String filepath) async {
//     var file = File(filepath);
//     int bytes = await file.length();
//     if (bytes <= 0) return "0 B";
//     const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
//     var i = (log(bytes) / log(1024)).floor();
//     return ((bytes / pow(1024, i)).toStringAsFixed(2)) + ' ' + suffixes[i];
//   }
