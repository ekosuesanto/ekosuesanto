package com.example.voopoler

import android.content.BroadcastReceiver
import android.content.Intent
import android.content.IntentFilter
import android.os.Build
import io.flutter.embedding.android.FlutterActivity
import org.jetbrains.annotations.Nullable

class MainActivity: FlutterActivity()

fun registerReceiver(@Nullable receiver: BroadcastReceiver?, filter: IntentFilter?): Intent? {
    return if (Build.VERSION.SDK_INT >= 34 && getApplicationInfo().targetSdkVersion >= 34) {
        context.registerReceiver(receiver, filter, Context.RECEIVER_EXPORTED)
    } else {
        context.registerReceiver(receiver, filter)
    }
}