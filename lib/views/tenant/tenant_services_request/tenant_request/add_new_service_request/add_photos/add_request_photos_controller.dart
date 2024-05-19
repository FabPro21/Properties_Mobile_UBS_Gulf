import 'dart:io';
import 'package:fap_properties/data/models/tenant_models/service_request/photo_file.dart';
import 'package:fap_properties/data/repository/tenant_repository.dart';
import 'package:fap_properties/utils/constants/check_file_extension.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart' as imagePicker;
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../../../utils/image_compress.dart';

class AddRequestPhotosController extends GetxController {
  String caseNo;
  RxBool addingPhoto = false.obs;
  List<PhotoFile> photos = [null];
  final imagePicker.ImagePicker _picker = imagePicker.ImagePicker();

  pickPhoto(ImageSource source) async {
    XFile file = await _picker.pickImage(source: source);

    // checking file extension
    if (!CheckFileExtenstion().checkImageExtFunc(file.path)) {
        Get.snackbar(AppMetaLabels().error, AppMetaLabels().fileExtensionError,
            duration: Duration(seconds: 5),
            backgroundColor: AppColors.redColor,
            colorText: AppColors.white54);
        return;
      }
    if (file != null) {
      addingPhoto.value = true;
      Uint8List photo = await file.readAsBytes();
      photo = await compressImage(photo);

       // checking file size EID
      print('Size of file ::: ${CheckFileExtenstion().getFileSize(photo)}');
      var size = CheckFileExtenstion().getFileSize(photo).split(' ')[0];
      var extension = CheckFileExtenstion().getFileSize(photo).split(' ')[1];
      if (extension.contains('MB')) {
        if (double.parse(size) > 10) {
          Get.snackbar(AppMetaLabels().error, AppMetaLabels().fileSizenError,
              duration: Duration(seconds: 5),
              backgroundColor: AppColors.redColor,
              colorText: AppColors.white54);
               addingPhoto.value = false;
          return;
        }
      }
      
      // we are commenting below lines because Editor change the extension 112233
      // final editedImage = await Get.to(() => ImageEditor(
      //       image: photo,
      //     ));
      // if (editedImage != null) photo = editedImage;
      String path = file.path;
      print('Path before store in local Storage ::: $path');
      if (photo != null && await getStoragePermission()) {
        final newPath = await getTemporaryDirectory();
        final newFile = File("${newPath.path}/${file.path.split('/').last}");
        if (newFile != null) {
          await newFile.writeAsBytes(photo);
          path = newFile.path;
        }
        print('Path After store in local Storage ::: ${newFile.path}');
        print('Path After store in local Storage ::: $path');
        photos[photos.length - 1] =
            PhotoFile(file: photo, path: path, type: file.mimeType);
        uploadPhoto(photos.length - 1);
        photos.add(null);
      }
      addingPhoto.value = false;
    }
  }

  uploadPhoto(int index) async {
    print('********Image upload***********');
    photos[index].errorUploading = false;
    photos[index].uploading.value = true;
    try {
      var resp = await TenantRepository.uploadFile(
          caseNo, photos[index].path, 'Images', '', '0');
      photos[index].id = resp['photoId'];
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      photos[index].errorUploading = true;
    }
    photos[index].uploading.value = false;
  }

  removePhoto(int index) async {
    photos[index].errorRemoving = false;
    photos[index].removing.value = true;
    var resp = await TenantRepository.removeReqPhoto(photos[index].id);
    if (resp == 200) {
      addingPhoto.value = true;
      photos.removeAt(index);
      addingPhoto.value = false;
    } else {
      photos[index].errorRemoving = true;
      photos[index].removing.value = false;
    }
  }

  Future<bool> getStoragePermission() async {
    if (await Permission.storage.request().isGranted) {
      return true;
    } else if (await Permission.storage.request().isPermanentlyDenied) {
      return await openAppSettings();
    } else if (await Permission.storage.request().isDenied) {
      return false;
    }
    return false;
  }
}
