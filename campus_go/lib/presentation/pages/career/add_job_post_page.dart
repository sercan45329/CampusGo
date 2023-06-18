import 'dart:math';

import 'package:campus_go/data/constants/phone_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../../data/constants/my_colors.dart';
import '../../../service/event_management.dart';
import '../../../service/job_management.dart';
import '../../../service/user_management.dart';

class AddJobPostPage extends StatefulWidget {
  const AddJobPostPage({super.key});

  @override
  State<AddJobPostPage> createState() => _AddJobPostPageState();
}

class _AddJobPostPageState extends State<AddJobPostPage> {
  final formkey = GlobalKey<FormState>();
  final jobmanager = JobManagement();
  final usermanager = UserManagement();
  final companyNameController = TextEditingController();
  final whatLookingController = TextEditingController();
  final requirementsController = TextEditingController();
  final responsibilitiesController = TextEditingController();
  final companyMailController = TextEditingController();
  final salaryTypeController = TextEditingController();
  final locationController = TextEditingController();
  final jobTitleController = TextEditingController();
  final jobFrequencyController = TextEditingController();
  final phoneController = TextEditingController();
  String salaryType = 'Free';
  String jobFrequency = 'Full-time';
  String category = "Engineering";
  var salaryTypes = ['Free', 'Paid'];
  var jobFrequencies = ['Part-time', 'Full-time'];
  var categories = [
    'Engineering',
    'Management',
    'Human Resources',
    'HealthCare',
    'Graphic Design'
  ];
  @override
  Widget build(BuildContext context) {
    final myHeightSizedBox = SizedBox(
      height: context.screenHeight * 0.010,
    );
    return Scaffold(
        backgroundColor: MyColors.appBackground,
        resizeToAvoidBottomInset: false,
        body: Form(
          key: formkey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40, left: 15, right: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, "/CareerPage");
                          },
                          icon: const Icon(Icons.arrow_back)),
                      const Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Add Job',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 24),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: context.screenWidth * 0.16,
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: text('Company Name')),
                  ],
                ),
                myHeightSizedBox,
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: context.screenWidth * 0.159),
                  child: textFormField(
                      'Company Name', companyNameController, false, 20, 1),
                ),
                myHeightSizedBox,
                Row(
                  children: [
                    SizedBox(
                      width: context.screenWidth * 0.16,
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: text('Company Mail')),
                  ],
                ),
                myHeightSizedBox,
                Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: context.screenWidth * 0.159),
                    child: textFormField(
                        'Company Mail', companyMailController, false, 25, 1)),
                myHeightSizedBox,
                Row(
                  children: [
                    SizedBox(
                      width: context.screenWidth * 0.16,
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: text('Location')),
                  ],
                ),
                myHeightSizedBox,
                Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: context.screenWidth * 0.159),
                    child: textFormField(
                        'Location', locationController, false, 15, 1)),
                myHeightSizedBox,
                myHeightSizedBox,
                Row(
                  children: [
                    SizedBox(
                      width: context.screenWidth * 0.16,
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: text('Job Title')),
                  ],
                ),
                myHeightSizedBox,
                Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: context.screenWidth * 0.159),
                    child: textFormField(
                        'Job Title', jobTitleController, false, 30, 1)),
                myHeightSizedBox,
                Row(
                  children: [
                    SizedBox(
                      width: context.screenWidth * 0.16,
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: text('Company Phone')),
                  ],
                ),
                myHeightSizedBox,
                Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: context.screenWidth * 0.159),
                    child: phoneTextFormField(
                        'Company Phone', phoneController, false)),
                myHeightSizedBox,
                myHeightSizedBox,
                Row(
                  children: [
                    SizedBox(
                      width: context.screenWidth * 0.16,
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: text('Salary Type')),
                  ],
                ),
                myHeightSizedBox,
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: context.screenWidth * 0.159),
                  child: Material(
                    elevation: 6,
                    borderRadius: BorderRadius.circular(10),
                    child: DropdownButton(
                      underline: const SizedBox(),
                      hint: const Text("Select"),
                      dropdownColor: Colors.white,
                      isExpanded: true,
                      value: salaryType,
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.black,
                      ),
                      items: salaryTypes.map((String item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              item,
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 17),
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          salaryType = newValue!;
                        });
                      },
                    ),
                  ),
                ),
                myHeightSizedBox,
                myHeightSizedBox,
                Row(
                  children: [
                    SizedBox(
                      width: context.screenWidth * 0.16,
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: text('Job Frequency')),
                  ],
                ),
                myHeightSizedBox,
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: context.screenWidth * 0.159),
                  child: Material(
                    elevation: 6,
                    borderRadius: BorderRadius.circular(10),
                    child: DropdownButton(
                      underline: const SizedBox(),
                      hint: const Text("Select"),
                      dropdownColor: Colors.white,
                      isExpanded: true,
                      value: jobFrequency,
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.black,
                      ),
                      items: jobFrequencies.map((String item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              item,
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 17),
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          jobFrequency = newValue!;
                        });
                      },
                    ),
                  ),
                ),
                myHeightSizedBox,
                myHeightSizedBox,
                Row(
                  children: [
                    SizedBox(
                      width: context.screenWidth * 0.16,
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: text('Job Category')),
                  ],
                ),
                myHeightSizedBox,
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: context.screenWidth * 0.159),
                  child: Material(
                    elevation: 6,
                    borderRadius: BorderRadius.circular(10),
                    child: DropdownButton(
                      underline: const SizedBox(),
                      hint: const Text("Select"),
                      dropdownColor: Colors.white,
                      isExpanded: true,
                      value: category,
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.black,
                      ),
                      items: categories.map((String item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              item,
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 17),
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          category = newValue!;
                        });
                      },
                    ),
                  ),
                ),
                myHeightSizedBox,
                myHeightSizedBox,
                Row(
                  children: [
                    SizedBox(
                      width: context.screenWidth * 0.16,
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: text('What we are looking')),
                  ],
                ),
                myHeightSizedBox,
                Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: context.screenWidth * 0.159),
                    child: textFormField('What we are looking',
                        whatLookingController, false, 450, 6)),
                myHeightSizedBox,
                myHeightSizedBox,
                Row(
                  children: [
                    SizedBox(
                      width: context.screenWidth * 0.16,
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: text('Responsibilities')),
                  ],
                ),
                myHeightSizedBox,
                Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: context.screenWidth * 0.159),
                    child: textFormField('Responsibilities',
                        responsibilitiesController, false, 450, 6)),
                myHeightSizedBox,
                myHeightSizedBox,
                Row(
                  children: [
                    SizedBox(
                      width: context.screenWidth * 0.16,
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: text('Requirements')),
                  ],
                ),
                myHeightSizedBox,
                Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: context.screenWidth * 0.159),
                    child: textFormField(
                        'Requirements', requirementsController, false, 450, 6)),
                myHeightSizedBox,
                myHeightSizedBox,
                addButton()
              ],
            ),
          ),
        ));
  }

  Material textFormField(String label, TextEditingController controller,
      bool obscureText, int maxLength, int maxLines) {
    return Material(
      elevation: 6,
      borderRadius: BorderRadius.circular(10),
      child: TextFormField(
        maxLength: maxLength,
        minLines: 1,
        maxLines: maxLines,
        obscureText: obscureText,
        validator: (value) {
          if (value!.isEmpty) {
            return "Fill the blank";
          }
        },
        onTap: () {
          if (controller.text == label) {
            controller.clear();
          }
        },
        controller: controller,
        decoration: InputDecoration(
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          labelStyle: const TextStyle(
              color: Color.fromRGBO(54, 67, 86, 1),
              fontSize: 14,
              fontWeight: FontWeight.w300),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(10)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        ),
      ),
    );
  }

  Material numTextFormField(
    String label,
    TextEditingController controller,
    bool obscureText,
  ) {
    return Material(
      elevation: 6,
      borderRadius: BorderRadius.circular(10),
      child: TextFormField(
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        keyboardType: TextInputType.number,
        // rest of your TextFormField properties
        obscureText: obscureText,
        validator: (value) {
          if (value!.isEmpty) {
            return "Fill the blank";
          }
        },
        onTap: () {
          if (controller.text == label) {
            controller.clear();
          }
        },
        controller: controller,
        decoration: InputDecoration(
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          labelStyle: const TextStyle(
              color: Color.fromRGBO(54, 67, 86, 1),
              fontSize: 14,
              fontWeight: FontWeight.w300),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(10)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        ),
      ),
    );
  }

  Material phoneTextFormField(
    String label,
    TextEditingController controller,
    bool obscureText,
  ) {
    return Material(
      elevation: 6,
      borderRadius: BorderRadius.circular(10),
      child: TextFormField(
        maxLength: 15,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        keyboardType: TextInputType.phone,
        // rest of your TextFormField properties
        obscureText: obscureText,
        validator: (value) {
          if (value!.isEmpty) {
            return "Fill the blank";
          }
        },
        onTap: () {
          if (controller.text == label) {
            controller.clear();
          }
        },
        controller: controller,
        decoration: InputDecoration(
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          labelStyle: const TextStyle(
              color: Color.fromRGBO(54, 67, 86, 1),
              fontSize: 14,
              fontWeight: FontWeight.w300),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(10)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        ),
      ),
    );
  }

  InkWell addButton() {
    return InkWell(
      onTap: () async {
        if (formkey.currentState!.validate()) {
          var result = await jobmanager.addJobPosting(
              companyNameController.text,
              companyMailController.text,
              locationController.text,
              whatLookingController.text,
              responsibilitiesController.text,
              requirementsController.text,
              salaryType,
              phoneController.text,
              jobFrequency,
              jobTitleController.text,
              category);
          if (result == 'Success') {
            Navigator.pushReplacementNamed(context, "/CareerPage");
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(result)));
          }
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(result)));
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: MyColors.applicationMustUsedBlue,
        ),
        alignment: Alignment.center,
        height: 48,
        width: 225,
        child: const Text(
          'Add Job Posting',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Text text(String text) {
    return Text(text,
        style: const TextStyle(
            color: Color.fromRGBO(99, 109, 119, 1),
            fontSize: 16,
            fontWeight: FontWeight.w500));
  }
}
