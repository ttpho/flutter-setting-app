import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    let appID = "com.example"
    let featureName = "settings"
    let methodOpenAppSettingScreen = "openAppSettingScreen"
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        let channelName = "\(self.appID)/\(self.featureName)"
        
        let settingChannel = FlutterMethodChannel(name: channelName,
                                                  binaryMessenger: controller.binaryMessenger)
        settingChannel.setMethodCallHandler({
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            if (call.method == self.methodOpenAppSettingScreen) {
                result(self.openSettingScreen())
            }
            
        })
        
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    
    private func openSettingScreen() -> Bool {
        if let url = URL(string:UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10.0, *) {
                    do {
                        try  UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        return true
                    } catch {
                        return false
                    }
                    
                }
                return UIApplication.shared.openURL(url)
                
            }
        }
        
        return false
    }
}
