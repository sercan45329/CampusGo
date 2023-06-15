import 'package:campus_go/data/constants/phone_screen.dart';
import 'package:flutter/material.dart';

import '../../../service/event_management.dart';
import '../../../service/job_management.dart';
import '../../../service/user_management.dart';
import 'edit_career_page.dart';

class CareerDetailsPage extends StatefulWidget {
  final jobData;
  const CareerDetailsPage({super.key, required this.jobData});

  @override
  State<CareerDetailsPage> createState() => _CareerDetailsPageState();
}

class _CareerDetailsPageState extends State<CareerDetailsPage> {
  final usermanager = UserManagement();
  final eventmanager = EventManagement();
  final jobmanager = JobManagement();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: (usermanager.getCurrentEmail() ==
                'careereditor@isik.edu.tr')
            ? Padding(
                padding: const EdgeInsets.all(20.0),
                child: GestureDetector(
                  onTap: () async {
                    Navigator.pushReplacementNamed(context, "/AddJobPostPage");
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(52, 87, 199, 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(25.0))),
                    child: const Padding(
                        padding: EdgeInsets.all(10.0), child: Icon(Icons.add)),
                  ),
                ),
              )
            : Container(),
        backgroundColor: const Color.fromRGBO(52, 87, 199, 1.0),
        body: Column(
          children: [
            Row(
              children: [
                Padding(
                    padding: EdgeInsets.only(
                        left: context.screenWidth * 0.050,
                        top: context.screenHeight * 0.050),
                    child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, "/CareerPage");
                        },
                        child: const Icon(Icons.arrow_back))),
                Padding(
                    padding: EdgeInsets.only(
                        left: context.screenWidth * 0.050,
                        top: context.screenHeight * 0.050),
                    child: const Text(
                      'View Jobs',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    )),
                const SizedBox(
                  width: 110,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, "/ProfilePage");
                  },
                  child: FutureBuilder(
                      future: usermanager
                          .getProfileURLByID(usermanager.getCurrentUserID()),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
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
                )
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: context.screenHeight * 0.050),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Company Name: ${widget.jobData['company']}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        Text('Company Phone: ${widget.jobData['companyPhone']}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        Text('Field: ${widget.jobData['category']}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                ),
                (usermanager.getCurrentEmail() == 'careereditor@isik.edu.tr' ||
                        usermanager.getCurrentEmail() == 'admin@isik.edu.tr')
                    ? Padding(
                        padding: EdgeInsets.only(
                            top: context.screenHeight * 0.050,
                            left: context.screenWidth * 0.050),
                        child: GestureDetector(
                          onTap: () async {
                            var result = await jobmanager
                                .deleteJob(widget.jobData['jobID']);

                            if (result != 'Success') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(result)));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(result)));
                            }

                            Navigator.pushReplacementNamed(
                                context, "/CareerPage");
                          },
                          child: const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Icon(Icons.delete)),
                        ),
                      )
                    : Container(),
                (usermanager.getCurrentEmail() == 'careereditor@isik.edu.tr' ||
                        usermanager.getCurrentEmail() == 'admin@isik.edu.tr')
                    ? Padding(
                        padding:
                            EdgeInsets.only(top: context.screenHeight * 0.050),
                        child: IconButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      EditCareerPage(jobData: widget.jobData),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.black,
                            )),
                      )
                    : Container()
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: context.screenHeight * 0.025,
                  left: context.screenWidth * 0.050),
              child: Row(
                children: [
                  const Icon(
                    Icons.location_on_sharp,
                  ),
                  Text('${widget.jobData['location']}',
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  const SizedBox(
                    width: 10,
                  ),
                  const Icon(Icons.mail),
                  Text(
                    '${widget.jobData!['mail']}',
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Divider(
                color: Colors.black,
              ),
            ),
            Center(
                child: Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Text('${widget.jobData['title']}',
                        style: const TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)))),
            Expanded(
                child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50)),
                    ),
                    child: ListView(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'What we are looking',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: context.screenWidth * 0.9,
                              height: context.screenHeight * 0.35,
                              decoration: const BoxDecoration(
                                color: Color.fromRGBO(13, 13, 13, 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(30),
                                child: Text(
                                  widget.jobData['whatlooking'],
                                  style: const TextStyle(
                                      color: Color.fromRGBO(
                                        154,
                                        156,
                                        168,
                                        1,
                                      ),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text('Responsibilities',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: context.screenWidth * 0.9,
                              height: context.screenHeight * 0.35,
                              decoration: const BoxDecoration(
                                color: Color.fromRGBO(96, 128, 206, 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(30),
                                child: Text(
                                  widget.jobData['responsibilities'],
                                  style: const TextStyle(
                                      color: Color.fromRGBO(
                                        154,
                                        156,
                                        168,
                                        1,
                                      ),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text('Requirements',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: context.screenWidth * 0.9,
                              height: context.screenHeight * 0.35,
                              decoration: const BoxDecoration(
                                color: Color.fromRGBO(210, 210, 210, 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(30),
                                child: Text(
                                  widget.jobData['requirements'],
                                  style: const TextStyle(
                                      color: Color.fromRGBO(
                                        154,
                                        156,
                                        168,
                                        1,
                                      ),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    )))
          ],
        ));
  }
}
