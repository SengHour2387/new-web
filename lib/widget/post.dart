import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game_talk/model/post_model.dart';

import '../service/posting.dart';

class Post extends StatefulWidget {
  final String id;
  final PostModel post;
  const Post({super.key, required this.post , required this.id});

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  int maxLine = 2;
  double rotate = 0;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    TextEditingController commentController = TextEditingController();

    return ClipRRect(
      child: AnimatedContainer(
        curve: Easing.emphasizedDecelerate,
        padding: const EdgeInsets.all(20),
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: width * 0.1),
        duration: const Duration(milliseconds: 300),
        decoration: ShapeDecoration(
          color: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.post.title,
                style: Theme.of(context).textTheme.headlineMedium),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 9,
                    child: AnimatedSize(
                        alignment: Alignment(-1, -1),
                        duration: Duration(milliseconds: 300),
                        child: Text(
                          widget.post.description,
                          maxLines: maxLine,
                          overflow: TextOverflow.ellipsis,
                        ))),
                Expanded(
                  flex: 1,
                  child: AnimatedRotation(
                    alignment: Alignment(0, 0),
                    duration: Duration(milliseconds: 200),
                    turns: rotate,
                    child: CupertinoButton(
                      child: Icon(
                        CupertinoIcons.chevron_down,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          rotate = rotate == 0 ? 0.5 : 0;
                          maxLine = maxLine == 2 ? 100 : 2;
                        });
                      },
                    ),
                  ),
                )
              ],
            ),
            widget.post.image != "" && widget.post.image != null
                ? PhysicalModel(
                    color: Colors.transparent,
                    elevation: 10,
                    borderRadius: BorderRadius.circular(width*0.03),
                    child: Container(
                      width: width,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(width*0.03),
                        child: Image(
                          fit: BoxFit.contain,
                          image: NetworkImage("https://cors-anywhere.herokuapp.com/${widget.post.image}",scale: 1),
                        )
                        ,
                      ),
                    ),
                  )
                : Container(),
            const SizedBox(
              height: 20,
            ),
            if(widget.post.comments != null)
            AnimatedContainer(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(width*0.03),
                color: Colors.grey.withAlpha(50),
              ),
              padding: EdgeInsets.symmetric(vertical: 20,horizontal: width*0.05),
              width: width,
              duration: Duration(milliseconds: 200),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.post.comments?.length,
                itemBuilder: (context, index) => Text( "${index+1}.     " + widget.post.comments?[index]),),
              ),
            TextField(
              controller: commentController,
              decoration: InputDecoration(
                labelText: "Comment"
              ),
            ),
            CupertinoButton(child: Icon(CupertinoIcons.arrow_right_circle_fill,color: Colors.black,),
              onPressed: () {
              Posting().addComment(postId: widget.id, comment: commentController.text.trim());
              commentController.clear();
            },),
          ],
        ),
      ),
    );
  }
}
