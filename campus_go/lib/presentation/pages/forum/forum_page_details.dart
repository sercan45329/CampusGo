import 'package:campus_go/data/constants/my_colors.dart';
import 'package:campus_go/data/constants/phone_screen.dart';
import 'package:campus_go/presentation/pages/forum/edit_post_page.dart';
import 'package:campus_go/service/topic_management.dart';
import 'package:campus_go/service/user_management.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:comment_box/comment/comment.dart';
import '../../../service/comment_management.dart';
import '../../../service/post_management.dart';

class ForumPageDetails extends StatefulWidget {
  final userData;
  final postData;
  final currentUser;
  const ForumPageDetails(
      {super.key,
      required this.userData,
      required this.postData,
      required this.currentUser});

  @override
  State<ForumPageDetails> createState() => _ForumPageDetailsState();
}

class _ForumPageDetailsState extends State<ForumPageDetails> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();
  final usermanager = UserManagement();
  final commentmanager = CommentManagement();
  final postmanager = PostManagement();
  Color? likeColor;

  Widget commentChild() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: EdgeInsets.only(
                  left: context.screenWidth * 0.050,
                  top: context.screenHeight * 0.050,
                  right: context.screenWidth * 0.025,
                ),
                child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, "/ForumPage");
                    },
                    child: const Icon(Icons.arrow_back))),
            Expanded(
                flex: 8,
                child: Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: FutureBuilder(
                    future: postmanager.getPostByID(widget.postData['postID']),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }
                      var data = snapshot.data;
                      return postCardDetails(
                          data!['commentNum'], data!['likeNum']);
                    },
                  ),
                )),
            const Expanded(flex: 1, child: SizedBox())
          ],
        ),
        FutureBuilder(
            future: commentmanager.getAllComments(widget.postData['postID']),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }

              var commentList = snapshot.data;

              return commentList == null
                  ? const SizedBox(
                      height: 200,
                    )
                  : Expanded(
                      child: ListView(
                        children: [
                          for (var i = 0; i < commentList.length; i++)
                            Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    2.0, 8.0, 2.0, 0.0),
                                child: FutureBuilder(
                                    future: usermanager
                                        .getUserByID(commentList[i]['addedBy']),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const CircularProgressIndicator();
                                      }
                                      var user = snapshot.data;
                                      return ListTile(
                                        leading: GestureDetector(
                                          onTap: () async {},
                                          child: Container(
                                            height: 50.0,
                                            width: 50.0,
                                            decoration: const BoxDecoration(
                                                color: Color.fromARGB(
                                                    255, 30, 137, 224),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(50))),
                                            child: CircleAvatar(
                                                radius: 50,
                                                backgroundImage: CommentBox
                                                    .commentImageParser(
                                                        imageURLorPath: user![
                                                            'profileURL'])),
                                          ),
                                        ),
                                        title: Text(
                                          user['name'],
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle:
                                            Text(commentList[i]['description']),
                                        trailing: Text(
                                            commentList[i]['timestamp']
                                                .toDate()
                                                .toString(),
                                            style:
                                                const TextStyle(fontSize: 10)),
                                      );
                                    }))
                        ],
                      ),
                    );
            }),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: CommentBox(
      userImage: CommentBox.commentImageParser(
          imageURLorPath: NetworkImage(widget.currentUser!['profileURL'])),
      labelText: 'Write a comment...',
      errorText: 'Comment cannot be blank',
      withBorder: false,
      sendButtonMethod: () async {
        if (formKey.currentState!.validate()) {
          await commentmanager.addComment(
              widget.postData['postID'],
              commentController.text,
              widget.currentUser['name'],
              widget.currentUser['profileURL']);

          await postmanager.increaseCommentNum(widget.postData['postID']);

          commentController.clear();
          FocusScope.of(context).unfocus();
        }
        setState(() {});
      },
      formKey: formKey,
      commentController: commentController,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      sendWidget: const Icon(Icons.send_sharp, size: 30, color: Colors.white),
      child: commentChild(),
    )));
  }

  Container postCardDetails(var comnum, var likenum) {
    var profileURL = widget.userData['profileURL'];
    var name = widget.userData['name'];
    var title = widget.postData['title'];
    var description = widget.postData['description'];
    var category = widget.postData['category'];
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomCenter,
              stops: const [
                0.1,
                0.6
              ],
              colors: [
                Colors.white,
                MyColors.applicationMustUsedBlue,
              ]),
          shape: BoxShape.rectangle,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: Colors.blue),
      height: context.screenHeight * 0.45,
      width: context.screenWidth * 0.70,
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(profileURL!),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, right: 10.0),
                      child: Text(
                        "$category-$title",
                        style: const TextStyle(fontSize: 17),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      name,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              )
            ],
          ),
          Expanded(
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                      child: Text(
                        description,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )))),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, bottom: 10.0),
            child: Row(
              children: [
                Row(
                  children: [
                    FutureBuilder(
                      future:
                          postmanager.checkIfLiked(widget.postData['postID']),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        }
                        return IconButton(
                            onPressed: () async {
                              var data = await postmanager
                                  .getPostByID(widget.postData['postID']);
                              var currentUserID =
                                  usermanager.getCurrentUserID();
                              var docRef = await postmanager
                                  .getPostDocRefByID(widget.postData['postID']);

                              var likeList = List.from(data!['likes']);
                              if (!likeList.contains(currentUserID)) {
                                likeColor = Colors.green.shade600;
                                await docRef.update({
                                  'likes':
                                      FieldValue.arrayUnion([currentUserID]),
                                  'likeNum': FieldValue.increment(1)
                                });
                              } else if (likeList.contains(currentUserID)) {
                                likeColor = Colors.white;
                                await docRef.update(
                                  {
                                    'likes':
                                        FieldValue.arrayRemove([currentUserID]),
                                    'likeNum': FieldValue.increment(-1)
                                  },
                                );
                              }
                              setState(() {});
                            },
                            icon: Icon(
                              Icons.thumb_up,
                              color: snapshot.data,
                            ));
                      },
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(likenum.toString()),
                  ],
                ),
                const SizedBox(
                  width: 20,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.comment,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(comnum.toString())
                  ],
                ),
                (usermanager.getCurrentUserID() == widget.postData['addedBy'] ||
                        usermanager.getCurrentEmail() == 'admin@isik.edu.tr')
                    ? Padding(
                        padding: EdgeInsets.only(
                            left: context.screenWidth * 0.150,
                            right: context.screenWidth * 0.05),
                        child: IconButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      EditPostPage(postData: widget.postData),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.white,
                            )),
                      )
                    : Container(),
                (usermanager.getCurrentUserID() == widget.postData['addedBy'] ||
                        usermanager.getCurrentEmail() == 'admin@isik.edu.tr')
                    ? GestureDetector(
                        onTap: () async {
                          var result;
                          if (widget.postData['addedBy'] ==
                              usermanager.getCurrentUserID()) {
                            result = await postmanager
                                .deletePost(widget.postData['postID']);
                            if (result == 'Success') {
                              await TopicManagement()
                                  .descreasePostNumByCategory(
                                      widget.postData['category']);
                            }
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text(result)));
                            Navigator.pushReplacementNamed(
                                context, "/ForumPage");
                          } else if (widget.postData['addedBy'] !=
                              usermanager.getCurrentUserID()) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content:
                                    Text('You dont have the permission!')));
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text(result)));
                          }
                        },
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ))
                    : Container()
              ],
            ),
          )
        ],
      ),
    );
  }
}
