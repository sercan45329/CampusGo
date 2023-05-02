import 'package:flutter/material.dart';

extension PhoneScreenExtension on BuildContext {
  double get Screenheight => MediaQuery.of(this).size.height;
  double get Screenwidth => MediaQuery.of(this).size.width;
}
