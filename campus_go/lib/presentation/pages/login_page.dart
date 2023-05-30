import 'package:campus_go/data/constants/phone_screen.dart';
import 'package:campus_go/service/auth_service.dart';
import 'package:campus_go/widgets/login_page_widgets/login_pic.dart';
import 'package:campus_go/widgets/login_page_widgets/login_text.dart';
import 'package:flutter/material.dart';

import '../../data/constants/my_colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final mailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    mailTextController.text = 'example@isik.edu.tr';
    passwordTextController.text = '***************';
  }

  @override
  Widget build(BuildContext context) {
    final myHeightSizedBox = SizedBox(
      height: context.screenHeight * 0.010,
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: formkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const LoginPic(),
            SizedBox(
              height: context.screenHeight * 0.05,
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
                padding: EdgeInsets.symmetric(
                    horizontal: context.screenWidth * 0.159),
                child: textFormField(
                    'example@isik.edu.tr', mailTextController, false)),
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
                padding: EdgeInsets.symmetric(
                    horizontal: context.screenWidth * 0.159),
                child: textFormField(
                    '***************', passwordTextController, true)),
            SizedBox(
              height: context.screenHeight * 0.030,
            ),
            signInButton(),
            SizedBox(
              height: context.screenHeight * 0.030,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have account? "),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(
                        context, "/RegistrationPage");
                  },
                  child: Text('Sign Up',
                      style:
                          TextStyle(color: MyColors.applicationMustUsedBlue)),
                )
              ],
            ),
            SizedBox(
              height: context.screenHeight * 0.030,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, "/ForgotPasswordPage");
              },
              child: Text('Forgot Password?',
                  style: TextStyle(
                      color: MyColors.applicationMustUsedBlue,
                      fontWeight: FontWeight.w600,
                      fontSize: 15)),
            )
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

  InkWell signInButton() {
    return InkWell(
      onTap: () async {
        if (formkey.currentState!.validate()) {
          var result = await AuthService()
              .login(mailTextController.text, passwordTextController.text);
          if (result == 'Login Successful' && context.mounted) {
            Navigator.pushNamed(context, "/HomePage");
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
          'Sign In',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
