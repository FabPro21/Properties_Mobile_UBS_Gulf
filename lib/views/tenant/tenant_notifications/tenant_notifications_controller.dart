import 'dart:io';
import 'dart:typed_data';

import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/tenant_models/tenant_notifications_model/get_tenant_notifications_model.dart'
    as notif;
import 'package:fap_properties/data/models/tenant_models/tenant_notifications_model/tenant_archive_notifications_model.dart';
import 'package:fap_properties/data/models/tenant_models/tenant_notifications_model/tenant_notifications_detail_model.dart';
import 'package:fap_properties/data/models/tenant_models/tenant_notifications_model/tenant_read_notifications_model.dart';
import 'package:fap_properties/data/repository/tenant_repository.dart';
import 'package:fap_properties/utils/checkbox_controller.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../data/models/tenant_models/tenant_notifications_model/notification_files.dart';
import '../../../utils/styles/colors.dart';

import 'package:path_provider/path_provider.dart';

class GetTenantNotificationsController extends GetxController {
  var getNotifications = notif.GetTenantNotificationsModel().obs;
  var unreadNotifications = notif.GetTenantNotificationsModel().obs;
  var readNotificationsModel = TenantReadNotificationsModel().obs;
  var archiveNotificationsModel = TenantArchiveNotificationsModel().obs;
  var notificationsDetailModel = TenantNotificationsDetailModel().obs;

  var loadingData = false.obs;

  var unreadNotificationsLoading = false.obs;
  var loadingReadData = false.obs;
  var loadingArchiveData = true.obs;
  var loadingnotificationsDetail = true.obs;
  int allLength = 0;
  int unreadLength = 0;
  RxString error = "".obs;
  RxString errorUnread = "".obs;
  RxBool editTap = false.obs;
  RxBool markasRead = false.obs;
  CheckBoxController allCheckbox = CheckBoxController();
  CheckBoxController unreadCheckbox = CheckBoxController();
  RxInt currentIndex = 0.obs;

  int pageNo = 1;
  int pageSize = 2;
  int recordCount = 0;

  List<notif.Notification>? notifications;
  String pagaNoPAll = '1';
  getData(String pagaNoP) async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }
    try {
      error.value = '';
      noMoreDataPageAll.value = '';
      loadingData.value = true;
      var result =
          await TenantRepository.getNotificationsPagination('', pagaNoP);
      loadingData.value = false;
      if (result is notif.GetTenantNotificationsModel) {
        getNotifications.value = result;
        notifications = getNotifications.value.notifications!;
        if (getNotifications.value.status == AppMetaLabels().notFound) {
          error.value = AppMetaLabels().noDatafound;
          loadingData.value = false;
        } else {
          allLength = notifications!.length;
          allCheckbox.marked = List<RxBool>.filled(allLength, false.obs);
          loadingData.value = false;
        }
      } else {
        error.value = AppMetaLabels().noDatafound;
        loadingData.value = false;
      }
    } catch (e) {
      loadingData.value = false;
      print("this is the error from controller= $e");
    }
  }

  RxBool isLoadingAllNotification = false.obs;
  RxString noMoreDataPageAll = "".obs;
  getData1(String pagaNoP) async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }
    try {
      noMoreDataPageAll.value = '';
      isLoadingAllNotification.value = true;
      var result =
          await TenantRepository.getNotificationsPagination('', pagaNoP);
      if (result is notif.GetTenantNotificationsModel) {
        getNotifications.value = result;
        if (getNotifications.value.status == AppMetaLabels().notFound) {
          noMoreDataPageAll.value = AppMetaLabels().noDatafound;
          int pageSize = int.parse(pagaNoPAll);
          int naePageNo = pageSize - 1;
          pagaNoPAll = naePageNo.toString();
          isLoadingAllNotification.value = false;
        } else {
          for (int i = 0;
              i < getNotifications.value.notifications!.length;
              i++) {
            notifications!.add(getNotifications.value.notifications![i]);
          }
          allLength = notifications!.length;
          allCheckbox.marked = List<RxBool>.filled(allLength, false.obs);
          isLoadingAllNotification.value = false;
        }
      } else {
        noMoreDataPageAll.value = AppMetaLabels().noDatafound;
        int pageSize = int.parse(pagaNoPAll);
        int naePageNo = pageSize - 1;
        pagaNoPAll = naePageNo.toString();
        isLoadingAllNotification.value = false;
      }
    } catch (e) {
      int pageSize = int.parse(pagaNoPAll);
      int naePageNo = pageSize - 1;
      pagaNoPAll = naePageNo.toString();
      isLoadingAllNotification.value = false;
      print("this is the error from controller= $e");
    }
  }

  String pagaNoPURead = '1';
  List<notif.Notification>? notificationsUnRead;
  unReadNotifications(String pagaNoP) async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }
    try {
      errorUnread.value = '';
      noMoreDataUnRead.value = '';
      unreadNotificationsLoading.value = true;
      var result =
          await TenantRepository.getNotificationsPagination('Unread', pagaNoP);
      unreadNotificationsLoading.value = false;
      if (result is notif.GetTenantNotificationsModel) {
        unreadNotifications.value = result;
        notificationsUnRead = unreadNotifications.value.notifications!;
        if (unreadNotifications.value.status == AppMetaLabels().notFound) {
          errorUnread.value = AppMetaLabels().noDatafound;
          unreadNotificationsLoading.value = false;
        } else {
          unreadLength = notificationsUnRead!.length;
          unreadCheckbox.marked = List<RxBool>.filled(unreadLength, false.obs);
          unreadNotificationsLoading.value = false;
        }
      } else {
        errorUnread.value = AppMetaLabels().noDatafound;
        unreadNotificationsLoading.value = false;
      }
    } catch (e) {
      loadingData.value = false;

      print("this is the error from controller= $e");
    }
  }

  RxBool isLoadingUnReadNotification = false.obs;
  RxString noMoreDataUnRead = "".obs;
  unReadNotifications1(String pagaNoP) async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }
    try {
      noMoreDataUnRead.value = '';
      isLoadingUnReadNotification.value = true;
      var result =
          await TenantRepository.getNotificationsPagination('Unread', pagaNoP);
      isLoadingUnReadNotification.value = false;
      if (result is notif.GetTenantNotificationsModel) {
        unreadNotifications.value = result;
        if (unreadNotifications.value.status == AppMetaLabels().notFound) {
          noMoreDataUnRead.value = AppMetaLabels().noDatafound;
          int pageSize = int.parse(pagaNoPURead);
          int naePageNo = pageSize - 1;
          pagaNoPURead = naePageNo.toString();
          isLoadingUnReadNotification.value = false;
        } else {
          for (int i = 0;
              i < unreadNotifications.value.notifications!.length;
              i++) {
            notificationsUnRead!
                .add(unreadNotifications.value.notifications![i]);
          }
          unreadLength = notificationsUnRead!.length;
          unreadCheckbox.marked = List<RxBool>.filled(unreadLength, false.obs);
          isLoadingUnReadNotification.value = false;
        }
      } else {
        noMoreDataUnRead.value = AppMetaLabels().noDatafound;
        isLoadingUnReadNotification.value = false;
      }
    } catch (e) {
      int pageSize = int.parse(pagaNoPURead);
      int naePageNo = pageSize - 1;
      pagaNoPURead = naePageNo.toString();
      isLoadingUnReadNotification.value = false;
      print("this is the error from controller= $e");
    }
  }

  Future<bool> readNotifications(int index, String list) async {
    if (!loadingReadData.value) {
      bool _isInternetConnected = await BaseClientClass.isInternetConnected();
      if (!_isInternetConnected) {
        await Get.to(NoInternetScreen());
      }
      try {
        loadingReadData.value = true;
        var result = await TenantRepository.readNotification();
        loadingReadData.value = false;
        if (result is TenantReadNotificationsModel) {
          readNotificationsModel.value = result;
          print('Read Notification Model::::: ${readNotificationsModel.value}');
          if (readNotificationsModel.value.status == AppMetaLabels().notFound) {
            error.value = AppMetaLabels().noDatafound;
            loadingReadData.value = false;
          } else {
            if (list == 'all') {
              loadingData.value = true;
              notifications![index].isRead = true;
              loadingData.value = false;
            } else if (list == 'unread') {
              // notificationsUnRead![index].isRead = true;
              unreadNotificationsLoading.value = true;
              // notificationsUnRead!.removeAt(index);
              unreadNotificationsLoading.value = false;
              loadingReadData.value = false;
              update();
              return true;
            }
          }
          loadingData.value = false;
          print(' loadingData.value::::: ${loadingData.value}');
        } else {
          loadingReadData.value = false;
          error.value = AppMetaLabels().noDatafound;
          return false;
        }
      } catch (e) {
        loadingReadData.value = false;
        print("this is the error from controller= $e");
        return false;
      }
    }
    return false;
  }
  // Future<void> readNotifications(int index, String list) async {
  //   if (!loadingReadData.value) {
  //     bool _isInternetConnected = await BaseClientClass.isInternetConnected();
  //     if (!_isInternetConnected) {
  //       await Get.to(NoInternetScreen());
  //     }
  //     try {
  //       loadingReadData.value = true;
  //       var result = await TenantRepository.readNotification();
  //       loadingReadData.value = false;
  //       if (result is TenantReadNotificationsModel) {
  //         readNotificationsModel.value = result;
  //         print('Read Notification Model::::: ${readNotificationsModel.value}');
  //         if (readNotificationsModel.value.status == AppMetaLabels().notFound) {
  //           error.value = AppMetaLabels().noDatafound;
  //           loadingReadData.value = false;
  //         } else {
  //           if (list == 'all') {
  //             loadingData.value = true;
  //             notifications![index].isRead = true;
  //             loadingData.value = false;
  //           } else if (list == 'unread') {
  //             notificationsUnRead![index].isRead = true;
  //             unreadNotificationsLoading.value = true;
  //             notificationsUnRead!.removeAt(index);
  //             unreadNotificationsLoading.value = false;
  //             loadingReadData.value = false;
  //             update();
  //           }
  //         }
  //         loadingData.value = false;
  //         print(' loadingData.value::::: ${loadingData.value}');
  //       } else {
  //         loadingReadData.value = false;
  //         error.value = AppMetaLabels().noDatafound;
  //       }
  //     } catch (e) {
  //       loadingReadData.value = false;
  //       print("this is the error from controller= $e");
  //     }
  //   }
  // }

  Future<void> archiveNotifications() async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }
    try {
      loadingArchiveData.value = true;
      var result = await TenantRepository.archiveNotification();
      if (result is TenantArchiveNotificationsModel) {
        archiveNotificationsModel.value = result;
        if (archiveNotificationsModel.value.status ==
            AppMetaLabels().notFound) {
          error.value = AppMetaLabels().noDatafound;
          loadingArchiveData.value = false;
        } else {
          loadingArchiveData.value = false;
        }
      } else {
        error.value = AppMetaLabels().noDatafound;
        loadingArchiveData.value = false;
      }
    } catch (e) {
      loadingArchiveData.value = false;
      print("this is the error from controller= $e");
    }
  }

  Future<void> notificationsDetails() async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }
    try {
      error.value = '';
      loadingnotificationsDetail.value = true;
      var result = await TenantRepository.notificationDetails();
      if (result is TenantNotificationsDetailModel) {
        notificationsDetailModel.value = result;
        if (notificationsDetailModel.value.status == AppMetaLabels().notFound) {
          error.value = AppMetaLabels().noDatafound;
          loadingnotificationsDetail.value = false;
        } else {
          getFiles(result.notification!.notificationId ?? 0);
          loadingnotificationsDetail.value = false;
        }
      } else {
        error.value = AppMetaLabels().noDatafound;
        loadingnotificationsDetail.value = false;
      }
    } catch (e) {
      loadingnotificationsDetail.value = false;
      print("this is the error from controller= $e");
    }
  }

  //////////////////////get notification files////////

  NotificationFiles? files;
  RxBool loadingFiles = false.obs;

  void getFiles(int id) async {
    loadingFiles.value = true;
    var resp = await TenantRepository.getNotificationFiles(id);
    loadingFiles.value = false;
    if (resp is NotificationFiles) {
      files = resp;
    }
  }

  ///////////////////download file////////////

  void downloadFile(int index) async {
    files!.record![index].downloading!.value = true;
    var result = await TenantRepository.downloadNotificationFiles(
        files!.record![index].fileId ?? 0);

    files!.record![index].downloading!.value = false;
    if (result is Uint8List) {
      // ###1 permission
      // if (await getStoragePermission()) {
      String path =
          await createFile(result, files!.record![index].fileName ?? "");
      try {
        OpenFile.open(path);
      } catch (e) {
        print(e);
        Get.snackbar(
          AppMetaLabels().error,
          e.toString(),
          backgroundColor: AppColors.white54,
        );
        // }
      }
    } else {
      Get.snackbar(
        AppMetaLabels().error,
        AppMetaLabels().noFileReceived,
        backgroundColor: AppColors.white54,
      );
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

  Future<String> createFile(Uint8List data, String fileName) async {
    final output = await getTemporaryDirectory();
    final file = File("${output.path}/$fileName");
    await file.writeAsBytes(data.buffer.asUint8List());
    return "${output.path}/$fileName";
  }
}
