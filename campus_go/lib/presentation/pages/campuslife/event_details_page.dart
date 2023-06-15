import 'package:campus_go/data/constants/phone_screen.dart';
import 'package:campus_go/presentation/pages/campuslife/edit_event_page.dart';
import 'package:campus_go/service/event_management.dart';
import 'package:campus_go/service/user_management.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EventDetailsPage extends StatefulWidget {
  final data;
  const EventDetailsPage({super.key, required this.data});

  @override
  State<EventDetailsPage> createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage>
    with TickerProviderStateMixin {
  final usermanager = UserManagement();
  final eventmanager = EventManagement();

  late final _tabcontroller;
  @override
  void initState() {
    super.initState();
    _tabcontroller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Padding(
          padding: EdgeInsets.all(20.0),
          child: GestureDetector(
            onTap: () async {
              var dataa =
                  await eventmanager.getEventDataByID(widget.data['eventID']);
              if (dataa!['activeParticipant'] == dataa['maxParticipant']) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Event is fully participated')));
                return;
              }

              var docRef =
                  await eventmanager.getEventDocRefByID(widget.data['eventID']);
              if ((dataa['participants'] as List<dynamic>)
                  .contains(usermanager.getCurrentUserID())) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('You already joined the event!')));
                return;
              }
              try {
                await docRef.update({
                  'participants':
                      FieldValue.arrayUnion([usermanager.getCurrentUserID()]),
                  'activeParticipant': FieldValue.increment(1)
                });
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('You joined the event!')));
                setState(() {});
              } on Exception catch (e) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(e.toString())));
              }
            },
            child: Container(
              decoration: const BoxDecoration(
                  color: Color.fromRGBO(52, 87, 199, 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(25.0))),
              child: const Padding(
                  padding: EdgeInsets.all(10.0), child: Icon(Icons.add)),
            ),
          ),
        ),
        backgroundColor: Color.fromRGBO(52, 87, 199, 1.0),
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
                          Navigator.pushReplacementNamed(context, "/EventPage");
                        },
                        child: const Icon(Icons.arrow_back))),
                Padding(
                    padding: EdgeInsets.only(
                        left: context.screenWidth * 0.050,
                        top: context.screenHeight * 0.050),
                    child: const Text(
                      'View Events',
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
                Align(
                  child: Padding(
                      padding: EdgeInsets.only(
                          right: context.screenWidth * 0.050,
                          top: context.screenHeight * 0.050,
                          left: context.screenWidth * 0.075),
                      child: FutureBuilder(
                          future:
                              usermanager.getUserByID(widget.data['addedBy']),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            }
                            return CircleAvatar(
                              radius: 20,
                              backgroundImage:
                                  NetworkImage(snapshot.data!['profileURL']),
                            );
                          })),
                ),
                Padding(
                  padding: EdgeInsets.only(top: context.screenHeight * 0.050),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FutureBuilder(
                          future:
                              usermanager.getUserByID(widget.data['addedBy']),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            }
                            return Text(
                              '${snapshot.data!['name']}',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            );
                          }),
                      Text('Phone:${widget.data['phone']}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      FutureBuilder(
                          future: eventmanager
                              .getEventDataByID(widget.data['eventID']),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            }
                            var activeParticipants =
                                snapshot.data!['activeParticipant'];
                            var maxParticipants =
                                snapshot.data!['maxParticipant'];
                            return Text('$activeParticipants/$maxParticipants',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold));
                          }),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: context.screenHeight * 0.050,
                      left: context.screenWidth * 0.095),
                  child: GestureDetector(
                    onTap: () async {
                      var result;
                      if (widget.data['addedBy'] ==
                          usermanager.getCurrentUserID()) {
                        result = await eventmanager
                            .deleteEvent(widget.data['eventID']);
                        if (result != 'Success') {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text(result)));
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text(result)));
                        }

                        Navigator.pushReplacementNamed(context, "/EventPage");
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('You dont have the permission!')));
                      }
                    },
                    child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Icon(Icons.delete)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: context.screenHeight * 0.050),
                  child: IconButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                EditEventPage(eventData: widget.data),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.black,
                      )),
                )
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
                  Text('${widget.data['location']}',
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  const SizedBox(
                    width: 40,
                  ),
                  const Icon(Icons.mail),
                  FutureBuilder(
                      future: usermanager.getUserByID(widget.data['addedBy']),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        }
                        return Text(
                          '${snapshot.data!['email']}',
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        );
                      })
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
                    child: Text('${widget.data['title']}',
                        style: const TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)))),
            Expanded(
                child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50)),
                    ),
                    child: Column(
                      children: [
                        TabBar(
                          controller: _tabcontroller,
                          tabs: const [
                            Tab(
                              child: Text(
                                'About the event',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            Tab(
                              child: Text('Participants',
                                  style: TextStyle(color: Colors.black)),
                            ),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                            controller: _tabcontroller,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Container(
                                  decoration: const BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(25.0))),
                                  child: Padding(
                                    padding: EdgeInsets.all(15.0),
                                    child: Text(
                                      '${widget.data['description']}',
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Container(
                                    decoration: const BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25.0))),
                                    child: participantList()),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )))
          ],
        ));
  }

  FutureBuilder participant(index, list) {
    return FutureBuilder(
        future: usermanager.getUserByID(list[index]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          return ListTile(
            leading: CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(snapshot.data!['profileURL']!),
            ),
            title: Center(
              child: Text(
                'Name: ${snapshot.data['name']}\nEmail:${snapshot.data['email']}',
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          );
        });
  }

  FutureBuilder participantList() {
    return FutureBuilder(
        future: eventmanager.getEventDataByID(widget.data['eventID']),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          var snapshotdata = snapshot.data;
          var list = (snapshotdata['participants'] as List<dynamic>);
          var length = (snapshotdata['participants'] as List<dynamic>).length;
          return length == 0
              ? const Center(
                  child: Text('No participants joined',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                )
              : ListView.separated(
                  itemBuilder: (context, index) {
                    return participant(index, list);
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(
                      color: Colors.white,
                    );
                  },
                  itemCount: (length));
        });
  }
}
