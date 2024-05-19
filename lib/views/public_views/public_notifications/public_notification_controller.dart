import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/public_models/public_notifications/public_archived_notifications_model.dart';
import 'package:fap_properties/data/models/public_models/public_notifications/public_get_notifications_model.dart'
    as notif;
import 'package:fap_properties/data/models/public_models/public_notifications/public_notification_details_model.dart';
import 'package:fap_properties/data/models/public_models/public_notifications/public_read_notifications_model.dart';
import 'package:fap_properties/data/repository/public_repository.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:get/get.dart';

class PublicNotificationsController extends GetxController {
  var getNotificationsdata = notif.PublicGetNotificationModel().obs;
  var notificationsDetaildata = PublicNotificationDetailsModel().obs;
  var unreadNotifications = notif.PublicGetNotificationModel().obs;
  var readNotificationsdata = PublicReadNotificationModel().obs;
  var archiveNotificationsdata = PublicArchivedNotificationModel().obs;

  var loadingData = false.obs;
  var unreadNotificationsLoading = false.obs;
  var loadingReadData = true.obs;
  var loadingArchiveData = true.obs;
  var loadingnotificationsDetail = true.obs;
  int allLength = 0;
  int unreadLength = 0;
  RxString error = "".obs;
  RxString errorUnread = "".obs;
  RxBool editTap = false.obs;
  RxBool markasRead = false.obs;
  List<bool> isChecked;
  RxInt currentIndex = 0.obs;

  int pageNo = 1;
  int pageSize = 2;
  int recordCount = 0;

  @override
  void onInit() {
    // getData();
    super.onInit();
  }

  List<notif.Notification> notifications;
  String pagaNoPAll = '1';
  getNotifications(String pageNo) async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }
    try {
      error.value = '';
      noMoreDataPageAll.value = '';
      loadingData.value = true;
      var result = await PublicRepositoryDrop2.publicGetNotificationPagination(
          '', pageNo);
      if (result is notif.PublicGetNotificationModel) {
        getNotificationsdata.value = result;
        notifications = getNotificationsdata.value.notifications;
        if (getNotificationsdata.value.status == AppMetaLabels().notFound) {
          error.value = AppMetaLabels().noDatafound;
          loadingData.value = false;
        } else {
          allLength = notifications.length;
          isChecked = List<bool>.filled(allLength, false);
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
  getNotifications1(String pageNo) async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }
    try {
      noMoreDataPageAll.value = '';
      isLoadingAllNotification.value = true;
      var result = await PublicRepositoryDrop2.publicGetNotificationPagination(
          '', pageNo);
      if (result is notif.PublicGetNotificationModel) {
        getNotificationsdata.value = result;
        if (getNotificationsdata.value.status == AppMetaLabels().notFound) {
          noMoreDataPageAll.value = AppMetaLabels().noDatafound;
          int pageSize = int.parse(pagaNoPAll);
          int naePageNo = pageSize - 1;
          pagaNoPAll = naePageNo.toString();
          isLoadingAllNotification.value = false;
        } else {
          for (int i = 0;
              i < getNotificationsdata.value.notifications.length;
              i++) {
            notifications.add(getNotificationsdata.value.notifications[i]);
          }
          allLength = notifications.length;
          isChecked = List<bool>.filled(allLength, false);
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
      isLoadingAllNotification.value = false;
      int pageSize = int.parse(pagaNoPAll);
      int naePageNo = pageSize - 1;
      pagaNoPAll = naePageNo.toString();
      print("this is the error from controller= $e");
    }
  }

  String pagaNoPURead = '1';
  List<notif.Notification> notificationsUnRead;
  unReadNotifications(String pageNo) async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }
    try {
      errorUnread.value = '';
      noMoreDataUnRead.value = '';
      unreadNotificationsLoading.value = true;
      var result = await PublicRepositoryDrop2.publicGetNotificationPagination(
          "Unread", pageNo);
      unreadNotificationsLoading.value = false;
      if (result is notif.PublicGetNotificationModel) {
        unreadNotifications.value = result;
        notificationsUnRead = unreadNotifications.value.notifications;
        if (unreadNotifications.value.status == AppMetaLabels().notFound || unreadNotifications.value.statusCode.toString()=='404') {
          errorUnread.value = AppMetaLabels().noDatafound;
          unreadNotificationsLoading.value = false;
        } else {
          unreadLength = notificationsUnRead.length;
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
  unReadNotifications1(String pageNo) async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }
    try {
      noMoreDataUnRead.value = '';
      isLoadingUnReadNotification.value = true;
      var result = await PublicRepositoryDrop2.publicGetNotificationPagination(
          "Unread", pageNo);
      isLoadingUnReadNotification.value = false;
      if (result is notif.PublicGetNotificationModel) {
        unreadNotifications.value = result;
        if (unreadNotifications.value.status == AppMetaLabels().notFound) {
          noMoreDataUnRead.value = AppMetaLabels().noDatafound;
          int pageSize = int.parse(pagaNoPURead);
          int naePageNo = pageSize - 1;
          pagaNoPURead = naePageNo.toString();
          isLoadingUnReadNotification.value = false;
        } else {
          for (int i = 0;
              i < unreadNotifications.value.notifications.length;
              i++) {
            notificationsUnRead.add(unreadNotifications.value.notifications[i]);
          }
          unreadLength = notificationsUnRead.length;
          isLoadingUnReadNotification.value = false;
        }
      } else {
        noMoreDataUnRead.value = AppMetaLabels().noDatafound;
        int pageSize = int.parse(pagaNoPURead);
        int naePageNo = pageSize - 1;
        pagaNoPURead = naePageNo.toString();
        isLoadingUnReadNotification.value = false;
      }
    } catch (e) {
      loadingData.value = false;
      int pageSize = int.parse(pagaNoPURead);
      int naePageNo = pageSize - 1;
      pagaNoPURead = naePageNo.toString();
      isLoadingUnReadNotification.value = false;
      print("this is the error from controller= $e");
    }
  }

  Future<bool> readNotifications() async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }
    try {
      loadingReadData.value = true;
      var result = await PublicRepositoryDrop2.readNotifications();
      if (result is PublicReadNotificationModel) {
        readNotificationsdata.value = result;
        if (readNotificationsdata.value.status == AppMetaLabels().notFound) {
          error.value = AppMetaLabels().noDatafound;
          loadingReadData.value = false;
          return false;
        } else {
          loadingReadData.value = false;
          return true;
        }
      } else {
        error.value = AppMetaLabels().noDatafound;
        loadingReadData.value = false;
        return false;
      }
    } catch (e) {
      loadingReadData.value = false;
      return false;
    }
  }

  Future<void> archiveNotifications() async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }
    try {
      loadingArchiveData.value = true;
      var result = await PublicRepositoryDrop2.archivedNotifications();
      if (result is PublicArchivedNotificationModel) {
        archiveNotificationsdata.value = result;
        if (archiveNotificationsdata.value.status == AppMetaLabels().notFound) {
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
    }
  }

  Future<void> notificationsDetails() async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }
    try {
      loadingnotificationsDetail.value = true;
      var result = await PublicRepositoryDrop2.publicNotificationDetails();
      if (result is PublicNotificationDetailsModel) {
        if (notificationsDetaildata.value.status == AppMetaLabels().notFound) {
          error.value = AppMetaLabels().noDatafound;
          loadingnotificationsDetail.value = false;
        } else {
          notificationsDetaildata.value = result;
          loadingnotificationsDetail.value = false;
        }
      } else {
        error.value = AppMetaLabels().noDatafound;
        loadingnotificationsDetail.value = false;
      }
    } catch (e) {
      loadingnotificationsDetail.value = false;
    }
  }
}
