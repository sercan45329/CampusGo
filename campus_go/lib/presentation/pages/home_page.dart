import 'package:campus_go/data/constants/my_colors.dart';
import 'package:campus_go/data/constants/phone_screen.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColors.appBackground,
        body: Column(
          children: [
            SizedBox(height: 30.0),
            Row(
              children: const [
                Padding(padding: EdgeInsets.only(left: 30)),
                Icon(
                  Icons.face,
                  color: Colors.yellow,
                  size: 36.0,
                ),
                SizedBox(width: 8.0),
                Text(
                  "Hi, name here",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 8.0),
                Icon(
                  Icons.waving_hand,
                  color: Colors.yellow,
                  size: 30.0,
                ),
              ],
            ),
            const HomePic(),
            SizedBox(height: 70.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: context.screenWidth * 0.40,
                  height: context.screenHeight * 0.20,
                  decoration: BoxDecoration(
                    color: MyColors.applicationMustUsedBlue,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Center(
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
                SizedBox(width: 16.0),
                Container(
                  width: context.screenWidth * 0.40,
                  height: context.screenHeight * 0.20,
                  decoration: BoxDecoration(
                    color: MyColors.applicationMustUsedBlue,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Center(
                    child: Text(
                      'CAREER',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
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
                    Navigator.pushNamed(context, "/ForumPage");
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 16.0),
                    width: context.screenWidth * 0.85,
                    height: context.screenHeight * 0.20,
                    decoration: BoxDecoration(
                      color: MyColors.applicationMustUsedBlue,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Center(
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
        bottomNavigationBar: const NavBar());
  }
}
