import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/auth/auth.dart';
import 'package:social_media_app/auth/login_or_register.dart';
import 'package:social_media_app/firebase_options.dart';
import 'package:social_media_app/pages/homepage.dart';
import 'package:social_media_app/pages/profile_page.dart';
import 'package:social_media_app/pages/user_page.dart';
import 'package:social_media_app/themes/darkmode.dart';
import 'package:social_media_app/themes/lightmode.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: lightMode,
      darkTheme: darkMode,
      home: const AuthPage(),
      routes: {
        "login_register_page": (context) => const LoginOrRegister(),
        "/home_page": (context) => const HomePage(),
        "/profile_page": (context) => const ProfilePage(),
        "/user_page": (context) => const UserPage()
      },
    );
  }
}
