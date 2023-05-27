import 'package:campus_go/data/constants/my_colors.dart';
import 'package:campus_go/data/constants/phone_screen.dart';
import 'package:campus_go/widgets/registration_page_widgets/register_pic.dart';
import 'package:campus_go/widgets/registration_page_widgets/register_text.dart';
import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final nameTextController = TextEditingController();
  final mailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final repasswordTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final myHeightSizedBox = SizedBox(
      height: context.screenHeight * 0.010,
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const RegisterPic(),
          Row(
            children: [
              SizedBox(
                width: context.screenWidth * 0.16,
              ),
              const Align(
                  alignment: Alignment.centerLeft,
                  child: RegisterText(text: 'Name')),
            ],
          ),
          myHeightSizedBox,
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: context.screenWidth * 0.159),
            child: textFormField('Your name here', nameTextController),
          ),
          myHeightSizedBox,
          Row(
            children: [
              SizedBox(
                width: context.screenWidth * 0.16,
              ),
              const Align(
                  alignment: Alignment.centerLeft,
                  child: RegisterText(text: 'Email')),
            ],
          ),
          myHeightSizedBox,
          Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: context.screenWidth * 0.159),
              child: textFormField('example@isik.edu.tr', mailTextController)),
          myHeightSizedBox,
          Row(
            children: [
              SizedBox(
                width: context.screenWidth * 0.16,
              ),
              const Align(
                  alignment: Alignment.centerLeft,
                  child: RegisterText(text: 'Password')),
            ],
          ),
          myHeightSizedBox,
          Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: context.screenWidth * 0.159),
              child: textFormField('***************', passwordTextController)),
          myHeightSizedBox,
          Row(
            children: [
              SizedBox(
                width: context.screenWidth * 0.16,
              ),
              const Align(
                  alignment: Alignment.centerLeft,
                  child: RegisterText(text: 'Confirm Password')),
            ],
          ),
          myHeightSizedBox,
          Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: context.screenWidth * 0.159),
              child:
                  textFormField('***************', repasswordTextController)),
          SizedBox(
            height: context.screenHeight * 0.030,
          ),
          registerSignUp(),
          SizedBox(
            height: context.screenHeight * 0.030,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Already have account? "),
              Text('Sign In',
                  style: TextStyle(color: MyColors.applicationMustUsedBlue))
            ],
          )
        ],
      ),
    );
  }

  Material textFormField(String label, TextEditingController controller) {
    return Material(
      elevation: 6,
      borderRadius: BorderRadius.circular(10),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          labelStyle: const TextStyle(
              color: Color.fromRGBO(54, 67, 86, 1),
              fontSize: 14,
              fontWeight: FontWeight.w300),
          labelText: label,
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(10)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        ),
      ),
    );
  }

  InkWell registerSignUp() {
    return InkWell(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: MyColors.applicationMustUsedBlue,
        ),
        alignment: Alignment.center,
        height: 48,
        width: 225,
        child: const Text(
          'Sign up',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
