import 'dart:typed_data';

import 'package:get/get_rx/src/rx_types/rx_types.dart';

class PhotoFile {
  int? id;
  Uint8List? file;
  String? path;
  String? type;
  String? source;
  RxBool uploading = false.obs;
  RxBool downloading = false.obs;
  bool errorUploading = false;
  bool errorDownloading = false;
  String? errorText = '';
  RxBool removing = false.obs;
  bool errorRemoving = false;

  PhotoFile({this.id, this.file, this.path, this.type, this.source});

  factory PhotoFile.fromJson(Map<String?, dynamic> json) => PhotoFile(
      id: json['photoId'],
      source: json['photoSource'],
      type: json['attachmentType']);
}
