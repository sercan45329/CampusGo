import 'package:campus_go/data/constants/phone_screen.dart';
import 'package:campus_go/presentation/pages/career/career_details_page.dart';
import 'package:campus_go/service/job_management.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../data/constants/my_colors.dart';
import '../../../service/event_management.dart';
import '../../../service/user_management.dart';

class CareerViewAll extends StatefulWidget {
  const CareerViewAll({super.key});

  @override
  State<CareerViewAll> createState() => _CareerViewAllState();
}

class _CareerViewAllState extends State<CareerViewAll> {
  @override
  final usermanager = UserManagement();
  final eventmanager = EventManagement();
  final jobmanager = JobManagement();
  var searchValue = "";
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
                  decoration: BoxDecoration(
                      color: MyColors.applicationMustUsedBlue,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(25.0))),
                  child: const Padding(
                      padding: EdgeInsets.all(10.0), child: Icon(Icons.add)),
                ),
              ),
            )
          : Container(),
      body: Column(children: [
        Row(
          children: [
            Padding(
                padding: EdgeInsets.only(
                    left: context.screenWidth * 0.050,
                    top: context.screenHeight * 0.050),
                child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, "/CareerPage");
                    },
                    child: const Icon(Icons.arrow_back))),
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
                  'All Jobs',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ))),
        Expanded(
            child: Padding(
                padding: const EdgeInsets.all(15), child: jobPostingCardList()))
      ]),
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

        return ListView.separated(
          itemCount: list!.length,
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
