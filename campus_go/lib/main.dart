import 'package:campus_go/presentation/pages/auth/forgot_password_page.dart';
import 'package:campus_go/presentation/pages/campuslife/add_event_page.dart';
import 'package:campus_go/presentation/pages/campuslife/campus_life_event_page.dart';
import 'package:campus_go/presentation/pages/campuslife/campus_life_view_all_page.dart';
import 'package:campus_go/presentation/pages/career/career_page.dart';
import 'package:campus_go/presentation/pages/filter_page.dart';
import 'package:campus_go/presentation/pages/forum/add_post_page.dart';
import 'package:campus_go/presentation/pages/forum/forum_page.dart';
import 'package:campus_go/presentation/pages/home_page.dart';
import 'package:campus_go/presentation/pages/auth/login_page.dart';
import 'package:campus_go/presentation/pages/auth/registration_page.dart';
import 'package:campus_go/presentation/pages/forum/see_all_post_page.dart';
import 'package:campus_go/presentation/pages/profile_page.dart';
import 'package:campus_go/presentation/pages/settings_page.dart';
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
    return MaterialApp(routes: {
      "/LoginPage": (context) => const LoginPage(),
      "/RegistrationPage": (context) => const RegistrationPage(),
      "/HomePage": (context) => const HomePage(),
      "/ForumPage": (context) => const ForumPage(),
      "/ForgotPasswordPage": (context) => const ForgotPasswordPage(),
      "/SeeAllPostPage": (context) => const SeeAllPostPage(),
      "/AddPostPage": (context) => const AddPostPage(),
      "/SettingsPage": (context) => const SettingsPage(),
      "/CareerPage": (context) => const CareerPage(),
      "/ViewAllPageCampusLife": (context) => const ViewAllPageCampusLife(),
      "/AddEventPage": (context) => const AddEventPage(),
      "/EventPage": (context) => const EventPage(),
      "/ProfilePage": (context) => const ProfilePage(),
      "/FilterPage": (context) => const FilterPage()
    }, debugShowCheckedModeBanner: false, home: const LoginPage());
  }
}
