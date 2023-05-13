import 'package:campus_go/data/constants/phone_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginPic extends StatelessWidget {
  const LoginPic({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: context.screenHeight * .14),
      child: SvgPicture.asset(
        'assets/images/login_page_pic.svg',
        width: context.screenWidth * .6,
      ),
    );
  }
}
