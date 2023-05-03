import 'package:campus_go/data/constants/my_colors.dart';
import 'package:campus_go/data/constants/phone_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  @override
  Widget build(BuildContext context) {
    final myHeightSizedBox = SizedBox(
      height: context.Screenheight * 0.015,
    );

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          RegisterPagePicture(context),
          Row(
            children: [
              SizedBox(
                width: context.Screenwidth * 0.15,
              ),
              Align(
                child: Text('Name',
                    style: TextStyle(
                        color: Color.fromRGBO(99, 109, 119, 1),
                        fontSize: 16,
                        fontWeight: FontWeight.w500)),
                alignment: Alignment.centerLeft,
              ),
            ],
          ),
          myHeightSizedBox,
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: context.Screenwidth * 0.159),
            child: MyTextField('Sercan'),
          ),
          myHeightSizedBox,
          Row(
            children: [
              SizedBox(
                width: context.Screenwidth * 0.15,
              ),
              Align(
                child: Text('Email Address',
                    style: TextStyle(
                        color: Color.fromRGBO(99, 109, 119, 1),
                        fontSize: 16,
                        fontWeight: FontWeight.w500)),
                alignment: Alignment.centerLeft,
              ),
            ],
          ),
          myHeightSizedBox,
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: context.Screenwidth * 0.159),
            child: MyTextField('example@isik.edu.tr'),
          ),
          myHeightSizedBox,
          Row(
            children: [
              SizedBox(
                width: context.Screenwidth * 0.15,
              ),
              Align(
                child: Text('Password',
                    style: TextStyle(
                        color: Color.fromRGBO(99, 109, 119, 1),
                        fontSize: 16,
                        fontWeight: FontWeight.w500)),
                alignment: Alignment.centerLeft,
              ),
            ],
          ),
          myHeightSizedBox,
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: context.Screenwidth * 0.159),
            child: MyTextField('**********'),
          ),
          myHeightSizedBox,
          Row(
            children: [
              SizedBox(
                width: context.Screenwidth * 0.1564,
              ),
              Align(
                child: Text('Confirm Password',
                    style: TextStyle(
                        color: Color.fromRGBO(99, 109, 119, 1),
                        fontSize: 16,
                        fontWeight: FontWeight.w500)),
                alignment: Alignment.centerLeft,
              ),
            ],
          ),
          myHeightSizedBox,
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: context.Screenwidth * 0.159),
            child: MyTextField('**********'),
          ),
          SizedBox(
            height: context.Screenheight * 0.030,
          ),
          signUpButton(),
          SizedBox(
            height: context.Screenheight * 0.030,
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

  InkWell signUpButton() {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: MyColors.applicationMustUsedBlue,
        ),
        alignment: Alignment.center,
        height: 48,
        width: 225,
        child: const Text(
          'Sign Up',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Container RegisterPagePicture(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: context.Screenheight * .14),
      child: SvgPicture.asset(
        'assets/images/register_page_pic.svg',
        width: context.Screenwidth * .6,
      ),
    );
  }

  Material MyTextField(String label) {
    return Material(
      elevation: 6,
      borderRadius: BorderRadius.circular(10),
      child: TextField(
        decoration: InputDecoration(
          labelStyle: TextStyle(
              color: Color.fromRGBO(54, 67, 86, 1),
              fontSize: 14,
              fontWeight: FontWeight.w300),
          labelText: label,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(10)),

          contentPadding: EdgeInsets.symmetric(horizontal: 10), // <-- SEE HERE
        ),
      ),
    );
  }
}
