import 'dart:math';
import 'package:campus_go/data/constants/my_colors.dart';
import 'package:campus_go/data/constants/phone_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:comment_box/comment/comment.dart';

import '../../../data/constants/my_colors.dart';
import '../../../widgets/forum/post_card_list.dart';

class ForumPageDetails extends StatefulWidget {
  const ForumPageDetails({super.key});

  @override
  State<ForumPageDetails> createState() => _ForumPageDetailsState();
}

class _ForumPageDetailsState extends State<ForumPageDetails> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();
  List filedata = [
    {
      'name': 'Chuks Okwuenu',
      'pic': 'https://picsum.photos/300/30',
      'message': 'I love to code',
      'date': '2021-01-01 12:00:00'
    },
    {
      'name': 'Biggi Man',
      'pic': 'https://www.adeleyeayodeji.com/img/IMG_20200522_121756_834_2.jpg',
      'message': 'Very cool',
      'date': '2021-01-01 12:00:00'
    },
    {
      'name': 'Tunde Martins',
      'pic': 'assets/img/userpic.jpg',
      'message': 'Very cool',
      'date': '2021-01-01 12:00:00'
    },
    {
      'name': 'Biggi Man',
      'pic': 'https://picsum.photos/300/30',
      'message': 'Very cool',
      'date': '2021-01-01 12:00:00'
    },
  ];

  Widget commentChild(data) {
    return Column(
      children: [
        Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(top: 40),
              child: postCardDetails(),
            )),
        Expanded(
          child: ListView(
            children: [
              for (var i = 0; i < data.length; i++)
                Padding(
                  padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
                  child: ListTile(
                    leading: GestureDetector(
                      onTap: () async {
                        // Display the image in large form.
                        print("Comment Clicked");
                      },
                      child: Container(
                        height: 50.0,
                        width: 50.0,
                        decoration: new BoxDecoration(
                            color: Color.fromARGB(255, 30, 137, 224),
                            borderRadius:
                                new BorderRadius.all(Radius.circular(50))),
                        child: CircleAvatar(
                            radius: 50,
                            backgroundImage: CommentBox.commentImageParser(
                                imageURLorPath: data[i]['pic'])),
                      ),
                    ),
                    title: Text(
                      data[i]['name'],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(data[i]['message']),
                    trailing:
                        Text(data[i]['date'], style: TextStyle(fontSize: 10)),
                  ),
                )
            ],
          ),
        ),
      ],
    );
  }
  /*Yukarıdaki kod parçasında, CommentBox widget'ının içinde commentImageBuilder adlı bir özellik eklenmiştir. Bu özellik, CommentBox içindeki görselin oluşturulmasını sağlar. Yukarıdaki kodda, commentImageBuilder ile bir SizedBox döndürerek görseli kaldırmış olursunuz. Böylece "Write comment" yazısının solundaki görsel kaldırılmış olur. */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: CommentBox(
          /*userImage: CommentBox.commentImageParser(
              imageURLorPath: "assets/img/userpic.jpg"),*/
          child: commentChild(filedata),
          labelText: 'Write a comment...',
          errorText: 'Comment cannot be blank',
          withBorder: false,
          sendButtonMethod: () {
            if (formKey.currentState!.validate()) {
              print(commentController.text);
              setState(() {
                var value = {
                  'name': 'New User',
                  'pic':
                      'https://lh3.googleusercontent.com/a-/AOh14GjRHcaendrf6gU5fPIVd8GIl1OgblrMMvGUoCBj4g=s400',
                  'message': commentController.text,
                  'date': '2021-01-01 12:00:00'
                };
                filedata.insert(0, value);
              });
              commentController.clear();
              FocusScope.of(context).unfocus();
            } else {
              print("Not validated");
            }
          },
          formKey: formKey,
          commentController: commentController,
          backgroundColor: Colors.black54,
          textColor: Colors.white,
          sendWidget: Icon(Icons.send_sharp, size: 30, color: Colors.white),
        ),
      ),
    );
  }

  Container postCardDetails() {
    var profileURL =
        "https://www.google.com/url?sa=i&url=https%3A%2F%2Funsplash.com%2Fs%2Fphotos%2Fimage&psig=AOvVaw0VDQD7lLuIYOq7dvJKMPL0&ust=1685787621574000&source=images&cd=vfe&ved=0CBEQjRxqFwoTCMCVoLSupP8CFQAAAAAdAAAAABAE";
    var name = "test";
    var likenum = 3;
    var comnum = 3;
    var title = "TEST";
    var description =
        "here are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour";
    var category = 'gaming';
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
      width: context.screenWidth * 0.80,
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
                    const Icon(
                      Icons.thumb_up_alt_outlined,
                      color: Colors.white,
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
              ],
            ),
          )
        ],
      ),
    );
  }
}
