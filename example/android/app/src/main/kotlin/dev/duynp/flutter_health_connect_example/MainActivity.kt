package dev.duynp.flutter_health_connect_example

import android.content.Intent
import android.os.Bundle
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterFragmentActivity() {
    companion object {
        private const val CHANNEL = "app.channel.flutter.health.connect.show.privacy.policy"
        private const val FUNCTION = "checkIfShouldShowPrivacyPolicy"
    }

    private var shouldShowPrivacyPolicy: Boolean = false

    // If your application's android:launchMode is set to "standard" or "singleTop" in
    // your AndroidManifest then "onCreate" will be called when a user taps
    // the "privacy policy" button in Google Health's permision dialog.
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        handleIntent(intent)
    }

    // If your application's android:launchMode is set to "singleTask" or "singleInstance" or "singleInstancePerTask" in
    // your AndroidManifest then "onNewIntent" will be called when a user taps
    // the "privacy policy" button in Google Health's permision dialog.
    override fun onNewIntent(intent: Intent) {
        handleIntent(intent)
        super.onNewIntent(intent)
    }

    private fun handleIntent(intent: Intent) {
        val action = intent.action
        if (Intent.ACTION_VIEW_PERMISSION_USAGE == action || "androidx.health.ACTION_SHOW_PERMISSIONS_RATIONALE" == action) {
            shouldShowPrivacyPolicy = true
        }
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call: MethodCall, result: MethodChannel.Result ->
                if (call.method.contentEquals(FUNCTION)) {
                    result.success(shouldShowPrivacyPolicy)
                    shouldShowPrivacyPolicy = false
                }
            }
    }
}