import 'package:flutter/material.dart';
import 'package:social_media_app/pages/login_page.dart';
import 'package:social_media_app/pages/register_page.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  //initailly, show show login page
  bool showLoginPage = true;

  //toogle between the login and the register page
  //he ! operator is the logical negation operator
  //It flips the value of a boolean variable: if the variable is true, !true becomes false;
  // if the variable is false, !false becomes true.
  void tooglePage() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(
        onTap: tooglePage,
      );
    } else {
      return RegisterPage(
        onTap: tooglePage,
      );
    }
  }
}
