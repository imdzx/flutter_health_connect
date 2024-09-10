# Flutter Health Connect
[![pub package](https://img.shields.io/badge/1.2.3-flutter__health__connect-blue)](https://pub.dev/packages/flutter_health_connect)

Flutter plugin for Google Health Connect integration. Health Connect gives you a simple way to store and connect the data between your health and fitness apps.


## Requirements

NOTE: This plugin only works for Google Health on Android, and will not interact with Apple Health on iOS.

- minSdkVersion: `26` (Recommend 28)
- compileSdkVersion: `34`
- This package requires Flutter `2.5.0` or higher.

## Setup

**For all the following steps you can look at the example app code for reference.**

### Jackson
Add the following line to the end of your "android/gradle.properties" file:
```android.jetifier.ignorelist = jackson-core, jackson-databind, jackson-datatype-jsr310, fastdoubleparser```

### Configure Intents to handle the permissions dialog
To interact with Health Connect within the app, declare the Health Connect package name in your `AndroidManifest.xml` file:
```xml
<!-- Check whether Health Connect is installed or not -->
<queries>
    <package android:name="com.google.android.apps.healthdata" />
</queries>
```

Inside your MainActivity declaration add a reference to `health_permissions` and an intent filter for the Health Connect permissions action
```xml
<activity android:name=".MainActivity">
    <meta-data android:name="health_permissions" android:resource="@array/health_permissions" />

    <intent-filter>
        <action android:name="androidx.health.ACTION_SHOW_PERMISSIONS_RATIONALE" />
    </intent-filter>
</activity>
```

In the Health Connect permissions activity there is a link to your privacy policy. You need to grant the Health Connect app access in order to link back to your privacy policy. In the example below, you should either replace `.MainActivity` with an activity that presents the privacy policy or have the Main Activity route the user to the policy. This step may be required to pass Google app review when requesting access to sensitive permissions.

```xml
<activity-alias
     android:name="ViewPermissionUsageActivity"
     android:exported="true"
     android:targetActivity=".MainActivity"
     android:permission="android.permission.START_VIEW_PERMISSION_USAGE">
        <intent-filter>
            <action android:name="android.intent.action.VIEW_PERMISSION_USAGE" />
            <category android:name="android.intent.category.HEALTH_PERMISSIONS" />
        </intent-filter>
</activity-alias>
```

### Listen to Intents to show your Privacy Policy

*NOTE 1:* The following is derived from the Flutter doc here:
https://docs.flutter.dev/get-started/flutter-for/android-devs#how-do-i-handle-incoming-intents-from-external-applications-in-flutter

*NOTE 2:* If you have a MainActivity.java instead of a MainActivity.kt then you need to adapt the code under from kotlin to java. This should be easy to do by following the instructions in NOTE 1, since they are using java.

When a user taps the "privacy policy" button in the permission activity you need to intercept the intent and show the privacy policy from within Flutter.
This can be done in 2 steps:

#### Step 1
Change or update your MainActivity.kt file to:

```kotlin
package <your_app_package_name>

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
```

#### Step 2
*NOTE:* Depending on how your AndroidManifest is setup you will either handle this with a StatefulWidget in the `initState` method, 
or you will handle it after calling `HealthConnectFactory.requestPermissions`.
You technically only need one of the 2, but there is no harm implementing both either.


Create a Flutter widget like so to read the intent result:
```dart

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  /// NOTE: [_checkIfShouldShowPrivacyPolicyChannel] needs to match the CHANNEL name defined in Step 1.
  static const String _checkIfShouldShowPrivacyPolicyChannel = 'app.channel.flutter.health.connect.show.privacy.policy';
   /// NOTE: [_checkIfShouldShowPrivacyPolicyFunction] needs to match the FUNCTION name defined in Step 1.
  static const String _checkIfShouldShowPrivacyPolicyFunction = 'checkIfShouldShowPrivacyPolicy';
  static const MethodChannel platform = MethodChannel(_checkIfShouldShowPrivacyPolicyChannel);

  Future<bool> _checkIfShouldShowPrivacyPolicy() async =>
      await platform.invokeMethod(_checkIfShouldShowPrivacyPolicyFunction) as bool;

  void initState() {
    super.initState();

    /// If your application's android:launchMode is set to "standard" or "singleTop" in your AndroidManifest then initState
    /// will be called when the user taps the "privacy policy" in Google Health's permission dialog.
    /// If it is instead set to "singleTask" or "singleInstance" or "singleInstancePerTask" then initState will NOT be called.
    /// See [_onRequestPermissionsButtonTap] for more info.
    _checkIfShouldShowPrivacyPolicy().then(
      (shouldShowPrivacyPolicy) {
        if (shouldShowPrivacyPolicy) {
          /// The user asked to see your privacy policy.
        }
      },
    );
  }

 void _onRequestPermissionsButtonTap() async {
      final bool hasPermissions = await HealthConnectFactory.requestPermissions(
        [HealthConnectDataType.Steps],
      );

      /// If your application's android:launchMode is set to "singleTask" or "singleInstance" or
      /// "singleInstancePerTask" in your AndroidManifest then the app will continue executing the code
      /// from here when the user taps the "privacy policy" button in Google Health's permission dialog.
      /// If it is instead set to "standard" or "singleTop" then the code under will NOT be called, and initState
      /// will be called instead.
      final bool shouldShowPrivacyPolicy = await _checkIfShouldShowPrivacyPolicy();
      if (shouldShowPrivacyPolicy) {
        /// The user asked to see your privacy policy.
      }
  }


  @override
  Widget build(BuildContext context)...
}
```


Every data type your app reads or writes needs to be declared using a permission in your manifest. For the full list of permissions and their corresponding data types, see [List of data types](https://developer.android.com/guide/health-and-fitness/health-connect/data-and-data-types/data-types).

To create the declaration, add to regular permissions any of:
```xml
<uses-permission android:name="android.permission.health.READ_ACTIVE_CALORIES_BURNED"/>
<uses-permission android:name="android.permission.health.WRITE_ACTIVE_CALORIES_BURNED"/>
<uses-permission android:name="android.permission.health.READ_BASAL_BODY_TEMPERATURE"/>
<uses-permission android:name="android.permission.health.WRITE_BASAL_BODY_TEMPERATURE"/>
<uses-permission android:name="android.permission.health.READ_BASAL_METABOLIC_RATE"/>
<uses-permission android:name="android.permission.health.WRITE_BASAL_METABOLIC_RATE"/>
<uses-permission android:name="android.permission.health.READ_BLOOD_GLUCOSE"/>
<uses-permission android:name="android.permission.health.WRITE_BLOOD_GLUCOSE"/>
<uses-permission android:name="android.permission.health.READ_BLOOD_PRESSURE"/>
<uses-permission android:name="android.permission.health.WRITE_BLOOD_PRESSURE"/>
<uses-permission android:name="android.permission.health.READ_BODY_FAT"/>
<uses-permission android:name="android.permission.health.WRITE_BODY_FAT"/>
<uses-permission android:name="android.permission.health.READ_BODY_TEMPERATURE"/>
<uses-permission android:name="android.permission.health.WRITE_BODY_TEMPERATURE"/>
<uses-permission android:name="android.permission.health.READ_BODY_WATER_MASS"/>
<uses-permission android:name="android.permission.health.WRITE_BODY_WATER_MASS"/>
<uses-permission android:name="android.permission.health.READ_BONE_MASS"/>
<uses-permission android:name="android.permission.health.WRITE_BONE_MASS"/>
<uses-permission android:name="android.permission.health.READ_CERVICAL_MUCUS"/>
<uses-permission android:name="android.permission.health.WRITE_CERVICAL_MUCUS"/>
<uses-permission android:name="android.permission.health.READ_EXERCISE"/>
<uses-permission android:name="android.permission.health.WRITE_EXERCISE"/>
<uses-permission android:name="android.permission.health.READ_DISTANCE"/>
<uses-permission android:name="android.permission.health.WRITE_DISTANCE"/>
<uses-permission android:name="android.permission.health.READ_ELEVATION_GAINED"/>
<uses-permission android:name="android.permission.health.WRITE_ELEVATION_GAINED"/>
<uses-permission android:name="android.permission.health.READ_FLOORS_CLIMBED"/>
<uses-permission android:name="android.permission.health.WRITE_FLOORS_CLIMBED"/>
<uses-permission android:name="android.permission.health.READ_HEART_RATE"/>
<uses-permission android:name="android.permission.health.WRITE_HEART_RATE"/>
<uses-permission android:name="android.permission.health.READ_HEART_RATE_VARIABILITY"/>
<uses-permission android:name="android.permission.health.WRITE_HEART_RATE_VARIABILITY"/>
<uses-permission android:name="android.permission.health.READ_HEIGHT"/>
<uses-permission android:name="android.permission.health.WRITE_HEIGHT"/>
<uses-permission android:name="android.permission.health.READ_HYDRATION"/>
<uses-permission android:name="android.permission.health.WRITE_HYDRATION"/>
<uses-permission android:name="android.permission.health.READ_INTERMENSTRUAL_BLEEDING"/>
<uses-permission android:name="android.permission.health.WRITE_INTERMENSTRUAL_BLEEDING"/>
<uses-permission android:name="android.permission.health.READ_LEAN_BODY_MASS"/>
<uses-permission android:name="android.permission.health.WRITE_LEAN_BODY_MASS"/>
<uses-permission android:name="android.permission.health.READ_MENSTRUATION"/>
<uses-permission android:name="android.permission.health.WRITE_MENSTRUATION"/>
<uses-permission android:name="android.permission.health.READ_NUTRITION"/>
<uses-permission android:name="android.permission.health.WRITE_NUTRITION"/>
<uses-permission android:name="android.permission.health.READ_OVULATION_TEST"/>
<uses-permission android:name="android.permission.health.WRITE_OVULATION_TEST"/>
<uses-permission android:name="android.permission.health.READ_OXYGEN_SATURATION"/>
<uses-permission android:name="android.permission.health.WRITE_OXYGEN_SATURATION"/>
<uses-permission android:name="android.permission.health.READ_POWER"/>
<uses-permission android:name="android.permission.health.WRITE_POWER"/>
<uses-permission android:name="android.permission.health.READ_RESPIRATORY_RATE"/>
<uses-permission android:name="android.permission.health.WRITE_RESPIRATORY_RATE"/>
<uses-permission android:name="android.permission.health.READ_RESTING_HEART_RATE"/>
<uses-permission android:name="android.permission.health.WRITE_RESTING_HEART_RATE"/>
<uses-permission android:name="android.permission.health.READ_SEXUAL_ACTIVITY"/>
<uses-permission android:name="android.permission.health.WRITE_SEXUAL_ACTIVITY"/>
<uses-permission android:name="android.permission.health.READ_SLEEP"/>
<uses-permission android:name="android.permission.health.WRITE_SLEEP"/>
<uses-permission android:name="android.permission.health.READ_SPEED"/>
<uses-permission android:name="android.permission.health.WRITE_SPEED"/>
<uses-permission android:name="android.permission.health.READ_STEPS"/>
<uses-permission android:name="android.permission.health.WRITE_STEPS"/>
<uses-permission android:name="android.permission.health.READ_TOTAL_CALORIES_BURNED"/>
<uses-permission android:name="android.permission.health.WRITE_TOTAL_CALORIES_BURNED"/>
<uses-permission android:name="android.permission.health.READ_VO2_MAX"/>
<uses-permission android:name="android.permission.health.WRITE_VO2_MAX"/>
<uses-permission android:name="android.permission.health.READ_WEIGHT"/>
<uses-permission android:name="android.permission.health.WRITE_WEIGHT"/>
<uses-permission android:name="android.permission.health.READ_WHEELCHAIR_PUSHES"/>
<uses-permission android:name="android.permission.health.WRITE_WHEELCHAIR_PUSHES"/>
```

## Example

There is a detailed example app you can check for both functionalities and implementation details.

