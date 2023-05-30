import 'package:campus_go/data/constants/phone_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ForgotPasswordPic extends StatelessWidget {
  const ForgotPasswordPic({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: context.screenHeight * .14),
      child: SvgPicture.asset(
        'assets/images/forgot_password_pic.svg',
        width: context.screenWidth * .6,
      ),
    );
  }
}
