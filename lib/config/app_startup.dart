import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppStartUp {
  Future<void> setUp() async {
    /**
     * Note: This is where we would call all the singleton, dependencies, essentially anything we need before we run the actual application
     */
    WidgetsFlutterBinding.ensureInitialized();

    await setPreferredOrientations();

    /// loadStartUpConfig before registerServices
    await registerServices();
  }

  Future<void> registerServices() async {
  }

  Future<void> setPreferredOrientations() {
    return SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }
}
