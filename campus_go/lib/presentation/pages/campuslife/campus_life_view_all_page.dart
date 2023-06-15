import 'package:campus_go/data/constants/phone_screen.dart';
import 'package:campus_go/service/event_management.dart';
import 'package:campus_go/service/user_management.dart';
import 'package:flutter/material.dart';

import '../../../data/constants/my_colors.dart';
import 'event_details_page.dart';

class ViewAllPageCampusLife extends StatefulWidget {
  const ViewAllPageCampusLife({super.key});

  @override
  State<ViewAllPageCampusLife> createState() => _ViewAllPageCampusLifeState();
}

class _ViewAllPageCampusLifeState extends State<ViewAllPageCampusLife> {
  @override
  final usermanager = UserManagement();
  final eventmanager = EventManagement();
  var searchValue = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GestureDetector(
          onTap: () {
            Navigator.pushReplacementNamed(context, "/AddEventPage");
          },
          child: Container(
            decoration: BoxDecoration(
                color: MyColors.applicationMustUsedBlue,
                borderRadius: const BorderRadius.all(Radius.circular(25.0))),
            child: const Padding(
                padding: EdgeInsets.all(10.0), child: Icon(Icons.add)),
          ),
        ),
      ),
      body: Column(children: [
        Row(
          children: [
            Padding(
                padding: EdgeInsets.only(
                    left: context.screenWidth * 0.050,
                    top: context.screenHeight * 0.050),
                child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, "/EventPage");
                    },
                    child: const Icon(Icons.arrow_back))),
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
            GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(context, "/ProfilePage");
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
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  hintText: "Search",
                ),
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
    );
  }

  GestureDetector jobPostingCard(Map<String, dynamic>? data) {
    var maxParticipant = data!['maxParticipant'];
    var activeParticipant = data['activeParticipant'];
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => EventDetailsPage(data: data),
          ),
        );
      },
      child: Container(
        height: context.screenHeight * 0.10,
        width: context.screenWidth * 0.85,
        decoration: BoxDecoration(
            color: MyColors.applicationMustUsedBlue,
            borderRadius: BorderRadius.circular(50)),
        child: Row(
          children: [
            FutureBuilder(
                future: usermanager.getProfileURLByID(data['addedBy']),
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
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        data['title'] + '/',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        data['date'],
                        style: const TextStyle(
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
      ),
    );
  }

  FutureBuilder<List<Map<String, dynamic>>> jobPostingCardList() {
    return FutureBuilder(
      future: eventmanager.getAllPosts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        var list = snapshot.data;
        if (list!.isEmpty) {
          return Container();
        }
        return ListView.separated(
          itemCount: list.length,
          itemBuilder: (context, index) {
            var data = snapshot.data![index];
            if (data['title']
                .toString()
                .toLowerCase()
                .startsWith(searchValue.toLowerCase())) {
              return jobPostingCard(data);
            }

            return Container();
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
