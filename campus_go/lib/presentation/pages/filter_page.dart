import 'package:campus_go/data/constants/my_colors.dart';
import 'package:campus_go/data/constants/phone_screen.dart';
import 'package:flutter/material.dart';

import '../../service/filter.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView(
        children: [
          Padding(
              padding: EdgeInsets.only(
                  left: context.screenWidth * 0.010,
                  bottom: context.screenWidth * 0.040),
              child: Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, "/SeeAllPostPage");
                    },
                    child: const Icon(Icons.arrow_back)),
              )),
          Text(
            'Category',
            style: TextStyle(
                color: MyColors.applicationMustUsedBlue,
                fontWeight: FontWeight.w700,
                fontSize: 18),
          ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: Filter.categoryData.length,
              itemBuilder: (context, index) {
                return Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 8, right: 10),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: MyColors.applicationMustUsedBlue, width: 2),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        Filter.categoryData[index],
                        style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 25,
                        child: Checkbox(
                          checkColor: Colors.black,
                          value: Filter.selectedCategoryData
                              .contains(Filter.categoryData[index]),
                          onChanged: (bool? value) {
                            Filter.select(Filter.categoryData[index]);

                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ], // Text
      ),
    ));
  }
}
