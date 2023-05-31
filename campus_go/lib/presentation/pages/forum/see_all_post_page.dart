import 'package:campus_go/data/constants/my_colors.dart';
import 'package:campus_go/data/constants/phone_screen.dart';
import 'package:campus_go/widgets/forum/all_post_list.dart';
import 'package:campus_go/widgets/nav_Bar.dart';
import 'package:flutter/material.dart';

import '../../../service/user_management.dart';

class SeeAllPostPage extends StatefulWidget {
  const SeeAllPostPage({super.key});

  @override
  State<SeeAllPostPage> createState() => _SeeAllPostPageState();
}

class _SeeAllPostPageState extends State<SeeAllPostPage> {
  var usermanager = UserManagement();
  var searchValue = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                    padding: EdgeInsets.only(
                        left: context.screenWidth * 0.095,
                        top: context.screenHeight * 0.050),
                    child: const Text(
                      'View all posts',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
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
                  })
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
                          onPressed: () {},
                          color: MyColors.applicationMustUsedBlue)),
                )),
          ),
          const Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'All posts',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ))),
          Expanded(
              child: AllPostList(
            searchValue: searchValue,
          ))
        ],
      ),
      bottomNavigationBar: const NavBar(),
    );
  }
}
