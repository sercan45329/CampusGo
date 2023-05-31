import 'package:campus_go/service/topic_management.dart';
import 'package:flutter/material.dart';

import '../../data/constants/my_colors.dart';

class TopicCardList extends StatefulWidget {
  const TopicCardList({super.key});

  @override
  State<TopicCardList> createState() => _TopicCardList();
}

class _TopicCardList extends State<TopicCardList> {
  TopicManagement topicmanager = TopicManagement();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: topicmanager.getPopularTopics(3),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 3, // Replace with the actual number of items in your list
          itemBuilder: (context, index) {
            return topicCard(index, snapshot.data);
          },
        );
      },
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
