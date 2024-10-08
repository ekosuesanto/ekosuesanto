package com.example.voopoler
import android.content.Context
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {
    val REQUEST_CHANNEL = "add2app.io/request";
    override fun provideFlutterEngine(context:Context): FlutterEngine? {
        val flutterEngine = FlutterEngineCache.getInstance().get("my_engine_id")
        return flutterEngine
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        GeneratedPluginRegistrant.registerWith(flutterEngine)

    }

    fun registerFlutterCallbacks(flutterEngine: FlutterEngine) {
        MethodChannel(
            flutterEngine.getDartExecutor(),
            REQUEST_CHANNEL
        ).setMethodCallHandler { call, result ->
            if (call.method.equals("getNativeMsg")) {
                val nd = "Ola from Android"
                result.success(nd)
            } else {
                result.notImplemented()
            }
        }
    }
}