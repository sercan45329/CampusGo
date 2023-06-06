import 'package:campus_go/data/constants/my_colors.dart';
import 'package:campus_go/data/constants/phone_screen.dart';
import 'package:campus_go/service/user_management.dart';
import 'package:campus_go/widgets/forum/topic_card_list.dart';
import 'package:campus_go/widgets/forum/post_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class ForumPage extends StatelessWidget {
  const ForumPage({super.key});

  @override
  Widget build(BuildContext context) {
    var usermanager = UserManagement();
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    return Scaffold(
        backgroundColor: MyColors.appBackground,
        body: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                      padding: EdgeInsets.only(
                          left: context.screenWidth * 0.095,
                          top: context.screenHeight * 0.050),
                      child: const Text(
                        'Forum',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      )),
                ),
                FutureBuilder(
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
                            Navigator.pushNamed(context, "/SeeAllPostPage");
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
        bottomNavigationBar: GNav(
            backgroundColor: Colors.black,
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.grey.shade800,
            gap: 10,
            padding: EdgeInsets.all(context.screenHeight * 0.02),
            onTabChange: (value) {
              if (value == 1) {
                Navigator.pushNamed(context, "/AddPostPage");
              }
            },
            tabs: const [
              GButton(icon: Icons.home, text: 'Home'),
              GButton(icon: Icons.add, text: 'Add'),
              GButton(
                icon: Icons.settings,
                text: 'Settings',
              )
            ]));
  }
}
