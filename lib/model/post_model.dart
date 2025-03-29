import 'package:flutter/cupertino.dart';

class PostModel {
  final String title;
  final String description;
  final String? image;
  final List<dynamic>? comments;
  PostModel({required this.description,this.image,this.comments, required this.title});
  ImageProvider img() => NetworkImage(image!,scale: 1);

}
