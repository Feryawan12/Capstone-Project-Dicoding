import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/route_manager.dart';
import 'package:schedule_app/config/controler_binding.dart';
import 'package:schedule_app/config/theme.dart';
import 'package:schedule_app/views/splash_screen.dart';

class IndexApp extends StatefulWidget {
  const IndexApp({super.key});

  @override
  State<IndexApp> createState() => _IndexAppState();
}

class _IndexAppState extends State<IndexApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.upToDown,
      theme: ThemeApp.light(),
      title: 'Schedule App',
      builder: EasyLoading.init(),
      home: const SplashScreen(),
      initialBinding: InitialControllerBindings(),
    );
  }
}
