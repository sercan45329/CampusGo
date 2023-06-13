import 'package:campus_go/data/constants/phone_screen.dart';
import 'package:campus_go/service/user_management.dart';
import 'package:flutter/material.dart';

class CareerPage extends StatefulWidget {
  const CareerPage({super.key});

  @override
  State<CareerPage> createState() => _CareerPageState();
}

class _CareerPageState extends State<CareerPage> {
  final usermanager = UserManagement();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                  padding: EdgeInsets.only(
                      left: context.screenWidth * 0.095,
                      top: context.screenHeight * 0.050),
                  child: const Text(
                    'Discover your\ndream job',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
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
                  'Recent Jobs',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                )))
      ]),
    );
  }

  Row topicCard(int index, List<Map<String, dynamic>>? data) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          width: 180,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomCenter,
                colors: index % 2 == 0
                    ? [
                        Colors.purple,
                        Colors.black,
                      ]
                    : [
                        Colors.orange,
                        Colors.red,
                      ]),
            shape: BoxShape.rectangle,
            borderRadius: const BorderRadius.all(Radius.circular(40)),
          ),
          child: Column(
            children: [
              Text(
                data![index]["title"].toString(),
                style: const TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "${data[index]["postNumber"]} POST",
                style: const TextStyle(fontSize: 18, color: Colors.white),
              )
            ],
          ),

          // Replace with the desired colors for each item
        ),
        const SizedBox(
          width: 20,
        )
      ],
    );
  }
}
