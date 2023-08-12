import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void>? isInitialized;

  @override
  void initState() {
    super.initState();
    isInitialized = _initializeApp();
  }

  Future<void> _initializeApp() async {
    //инициализация приложения.....
    await Future.delayed(const Duration(seconds: 2));

    _navigateToNext();
  }

  void _navigateToNext() {
    print("Переход на следующий экран");
    // После изучения навигации добавьте логику перехода
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Splash Screen')),
    );
  }
}
