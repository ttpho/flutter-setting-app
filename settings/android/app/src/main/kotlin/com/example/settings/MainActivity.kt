package com.example.settings

import android.content.Intent
import android.net.Uri
import android.provider.Settings
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.lang.Exception

class MainActivity: FlutterActivity() {
    companion object {
        private const val APP_ID: String = "com.example"
        private const val FEATURE_NAME: String = "settings"
        private const val CHANNEL_NAME: String = "$APP_ID/$FEATURE_NAME"
        private const val METHOD_OPEN_APP_SETTING_SCREEN: String = "openAppSettingScreen"
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL_NAME).setMethodCallHandler {
                call, result ->
            if (call.method == METHOD_OPEN_APP_SETTING_SCREEN) {
                result.success(openSettingScreen())
                return@setMethodCallHandler
            }
        }
    }

    private fun openSettingScreen(): Boolean {
        val intentSetting = Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS).apply {
            data = Uri.fromParts("package", packageName, null)
        }
        return try {
            startActivity(intentSetting)
            true
        } catch (e: Exception) {
            false
        }
    }

}
