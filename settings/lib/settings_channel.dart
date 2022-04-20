import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class SettingChannel {
  static const String appID = "com.example";
  static const String featureName = "settings";
  static const String channelName = "$appID/$featureName";
  static const MethodChannel platform = MethodChannel(channelName);
  static const String methodOpenAppSettingScreen = "openAppSettingScreen";

  Future<bool> openAppSettingScreen() async {
    try {
      final bool result =
          await platform.invokeMethod(methodOpenAppSettingScreen);
      return result;
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return false;
    }
  }
}
