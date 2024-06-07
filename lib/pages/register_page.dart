import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/components/helper/helper_function.dart';
import 'package:social_media_app/components/my_button.dart';
import 'package:social_media_app/components/my_textfield.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //email controller
  final emailController = TextEditingController();
  //password controller

  final passwordController = TextEditingController();
  //other contrller
  final usernameController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  //register method
  void register() async {
    ///show loading circle
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    ///make sure password match
    if (passwordController.text != confirmPasswordController.text) {
      //pop loading circle
      Navigator.pop(context);

      //show the user error message
      displayMessageToUser("password don't match.", context);
    } else {
      ///try catching the user
      try {
        //create user
        UserCredential? usercreadential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        //create a user document and add to firestore
        createUserDocument(usercreadential);
        Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        //pop the loading circle
        if (context.mounted) Navigator.pop(context);
        //display error message to the user
        displayMessageToUser(e.code, context);
      }
    }
  }

  //create a user document and collect them in the firestore
  Future<void> createUserDocument(UserCredential? userCredential) async {
    if (userCredential != null && userCredential.user != null) {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(userCredential.user!.email)
          .set({
        'email': userCredential.user!.email,
        'username': usernameController.text
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //logo
                Icon(
                  Icons.person,
                  size: 80,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),

                const SizedBox(
                  height: 25,
                ),

                //app name
                const Text(
                  "M I N I M A L",
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 50,
                ),
                MyTextField(
                  hintText: "username",
                  controller: usernameController,
                ),

                const SizedBox(
                  height: 15,
                ),
                //email textfield
                MyTextField(
                  hintText: 'email',
                  controller: emailController,
                ),
                //password textfied
                const SizedBox(
                  height: 15,
                ),
                MyTextField(
                  hintText: "password",
                  controller: passwordController,
                  obscureText: true,
                ),
                const SizedBox(
                  height: 15,
                ),

                MyTextField(
                  hintText: "confirm password",
                  controller: confirmPasswordController,
                  obscureText: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                //forget password
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Forgot password?",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary),
                    )
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),

                //sign in button
                MyButton(text: "Register", onTap: register),

                const SizedBox(
                  height: 25,
                ),

                /// i don't have an account? register here
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?  "),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        "login here",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.blue),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
