package dev.duynp.flutter_health_connect

import android.app.Activity
import android.content.Context
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.cancel
import java.lang.ref.WeakReference


abstract class ContextAwarePlugin : FlutterPlugin, ActivityAware, MethodChannel.MethodCallHandler {

    abstract val pluginName: String

    private lateinit var channel : MethodChannel

    lateinit var scope: CoroutineScope
    protected val activity get() = activityReference.get()
    protected val applicationContext get() =
        contextReference.get() ?: activity?.applicationContext

    private var activityReference = WeakReference<Activity>(null)
    private var contextReference = WeakReference<Context>(null)

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activityReference = WeakReference(binding.activity)
    }

    override fun onDetachedFromActivityForConfigChanges() {
        activityReference.clear()
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        activityReference = WeakReference(binding.activity)
    }

    override fun onDetachedFromActivity() {
        activityReference.clear()
    }

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, pluginName)
        channel.setMethodCallHandler(this)

        contextReference = WeakReference(flutterPluginBinding.applicationContext)
        scope = CoroutineScope(SupervisorJob() + Dispatchers.Main)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
        scope.cancel()
    }

}