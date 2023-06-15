import 'package:campus_go/data/constants/my_colors.dart';
import 'package:campus_go/data/constants/phone_screen.dart';
import 'package:campus_go/service/auth_service.dart';
import 'package:campus_go/widgets/registration_page_widgets/register_pic.dart';
import 'package:campus_go/widgets/registration_page_widgets/register_text.dart';
import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final nameTextController = TextEditingController();
  final mailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final repasswordTextController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  int counter = 0;
  @override
  void initState() {
    super.initState();
    nameTextController.text = 'Your name here';
    mailTextController.text = 'example@isik.edu.tr';
    passwordTextController.text = '***************';
    repasswordTextController.text = '***************';
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
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: EdgeInsets.only(
                      left: context.screenWidth * 0.070,
                      top: context.screenHeight * 0.050),
                  child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, "/LoginPage");
                      },
                      child: const Icon(Icons.arrow_back))),
            ),
            const RegisterPic(),
            Row(
              children: [
                SizedBox(
                  width: context.screenWidth * 0.16,
                ),
                const Align(
                    alignment: Alignment.centerLeft,
                    child: RegisterText(text: 'Name')),
              ],
            ),
            myHeightSizedBox,
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: context.screenWidth * 0.159),
              child: textFormField('Your name here', nameTextController, false),
            ),
            myHeightSizedBox,
            Row(
              children: [
                SizedBox(
                  width: context.screenWidth * 0.16,
                ),
                const Align(
                    alignment: Alignment.centerLeft,
                    child: RegisterText(text: 'Email')),
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
                    child: RegisterText(text: 'Password')),
              ],
            ),
            myHeightSizedBox,
            Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: context.screenWidth * 0.159),
                child: textFormField(
                    '***************', passwordTextController, true)),
            myHeightSizedBox,
            Row(
              children: [
                SizedBox(
                  width: context.screenWidth * 0.16,
                ),
                const Align(
                    alignment: Alignment.centerLeft,
                    child: RegisterText(text: 'Confirm Password')),
              ],
            ),
            myHeightSizedBox,
            Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: context.screenWidth * 0.159),
                child: textFormField(
                    '***************', repasswordTextController, true)),
            SizedBox(
              height: context.screenHeight * 0.030,
            ),
            registerSignUp(),
            SizedBox(
              height: context.screenHeight * 0.030,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have account? "),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, "/LoginPage");
                  },
                  child: Text('Sign In',
                      style:
                          TextStyle(color: MyColors.applicationMustUsedBlue)),
                )
              ],
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

  InkWell registerSignUp() {
    return InkWell(
      onTap: () async {
        if (formkey.currentState!.validate()) {
          if (!mailTextController.text.endsWith('@isik.edu.tr')) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('You should register with isik account')));
            return;
          }
          var result = await AuthService().register(
              nameTextController.text,
              mailTextController.text,
              passwordTextController.text,
              repasswordTextController.text);
          if (result == 'Registration Successful') {
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
          'Sign up',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
