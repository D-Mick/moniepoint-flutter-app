import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:stockrx/modules/auth/log_in/di.dart';
import 'package:stockrx/modules/dashboard/di.dart';
import 'package:stockrx/modules/onboarding/di.dart';
import 'package:stockrx/navigation/navigation_service.dart';
import 'package:window_manager/window_manager.dart';

class AppStartUp {
  Future<void> setUp() async {
    /**
     * Note: This is where we would call all the singleton, dependencies, essentially anything we need before we run the actual application
     */
    WidgetsFlutterBinding.ensureInitialized();

    await setWindowLaunchFullscreen();

    await setPreferredOrientations();

    /// loadStartUpConfig before registerServices
    await registerServices();
  }

  Future<void> registerServices() async {
    GetIt.I.registerSingleton<NavigationService>(NavigationService());
    setupOnboardingServices(GetIt.I);
    setupLoginServices(GetIt.I);
    setupDashBoardServices(GetIt.I);
  }

  Future<void> setWindowLaunchFullscreen() async {
    await windowManager.ensureInitialized();

    WindowManager.instance.setMinimumSize(const Size(1400, 900));

    WindowOptions windowOptions = const WindowOptions(
      size: Size(1400, 900),
      titleBarStyle: TitleBarStyle.normal,
    );

    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }

  Future<void> setPreferredOrientations() {
    return SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }
}
