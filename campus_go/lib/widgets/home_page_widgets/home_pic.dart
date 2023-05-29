import 'package:campus_go/data/constants/phone_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomePic extends StatelessWidget {
  const HomePic({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: context.screenHeight * 0.02),
      child: SvgPicture.asset(
        'assets/images/home_page_pic.svg',
        width: context.screenWidth * .9,
      ),
    );
  }
}
