import 'package:flutter/material.dart';

class RegisterText extends StatelessWidget {
  final String text;
  const RegisterText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: const TextStyle(
            color: Color.fromRGBO(99, 109, 119, 1),
            fontSize: 16,
            fontWeight: FontWeight.w500));
  }
}
