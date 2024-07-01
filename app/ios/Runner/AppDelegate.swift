import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
//     GMSServices.provideAPIKey(getMapKey())
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

//   func getMapKey() -> String {
//   let mapApiKey = Bundle.main.object(forInfoDictionaryKey: "MapApiKey") as? String
//   return mapApiKey ?? ""
//   }
}
