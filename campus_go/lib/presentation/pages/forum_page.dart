import 'package:campus_go/data/constants/my_colors.dart';
import 'package:campus_go/data/constants/phone_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ForumPage extends StatelessWidget {
  const ForumPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    )),
              ),
              Align(
                child: Padding(
                  padding: EdgeInsets.only(
                      right: context.screenWidth * 0.095,
                      top: context.screenHeight * 0.050),
                  child: Container(
                    alignment: Alignment.centerRight,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: const BorderRadius.all(Radius.circular(40)),
                      color: MyColors.applicationMustUsedBlue,
                    ),
                    width: 98,
                    height: 42,
                  ),
                ),
              )
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
                top: context.screenHeight * 0.035,
                left: context.screenWidth * 0.1),
            child: SizedBox(
              height: 130,
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount:
                    4, // Replace with the actual number of items in your list
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Container(
                        width: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(40)),
                          color: index % 2 == 0
                              ? MyColors.applicationMustUsedBlue
                              : Colors.red,
                        ),

                        // Replace with the desired colors for each item
                      ),
                      const SizedBox(
                        width: 20,
                      )
                    ],
                  );
                },
              ),
            ),
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: EdgeInsets.only(
                      left: context.screenWidth * 0.095,
                      top: context.screenHeight * 0.035),
                  child: const Text(
                    'Trending Posts',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ))),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.only(
                left: context.screenWidth * 0.070,
                right: context.screenWidth * 0.070),
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomCenter,
                      stops: [
                        0.1,
                        0.6
                      ],
                      colors: [
                        Colors.white,
                        MyColors.applicationMustUsedBlue,
                      ]),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.blue),
              height: context.screenHeight * 0.25,
              width: context.screenWidth * 0.80,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.only(
                left: context.screenWidth * 0.070,
                right: context.screenWidth * 0.070),
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomCenter,
                      stops: [
                        0.1,
                        0.6
                      ],
                      colors: [
                        Colors.white,
                        MyColors.applicationMustUsedBlue,
                      ]),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.blue),
              height: context.screenHeight * 0.25,
              width: context.screenWidth * 0.80,
            ),
          )
        ],
      ),
    );
  }
}
