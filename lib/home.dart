import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game_talk/model/post_model.dart';
import 'package:game_talk/post_screen.dart';
import 'package:game_talk/service/posting.dart';
import 'package:game_talk/widget/blurred_appbar.dart';
import 'package:game_talk/widget/post.dart';
import 'package:soft_edge_blur/soft_edge_blur.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

    @override
    Widget build(BuildContext context) {

      return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: BlurredAppbar(
          appBar: AppBar(
            title: const Text(
              "Communities",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.white.withOpacity(0),
            actions: [
              CupertinoButton(
                onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => PostScreen()));
                },
                child: PhysicalModel(
                  borderRadius: BorderRadius.circular(20),
                  elevation: 5,
                  color: Colors.transparent,
                  child: const Icon(
                    CupertinoIcons.add_circled_solid,
                    color: Colors.black,
                  ),
                ),)
            ],
          ),
        ),
        body: StreamBuilder(
          stream:  Posting().getPosts(),
          builder: (context, snapshot) {

            final posts = snapshot.data?.docs;

            if(snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(),);
            }
            if(snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()),);
            }
            if(snapshot.data?.size == 0) {
              return const Center(child: Text("No posts"),);
            }

            return ListView.builder(
              itemCount: snapshot.data?.size,
              itemBuilder: (context, index) {

                final post = PostModel(description: posts?[index]["description"], image: posts?[index]["image"], title: posts?[index]["title"],comments: posts?[index]["comments"]);

                return Post(
                  id: posts![index].id,
                  post: post,
                ) ;
              }
              ,
            );
          }
          ,
        ),
      );
    }
  }