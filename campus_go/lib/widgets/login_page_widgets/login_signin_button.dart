import 'package:flutter/material.dart';
import '../../data/constants/my_colors.dart';

class LoginSigninButton extends StatelessWidget {
  final String text;
  const LoginSigninButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, "/RegistrationPage");
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: MyColors.applicationMustUsedBlue,
        ),
        alignment: Alignment.center,
        height: 48,
        width: 225,
        child: Text(
          text,
          style: const TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
