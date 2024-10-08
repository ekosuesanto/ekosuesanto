import 'dart:math';
import 'package:flutter/material.dart';
import 'package:telephony/telephony.dart';

class SignUpController {
  signUp(
      {required String email,
      required String phone,
      required String captchaCode}) async {
    return null;
  }

  Future<int> generateOTP(int min, int max) async {
    final Random random = Random();
    int randomNumber = min + (random.nextInt(max));
    return randomNumber;
  }

  // Future<bool> _sendSMS(String message, List<String> recipents) async {
  //   await sendSMS(message: message, recipients: recipents)
  //       .catchError((onError) {
  //     print(onError.toString());
  //   });
  //   return true;
  // }

  Future<dynamic> sendOTP(BuildContext context,
      {required String mobile}) async {
    final Telephony telephony = Telephony.instance;
    int otpNumber = await generateOTP(000000, 999999);
    String message =
        "Your OTP Code ${otpNumber.toString()}. Please Don't share this code with other people!";

    return await telephony.sendSms(
      to: mobile,
      message: message,
      statusListener: (SendStatus status) {
        switch (status) {
          case SendStatus.SENT:
            return otpNumber;
          case SendStatus.DELIVERED:
            return 'Waiting send SMS...';
          default:
            return 'OTP failed to Send';
        }
      },
    );
  }

  signOut({required String key}) async {}
}
