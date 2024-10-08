import 'package:flutter/material.dart';
import 'package:glossy/glossy.dart';
import 'package:otp_pin_field/otp_pin_field.dart';
import '../signin.dart';

class OtpViews extends StatefulWidget {
  final int resendCode;
  final String mobile;

  const OtpViews(this.resendCode, this.mobile, {super.key});

  @override
  State<OtpViews> createState() => _OtpViewsState();
}

class _OtpViewsState extends State<OtpViews> {
  final _otpPinFieldController = GlobalKey<OtpPinFieldState>();
  ScrollController scrollController = ScrollController();
  final Shader linearGradient = const LinearGradient(
    colors: <Color>[Color(0xfffcb13c), Color(0xffd66dfe)],
  ).createShader(const Rect.fromLTWH(10.0, 10.0, 200.0, 30.0));
  @override
  Widget build(BuildContext context) {
    print(widget.resendCode);
    return MaterialApp(
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
                                    'OTP Verification',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Enter 6 digit code has been send via SMS to your mobile number.',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.black54,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: OtpPinField(
                                fieldWidth:
                                    MediaQuery.of(context).size.width / 10,
                                fieldHeight:
                                    MediaQuery.of(context).size.width / 10,
                                key: _otpPinFieldController,
                                autoFillEnable: false,
                                textInputAction: TextInputAction.done,
                                onSubmit: (text) {
                                  if (widget.resendCode.toString() == text) {}
                                },
                                onChange: (text) {
                                  print('Enter on change pin is $text');
                                },
                                onCodeChanged: (code) {
                                  print('onCodeChanged  is $code');
                                },

                                otpPinFieldStyle: OtpPinFieldStyle(

                                    /// border color for inactive/unfocused Otp_Pin_Field
                                    defaultFieldBorderColor: Colors.black26,

                                    /// border color for active/focused Otp_Pin_Field
                                    activeFieldBorderColor: Colors.black26,

                                    /// Background Color for inactive/unfocused Otp_Pin_Field
                                    defaultFieldBackgroundColor: Colors.black12,

                                    /// Background Color for active/focused Otp_Pin_Field
                                    activeFieldBackgroundColor: Colors.white,

                                    /// Background Color for filled field pin box
                                    filledFieldBackgroundColor:
                                        Colors.green.shade800,

                                    /// border Color for filled field pin box
                                    filledFieldBorderColor: Colors.green,

                                    /// gradient border Color for field pin box
                                    ///
                                    textStyle: const TextStyle(
                                      fontSize: 30,
                                      color: Colors.white,
                                    )),
                                maxLength: 6,

                                /// no of pin field
                                showCursor: true,

                                /// bool to show cursor in pin field or not
                                cursorColor: Colors.grey,

                                /// to choose cursor color
                                upperChild: const Column(
                                  children: [
                                    SizedBox(height: 30),
                                    Icon(Icons.flutter_dash_outlined,
                                        size: 150),
                                    SizedBox(height: 20),
                                  ],
                                ),
                                // 123456
                                middleChild: Column(
                                  children: [
                                    const SizedBox(height: 30),
                                    ElevatedButton(
                                        onPressed: () {
                                          _otpPinFieldController.currentState
                                              ?.clearOtp(); // clear controller
                                        },
                                        child: const Text('clear OTP')),
                                    const SizedBox(height: 30),
                                  ],
                                ),

                                ///bool which manage to show custom keyboard
                                // showCustomKeyboard: true,

                                /// Widget which help you to show your own custom keyboard in place if default custom keyboard
                                // customKeyboard: Container(),
                                ///bool which manage to show default OS keyboard
                                // showDefaultKeyboard: true,

                                /// to select cursor width
                                cursorWidth: 3,

                                /// place otp pin field according to yourself
                                mainAxisAlignment: MainAxisAlignment.center,

                                /// predefine decorate of pinField use  OtpPinFieldDecoration.defaultPinBoxDecoration||OtpPinFieldDecoration.underlinedPinBoxDecoration||OtpPinFieldDecoration.roundedPinBoxDecoration
                                ///use OtpPinFieldDecoration.custom  (by using this you can make Otp_Pin_Field according to yourself like you can give fieldBorderRadius,fieldBorderWidth and etc things)
                                otpPinFieldDecoration: OtpPinFieldDecoration
                                    .defaultPinBoxDecoration,
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: InkWell(
                                child: const Row(
                                  children: [
                                    Text(
                                      'Resend OTP',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Icon(Icons.arrow_right),
                                  ],
                                ),
                                onTap: () {
                                  _otpPinFieldController.currentState
                                      ?.codeUpdated();
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: const WidgetStatePropertyAll(
                                      Colors.transparent),
                                  padding: const WidgetStatePropertyAll(
                                    EdgeInsets.symmetric(vertical: 0),
                                  ),
                                  shape: WidgetStatePropertyAll(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  if (widget.resendCode.toString() ==
                                      _otpPinFieldController
                                          .currentState!.controller.text
                                          .toString()) {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (_) {
                                        return const SignIn();
                                      }),
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
                                        vertical: 8.0, horizontal: 24),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Continue',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
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
}
