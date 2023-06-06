import 'package:campus_go/data/constants/phone_screen.dart';
import 'package:campus_go/service/event_management.dart';
import 'package:campus_go/service/user_management.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../../data/constants/my_colors.dart';

class ViewAllPageCampusLife extends StatefulWidget {
  const ViewAllPageCampusLife({super.key});

  @override
  State<ViewAllPageCampusLife> createState() => _ViewAllPageCampusLifeState();
}

class _ViewAllPageCampusLifeState extends State<ViewAllPageCampusLife> {
  @override
  bool _isDisposed = false;
  @override
  void dispose() {
    _isDisposed = true;
    // TODO: implement dispose
    super.dispose();
  }

  final usermanager = UserManagement();
  final eventmanager = EventManagement();
  var searchValue = "";
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
                    'Join your\ndream event',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
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
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40.0),
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                ),
              ),
              child: TextFormField(
                onChanged: (value) {
                  setState(() {
                    searchValue = value;
                  });
                },
                decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    hintText: "Search",
                    suffixIcon: IconButton(
                        icon: const Icon(Icons.filter_alt),
                        onPressed: () {
                          Navigator.pushNamed(context, "/FilterPage");
                        },
                        color: MyColors.applicationMustUsedBlue)),
              )),
        ),
        Align(
            alignment: Alignment.centerLeft,
            child: Padding(
                padding: EdgeInsets.only(
                  left: context.screenWidth * 0.095,
                ),
                child: const Text(
                  'All Events',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ))),
        Expanded(
            child: Padding(
                padding: const EdgeInsets.all(15), child: jobPostingCardList()))
      ]),
      bottomNavigationBar: GNav(
          backgroundColor: Colors.black,
          color: Colors.white,
          activeColor: Colors.white,
          tabBackgroundColor: Colors.grey.shade800,
          gap: 10,
          padding: EdgeInsets.all(context.screenHeight * 0.02),
          onTabChange: (value) {
            if (value == 1) {
              if (!_isDisposed) {
                Navigator.pushReplacementNamed(context, "/AddEventPage");
              }
            }
          },
          tabs: const [
            GButton(icon: Icons.home, text: 'Home'),
            GButton(icon: Icons.add, text: 'Add'),
            GButton(
              icon: Icons.settings,
              text: 'Settings',
            )
          ]),
    );
  }

  Container jobPostingCard(Map<String, dynamic>? data) {
    var maxParticipant = data!['maxParticipant'];
    var activeParticipant = data['activeParticipant'];
    return Container(
      height: context.screenHeight * 0.10,
      width: context.screenWidth * 0.85,
      decoration: BoxDecoration(
          color: MyColors.applicationMustUsedBlue,
          borderRadius: BorderRadius.circular(50)),
      child: Row(
        children: [
          FutureBuilder(
              future:
                  usermanager.getProfileURLByID(usermanager.getCurrentUserID()),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                return Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(snapshot.data!),
                  ),
                );
              }),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      data!['title'],
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: context.screenWidth * 0.35,
                    ),
                    Text(
                      data['date'],
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5, left: 10),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(20)),
                            height: context.screenHeight * 0.1,
                            width: context.screenWidth * 0.15,
                            child: Center(
                                child: Text(
                              data['location'],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10),
                            )),
                          ),
                          const SizedBox(
                            width: 5,
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5, left: 10),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(20)),
                            height: context.screenHeight * 0.1,
                            width: context.screenWidth * 0.15,
                            child: Center(
                                child: Text(
                              data['price'].toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10),
                            )),
                          ),
                          const SizedBox(
                            width: 5,
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5, left: 10),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(20)),
                            height: context.screenHeight * 0.1,
                            width: context.screenWidth * 0.15,
                            child: Center(
                                child: Text(
                              "$activeParticipant/$maxParticipant",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10),
                            )),
                          ),
                          const SizedBox(
                            width: 5,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  FutureBuilder<List<Map<String, dynamic>>> jobPostingCardList() {
    return FutureBuilder(
      future: eventmanager.getAllPosts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        var list = snapshot.data;
        return ListView.separated(
          itemCount: list!.length,
          itemBuilder: (context, index) {
            var data = snapshot.data![index];
            return jobPostingCard(data);
          },
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 10,
            );
          },
        );
      },
    );
  }
}
