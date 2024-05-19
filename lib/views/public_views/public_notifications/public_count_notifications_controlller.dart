import 'package:fap_properties/data/models/public_models/public_notifications/public_count_notification_model.dart';
import 'package:fap_properties/data/repository/public_repository.dart';
import 'package:get/get.dart';

class PublicCountNotificationsController extends GetxController {
  var getCountNotifications = PublicCountNotificationModel().obs;
  var loading = false.obs;
  RxString error = "".obs;
  RxInt countN = 0.obs;

  void countNotifications() async {
    loading.value = true;
    var resp = await PublicRepositoryDrop2.countNotifications();

    if (resp is PublicCountNotificationModel) {
      if (resp.status == "Ok") countN.value = resp.notifications;
      print('Count :::::: =>   $countN');
      loading.value = false;
    } else {
      error.value = resp;
      loading.value = false;
    }
  }
}
