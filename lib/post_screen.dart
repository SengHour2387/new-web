import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game_talk/service/posting.dart';
import 'package:game_talk/widget/blurred_appbar.dart';

import 'model/post_model.dart';

class PostScreen extends StatefulWidget {
  PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final Posting posting = Posting();

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController imageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: BlurredAppbar(
          appBar: AppBar(
        title: const Text(
          "Add a post",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white.withOpacity(0),
      )),
      body: Padding(
        padding: EdgeInsets.all(width * 0.1),
        child: Column(
          children: [
            PhysicalModel(
              borderRadius: BorderRadius.circular(24),
              elevation: 10,
              color: Colors.transparent,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: width * 0.1),

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: Colors.blue,

                ),
                child: CupertinoButton(
                    child: Icon(
                      CupertinoIcons.share_up,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      final post = PostModel(
                          title: titleController.text,
                          description: descriptionController.text,
                          image: imageController.text);
                      posting.addPost(post: post);
                      Navigator.of(context).pop();
                    }),
              ),
            ),

            /////----title-------////

            TextField(
              controller: titleController,
              style: Theme.of(context).textTheme.headlineMedium,
              decoration: const InputDecoration(
                  border: InputBorder.none, labelText: "Post's title..."),
            ),

            ////-description-------////

            TextField(
              controller: descriptionController,
              style: Theme.of(context).textTheme.bodyMedium,
              decoration: const InputDecoration(
                  border: InputBorder.none, labelText: "Post's description..."),
            ),
            SizedBox(
              height: 20,
            ),

            ///-image url-------////

            TextField(
              controller: imageController,
              style: Theme.of(context).textTheme.bodyMedium,
              decoration: const InputDecoration(
                  border: InputBorder.none, labelText: "Post's image url..."),
            ),
          ],
        ),
      ),
    );
  }
}
