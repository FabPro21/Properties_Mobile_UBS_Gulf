import 'dart:math';
import 'dart:typed_data';
import 'package:path/path.dart' as p;
import 'package:file_picker/file_picker.dart';

class CheckFileExtenstion {
  bool checkFileExtFunc(FilePickerResult result) {
    if (result.files[0].extension == 'pdf' ||
        result.files[0].extension == 'png' ||
        result.files[0].extension == 'jpg' ||
        result.files[0].extension == 'jpeg') {
      return true;
    } else {
      return false;
    }
  }

  bool checkImageExtFunc(String path) {
    print(p.extension(path));
    print('?????????????????????');
    if (p.extension(path) == '.pdf' ||
        p.extension(path) == '.png' ||
        p.extension(path) == '.jpg' ||
        p.extension(path) == '.jpeg') {
      return true;
    } else {
      return false;
    }
  }

  String getFileSize(Uint8List file) {
    int bytes = file.lengthInBytes;
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(2)) + ' ' + suffixes[i];
  }
}
//  if (result.files[0].extension == 'doc' ||
//         result.files[0].extension == 'docx' ||
//         result.files[0].extension == 'jpeg' ||
//         result.files[0].extension == 'gif') {
//       Get.snackbar(
//         'Error',
//         'You can only upload  "pdf , jpg , png" files of maximum size 10 MB ',
//         backgroundColor: AppColors.redColor,
//         colorText: AppColors.white54
//       );
//       return;
//     }