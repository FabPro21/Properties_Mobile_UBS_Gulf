import 'dart:io';
import 'dart:math';

import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/tenant_models/get_service_request_details_model.dart';
import 'package:fap_properties/data/models/tenant_models/service_request/doc_file.dart';
import 'package:fap_properties/data/models/tenant_models/service_request/photo_file.dart';
import 'package:fap_properties/data/models/tenant_models/tenant_feedback/tenant_get_sr_feedback.dart';
import 'package:fap_properties/data/models/tenant_models/tenant_feedback/tenant_save_feedback_model.dart';
import 'package:fap_properties/data/repository/tenant_repository.dart';
import 'package:fap_properties/data/repository/vendor_repository.dart';
import 'package:fap_properties/utils/constants/check_file_extension.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/image_compress.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:fap_properties/views/tenant/tenant_services_request/tenant_request_details/tenant_service_request_tab/take_survey/take_survey_controller.dart';
import 'package:fap_properties/views/widgets/snackbar_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';

import '../tenant_request/tenant_request_list/tenant_request_list_controller.dart';

class TenantRequestDetailsController extends GetxController {
  RxBool isContractRenewed = false.obs;
  RxBool isEnableBackButton = true.obs;
  int caseNo = 0;
  RxBool loadingReport = false.obs;
  String errorLoadingReport = '';
  Rx<DocFile> report = DocFile().obs;
  RxBool canClose = false.obs;
  RxBool editingReport = false.obs;
  bool errorEditingReport = false;

  uploadReport() async {
    errorEditingReport = false;
    editingReport.value = true;
    try {
      // 112233 Uploaded Document
      var resp = await VendorRepository.uploadFile(
          caseNo, report.value.path, 'Document', '', 0);

      loadingReport.value = true;
      var id = resp['photoId'];
      report.value =
          DocFile(id: id, path: report.value.path, file: report.value.file);
      loadingReport.value = false;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      errorEditingReport = true;
    }
    editingReport.value = false;
  }

  void getFiles() async {
    errorLoadingReport = '';
    loadingReport.value = true;
    print('Case No :::::::::: ${caseNo.toString()}');
    var resp = await TenantRepository.getReqDocsForTenant(caseNo.toString(), 1);
    if (resp is List<DocFile>) {
      print('Respons :::getFiles:: $resp');
      if (resp.isNotEmpty) {
        report.value = resp[0];
        report.value.size = getFileSize(report.value.file);
      }
    } else
      errorLoadingReport = resp;
    loadingReport.value = false;
  }

  pickReport() async {
    FilePickerResult result = await FilePicker.platform
        .pickFiles(allowedExtensions: ['pdf'], type: FileType.custom);
    if (result != null) {
      File file = File(result.files.single.path);
      Uint8List bytesFile = await file.readAsBytes();
      String path = file.path;
      String size = getFileSize(bytesFile);
      report.value = DocFile(path: path, file: bytesFile, size: size);
      uploadReport();
    }
  }

  String getFileSize(Uint8List file) {
    int bytes = file.length;
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(2)) + ' ' + suffixes[i];
  }

  void showReport() async {
    if (report.value.path == null) {
      if (await getStoragePermission()) {
        String path = await saveReport();
        report.value.path = path;
      }
    }
    await OpenFile.open(report.value.path);
  }

  Future<String> saveReport() async {
    final path = await getTemporaryDirectory();
    final file =
        File("${path.path}/${this.report.value.name}${this.report.value.type}");
    await file.writeAsBytes(report.value.file);
    return file.path;
  }
  // end for show document-> ABOVE TRACK

  var tenantRequestDetails = GetServiceRequestDetailsModel().obs;
  var loadingData = true.obs;
  RxString error = "".obs;
  RxBool cancellingRequest = false.obs;
  //--------feedback
  double rating = 0;
  Rx<TenantGetSrFeedback> feedback = TenantGetSrFeedback().obs;
  RxBool addingFeedback = false.obs;
  RxBool gettingFeedback = false.obs;
  String errorGettingFeedback = '';

  //--------photos---------
  RxBool gettingPhotos = false.obs;
  String errorGettingPhotos = '';
  List<PhotoFile> photos = [];
  final ImagePicker _picker = ImagePicker();
  RxBool reopeningSvcReq = false.obs;

  bool updatedReq = false;

  bool showSurveyButton = false;

  bool canCommunicate = true;

  @override
  void onInit() {
    getDataMain();
    super.onInit();
  }

  // 112233 calling for detail and also get file
  // 112233 get file
  getDataMain() async {
    await getData();
    getFiles();
  }

  Future<void> getData() async {
    print('========>>>> Main');
    print('====> Case No ::::::: $caseNo =====>');
    canCommunicate = true;
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(() => NoInternetScreen());
    }
    // try {
    loadingData.value = true;
    var result = await TenantRepository.getServiceRequestDetails();
    if (result is GetServiceRequestDetailsModel) {
      tenantRequestDetails.value = result;
      caseNo = tenantRequestDetails.value.detail.caseNo;

      ///
      print('====> Case No ::::::: $caseNo =====>');
      print(
          '====> canUploadDocs ::::::: ${tenantRequestDetails.value.statusInfo.canUploadDocs} =====>');
      print(
          '====> result.statusInfo.canTakeSurvey ::::::: ${result.statusInfo.canTakeSurvey} =====>');
      print('====> isRenwed Cace ::::::: $isContractRenewed=====>');

      if (result.detail.requestType == 'FM') getPhotos();
      if (result.detail.caseFeedback != 0) getFeedback();
      update();
      if (result.statusInfo.canTakeSurvey) {
        TakeSurveyController surveyController = Get.put(TakeSurveyController(
            caseNo: result.detail.caseNo,
            catId: result.detail.caseCategouryId));
        showSurveyButton = await surveyController.getSurveyQuestions();
        print('====> showSurveyButton ::::::: $showSurveyButton =====>');
      }
      if (result.detail.status.toLowerCase().contains('closed') ||
          result.detail.status.toLowerCase().contains('cancelled')) {
        canCommunicate = false;
      }
    } else {
      error.value = result;
    }
    loadingData.value = false;
  }

  Future<void> getPhotos() async {
    print('Photo ::::::::::: ');
    photos.clear();
    errorGettingPhotos = '';
    gettingPhotos.value = true;
    var resp = await TenantRepository.getReqThumbnails(
        tenantRequestDetails.value.detail.caseNo, 1);
    print('Photo ::::::getReqThumbnails::::::: $resp');
    if (resp is List<PhotoFile>) {
      photos = resp;
      if (tenantRequestDetails.value.statusInfo.canCancel) photos.add(null);
    } else if (resp == 404 || resp == AppMetaLabels().noDatafound) {
      if (tenantRequestDetails.value.statusInfo.canCancel)
        photos.add(null);
      else
        errorGettingPhotos = AppMetaLabels().noPhotos;
    } else
      errorGettingPhotos = resp;
    gettingPhotos.value = false;
  }

  Future<bool> cancelRequest() async {
    try {
      cancellingRequest.value = true;
      var resp = await TenantRepository.cancelServiceRequest(
          tenantRequestDetails.value.detail.caseNo);
      cancellingRequest.value = false;
      if (resp is String) {
        if (resp == 'ok') {
          getData();
          // new
          GetTenantServiceRequestsController controller =
              Get.put(GetTenantServiceRequestsController());
          controller.getData();
          //old
          // Get.find<GetTenantServiceRequestsController>().getData();
          updatedReq = true;
          return true;
        } else
          Get.snackbar(
            AppMetaLabels().error,
            resp,
            backgroundColor: AppColors.white54,
          );
        return false;
      } else
        Get.snackbar(
          AppMetaLabels().error,
          AppMetaLabels().someThingWentWrong,
          backgroundColor: AppColors.white54,
        );
      return false;
    } catch (e) {
      cancellingRequest.value = false;
      rethrow;
    }
  }

  // void reopenRequest() async {
  //   reopeningSvcReq.value = true;
  //   var resp = await TenantRepository.reopenServiceRequest(
  //       tenantRequestDetails.value.detail.caseNo);
  //   reopeningSvcReq.value = false;
  //   if (resp is String) {
  //     if (resp == 'Ok') {
  //       getData();
  //       updatedReq = true;
  //     } else
  //       Get.snackbar(
  //         AppMetaLabels().error,
  //         resp,
  //         backgroundColor: AppColors.white54,
  //       );
  //   } else
  //     Get.snackbar(
  //       AppMetaLabels().error,
  //       AppMetaLabels().someThingWentWrong,
  //       backgroundColor: AppColors.white54,
  //     );
  // }

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
      gettingPhotos.value = true;
      print('File Path ::::: ===> ${file.path}');
      Uint8List photo = await file.readAsBytes();

      photo = await compressImage(photo);

      // checking file size EID
      print('Size of file ::: ${CheckFileExtenstion().getFileSize(photo)}');
      var size = CheckFileExtenstion().getFileSize(photo).split(' ')[0];
      var extension = CheckFileExtenstion().getFileSize(photo).split(' ')[1];
      if (extension.contains('MB')) {
        if (double.parse(size) > 10) {
          Get.snackbar(
            AppMetaLabels().error,
            AppMetaLabels().fileSizenError,
            duration: Duration(seconds: 5),
            backgroundColor: AppColors.redColor,
            colorText: AppColors.white54,
          );

          gettingPhotos.value = false;
          return;
        }
      }

      // we are commenting below lines because Editor change the extension 112233
      // final editedImage = await Get.to(() => ImageEditor(
      //       image: photo,
      //     ));
      // if (editedImage != null) photo = editedImage;
   
      // for testing
      await getFileSizeFromPath(file.path);

      String path = file.path;
      if (photo != null && await getStoragePermission()) {
        final newPath = await getTemporaryDirectory();
        final newFile = File("${newPath.path}/${file.path.split('/').last}");

        if (newFile != null) {
          await newFile.writeAsBytes(photo);
          path = newFile.path;
        }
        print('New Path:::::::::::::::: $path');
        photos[photos.length - 1] =
            PhotoFile(file: photo, path: path, type: file.mimeType);
        print(photos);
        uploadPhoto(photos.length - 1);
        photos.add(null);
      }
      gettingPhotos.value = false;
    }
  }

  getFileSizeFromPath(String filepath) async {
    var file = File(filepath);
    int bytes = await file.length();
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    print(
        'File Size getFileSizeFromPath ** :::::: ** ${((bytes / pow(1024, i)).toStringAsFixed(1)) + ' ' + suffixes[i]}');

    return ((bytes / pow(1024, i)).toStringAsFixed(1)) + ' ' + suffixes[i];
  }

  uploadPhoto(int index) async {
    photos[index].errorUploading = false;
    photos[index].uploading.value = true;
    try {
      var resp = await TenantRepository.uploadFile(
          tenantRequestDetails.value.detail.caseNo.toString(),
          photos[index].path,
          'Images',
          '',
          '0');
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
      gettingPhotos.value = true;
      photos.removeAt(index);
      gettingPhotos.value = false;
    } else {
      photos[index].errorRemoving = true;
      photos[index].removing.value = false;
    }
  }

  void downloadDoc(int index) async {
    photos[index].errorDownloading = false;
    photos[index].downloading.value = true;
    var resp = await TenantRepository.downloadDoc(
        tenantRequestDetails.value.detail.caseNo, 1, photos[index].id);
    photos[index].downloading.value = false;
    if (resp is Uint8List) {
      photos[index].file = resp;
    } else {
      photos[index].errorDownloading = true;
      photos[index].errorText = resp.toString();
    }
  }

  void showFile(PhotoFile file) async {
    if (file.path == null) {
      if (await getStoragePermission()) {
        String path = await saveFile(file);
        file.path = path;
      }
    }
    OpenFile.open(file.path);
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

  Future<String> saveFile(PhotoFile reqFile) async {
    final path = await getTemporaryDirectory();
    final file = File("${path.path}/${reqFile.id}${reqFile.type}");
    await file.writeAsBytes(reqFile.file);
    return file.path;
  }

  Future<bool> addFeedback(String desc) async {
    addingFeedback.value = true;
    var resp = await TenantRepository.saveTenantSRFeedback(
        tenantRequestDetails.value.detail.caseNo.toString(), desc, rating);
    addingFeedback.value = false;
    if (resp is TenantSaveFeedbackModel && resp.status == 'Ok') {
      // Get.snackbar(
      //   AppMetaLabels().success,
      //   AppMetaLabels().feedBackAddedSuccessFully,
      //   backgroundColor: AppColors.white54,
      // );
      SnakBarWidget.getSnackBarSuccess(
          AppMetaLabels().success, AppMetaLabels().feedBackAddedSuccessFully);
      feedback.value = TenantGetSrFeedback(
          feedback: Feedback(
              description: desc,
              rating: rating,
              caseNo: tenantRequestDetails.value.detail.caseNo));
      loadingData.value = true;
      tenantRequestDetails.value.statusInfo.canAddFeedback = false;
      loadingData.value = false;

      return true;
    } else {
      Get.snackbar(
        AppMetaLabels().error,
        resp,
        backgroundColor: AppColors.white54,
      );
      return false;
    }
  }

  void getFeedback() async {
    errorGettingFeedback = '';
    gettingFeedback.value = true;
    var resp = await TenantRepository.getTenantSRFeedback(
        tenantRequestDetails.value.detail.caseNo);
    gettingFeedback.value = false;
    if (resp is TenantGetSrFeedback) {
      feedback.value = resp;
    } else {
      errorGettingFeedback = resp;
    }
  }
}
