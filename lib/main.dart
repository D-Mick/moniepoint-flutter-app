import 'package:flutter/material.dart';
import 'package:moniepointflutterapp/config/app_startup.dart';
import 'package:moniepointflutterapp/modules/landing_screen.dart';

Future<void> main() async {
  await AppStartUp().setUp();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LandingScreen(),
    );
  }
}
