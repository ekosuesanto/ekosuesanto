package com.example.voopoler
import android.R
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.Bundle
import android.util.Log
import androidx.appcompat.app.AppCompatActivity
import android.content.BroadcastReceiver
class MainActivity : AppCompatActivity() {
    private val smsReceiver = SmsReceiver()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.main_activity)
        registerReceiver(smsReceiver,
            IntentFilter("android.provider.Telephony.SMS_RECEIVED")
        )
    }

    override fun onDestroy() {
        super.onDestroy()
        unregisterReceiver(smsReceiver)
    }

}
class SmsReceiver: BroadcastReceiver() {
    override fun onReceive(context: Context?, intent: Intent?) {
        if(intent?.action == "android.provider.Telephony.SMS_RECEIVED") { // it's best practice to verify intent action before performing any operation
            Log.i("ReceiverApp", "SMS Received")
        }
    }
}