import 'package:campus_go/data/constants/phone_screen.dart';
import 'package:campus_go/service/event_management.dart';
import 'package:campus_go/service/user_management.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../../data/constants/my_colors.dart';

class AddEventPage extends StatefulWidget {
  const AddEventPage({super.key});

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  final formkey = GlobalKey<FormState>();
  final eventmanager = EventManagement();
  final usermanager = UserManagement();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final locationController = TextEditingController();
  final maxParticipantController = TextEditingController();
  final dateController = TextEditingController();
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
              Padding(
                padding: const EdgeInsets.only(top: 40, left: 15, right: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, "/ViewAllPageCampusLife");
                        },
                        icon: const Icon(Icons.arrow_back)),
                    const Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Add Event',
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
                  Align(alignment: Alignment.centerLeft, child: text('Title')),
                ],
              ),
              myHeightSizedBox,
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: context.screenWidth * 0.159),
                child: textFormField('Title', titleController, false),
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
                  child: textFormField(
                      'Description', descriptionController, false)),
              myHeightSizedBox,
              Row(
                children: [
                  SizedBox(
                    width: context.screenWidth * 0.16,
                  ),
                  Align(
                      alignment: Alignment.centerLeft, child: text('Location')),
                ],
              ),
              myHeightSizedBox,
              Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: context.screenWidth * 0.159),
                  child: textFormField('Location', locationController, false)),
              myHeightSizedBox,
              myHeightSizedBox,
              Row(
                children: [
                  SizedBox(
                    width: context.screenWidth * 0.16,
                  ),
                  Align(alignment: Alignment.centerLeft, child: text('Price')),
                ],
              ),
              myHeightSizedBox,
              Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: context.screenWidth * 0.159),
                  child: numTextFormField('Price', priceController, false)),
              myHeightSizedBox,
              myHeightSizedBox,
              Row(
                children: [
                  SizedBox(
                    width: context.screenWidth * 0.16,
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: text('Max Participant')),
                ],
              ),
              myHeightSizedBox,
              Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: context.screenWidth * 0.159),
                  child: numTextFormField(
                      'Max Participant', maxParticipantController, false)),
              myHeightSizedBox,
              myHeightSizedBox,
              Row(
                children: [
                  SizedBox(
                    width: context.screenWidth * 0.16,
                  ),
                  Align(alignment: Alignment.centerLeft, child: text('Date')),
                ],
              ),
              myHeightSizedBox,
              Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: context.screenWidth * 0.159),
                  child: datePicker()),
              myHeightSizedBox,
              addButton()
            ],
          ),
        ));
  }

  Material textFormField(
    String label,
    TextEditingController controller,
    bool obscureText,
  ) {
    return Material(
      elevation: 6,
      borderRadius: BorderRadius.circular(10),
      child: TextFormField(
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

  InkWell addButton() {
    return InkWell(
      onTap: () async {
        if (formkey.currentState!.validate()) {
          var currentUserData = await usermanager.getCurrentUser();
          var url = currentUserData['profileURL'];
          var result = await eventmanager.addEvent(
              titleController.text,
              descriptionController.text,
              url,
              locationController.text,
              priceController.text,
              int.parse(maxParticipantController.text),
              dateController.text);
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(result)));
          if (result == 'Success') {
            Navigator.pushReplacementNamed(context, "/ViewAllPageCampusLife");
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
          'Add Event',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Material datePicker() {
    return Material(
      elevation: 6,
      borderRadius: BorderRadius.circular(10),
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return "Fill the blank";
          }
        },
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2101));
          if (pickedDate != null) {
            String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
            setState(() {
              dateController.text = formattedDate;
            });
          }
        },
        controller: dateController,
        readOnly: true,
        decoration: InputDecoration(
          icon: Icon(Icons.calendar_today),
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

  Text text(String text) {
    return Text(text,
        style: TextStyle(
            color: Color.fromRGBO(99, 109, 119, 1),
            fontSize: 16,
            fontWeight: FontWeight.w500));
  }
}
