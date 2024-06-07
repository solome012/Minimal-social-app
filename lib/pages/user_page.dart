import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:social_media_app/components/helper/helper_function.dart';
import 'package:social_media_app/components/my_back_button.dart';
import 'package:social_media_app/components/mylist_tile.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Users").snapshots(),
        builder: (context, snapshot) {
          //if any error
          if (snapshot.hasError) {
            displayMessageToUser("Something went wrong", context);
          }
          //show loading circle
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          //if no data
          if (snapshot.data == null) {
            return const Text("No data avaiable");
          }
          //get all the users
          final users = snapshot.data!.docs;
          return Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 60, left: 20),
                child: Row(
                  children: [MyBackButton()],
                ),
              ),

              //list of the user in the app
              Expanded(
                child: ListView.builder(
                    itemCount: users.length,
                    padding: const EdgeInsets.all(10),
                    itemBuilder: (context, index) {
                      //get individual users
                      final user = users[index];

                      //get data from each user
                      String username = user['username'];
                      String email = user['email'];
                      return MyListTile(
                        title: username,
                        subtitle: email,
                      );
                    }),
              ),
            ],
          );
        },
      ),
    );
  }
}
