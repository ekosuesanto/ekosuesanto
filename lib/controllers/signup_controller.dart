import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthController {
  signUp(
      {required String email,
      required String phone,
      required String captchaCode}) async {
    return null;
  }

  signIn(email, password) async {}
  Future<String> sendOTP(BuildContext context, {required String mobile}) async {
    // final response = await http.post(
    //   Uri.parse('https://your-backend-url/send-otp'),
    //   body: {'mobile': mobile},
    // );
    // if (response.statusCode == 200) {
    return '321231';
    // 32
  }

  signOut({required String key}) async {}
}
