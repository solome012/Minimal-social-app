import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/components/my_drawer.dart';
import 'package:social_media_app/components/my_textfield.dart';
import 'package:social_media_app/components/mylist_tile.dart';
import 'package:social_media_app/components/post_button.dart';
import 'package:social_media_app/database/firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //firestore access
  final FirestoreDatabase database = FirestoreDatabase();

  //post message
  void postMessage() {
    //only post a message if there is something on the textfield
    if (textController.text.isNotEmpty) {
      String message = textController.text;
      database.addPost(message);
    }
    //after user post the message , clear the controller
    textController.clear();
  }

  //text controller
  final textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
        title: const Center(child: Text("W A L L")),
      ),
      drawer: const MyDrawer(),
      body: Column(
        children: [
          ///Textfiled box for user to type
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              children: [
                Expanded(
                  child: MyTextField(
                    hintText: "What's on your minds?",
                    controller: textController,
                  ),
                ),
                PostButton(onTap: postMessage)
              ],
            ),
          ),
          //Posts
          StreamBuilder(
              stream: database.getPostStream(),
              builder: (context, snapshot) {
                //show loading cirlce
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                //get all posts
                final posts = snapshot.data!.docs;
                //no data?
                if (snapshot.data == null || posts.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Text("No posts. Please Post something."),
                    ),
                  );
                }
                //return as list
                return Expanded(
                    child: ListView.builder(
                        itemCount: posts.length,
                        itemBuilder: (context, index) {
                          //get each individaul posts
                          final post = posts[index];
                          //get data from each post
                          String message = post['PostMessage'];
                          String userEmail = post['UserEmail'];
                          Timestamp timestamp = post['Timestamp'];
                          //return as listTile
                          return MyListTile(
                              title: message, subtitle: userEmail);
                        }));
              })
        ],
      ),
    );
  }
}
