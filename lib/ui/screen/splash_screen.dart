import 'package:flutter/material.dart';
import 'package:places/data/dio_client.dart';
import 'package:places/ui/screen/router/route_names.dart';

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
    final apiClient = ApiClient();
    await apiClient.fetchData();
    //await Future.delayed(const Duration(seconds: 2));

    _navigateToNext();
  }

  void _navigateToNext() {
    Navigator.pushNamed(context, Routes.onBoarding);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Splash Screen')),
    );
  }
}
