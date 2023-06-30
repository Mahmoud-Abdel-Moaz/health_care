import UIKit
import Flutter
import GoogleMaps
import FirebaseCore

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
   FirebaseApp.configure()
   GMSServices.provideAPIKey("AIzaSyCU97vb0CVV97TtavlB8k6JPon4ryqw3N0")
       if #available(iOS 10.0, *) {
         UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
       }
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}


