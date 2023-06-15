import 'package:campus_go/data/constants/phone_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../../data/constants/my_colors.dart';
import '../../../service/event_management.dart';
import '../../../service/user_management.dart';

class EditEventPage extends StatefulWidget {
  final eventData;
  const EditEventPage({super.key, required this.eventData});

  @override
  State<EditEventPage> createState() => _EditEventPageState();
}

class _EditEventPageState extends State<EditEventPage> {
  final formkey = GlobalKey<FormState>();
  final eventmanager = EventManagement();
  final usermanager = UserManagement();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final locationController = TextEditingController();
  final maxParticipantController = TextEditingController();
  final dateController = TextEditingController();
  final phoneController = TextEditingController();
  @override
  void initState() {
    super.initState();
    titleController.text = widget.eventData['title'];
    descriptionController.text = widget.eventData['description'];
    priceController.text = widget.eventData['price'];
    locationController.text = widget.eventData['location'];
    maxParticipantController.text =
        widget.eventData['maxParticipant'].toString();
    dateController.text = widget.eventData['date'];
    phoneController.text = widget.eventData['phone'];
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
                Padding(
                  padding: const EdgeInsets.only(top: 40, left: 15, right: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, "/EventPage");
                          },
                          icon: const Icon(Icons.arrow_back)),
                      const Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Edit Event',
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
                        alignment: Alignment.centerLeft, child: text('Title')),
                  ],
                ),
                myHeightSizedBox,
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: context.screenWidth * 0.159),
                  child: textFormField('Title', titleController, false, 20, 1),
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
                        'Description', descriptionController, false, 900, 6)),
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
                        'Location', locationController, false, 20, 1)),
                myHeightSizedBox,
                myHeightSizedBox,
                Row(
                  children: [
                    SizedBox(
                      width: context.screenWidth * 0.16,
                    ),
                    Align(
                        alignment: Alignment.centerLeft, child: text('Price')),
                  ],
                ),
                myHeightSizedBox,
                Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: context.screenWidth * 0.159),
                    child: numTextFormField('Price', priceController, false)),
                myHeightSizedBox,
                Row(
                  children: [
                    SizedBox(
                      width: context.screenWidth * 0.16,
                    ),
                    Align(
                        alignment: Alignment.centerLeft, child: text('Phone')),
                  ],
                ),
                myHeightSizedBox,
                Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: context.screenWidth * 0.159),
                    child:
                        phoneTextFormField('Location', phoneController, false)),
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
                editButton()
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
        minLines: 1,
        maxLines: maxLines,
        maxLength: maxLength,
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
        maxLength: 4,
        minLines: 1,
        maxLines: 1,
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
        maxLines: 1,
        minLines: 1,
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

  InkWell editButton() {
    return InkWell(
      onTap: () async {
        if (formkey.currentState!.validate()) {
          if (widget.eventData['activeParticipant'] >
              int.parse(maxParticipantController.text)) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text(
                    'You cannot have more active participant than max participant')));
            return;
          }
          var result = await eventmanager.updateEvent(
              widget.eventData['eventID'],
              titleController.text,
              descriptionController.text,
              locationController.text,
              priceController.text,
              phoneController.text,
              maxParticipantController.text,
              dateController.text);
          if (result == 'Success') {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(result)));
            Navigator.pushReplacementNamed(context, "/EventPage");
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
          'Edit Event',
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
          icon: const Icon(Icons.calendar_today),
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
        style: const TextStyle(
            color: Color.fromRGBO(99, 109, 119, 1),
            fontSize: 16,
            fontWeight: FontWeight.w500));
  }
}
