import 'package:campus_go/data/constants/phone_screen.dart';
import 'package:flutter/material.dart';

import '../../data/constants/my_colors.dart';
import '../../service/filter.dart';
import '../../service/post_management.dart';
import '../../service/user_management.dart';

class AllPostList extends StatefulWidget {
  String searchValue;
  AllPostList({super.key, required this.searchValue});

  @override
  State<AllPostList> createState() => _AllPostListState();
}

class _AllPostListState extends State<AllPostList> {
  PostManagement postmanager = PostManagement();
  UserManagement usermanager = UserManagement();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: postmanager.getAllPosts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        var list = snapshot.data;
        return ListView.builder(
          itemBuilder: (context, index) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            var addedby = list[index]['addedBy'];
            if (list[index]['title']
                .toString()
                .toLowerCase()
                .startsWith(widget.searchValue.toLowerCase())) {
              if (Filter.selectedCategoryData
                  .contains(list[index]['category'])) {
                return FutureBuilder(
                  future: usermanager.getUserByID(addedby),
                  builder: (context, snapshott) {
                    var user = snapshott.data;

                    if (snapshott.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    return Column(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(
                                left: context.screenWidth * 0.070,
                                right: context.screenWidth * 0.070),
                            child: postCard(list, index, user)),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    );
                  },
                );
              } else if (Filter.selectedCategoryData.isEmpty) {
                return FutureBuilder(
                  future: usermanager.getUserByID(addedby),
                  builder: (context, snapshott) {
                    var user = snapshott.data;

                    if (snapshott.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    return Column(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(
                                left: context.screenWidth * 0.070,
                                right: context.screenWidth * 0.070),
                            child: postCard(list, index, user)),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    );
                  },
                );
              }
            }
            return Container();
          },
          itemCount: list!.length,
        );
      },
    );
  }

  Container postCard(
      List<Map<String, dynamic>>? data, int index, Map<String, dynamic>? user) {
    var profileURL = user!['profileURL'];
    var name = user['name'];
    var likenum = data![index]['likeNum'];
    var comnum = data[index]['commentNum'];
    var title = data[index]['title'];
    var description = data[index]['description'];
    var category = data[index]['category'];
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomCenter,
              stops: const [
                0.1,
                0.6
              ],
              colors: [
                Colors.white,
                MyColors.applicationMustUsedBlue,
              ]),
          shape: BoxShape.rectangle,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: Colors.blue),
      height: context.screenHeight * 0.25,
      width: context.screenWidth * 0.80,
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(profileURL!),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, right: 10.0),
                      child: Text(
                        "$category-$title",
                        style: const TextStyle(fontSize: 17),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      name,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              )
            ],
          ),
          Expanded(
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                      child: Text(
                        description,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )))),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, bottom: 10.0),
            child: Row(
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.thumb_up_alt_outlined,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(likenum.toString()),
                  ],
                ),
                const SizedBox(
                  width: 20,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.comment,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(comnum.toString())
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
