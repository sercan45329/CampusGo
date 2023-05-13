import 'package:campus_go/data/constants/phone_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RegisterPic extends StatelessWidget {
  const RegisterPic({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: context.screenHeight * .14),
      child: SvgPicture.asset(
        'assets/images/register_page_pic.svg',
        width: context.screenWidth * .6,
      ),
    );
  }
}
