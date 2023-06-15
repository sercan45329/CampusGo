import 'package:campus_go/data/constants/phone_screen.dart';
import 'package:campus_go/presentation/pages/campuslife/event_details_page.dart';
import 'package:campus_go/service/event_management.dart';
import 'package:campus_go/service/user_management.dart';
import 'package:flutter/material.dart';

import '../../../data/constants/my_colors.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  final usermanager = UserManagement();
  final eventmanager = EventManagement();
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
            decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(Radius.circular(25.0))),
            child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                )),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                flex: 20,
                child: Padding(
                    padding: EdgeInsets.only(
                        left: context.screenWidth * 0.095,
                        top: context.screenHeight * 0.050),
                    child: const Text(
                      'Join your\ndream event',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
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
          const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Featured Events',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              )),
          Container(
              height: context.screenHeight * 0.25,
              child: minimalEventCardList()),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                  padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: Text(
                    'All Events',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  )),
              Padding(
                padding: const EdgeInsets.only(right: 30.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(
                        context, "/ViewAllPageCampusLife");
                  },
                  child: const Text('See all',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: jobPostingCardList()),
          )
        ],
      ),
    );
  }

  GestureDetector jobPostingCard(Map<String, dynamic>? data) {
    var maxParticipant = data!['maxParticipant'];
    var activeParticipant = data['activeParticipant'];
    var location = data['location'];
    if (location.length > 7) {
      location = location.substring(0, 7) + '...';
    }
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                location,
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

  GestureDetector minimalEventCard(var data) {
    var title = data['title'];
    var price = data['price'];
    var maxParticipant = data['maxParticipant'];
    var activeParticipant = data['activeParticipant'];
    var date = data['date'];
    var location = data['location'];
    if (location.length > 7) {
      location = location.substring(0, 7) + '...';
    }
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
        width: context.screenWidth * 0.7,
        decoration: BoxDecoration(
            color: MyColors.applicationMustUsedBlue,
            borderRadius: BorderRadius.circular(30)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FutureBuilder(
                    future: usermanager.getProfileURLByID(data['addedBy']),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }
                      return Padding(
                        padding: const EdgeInsets.all(20),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(snapshot.data!),
                        ),
                      );
                    }),
                Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Text(
                      '$date',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold),
                    ))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Text(
                      '$title',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    )),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(20)),
                    height: context.screenHeight * 0.02,
                    width: context.screenWidth * 0.15,
                    child: Center(
                        child: Text(
                      '$location',
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 10),
                    )),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(20)),
                    height: context.screenHeight * 0.02,
                    width: context.screenWidth * 0.15,
                    child: Center(
                        child: Text(
                      '$price',
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 10),
                    )),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(20)),
                    height: context.screenHeight * 0.02,
                    width: context.screenWidth * 0.15,
                    child: Center(
                        child: Text(
                      '$activeParticipant/$maxParticipant',
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 10),
                    )),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  ListView minimalEventCardList() {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: 2, // Replace with the actual number of items in your list
      itemBuilder: (context, index) {
        return FutureBuilder(
          future: eventmanager.getMostParticipatedEvents(2),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            var list = snapshot.data;
            var data = list![index];
            if (list.isEmpty) {
              return Container();
            }
            return Padding(
                padding: const EdgeInsets.only(left: 10),
                child: minimalEventCard(data));
          },
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(
          width: 10,
        );
      },
    );
  }
}
