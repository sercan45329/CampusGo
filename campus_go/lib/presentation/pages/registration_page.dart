import 'package:campus_go/data/constants/my_colors.dart';
import 'package:campus_go/data/constants/phone_screen.dart';
import 'package:campus_go/widgets/registration_page_widgets/register_pic.dart';
import 'package:campus_go/widgets/registration_page_widgets/register_text.dart';
import 'package:campus_go/widgets/registration_page_widgets/register_textformfield.dart';
import 'package:campus_go/widgets/registration_page_widgets/register_signup_button.dart';
import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  @override
  Widget build(BuildContext context) {
    final myHeightSizedBox = SizedBox(
      height: context.screenHeight * 0.010,
    );

    return Scaffold(
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
            child: const RegisterTextFormField(label: 'Your name here'),
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
            child: const RegisterTextFormField(label: 'example@isik.edu.tr'),
          ),
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
            child: const RegisterTextFormField(label: '***************'),
          ),
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
            child: const RegisterTextFormField(label: '***************'),
          ),
          SizedBox(
            height: context.screenHeight * 0.030,
          ),
          const RegisterSignupButton(text: 'Sign up'),
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
}
