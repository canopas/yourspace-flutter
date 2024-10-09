import UIKit
import FirebaseMessaging
import Flutter
import GoogleMaps
import flutter_background_service_ios
import CoreLocation

@main
@objc class AppDelegate: FlutterAppDelegate {

    var geofencePlugin: GeofenceService?
    var locationManager: CLLocationManager?
    var lastUpdateTime: Date?

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        UIDevice.current.isBatteryMonitoringEnabled = true
        
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self as UNUserNotificationCenterDelegate
        }

        setUpLocation()

        let key = Bundle.main.object(forInfoDictionaryKey: "ApiMapKey")
        GMSServices.provideAPIKey(key as! String)

        geofencePluginRegistration()

        GeneratedPluginRegistrant.register(with: self)
        setUpFlutterMethodChannelForInvokeLocation()
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func application(application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
}

// Geofence methods
extension AppDelegate {
    private func geofencePluginRegistration() {
        let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
        let geofenceChannel = FlutterMethodChannel(name: "geofence_plugin", binaryMessenger: controller.binaryMessenger)

        geofencePlugin = GeofenceService(channel: geofenceChannel)

        geofenceChannel.setMethodCallHandler { [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) in
            guard let self = self else { return }
            if call.method == "startMonitoring" {
                if let args = call.arguments as? [String: Any],
                   let lat  = args["latitude"] as? Double,
                   let lng = args["longitude"] as? Double,
                   let radius = args["radius"] as? Double,
                   let id = args["identifier"] as? String {
                    let center = CLLocationCoordinate2D(latitude: lat, longitude: lng)
                    self.geofencePlugin?.startMonitoring(center: center, radius: radius, identifier: id)
                    result(nil)
                }
            } else if call.method == "stopMonitoring" {
                if let args = call.arguments as? [String: Any],
                   let id = args["identifier"] as? String {
                    self.geofencePlugin?.stopMonitoring(identifier: id)
                    result(nil)
                }
            } else {
                result(FlutterMethodNotImplemented)
            }
        }
    }
}

// Location delegate methods
extension AppDelegate: CLLocationManagerDelegate {
    private func setUpLocation() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.distanceFilter = kCLDistanceFilterNone
        locationManager?.allowsBackgroundLocationUpdates = true
        locationManager?.pausesLocationUpdatesAutomatically = false
        locationManager?.startMonitoringSignificantLocationChanges()
    }
    
    private func setUpFlutterMethodChannelForInvokeLocation() {
        let controller = window?.rootViewController as! FlutterViewController
        let locationChannel = FlutterMethodChannel(name: "com.grouptrack/set_up_location", binaryMessenger: controller.binaryMessenger)
        
        locationChannel.setMethodCallHandler { [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) in
            guard let self = self else { return }
            if call.method == "setUpLocation" {
                self.setUpLocation()
                result(nil)
            } else {
                result(FlutterMethodNotImplemented)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.last else { return }
        
        let currentTime = Date()
        
        if let lastTime = lastUpdateTime {
            let timeInterval = currentTime.timeIntervalSince(lastTime)
            if timeInterval < 10 {
                return
            }
        }
        
        lastUpdateTime = currentTime
        
        let locationData: [String: Any] = [
            "latitude": currentLocation.coordinate.latitude,
            "longitude": currentLocation.coordinate.longitude,
            "timestamp": currentLocation.timestamp.timeIntervalSince1970 * 1000
        ]
        
        if let controller = window?.rootViewController as? FlutterViewController {
            let methodChannel = FlutterMethodChannel(name: "com.grouptrack/location", binaryMessenger: controller.binaryMessenger)
            methodChannel.invokeMethod("onLocationUpdate", arguments: locationData)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            locationManager?.startMonitoringSignificantLocationChanges()
        } else {
            locationManager?.stopUpdatingLocation()
        }
    }
}
