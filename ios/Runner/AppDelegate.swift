// import UIKit
// import Flutter

// @UIApplicationMain
// @objc class AppDelegate: FlutterAppDelegate {
//   override func application(
//     _ application: UIApplication,
//     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
//   ) -> Bool {
//     GeneratedPluginRegistrant.register(with: self)
//     return super.application(application, didFinishLaunchingWithOptions: launchOptions)
//   }
// }
// import UIKit
// import Flutter
// import GoogleMaps
// import Firebase
// import flutter_downloader

// @main
// @objc class AppDelegate: FlutterAppDelegate, MessagingDelegate {

//    @objc func registerPlugins(registry: FlutterPluginRegistry) {
//     if (!registry.hasPlugin("FlutterDownloaderPlugin")) {
//        FlutterDownloaderPlugin.register(with: registry.registrar(forPlugin: "FlutterDownloaderPlugin")!)
//     }
//   }

//   override func application(
//     _ application: UIApplication,
//     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
//   ) -> Bool {

//     FirebaseApp.configure()
//     Messaging.messaging().isAutoInitEnabled = true
//     GMSServices.provideAPIKey("AIzaSyA7oJh-zxTM2UPWlDtGd4P9uG3nOv4dF6w")
//     GeneratedPluginRegistrant.register(with: self)

//     if #available(iOS 10.0, *) {
//       UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
//     }
         
//     FlutterDownloaderPlugin.setPluginRegistrantCallback(registerPlugins)
//       return super.application(application, didFinishLaunchingWithOptions: launchOptions)
//       // Register for remote notifications
//         application.registerForRemoteNotifications()

//       // Configure Firebase Messaging
//        Messaging.messaging().delegate = self
//   }

//   override func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//     Messaging.messaging().apnsToken = deviceToken
//   }

//   func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
//       print("FCM Registration Token: \(fcmToken)")
//   }
// }


import UIKit
import Flutter
import GoogleMaps
import Firebase
import flutter_downloader
import FirebaseAuth

@main
@objc class AppDelegate: FlutterAppDelegate,MessagingDelegate {

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
        FirebaseApp.configure()
        application.registerForRemoteNotifications()
        Messaging.messaging().isAutoInitEnabled = true
        Messaging.messaging().delegate = self
        GMSServices.provideAPIKey("AIzaSyA7oJh-zxTM2UPWlDtGd4P9uG3nOv4dF6w")
        
      GeneratedPluginRegistrant.register(with: self)
          if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
          }
          FlutterDownloaderPlugin.setPluginRegistrantCallback(registerPlugins)
          return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  override func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    Messaging.messaging().apnsToken = deviceToken
    let firebaseAuth = Auth.auth()
    firebaseAuth.setAPNSToken(deviceToken, type: AuthAPNSTokenType.unknown)
  }
 override func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        let firebaseAuth = Auth.auth()
        if (firebaseAuth.canHandleNotification(userInfo)){
            print(userInfo)
            return
        }
    }
  func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
      print("FCM Registration Token: \(fcmToken)")
    }
  }
  private func registerPlugins(registry: FlutterPluginRegistry) {
    if (!registry.hasPlugin("FlutterDownloaderPlugin")) {
       FlutterDownloaderPlugin.register(with: registry.registrar(forPlugin: "FlutterDownloaderPlugin")!)
    }

}
// working version
// import UIKit
// import Flutter
// import GoogleMaps
// import Firebase
// import flutter_downloader

// @main
// @objc class AppDelegate: FlutterAppDelegate {
//   override func application(
//     _ application: UIApplication,
//     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
//   ) -> Bool {
//     GMSServices.provideAPIKey("AIzaSyA7oJh-zxTM2UPWlDtGd4P9uG3nOv4dF6w")
//       GeneratedPluginRegistrant.register(with: self)
//           if #available(iOS 10.0, *) {
//             UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
//           }
//           FlutterDownloaderPlugin.setPluginRegistrantCallback(registerPlugins)
//           return super.application(application, didFinishLaunchingWithOptions: launchOptions)
//   }
  
  
//   }
//   private func registerPlugins(registry: FlutterPluginRegistry) {
//     if (!registry.hasPlugin("FlutterDownloaderPlugin")) {
//        FlutterDownloaderPlugin.register(with: registry.registrar(forPlugin: "FlutterDownloaderPlugin")!)
//     }
// }
