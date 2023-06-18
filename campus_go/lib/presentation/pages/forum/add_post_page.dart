import 'package:campus_go/data/constants/phone_screen.dart';
import 'package:campus_go/service/post_management.dart';
import 'package:campus_go/service/topic_management.dart';
import 'package:flutter/material.dart';

import '../../../data/constants/my_colors.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({super.key});

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  final postManager = PostManagement();
  String category = 'Gaming';
  var categories = [
    'Gaming',
    'Computer Engineering',
    'Others',
    'Cafeteria Prices'
  ];
  int counter = 0;
  @override
  void initState() {
    super.initState();
    titleController.text = 'Title';
    descriptionController.text = 'Description';
  }

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
                Row(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(
                            left: context.screenWidth * 0.050,
                            top: context.screenHeight * 0.050),
                        child: GestureDetector(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                  context, "/ForumPage");
                            },
                            child: const Icon(Icons.arrow_back))),
                    Expanded(
                      child: Padding(
                          padding: EdgeInsets.only(
                              left: context.screenWidth * 0.250,
                              top: context.screenHeight * 0.050),
                          child: const Text(
                            'Add Post',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 24),
                          )),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: context.screenWidth * 0.16,
                    ),
                    Align(
                        alignment: Alignment.centerLeft, child: text('Title')),
                  ],
                ),
                myHeightSizedBox,
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: context.screenWidth * 0.159),
                  child:
                      textFormField('Title', titleController, false, 1, 1, 35),
                ),
                myHeightSizedBox,
                Row(
                  children: [
                    SizedBox(
                      width: context.screenWidth * 0.16,
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: text('Description')),
                  ],
                ),
                myHeightSizedBox,
                Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: context.screenWidth * 0.159),
                    child: textFormField('Description', descriptionController,
                        false, 6, 1, 450)),
                myHeightSizedBox,
                Row(
                  children: [
                    SizedBox(
                      width: context.screenWidth * 0.16,
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: text('Category')),
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
                SizedBox(
                  height: context.screenHeight * 0.025,
                ),
                addButton()
              ],
            ),
          ),
        ));
  }

  Material textFormField(String label, TextEditingController controller,
      bool obscureText, int maxLines, int minLines, int maxLength) {
    return Material(
      elevation: 6,
      borderRadius: BorderRadius.circular(10),
      child: TextFormField(
        maxLength: maxLength,
        maxLines: maxLines,
        minLines: minLines,
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
          var result = await postManager.addPost(
              titleController.text, category, descriptionController.text);
          if (result == 'Success') {
            await TopicManagement().increasePostNumByCategory(category);
            Navigator.pushReplacementNamed(context, "/ForumPage");
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
          'Add Post',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Text text(String text) {
    return Text(text,
        style: TextStyle(
            color: Color.fromRGBO(99, 109, 119, 1),
            fontSize: 16,
            fontWeight: FontWeight.w500));
  }
}
