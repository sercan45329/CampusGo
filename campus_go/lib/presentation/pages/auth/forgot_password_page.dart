import 'package:campus_go/data/constants/my_colors.dart';
import 'package:campus_go/data/constants/phone_screen.dart';
import 'package:campus_go/service/auth_service.dart';
import 'package:campus_go/widgets/forgot_password_widgets/forgot_password_pic.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final formkey = GlobalKey<FormState>();

  final mailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: MyColors.appBackground,
      body: Form(
        key: formkey,
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: EdgeInsets.only(
                      left: context.screenWidth * 0.070,
                      top: context.screenHeight * 0.070),
                  child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, "/LoginPage");
                      },
                      child: const Icon(Icons.arrow_back))),
            ),
            const ForgotPasswordPic(),
            SizedBox(
              height: context.screenHeight * 0.05,
            ),
            Padding(
                padding: const EdgeInsets.all(25.0),
                child: textFormField(
                    'example@isik.edu.tr', mailController, false)),
            resetPassword()
          ],
        ),
      ),
    );
  }

  Material textFormField(
      String label, TextEditingController controller, bool obscureText) {
    return Material(
      elevation: 6,
      borderRadius: BorderRadius.circular(10),
      child: TextFormField(
        textAlignVertical: TextAlignVertical.center,
        obscureText: obscureText,
        validator: (value) {
          if (value!.isEmpty) {
            return "Fill the blank";
          }
        },
        onTap: () {
          if (controller.text == label) {
            controller.clear();
          }
        },
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.mail),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          labelStyle: const TextStyle(
              color: Color.fromRGBO(54, 67, 86, 1),
              fontSize: 14,
              fontWeight: FontWeight.w300),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(10)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        ),
      ),
    );
  }

  InkWell resetPassword() {
    return InkWell(
      onTap: () async {
        if (formkey.currentState!.validate()) {
          var result = await AuthService().forgotPassword(mailController.text);
          if (result == 'Mail sent to reset your password' && context.mounted) {
            Navigator.pushReplacementNamed(context, "/LoginPage");
          }
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(result!)));
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: MyColors.applicationMustUsedBlue,
        ),
        alignment: Alignment.center,
        height: 48,
        width: 225,
        child: const Text(
          'Reset Password',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
