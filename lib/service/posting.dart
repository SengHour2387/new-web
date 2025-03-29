import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import '../model/post_model.dart';

class Posting {
  final _firstore = FirebaseFirestore.instance;

  Future<void> addPost({required PostModel post}) async {
    Map<String, dynamic> postData = {
      "title": post.title,
      "description": post.description,
      "image": post.image,
      "comments": post.comments,
    };
    await _firstore.collection("post").add(postData);
  }

  Stream<QuerySnapshot<Object?>> getPosts() {
    return _firstore.collection("post").snapshots();
  }
  Future<void> addComment({required String postId, required String comment}) async {
    final post = await _firstore.collection("post").doc(postId).get();

    List<dynamic> cmtList = post.data()?["comments"] ?? []; // Handle null case

    cmtList.add(comment);

    await _firstore.collection("post").doc(postId).set(
      {"comments": cmtList},
      SetOptions(merge: true),
    );
  }


}