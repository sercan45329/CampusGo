import 'package:campus_go/presentation/pages/login_page.dart';
import 'package:campus_go/presentation/pages/registration_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/LoginPage": (context) => const LoginPage(),
        "/RegistrationPage": (context) => const RegistrationPage()
      },
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
    );
  }
}
