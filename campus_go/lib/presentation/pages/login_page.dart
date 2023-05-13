import 'package:campus_go/data/constants/phone_screen.dart';
import 'package:campus_go/widgets/login_page_widgets/login_pic.dart';
import 'package:campus_go/widgets/login_page_widgets/login_signin_button.dart';
import 'package:campus_go/widgets/login_page_widgets/login_text.dart';
import 'package:campus_go/widgets/login_page_widgets/login_textformfield.dart';
import 'package:flutter/material.dart';

import '../../data/constants/my_colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final myHeightSizedBox = SizedBox(
      height: context.screenHeight * 0.010,
    );
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const LoginPic(),
          SizedBox(
            height: context.screenHeight * 0.050,
          ),
          Row(
            children: [
              SizedBox(
                width: context.screenWidth * 0.16,
              ),
              const Align(
                  alignment: Alignment.centerLeft,
                  child: LoginText(text: 'Email')),
            ],
          ),
          myHeightSizedBox,
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: context.screenWidth * 0.159),
            child: const LoginTextFormField(label: 'example@isik.edu.tr'),
          ),
          myHeightSizedBox,
          Row(
            children: [
              SizedBox(
                width: context.screenWidth * 0.16,
              ),
              const Align(
                  alignment: Alignment.centerLeft,
                  child: LoginText(text: 'Password')),
            ],
          ),
          myHeightSizedBox,
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: context.screenWidth * 0.159),
            child: const LoginTextFormField(label: '***************'),
          ),
          SizedBox(
            height: context.screenHeight * 0.030,
          ),
          const LoginSigninButton(text: 'Sign in'),
          SizedBox(
            height: context.screenHeight * 0.030,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Don't have account? "),
              Text('Sign Up',
                  style: TextStyle(color: MyColors.applicationMustUsedBlue))
            ],
          ),
          SizedBox(
            height: context.screenHeight * 0.030,
          ),
          Text('Forgot Password?',
              style: TextStyle(
                  color: MyColors.applicationMustUsedBlue,
                  fontWeight: FontWeight.w600,
                  fontSize: 15))
        ],
      ),
    );
  }
}
