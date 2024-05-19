import 'dart:typed_data';

import 'package:get/get_rx/src/rx_types/rx_types.dart';


class DocFile {
  int id;
  Uint8List file;
  String path;
  String type;
  String name;
  String nameAr;
  String expiry;
  String size;
  String attachmentDate;
  int documentTypeId;
  bool isRejected;
  RxBool loading = false.obs;
  bool errorLoading = false;
  RxBool removing = false.obs;
  bool errorRemoving = false;
  RxBool update = false.obs;

  DocFile(
      {this.id,
      this.file,
      this.path,
      this.type,
      this.name,
      this.nameAr,
      this.expiry,
      this.size,
      this.attachmentDate,
      this.documentTypeId,
      this.isRejected});

  factory DocFile.fromJson(Map<String, dynamic> json) {
    return DocFile(
        name: json['name'] ?? '',
        nameAr: json['nameAr'] ?? '',
        type: json['extentsion'],
        expiry: json['expireDate'],
        id: json['attachmentId'],
        attachmentDate: json['attachmentDate'],
        documentTypeId: json['documentTypeId'],
        isRejected: json['isRejected'] ?? false);
  }
}
