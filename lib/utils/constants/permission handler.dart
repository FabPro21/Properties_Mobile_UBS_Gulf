import 'package:permission_handler/permission_handler.dart';

class PermisionHandlerClasee {
  Future<bool> requestPermission() async {
    var status = await Permission.storage.status;
    if (status.isGranted) {
      // Permission granted, proceed with accessing external storage
      print('Permission granted for storage');
      await openAppSettings();
      // Your code to access external storage here
      return true;
    } else if (status.isDenied) {
      // Permission denied
      print('Permission denied for storage');
      await openAppSettings();
      // Optionally, show an alert dialog explaining why permission is needed and how to grant it
      return false;
    } else if (status.isPermanentlyDenied) {
      // Permission permanently denied, navigate to app settings
      print('Permission permanently denied for storage');
      await openAppSettings();
      return true; // Opens app settings for the user to enable the permission manually
    } else {
      return false;
    }
  }

  
}
