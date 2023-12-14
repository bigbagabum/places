import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:places/data/interactor/settings_interactor.dart';
import 'package:places/ui/screen/errors/error_handlers.dart';
import 'package:places/ui/screen/res/app_state.dart';
import 'package:places/ui/screen/router/app_router.dart';
import 'package:places/ui/screen/router/route_names.dart';
import 'package:places/ui/screen/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeInteractor>(
          create: (context) => ThemeInteractor(),
        ),
        ChangeNotifierProvider<AppState>(
          create: (context) => AppState(),
        ),
        Provider<ErrorManager>(
          create: (context) => ErrorManager(),
          dispose: (_, errorManager) => errorManager.dispose(),
        ),
      ],
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
    final errorManager = Provider.of<ErrorManager>(context, listen: false);

    return MaterialApp(
      theme: context.watch<ThemeInteractor>().currentTheme,
      onGenerateRoute: AppRouter.router,
      home: StreamBuilder<bool>(
        stream: errorManager.errorStream,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!) {
            // Здесь вы можете выполнить действия при обнаружении сетевой ошибки
            print(
                '===========================ОШИБКА СЕТИ ОШИБКА СЕТИ========================');

            // Сделать переход на экран Routes.netError
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushNamed(context, Routes.netError);
            });

            return const SizedBox();
          } else {
            // Здесь вы можете разместить другие виджеты при отсутствии сетевой ошибки
            return const SplashScreen();
          }
        },
      ),
    );
  }
}
