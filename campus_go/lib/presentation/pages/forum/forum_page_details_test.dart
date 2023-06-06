/*import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../../models/model.dart';

class ForumPageDetailsTest extends StatelessWidget {
  //const ForumPageDetails({super.key});
  final Question question;
  // ignore: use_key_in_widget_constructors
  const ForumPageDetailsTest(String question, {this.question});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
              child: Row(
                children: <Widget>[
                  IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.arrow_back,
                        size: 20,
                        color: Colors.black,
                      )),
                  SizedBox(width: 5.0),
                  Text(
                    "View Post",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26.withOpacity(0.05),
                        offset: Offset(0.0, 6.0),
                        blurRadius: 10.0,
                        spreadRadius: 0.10)
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 60,
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/images/avatar.png'),
                                radius: 22,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      child: Text(
                                        question.author.name,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: .4),
                                      ),
                                    ),
                                    SizedBox(height: 2.0),
                                    Text(
                                      question.created_at,
                                      style: TextStyle(color: Colors.grey),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          Icon(
                            Icons.handshake,
                            color: Colors.grey.withOpacity(0.6),
                            size: 26,
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      child: Text(
                        question.question,
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.black.withOpacity(0.8),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      question.content,
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.4),
                          fontSize: 17,
                          letterSpacing: .2),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.handshake,
                                color: Colors.grey.withOpacity(0.5),
                                size: 22,
                              ),
                              SizedBox(width: 4.0),
                              Text(
                                "${question.votes} votes",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.withOpacity(0.5),
                                ),
                              )
                            ],
                          ),
                          SizedBox(width: 15.0),
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.handshake,
                                color: Colors.grey.withOpacity(0.5),
                                size: 18,
                              ),
                              SizedBox(width: 4.0),
                              Text(
                                "${question.views} views",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.withOpacity(0.5),
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.0, top: 20.0, bottom: 10.0),
              child: Text(
                "Replies (${question.replies.length})",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Column(
              children: question.replies
                  .map((reply) => Container(
                      margin:
                          EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26.withOpacity(0.03),
                              offset: Offset(0.0, 6.0),
                              blurRadius: 10.0,
                              spreadRadius: 0.10)
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: 60,
                              color: Colors.white,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      CircleAvatar(
                                        backgroundImage:
                                            AssetImage(reply.author.imageUrl),
                                        radius: 18,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                              child: Text(
                                                reply.author.name,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    letterSpacing: .4),
                                              ),
                                            ),
                                            SizedBox(height: 2.0),
                                            Text(
                                              question.created_at,
                                              style: TextStyle(
                                                  color: Colors.grey
                                                      .withOpacity(0.4)),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 15.0),
                              child: Text(
                                reply.content,
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.25),
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Icon(
                                  Icons.handshake,
                                  color: Colors.grey.withOpacity(0.5),
                                  size: 20,
                                ),
                                SizedBox(width: 5.0),
                                Text(
                                  "${reply.likes}",
                                  style: TextStyle(
                                      color: Colors.grey.withOpacity(0.5)),
                                )
                              ],
                            )
                          ],
                        ),
                      )))
                  .toList(),
            )
          ],
        ),
      ),
    );
  }
}*/