import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:glossy/glossy.dart';
import 'package:local_captcha/local_captcha.dart';
import 'package:otp_pin_field/otp_pin_field.dart';
import 'package:voopoler/controllers/signup_controller.dart';
import 'package:voopoler/views/module/auth/forgot/otp.dart';

import 'signin.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _messangerKey = GlobalKey<ScaffoldMessengerState>();
  ScrollController scrollController = ScrollController();
  final _captchaFormKey = GlobalKey<FormState>();
  final _configFormKey = GlobalKey<FormState>();
  final _localCaptchaController = LocalCaptchaController();
  final _configFormData = ConfigFormData();
  final _refreshButtonEnableVN = ValueNotifier(true);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final AuthController _authController = AuthController();
  final Shader linearGradient = const LinearGradient(
    colors: <Color>[Color(0xfffcb13c), Color(0xffd66dfe)],
  ).createShader(const Rect.fromLTWH(10.0, 10.0, 200.0, 30.0));

  var _inputCode = '';
  Timer? _refreshTimer;
  bool _isLoading = false;
  @override
  void dispose() {
    _localCaptchaController.dispose();
    _refreshTimer?.cancel();
    _refreshTimer = null;
    _isLoading = false;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: _messangerKey,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.black87,
            image: DecorationImage(
              image: AssetImage('asset/background_login_1.jpg'),
              fit: BoxFit.cover,
              opacity: 1,
            ),
          ),
          child: GlossyContainer(
            opacity: 0.1,
            height: double.infinity,
            width: MediaQuery.of(context).size.width,
            child: GestureDetector(
              onTap: hideKeyboard,
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 150,
                      child: Align(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'asset/logo.png',
                              height: 50,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Voopoler',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                foreground: Paint()..shader = linearGradient,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      constraints: BoxConstraints(
                        minWidth: MediaQuery.of(context).size.width,
                      ),
                      margin: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 50),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(24),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32.0, vertical: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Sign Up!',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Enter your email and phone Number below to Sign Up.',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.black54,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Form(
                                key: _captchaFormKey,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: TextFormField(
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          controller: _emailController,
                                          decoration: const InputDecoration(
                                            labelText: "Email",
                                            labelStyle: TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                          validator: _validateEmail),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: TextFormField(
                                          keyboardType: TextInputType.number,
                                          controller: _phoneNumberController,
                                          decoration: const InputDecoration(
                                            labelText: "Phone Number",
                                            labelStyle: TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                          validator: _validatePhoneNumber),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              LocalCaptcha(
                                                key: ValueKey(
                                                    _configFormData.toString()),
                                                controller:
                                                    _localCaptchaController,
                                                height: 70,
                                                width: 200,
                                                backgroundColor:
                                                    Colors.grey[100]!,
                                                chars: _configFormData.chars,
                                                length: _configFormData.length,
                                                fontSize:
                                                    _configFormData.fontSize > 0
                                                        ? _configFormData
                                                            .fontSize
                                                        : null,
                                                caseSensitive: _configFormData
                                                    .caseSensitive,
                                                codeExpireAfter: _configFormData
                                                    .codeExpireAfter,
                                                onCaptchaGenerated: (captcha) {
                                                  debugPrint(
                                                      'Generated captcha: $captcha');
                                                },
                                              ),
                                              SizedBox(
                                                height: 70.0,
                                                width: 50,
                                                child: ValueListenableBuilder(
                                                    valueListenable:
                                                        _refreshButtonEnableVN,
                                                    builder: (context, enable,
                                                        child) {
                                                      final onPressed = enable
                                                          ? () {
                                                              if (_refreshTimer ==
                                                                  null) {
                                                                // Prevent spam pressing refresh button.
                                                                _refreshTimer = Timer(
                                                                    const Duration(
                                                                        seconds:
                                                                            1),
                                                                    () {
                                                                  _refreshButtonEnableVN
                                                                          .value =
                                                                      true;

                                                                  _refreshTimer
                                                                      ?.cancel();
                                                                  _refreshTimer =
                                                                      null;
                                                                });

                                                                _refreshButtonEnableVN
                                                                        .value =
                                                                    false;
                                                                _localCaptchaController
                                                                    .refresh();
                                                              }
                                                            }
                                                          : null;

                                                      return Align(
                                                        alignment: Alignment
                                                            .bottomRight,
                                                        child: Text.rich(
                                                          TextSpan(
                                                              text: "Refresh",
                                                              recognizer:
                                                                  TapGestureRecognizer()
                                                                    ..onTap =
                                                                        onPressed),
                                                        ),
                                                      );
                                                    }),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 16.0),
                                          TextFormField(
                                              decoration: const InputDecoration(
                                                labelText: 'Enter code',
                                                hintText: 'Enter code',
                                                isDense: true,
                                                border: OutlineInputBorder(),
                                              ),
                                              validator: _validateOtpCode,
                                              onChanged: (value) =>
                                                  setState(() {
                                                    _inputCode = value;
                                                  })),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 0,
                                    ),
                                    Column(
                                      children: [
                                        const SizedBox(
                                          height: 16,
                                        ),
                                        const Text(
                                          'or',
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.black54,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        const Text(
                                          'Sign Up with',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: ElevatedButton(
                                            style: const ButtonStyle(
                                              backgroundColor:
                                                  WidgetStatePropertyAll(
                                                Colors.redAccent,
                                              ),
                                            ),
                                            onPressed: () {},
                                            child: const Row(
                                              children: [
                                                Icon(
                                                  Icons.g_mobiledata,
                                                  color: Colors.white,
                                                ),
                                                Text(
                                                  'Google',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        SizedBox(
                                          child: Text.rich(
                                            TextSpan(
                                              text: "Have a already account ?",
                                              children: [
                                                const TextSpan(text: " "),
                                                TextSpan(
                                                    text: "Sign In",
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                    recognizer:
                                                        TapGestureRecognizer()
                                                          ..onTap = () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (__) =>
                                                                        const SignIn()));
                                                          }),
                                              ],
                                              style: const TextStyle(
                                                color: Colors.black45,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  const WidgetStatePropertyAll(
                                                      Colors.transparent),
                                              padding:
                                                  const WidgetStatePropertyAll(
                                                EdgeInsets.symmetric(
                                                    vertical: 0),
                                              ),
                                              shape: WidgetStatePropertyAll(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                ),
                                              ),
                                            ),
                                            onPressed: () async {
                                              print(_emailController.text);
                                              print(
                                                  _phoneNumberController.text);
                                              print(_inputCode);
                                              if (_emailController
                                                      .text.isNotEmpty &&
                                                  _phoneNumberController
                                                      .text.isNotEmpty &&
                                                  _inputCode.isNotEmpty) {
                                                await _authController
                                                    .signUp(
                                                  email: _emailController.text,
                                                  phone: _phoneNumberController
                                                      .text,
                                                  captchaCode:
                                                      _inputCode.trim(),
                                                )
                                                    .then((result) async {
                                                  if (result == null) {
                                                    String getOTP =
                                                        await _authController
                                                            .sendOTP(
                                                      context,
                                                      mobile:
                                                          _phoneNumberController
                                                              .text,
                                                    );
                                                    print(getOTP);
                                                    if (getOTP.isNotEmpty) {
                                                      if (!context.mounted) {
                                                        return;
                                                      }
                                                      _messangerKey.currentState
                                                          ?.showSnackBar(
                                                              const SnackBar(
                                                                  content: Text(
                                                                      'OTP sent!')));
                                                      await Future.delayed(
                                                        const Duration(
                                                          seconds: 3,
                                                        ),
                                                      );
                                                      Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              OtpViews(
                                                            resendCode: getOTP,
                                                          ),
                                                        ),
                                                      );
                                                    } else {
                                                      if (!context.mounted) {
                                                        return;
                                                      }
                                                      _messangerKey.currentState
                                                          ?.showSnackBar(
                                                        const SnackBar(
                                                          content: Text(
                                                            'Failed to send OTP',
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                  } else {
                                                    _messangerKey.currentState
                                                        ?.showSnackBar(
                                                      const SnackBar(
                                                        content: Text(
                                                          'Please check your data',
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                });
                                              } else {
                                                _messangerKey.currentState
                                                    ?.showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                      'Please check your data',
                                                    ),
                                                  ),
                                                );
                                              }
                                            },
                                            child: Container(
                                              width: 180,
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(32),
                                                ),
                                              ),
                                              child: const Padding(
                                                padding: EdgeInsets.symmetric(
                                                  vertical: 8.0,
                                                  horizontal: 24,
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Continue',
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Icon(
                                                      Icons.arrow_right,
                                                      size: 24,
                                                      color: Colors.white,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? _validateEmail(String? value) {
    if (value!.trim().isEmpty) {
      return 'Please enter a longer string';
    }
    final RegExp regex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)| (\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (!regex.hasMatch(value.trim())) {
      return 'Enter Valid Email';
    }
    return null;
  }

  String? _validatePhoneNumber(String? value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(patttern);
    if (value!.trim().length < 10) {
      return 'Please enter a longer string';
    } else if (!regExp.hasMatch(value.trim())) {
      return 'Please enter valid mobile number';
    }
    return null;
  }

  String? _validateOtpCode(String? value) {
    if (value != null && value.isNotEmpty) {
      if (value.trim().length != _configFormData.length) {
        return '* Code must be length of ${_configFormData.length}.';
      }

      final validation = _localCaptchaController.validate(value);

      switch (validation) {
        case LocalCaptchaValidation.invalidCode:
          return '* Invalid code.';
        case LocalCaptchaValidation.codeExpired:
          return '* Code expired.';
        case LocalCaptchaValidation.valid:
        default:
          return null;
      }
    }

    return '* Required field.';
  }
}

class ConfigFormData {
  String chars = 'abdefghnryABDEFGHNQRY3468';
  int length = 5;
  double fontSize = 0;
  bool caseSensitive = false;
  Duration codeExpireAfter = const Duration(minutes: 10);

  @override
  String toString() {
    return '$chars$length$caseSensitive${codeExpireAfter.inMinutes}';
  }
}
