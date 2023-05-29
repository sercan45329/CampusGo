import 'package:campus_go/presentation/pages/forum_page.dart';
import 'package:campus_go/presentation/pages/home_page.dart';
import 'package:campus_go/presentation/pages/login_page.dart';
import 'package:campus_go/presentation/pages/registration_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/LoginPage": (context) => const LoginPage(),
        "/RegistrationPage": (context) => const RegistrationPage(),
        "/HomePage": (context) => const HomePage()
      },
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
    );
  }
}
