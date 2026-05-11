import 'package:flutter/material.dart';
import 'constants/constants.dart';
import 'screens/screens.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appTitle,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      routes: {
        '/home': (context) => const HomeScreen(),
        '/tutorial_11_1': (context) => const Tutorial11_1Screen(),
        '/tutorial_11_2': (context) => const Tutorial11_2Screen(),
      },
    );
  }
}