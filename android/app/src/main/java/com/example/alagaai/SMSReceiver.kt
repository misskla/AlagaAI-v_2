package com.example.alagaai

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.telephony.SmsMessage
import android.util.Log
import android.widget.Toast
import com.example.alagaai.MainActivity

class SMSReceiver : BroadcastReceiver() {
    companion object {
        private const val TAG = "SMSReceiver"
    }

    override fun onReceive(context: Context?, intent: Intent?) {
        if (context == null || intent?.action != "android.provider.Telephony.SMS_RECEIVED") return
        val bundle = intent?.extras
        val pdus = bundle?.get("pdus") as? Array<*> ?: return
        val format = bundle.getString("format")
        val fullMessage = StringBuilder()
        var sender: String? = null
        var timestamp: Long = 0

        for (pdu in pdus) {
            val message = if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.M) {
                SmsMessage.createFromPdu(pdu as ByteArray, format)
            } else {
                @Suppress("DEPRECATION")
                SmsMessage.createFromPdu(pdu as ByteArray)
            }

            message?.let {
                sender = it.originatingAddress
                fullMessage.append(it.messageBody)
                timestamp = it.timestampMillis
            }
        }

        if (sender != null && fullMessage.isNotEmpty()) {
            val messageText = fullMessage.toString()
            Log.d(TAG, "From: $sender, Message: $messageText, Timestamp: $timestamp")

            Toast.makeText(
                context,
                "From: $sender\nMessage: $messageText",
                Toast.LENGTH_LONG
            ).show()

            val triggerWords = listOf("kill", "hurt", "secret", "abuse", "suicide")
            val isTriggered = triggerWords.any { messageText.lowercase().contains(it) }

            if (isTriggered) {
                MainActivity.methodChannel?.invokeMethod(
                    "onSmsReceived",
                    mapOf(
                        "sender" to sender,
                        "message" to messageText,
                        "timestamp" to timestamp
                    )
                )
            }
        }
    }
}
