import 'package:campus_go/data/constants/phone_screen.dart';
import 'package:campus_go/service/topic_management.dart';
import 'package:flutter/material.dart';

import '../../../data/constants/my_colors.dart';
import '../../../service/post_management.dart';

class EditPostPage extends StatefulWidget {
  final postData;
  const EditPostPage({super.key, required this.postData});

  @override
  State<EditPostPage> createState() => _EditPostPageState();
}

class _EditPostPageState extends State<EditPostPage> {
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
    titleController.text = widget.postData['title'];
    descriptionController.text = widget.postData['description'];
    category = widget.postData['category'];
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
                            Navigator.pop(context);
                          },
                          child: const Icon(Icons.arrow_back))),
                  Expanded(
                    child: Padding(
                        padding: EdgeInsets.only(
                            left: context.screenWidth * 0.250,
                            top: context.screenHeight * 0.050),
                        child: const Text(
                          'Edit Post',
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
                  Align(alignment: Alignment.centerLeft, child: text('Title')),
                ],
              ),
              myHeightSizedBox,
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: context.screenWidth * 0.159),
                child: textFormField(titleController, false, 35, 1),
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
                  child: textFormField(descriptionController, false, 450, 6)),
              myHeightSizedBox,
              Row(
                children: [
                  SizedBox(
                    width: context.screenWidth * 0.16,
                  ),
                  Align(
                      alignment: Alignment.centerLeft, child: text('Category')),
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
              editButton()
            ],
          ),
        ));
  }

  Material textFormField(TextEditingController controller, bool obscureText,
      int maxLength, int maxLines) {
    return Material(
      elevation: 6,
      borderRadius: BorderRadius.circular(10),
      child: TextFormField(
        maxLines: maxLines,
        maxLength: maxLength,
        obscureText: obscureText,
        validator: (value) {
          if (value!.isEmpty) {
            return "Fill the blank";
          }
        },
        onTap: () {},
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

  InkWell editButton() {
    return InkWell(
      onTap: () async {
        if (formkey.currentState!.validate()) {
          var result = await postManager.updatePost(widget.postData['postID'],
              titleController.text, category, descriptionController.text);
          if (result == 'Success') {
            if (category != widget.postData['category']) {
              await TopicManagement().increasePostNumByCategory(category);
              await TopicManagement()
                  .descreasePostNumByCategory(widget.postData['category']);
            }
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(result)));
            Navigator.pushReplacementNamed(context, "/ForumPage");
          } else {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(result)));
          }
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
          'Edit Post',
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
