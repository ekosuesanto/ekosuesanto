import 'package:cupertino_onboarding/cupertino_onboarding.dart';
import 'package:easy_permission_validator/easy_permission_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'views/module/auth/signin.dart';

void main() {
  runApp(const VooApp());
}

class VooApp extends StatelessWidget {
  const VooApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      debugShowCheckedModeBanner: false,
      title: 'Voopoler',
      home: CupertinoScaffold(
        body: Onboarding(),
      ),
    );
  }
}

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  bool? _result = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 0), () async {
      await permissionRequestResult(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return (_result == false)
        ? const SignIn()
        : CupertinoOnboarding(
            bottomButtonColor: CupertinoColors.systemGreen.resolveFrom(context),
            onPressedOnLastPage: () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const SignIn()),
                (r) => false),
            pages: [
              WhatsNewPage(
                title: const Text("What's New in Calendar"),
                features: [
                  WhatsNewFeature(
                    icon: Icon(
                      CupertinoIcons.mail,
                      color: CupertinoColors.systemRed.resolveFrom(context),
                    ),
                    title: const Text('Found Events'),
                    description: const Text(
                      'Siri suggests events found in Mail, Messages, and Safari, so you can add them easily, such as flight reservations and hotel bookings.',
                    ),
                  ),
                  WhatsNewFeature(
                    icon: Icon(
                      CupertinoIcons.time,
                      color: CupertinoColors.systemRed.resolveFrom(context),
                    ),
                    title: const Text('Time to Leave'),
                    description: const Text(
                      "Calendar uses Apple Maps to look up locations, traffic conditions, and transit options to tell you when it's time to leave.",
                    ),
                  ),
                ],
              ),
              const CupertinoOnboardingPage(
                title: Text('Support For Multiple Pages'),
                body: Icon(
                  CupertinoIcons.square_stack_3d_down_right,
                  size: 200,
                ),
              ),
              const CupertinoOnboardingPage(
                title: Text('Great Look in Light and Dark Mode'),
                body: Icon(
                  CupertinoIcons.sun_max,
                  size: 200,
                ),
              ),
            ],
          );
  }

  Future<void> _permissionRequest(BuildContext context) async {
    final permissionValidator = EasyPermissionValidator(
      context: context,
      appName: 'Voopoler',
    );
    final result = await permissionValidator.camera();

    if (result) {
      setState(() {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const SignIn()));
      });
    } else {
      _permissionWithCustomPopup();
    }
  }

  Future<bool?> permissionRequestResult(BuildContext context) async {
    bool? response;
    final permissionValidator = EasyPermissionValidator(
      context: context,
      appName: 'Voopoler',
    );

    final result = await permissionValidator.camera();

    if (result) {
      setState(() {
        _result = true;
        response = true;
      });
    } else {
      setState(() {
        _result = false;
        response = false;
      });
    }

    return response;
  }

  Future<void> _permissionWithCustomPopup() async {
    final permissionValidator = EasyPermissionValidator(
      context: context,
      appName: 'Easy Permission Validator',
      customDialog: _MyAmazingCustomPopup(),
    );
    final result = await permissionValidator.camera();
    if (result) {
      setState(() => _result = true);
    }
  }
}

class _MyAmazingCustomPopup extends StatefulWidget {
  @override
  State<_MyAmazingCustomPopup> createState() => _MyAmazingCustomPopupState();
}

class _MyAmazingCustomPopupState extends State<_MyAmazingCustomPopup> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13),
          child: SizedBox(
            height: 300,
            width: MediaQuery.of(context).size.width,
            child: Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text(
                      'Easy Permission Validator Demo',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Icon(
                      Icons.perm_camera_mic,
                      size: 60,
                      color: Colors.red,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        ElevatedButton.icon(
                          onPressed: _closePopup,
                          icon: const Icon(Icons.cancel),
                          label: const Text('Cancel'),
                        ),
                        ElevatedButton.icon(
                          onPressed: _openPermissionSettings,
                          icon: const Icon(Icons.arrow_forward_ios),
                          label: const Text('Go To Settings'),
                        ),
                      ],
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

  Future<void> _openPermissionSettings() async {
    _closePopup();
  }

  void _closePopup() {
    Navigator.of(context).pop();
  }
}
