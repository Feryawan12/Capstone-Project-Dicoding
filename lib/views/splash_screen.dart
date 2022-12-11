import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:schedule_app/views/login/login_page.dart';
import 'package:schedule_app/views/mainScreen/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(
        const Duration(milliseconds: 5000),
        () => Get.off(() => GetStorage().read('user') != null
            ? const MainScreen()
            : const LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Wellcome Schedule App',
                textAlign: TextAlign.center,
                softWrap: true,
                style: Theme.of(context).primaryTextTheme.displayLarge),
            const SizedBox(height: 11.0),
            Image.asset(
              'assets/gambar_meeting.png',
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width / 1.5,
            )
          ],
        ),
      ),
    );
  }
}
