import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:places/data/interactor/settings_interactor.dart';
import 'package:places/ui/screen/router/app_router.dart';
import 'package:places/ui/screen/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:places/ui/screen/res/themes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  runApp(
    ChangeNotifierProvider<ThemeInteractor>(
      create: (context) => ThemeInteractor(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: context.watch<ThemeInteractor>().currentTheme,
      onGenerateRoute: AppRouter.router,
      home: const SplashScreen(),
    );
  }
}
