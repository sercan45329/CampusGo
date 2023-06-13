import 'package:campus_go/data/constants/my_colors.dart';
import 'package:campus_go/data/constants/phone_screen.dart';
import 'package:campus_go/service/user_management.dart';
import 'package:campus_go/widgets/forum/topic_card_list.dart';
import 'package:campus_go/widgets/forum/post_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class ForumPage extends StatefulWidget {
  const ForumPage({super.key});

  @override
  State<ForumPage> createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  @override
  Widget build(BuildContext context) {
    setState(() {});
    var usermanager = UserManagement();
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, "/AddPostPage");
          },
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(25.0))),
            child: const Padding(
                padding: EdgeInsets.all(10.0), child: Icon(Icons.add)),
          ),
        ),
      ),
      backgroundColor: MyColors.appBackground,
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                  padding: EdgeInsets.only(
                      left: context.screenWidth * 0.050,
                      top: context.screenHeight * 0.050),
                  child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, "/HomePage");
                      },
                      child: const Icon(Icons.arrow_back))),
              Expanded(
                child: Padding(
                    padding: EdgeInsets.only(
                        left: context.screenWidth * 0.095,
                        top: context.screenHeight * 0.050),
                    child: const Text(
                      'Forum',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    )),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, "/ProfilePage");
                },
                child: FutureBuilder(
                    future: usermanager
                        .getProfileURLByID(usermanager.getCurrentUserID()),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }
                      return Align(
                        child: Padding(
                            padding: EdgeInsets.only(
                                right: context.screenWidth * 0.095,
                                top: context.screenHeight * 0.050),
                            child: CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage(snapshot.data!),
                            )),
                      );
                    }),
              ),
            ],
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: EdgeInsets.only(
                      left: context.screenWidth * 0.095,
                      top: context.screenHeight * 0.035),
                  child: const Text(
                    'Popular Topics',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ))),
          Padding(
            padding: EdgeInsets.only(
                bottom: 10,
                top: context.screenHeight * 0.020,
                left: context.screenWidth * 0.1),
            child: const SizedBox(
              height: 110,
              width: double.infinity,
              child: TopicCardList(),
            ),
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: EdgeInsets.only(
                      left: context.screenWidth * 0.095,
                      top: context.screenHeight * 0.020),
                  child: Row(
                    children: [
                      const Text(
                        'Popular Posts',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      SizedBox(
                        width: context.screenWidth * 0.4,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, "/SeeAllPostPage");
                        },
                        child: const Text(
                          'See all',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ))),
          const SizedBox(
            height: 10,
          ),
          const Expanded(child: PostCardList()),
        ],
      ),
    );
  }
}
