import 'dart:io';

import 'package:campus_go/data/constants/my_colors.dart';
import 'package:campus_go/data/constants/phone_screen.dart';
import 'package:campus_go/service/auth_service.dart';
import 'package:campus_go/service/user_management.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final usermanager = UserManagement();
  final formkey = GlobalKey<FormState>();
  final formkey1 = GlobalKey<FormState>();
  final formkey2 = GlobalKey<FormState>();
  final formkey3 = GlobalKey<FormState>();
  final storageRef = FirebaseStorage.instance.ref();
  final mailController = TextEditingController();
  final newmailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final newPasswordController = TextEditingController();
  ImagePicker picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: FutureBuilder(
          future: usermanager.getCurrentUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            var data = snapshot.data;
            return Form(
              key: formkey,
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                          padding: EdgeInsets.only(
                              left: context.screenWidth * 0.050,
                              top: context.screenHeight * 0.050),
                          child: GestureDetector(
                              onTap: () {
                                Navigator.pushReplacementNamed(
                                    context, "/HomePage");
                              },
                              child: const Icon(Icons.arrow_back))),
                      Padding(
                          padding: EdgeInsets.only(
                              left: context.screenWidth * 0.300,
                              top: context.screenHeight * 0.050),
                          child: Text(
                            "Profile",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 24),
                          )),
                    ],
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 70),
                      child: Stack(
                        children: [
                          CircleAvatar(
                              radius: 100,
                              backgroundImage:
                                  NetworkImage(data!['profileURL'])),
                          Positioned(
                              right: 5,
                              bottom: 5,
                              child: GestureDetector(
                                onTap: () async {
                                  File? imagePicked;
                                  try {
                                    var result = await picker.pickImage(
                                        source: ImageSource.gallery,
                                        maxHeight: 150,
                                        maxWidth: 350,
                                        imageQuality: 100);
                                    if (result == null) {
                                      return;
                                    }
                                    final temp = File(result.path);
                                    imagePicked = temp;
                                  } on PlatformException catch (e) {
                                    print(e.toString());
                                  }
                                  if (imagePicked != null) {
                                    var userID = data['userID'];
                                    var imageRef =
                                        storageRef.child("profilePics/$userID");
                                    try {
                                      await imageRef.putFile(imagePicked!);
                                    } on FirebaseException catch (e) {
                                      print(e.toString());
                                    }
                                    String url =
                                        await imageRef.getDownloadURL();
                                    await usermanager.updateProfileURLByID(
                                        userID, url);
                                    setState(() {});
                                  }
                                },
                                child: Icon(
                                  Icons.edit,
                                  color: MyColors.applicationMustUsedBlue,
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: context.screenHeight * 0.1,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 30),
                        child: Icon(
                          Icons.person,
                          color: MyColors.applicationMustUsedBlue,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(data['name'],
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold))
                    ],
                  ),
                  Divider(
                    color: Colors.black.withOpacity(0.7),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Icon(
                          Icons.mail,
                          color: MyColors.applicationMustUsedBlue,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(data['email'],
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold))
                    ],
                  ),
                  Divider(
                    color: Colors.black.withOpacity(0.7),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  changePasswordButton(),
                  const SizedBox(
                    height: 20,
                  ),
                  editProfileButton(),
                  const SizedBox(
                    height: 20,
                  ),
                  logoutButton()
                ],
              ),
            );
          }),
    );
  }

  InkWell logoutButton() {
    return InkWell(
      onTap: () async {
        if (formkey.currentState!.validate()) {
          var result = await AuthService().signOut();
          if (result == "Success") {
            Navigator.pushNamedAndRemoveUntil(
                context, "/LoginPage", (route) => false);
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(result)));
          } else {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(result)));
          }
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.red,
        ),
        alignment: Alignment.center,
        height: 48,
        width: 225,
        child: const Text(
          'Logout',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  InkWell editProfileButton() {
    return InkWell(
      onTap: () async {
        showDialog(
            context: context,
            builder: (context) {
              return popUpDialogForEdit();
            });
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
          'Edit Profile',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Form popUpDialog() {
    return Form(
      key: formkey1,
      child: AlertDialog(
        title: const Text('Enter your credentials'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Fill the blank';
                }
              },
              controller: mailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              obscureText: true,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Fill the blank';
                }
              },
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          ElevatedButton(
            child: const Text('Submit'),
            onPressed: () async {
              if (formkey1.currentState!.validate()) {
                AuthCredential credential = EmailAuthProvider.credential(
                  email: mailController.text,
                  password: passwordController.text,
                );
                var result = await AuthService().reauthenticate(credential);
                if (result == "Success") {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return changePasswordDialog();
                      });
                } else {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(result)));
                  Navigator.of(context).pop();
                }
              }
            },
          ),
        ],
      ),
    );
  }

  Form popUpDialogForEdit() {
    return Form(
      key: formkey1,
      child: AlertDialog(
        title: const Text('Enter your credentials'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Fill the blank';
                }
              },
              controller: mailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              obscureText: true,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Fill the blank';
                }
              },
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          ElevatedButton(
            child: const Text('Submit'),
            onPressed: () async {
              if (formkey1.currentState!.validate()) {
                AuthCredential credential = EmailAuthProvider.credential(
                  email: mailController.text,
                  password: passwordController.text,
                );
                var result = await AuthService().reauthenticate(credential);
                if (result == "Success") {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return editDialog();
                      });
                } else {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(result)));
                  Navigator.of(context).pop();
                }
              }
            },
          ),
        ],
      ),
    );
  }

  Form changePasswordDialog() {
    return Form(
      key: formkey2,
      child: AlertDialog(
        title: const Text('Enter your new password'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Fill the blank';
                }
              },
              controller: newPasswordController,
              decoration: const InputDecoration(labelText: 'New Password'),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed("/ProfilePage");
            },
          ),
          ElevatedButton(
            child: const Text('Submit'),
            onPressed: () async {
              if (formkey2.currentState!.validate()) {
                var result = await AuthService()
                    .updatePassword(newPasswordController.text);
                if (result == 'Success') {
                  Navigator.of(context).pushReplacementNamed("/ProfilePage");
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(result)));
                } else {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(title: Text(result));
                      });
                }
              }
            },
          ),
        ],
      ),
    );
  }

  Form editDialog() {
    return Form(
      key: formkey3,
      child: AlertDialog(
        title: const Text('Enter your new name and mail'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Fill the blank';
                }
              },
              controller: nameController,
              decoration: const InputDecoration(labelText: 'New name'),
            ),
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Fill the blank';
                }
              },
              controller: newmailController,
              decoration: const InputDecoration(labelText: 'New email'),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed("/ProfilePage");
            },
          ),
          ElevatedButton(
            child: const Text('Submit'),
            onPressed: () async {
              if (formkey3.currentState!.validate()) {
                var result =
                    await AuthService().updateMail(newmailController.text);
                if (result == 'Success') {
                  await usermanager.updateNameAndMailCurrentUser(
                      newmailController.text, nameController.text);
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(result)));
                  Navigator.of(context).pushReplacementNamed("/ProfilePage");
                } else {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(result)));
                }
              }
            },
          ),
        ],
      ),
    );
  }

  InkWell changePasswordButton() {
    return InkWell(
      onTap: () async {
        showDialog(
            context: context,
            builder: (context) {
              return popUpDialog();
            });
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
          'Change Password',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
