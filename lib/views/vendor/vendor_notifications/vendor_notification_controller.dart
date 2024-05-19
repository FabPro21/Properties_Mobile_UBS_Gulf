import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/models/vendor_models/vendor_notificaton/vendor_get_notification_model.dart'
    as notif;
import 'package:fap_properties/data/models/vendor_models/vendor_notificaton/vendor_notification_archived_model.dart';
import 'package:fap_properties/data/models/vendor_models/vendor_notificaton/vendor_notification_details_model.dart';
import 'package:fap_properties/data/models/vendor_models/vendor_notificaton/vendor_read_notification_model.dart';
import 'package:fap_properties/data/repository/vendor_repository.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:get/get.dart';

class VendorNotificationsController extends GetxController {
  var getNotifications = notif.VendorGetNotificationModel().obs;
  var unreadNotifications = notif.VendorGetNotificationModel().obs;
  var readNotificationsdata = VendorNotificationReadModel().obs;
  var archiveNotificationsdata = VendorNotificationArchivedModel().obs;
  var notificationsDetaildata = VendorNotificationDetailsModel().obs;

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

  List<notif.Notification> notifications;
  String pagaNoPAll = '1';
  getData(String pagaNoP) async {
    print(':::::::::: getData()');
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }
    try {
      error.value = '';
      noMoreDataPageAll.value = '';
      loadingData.value = true;
      var result =
          await VendorRepository.getNotificationsPagination('', pagaNoP);
      if (result is notif.VendorGetNotificationModel) {
        getNotifications.value = result;
        notifications = getNotifications.value.notifications;
        print('AFTER PARSE :::: ${getNotifications.value}');
        if (getNotifications.value.status == AppMetaLabels().notFound) {
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
  getData1(String pagaNoP) async {
    print(':::::::::: getData()');
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }
    try {
      noMoreDataPageAll.value = '';
      isLoadingAllNotification.value = true;
      var result =
          await VendorRepository.getNotificationsPagination('', pagaNoP);
      if (result is notif.VendorGetNotificationModel) {
        getNotifications.value = result;
        print('AFTER PARSE :::: ${getNotifications.value}');
        if (getNotifications.value.status == AppMetaLabels().notFound) {
          noMoreDataPageAll.value = AppMetaLabels().noDatafound;
          int pageSize = int.parse(pagaNoPAll);
          int naePageNo = pageSize - 1;
          pagaNoPAll = naePageNo.toString();
          isLoadingAllNotification.value = false;
        } else {
          for (int i = 0;
              i < getNotifications.value.notifications.length;
              i++) {
            notifications.add(getNotifications.value.notifications[i]);
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
          await VendorRepository.getNotificationsPagination('Unread', pagaNoP);
      unreadNotificationsLoading.value = false;
      if (result is notif.VendorGetNotificationModel) {
        unreadNotifications.value = result;
        notificationsUnRead = unreadNotifications.value.notifications;
        if (unreadNotifications.value.status == AppMetaLabels().notFound) {
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
  unReadNotifications1(String pagaNoP) async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }
    try {
      noMoreDataUnRead.value = '';
      isLoadingUnReadNotification.value = true;
      var result =
          await VendorRepository.getNotificationsPagination('Unread', pagaNoP);
      isLoadingUnReadNotification.value = false;
      if (result is notif.VendorGetNotificationModel) {
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
      isLoadingUnReadNotification.value = false;
      int pageSize = int.parse(pagaNoPURead);
      int naePageNo = pageSize - 1;
      pagaNoPURead = naePageNo.toString();
      print("this is the error from controller= $e");
    }
  }

  Future<bool> readNotifications(int index) async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }
    try {
      loadingReadData.value = true;
      var result = await VendorRepository.getReadNotification();
      if (result is VendorNotificationReadModel) {
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
      print("this is the error from controller= $e");
      return false;
    }
  }

  Future<bool> archiveNotifications() async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }
    try {
      loadingArchiveData.value = true;
      var result = await VendorRepository.getArchiveNotification();
      if (result is VendorNotificationArchivedModel) {
        archiveNotificationsdata.value = result;
        if (archiveNotificationsdata.value.status == AppMetaLabels().notFound) {
          error.value = AppMetaLabels().noDatafound;
          loadingArchiveData.value = false;
          return false;
        } else {
          loadingArchiveData.value = false;
          return true;
        }
      } else {
        error.value = AppMetaLabels().noDatafound;
        loadingArchiveData.value = false;
        return false;
      }
    } catch (e) {
      loadingArchiveData.value = false;
      print("this is the error from controller= $e");
      return false;
    }
  }

  Future<void> notificationsDetails() async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }
    try {
      loadingnotificationsDetail.value = true;
      var result = await VendorRepository.getNotificationDetails();
      if (result is VendorNotificationDetailsModel) {
        print('======? ${notificationsDetaildata.value.status} ======== ?');
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
      // if (result is VendorNotificationDetailsModel) {
      //   print('======? ${notificationsDetaildata.value.status} ======== ?');
      //   if (notificationsDetaildata.value.status == AppMetaLabels().notFound) {
      //     error.value = AppMetaLabels().noDatafound;
      //     loadingnotificationsDetail.value = false;
      //   } else {
      //     notificationsDetaildata.value = result;
      //     loadingnotificationsDetail.value = false;
      //   }
      // } else {
      //   error.value = AppMetaLabels().noDatafound;
      //   loadingnotificationsDetail.value = false;
      // }
    } catch (e) {
      loadingnotificationsDetail.value = false;
      print("this is the error from controller= $e");
    }
  }
}
