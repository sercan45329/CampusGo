import 'package:campus_go/data/constants/phone_screen.dart';
import 'package:campus_go/presentation/pages/career/career_details_page.dart';
import 'package:campus_go/service/job_management.dart';
import 'package:campus_go/service/user_management.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../data/constants/my_colors.dart';
import '../../../service/event_management.dart';
import '../campuslife/event_details_page.dart';

class CareerPage extends StatefulWidget {
  const CareerPage({super.key});

  @override
  State<CareerPage> createState() => _CareerPageState();
}

class _CareerPageState extends State<CareerPage> {
  final usermanager = UserManagement();
  final eventmanager = EventManagement();
  final jobmanager = JobManagement();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: (usermanager.getCurrentEmail() ==
                  'careereditor@isik.edu.tr' ||
              usermanager.getCurrentEmail() == 'admin@isik.edu.tr')
          ? Padding(
              padding: const EdgeInsets.all(20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(context, "/AddJobPostPage");
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
            )
          : Container(),
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
                      'Discover your\ndream job',
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
                'Recent Jobs',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              )),
          SizedBox(
              height: context.screenHeight * 0.25,
              child: minimalEventCardList()),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                  padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: Text(
                    'All Jobs',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  )),
              Padding(
                padding: const EdgeInsets.only(right: 30.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(
                        context, "/CareerViewAllPage");
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
    var title = data!['title'];
    var salary = data['salary'];
    Timestamp timestamp = data['dateCreated'];
    var date = timestamp.toDate();
    String dateString = '${date.year}-${date.month}-${date.day}';
    var type = data['type'];
    var category = data['category'];
    var shortenedCategory = '';
    if (category.length > 7) {
      shortenedCategory = category.substring(0, 7);
    }
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => CareerDetailsPage(jobData: data),
          ),
        );
      },
      child: Container(
        height: context.screenHeight * 0.10,
        width: context.screenWidth * 0.85,
        decoration: BoxDecoration(
            color: MyColors.applicationMustUsedBlue,
            borderRadius: BorderRadius.circular(50)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    flex: 5,
                    child: Text(
                      title,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      dateString,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 25.0),
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
                              (category.length > 10)
                                  ? '$shortenedCategory...'
                                  : category,
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
                              type,
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
                        children: const [
                          SizedBox(
                            width: 5,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  FutureBuilder<List<Map<String, dynamic>>> jobPostingCardList() {
    return FutureBuilder(
      future: jobmanager.getAllJobs(),
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
    var shortenedTitle = '';
    if (title.length > 15) {
      shortenedTitle = title.substring(0, 15);
    }
    var salary = data['salary'];
    var location = data['location'];
    var type = data['type'];
    var category = data['category'];
    var shortenedCategory = '';
    if (category.length > 7) {
      shortenedCategory = category.substring(0, 7);
    }
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => CareerDetailsPage(jobData: data),
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
                Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      (title.length <= 15) ? title : '$shortenedTitle...',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    )),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(20)),
                    height: context.screenHeight * 0.02,
                    width: context.screenWidth * 0.15,
                    child: Center(
                        child: Text(
                      (category.length > 10)
                          ? '$shortenedCategory...'
                          : category,
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
                      '$type',
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 10),
                    )),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 15.0, top: 15.0),
                  child: Icon(
                    Icons.location_on,
                    color: Colors.white,
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Padding(
                      padding: const EdgeInsets.only(left: 5.0, top: 15.0),
                      child: Text('$location',
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15))),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Text('$salary',
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10))),
                )
              ],
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
          future: jobmanager.getRecentJobs(2),
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
