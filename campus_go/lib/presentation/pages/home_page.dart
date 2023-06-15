import 'package:campus_go/data/constants/my_colors.dart';
import 'package:campus_go/data/constants/phone_screen.dart';
import 'package:campus_go/service/user_management.dart';
import 'package:campus_go/widgets/nav_Bar.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'package:campus_go/widgets/home_page_widgets/home_pic.dart';
import 'package:campus_go/widgets/home_page_widgets/home_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final usermanager = UserManagement();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.appBackground,
      body: Column(
        children: [
          SizedBox(height: 30.0),
          Row(
            children: [
              Padding(padding: EdgeInsets.only(left: 30)),
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
                      return CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(snapshot.data!),
                      );
                    }),
              ),
              const SizedBox(width: 8.0),
              FutureBuilder(
                  future: usermanager.getCurrentUser(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    var name = snapshot.data!['name'];
                    return Text(
                      "Hi, $name",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }),
              SizedBox(width: 8.0),
              const Icon(
                Icons.waving_hand,
                color: Colors.yellow,
                size: 30.0,
              ),
            ],
          ),
          const HomePic(),
          const SizedBox(height: 70.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  if (usermanager.getCurrentEmail() ==
                      'careereditor@isik.edu.tr') {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("You don't have permission to do that")));
                    return;
                  }
                  Navigator.pushReplacementNamed(context, "/EventPage");
                },
                child: Container(
                  width: context.screenWidth * 0.40,
                  height: context.screenHeight * 0.20,
                  decoration: BoxDecoration(
                    color: MyColors.applicationMustUsedBlue,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: const Center(
                    child: Text(
                      'CAMPUS LIFE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16.0),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(context, "/CareerPage");
                },
                child: Container(
                  width: context.screenWidth * 0.40,
                  height: context.screenHeight * 0.20,
                  decoration: BoxDecoration(
                    color: MyColors.applicationMustUsedBlue,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: const Center(
                    child: Text(
                      'CAREER',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  if (usermanager.getCurrentEmail() ==
                      'careereditor@isik.edu.tr') {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("You don't have permission to do that")));
                    return;
                  }
                  Navigator.pushReplacementNamed(context, "/ForumPage");
                },
                child: Container(
                  margin: EdgeInsets.only(top: 16.0),
                  width: context.screenWidth * 0.85,
                  height: context.screenHeight * 0.20,
                  decoration: BoxDecoration(
                    color: MyColors.applicationMustUsedBlue,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: const Center(
                    child: Text(
                      'FORUM',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
