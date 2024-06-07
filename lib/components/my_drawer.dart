import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});
  //logout user
  void logout() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              //drawer header
              const DrawerHeader(child: Icon(Icons.favorite)),
              const SizedBox(
                height: 25,
              ),
              //home tile
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text("H O M E"),
                  onTap: () {
                    //this is already the home screen so just pop drawere
                    Navigator.pop(context);
                  },
                ),
              ),
              //profile tile

              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text("P R O F I L E"),
                  onTap: () {
                    //this is already the home screen so just pop drawere
                    Navigator.pop(context);

                    //navigate to the profile page
                    Navigator.pushNamed(context, "/profile_page");
                  },
                ),
              ),

              //PROFILE TILE
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: ListTile(
                  leading: const Icon(Icons.group),
                  title: const Text("U S E R"),
                  onTap: () {
                    //this is already the home screen so just pop drawere
                    Navigator.pop(context);

                    //navigate to the user page
                    Navigator.pushNamed(context, "/user_page");
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, bottom: 20),
            child: ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("L O G O U T"),
              //POP DRAWER

              //log out
              onTap: () {
                Navigator.pop(context);
                logout();
              },
            ),
          ),
        ],
      ),
    );
  }
}
