import 'dart:io';

import 'package:car_store/models/UserDate.dart';
import 'package:car_store/widget/Custom_app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class UserEditAccount extends StatefulWidget {
  UserEditAccount({super.key});
  static String id = 'UserEditAccount';

  @override
  State<UserEditAccount> createState() => _UserEditAccountState();
}

class _UserEditAccountState extends State<UserEditAccount> {
  String? Full_name;

  String? Email;

  String? Password;

  File? image;
  final PickedFile = ImagePicker();
  uploadImage() async {
    XFile? xFile = await PickedFile.pickImage(source: ImageSource.gallery);
    if (xFile != null) {
      setState(() {
        image = File(xFile.path);
      });
    } else {
      setState(() {
        image = File('assets/defult profile.jpg');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String uid = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
        backgroundColor: Colors.white,
        body: StreamBuilder<UserData?>(
          stream: Stream.fromFuture(fetchUserData()),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data == null) {
              return Center(child: Text('No user data found'));
            } else {
              final userData = snapshot.data!;
              Full_name = userData.name;
              Email = userData.email;
              Password = userData.password;
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ListView(
                    children: [
                      CustomAppBar(
                        ontap: () {
                          saveUserData(Full_name!, Password!, Email!, uid,
                              image!.toString());
                          updateEmail(Email!);
                          updatePassword(Password!);
                        },
                        conatianercolorback: const Color(0xff373B3F),
                        textcolor: Colors.black,
                        actionicon: const Icon(
                          Icons.check,
                          size: 28,
                          color: Colors.white,
                        ),
                        text: 'Edit Profile',
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: uploadImage,
                          child: const Stack(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.amber,
                                radius: 100,
                                child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 150,
                                ),
                              ),
                              Positioned(
                                  bottom: 15,
                                  right: 20,
                                  child: Icon(
                                    Icons.add_circle_outlined,
                                    color: Colors.black,
                                    size: 32,
                                  ))
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Full Name',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          Textfield(
                            hinttext: userData.name,
                            onchange: (value) {
                              Full_name =
                                  value.isNotEmpty ? value : userData.name;
                            },
                          ),
                        ],
                      )),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Password',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500)),
                          Textfield(
                            hinttext: userData.password,
                            onchange: (value) {
                              Password =
                                  value.isNotEmpty ? value : userData.password;
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Email',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500)),
                          Textfield(
                            hinttext: userData.email,
                            onchange: (value) {
                              Email = value.isNotEmpty ? value : userData.email;
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ));
  }
}

class Textfield extends StatelessWidget {
  Textfield({super.key, required this.hinttext, required this.onchange});
  final String? hinttext;
  final void Function(String)? onchange;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        onChanged: onchange,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.black),
          ),
          hintText: hinttext,
          hintStyle: TextStyle(color: Colors.grey[500], fontSize: 15),
        ));
  }
}

Future<void> saveUserData(String fullname, String password, String email,
    String uid, String image) async {
  try {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    await _firestore.collection('users').doc(uid).update({
      'Full name': fullname,
      'password': password,
      'email': email,
      'image': image,
    });

    print('Profile updated successfully!');
  } catch (e) {
    print(e);
  }
}

Future<UserData?> fetchUserData() async {
  try {
    // الحصول على الـ UID الخاص بالمستخدم الحالي
    String uid = FirebaseAuth.instance.currentUser!.uid;

    // الوصول إلى الـ Document الخاص بالمستخدم
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users') // اسم الـ Collection
        .doc(uid) // الـ UID هو المعرف
        .get();

    // التحقق من وجود البيانات
    if (userDoc.exists) {
      // تحويل البيانات إلى UserData
      return UserData.fromMap(userDoc.data() as Map<String, dynamic>);
    } else {
      print('User data not found');
      return null;
    }
  } catch (e) {
    print('Error fetching user data: $e');
    return null;
  }
}


Future<void> updateEmail(String newEmail) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    User? user = _auth.currentUser;

    try {
      // تحقق من إذا كان المستخدم قد سجل الدخول مؤخرًا، وإذا لم يكن كذلك، نطلب منهم إعادة تسجيل الدخول
      await user?.reauthenticateWithCredential(
        EmailAuthProvider.credential(
          email: user!.email!,
          password: 'your-current-password', // أدخل كلمة المرور الحالية
        ),
      );

      // إذا كانت عملية المصادقة ناجحة، نقوم بتغيير البريد الإلكتروني
      await user?.updateEmail(newEmail);
      await user?.sendEmailVerification(); // إرسال رسالة التحقق إلى البريد الجديد
      print("Email updated successfully");

    } catch (e) {
      print('Error updating email: $e');
      if (e is FirebaseAuthException) {
        if (e.code == 'requires-recent-login') {
          // إذا كانت العملية تتطلب إعادة تسجيل الدخول
          print("Please log in again to change your email");
        }
      }
    }
  }

  // تغيير كلمة المرور
  Future<void> updatePassword(String newPassword) async {
      final FirebaseAuth _auth = FirebaseAuth.instance;
    User? user = _auth.currentUser;

    try {
      // تحقق من إذا كان المستخدم قد سجل الدخول مؤخرًا، وإذا لم يكن كذلك، نطلب منهم إعادة تسجيل الدخول
      await user?.reauthenticateWithCredential(
        EmailAuthProvider.credential(
          email: user!.email!,
          password: 'your-current-password', // أدخل كلمة المرور الحالية
        ),
      );

      // إذا كانت عملية المصادقة ناجحة، نقوم بتغيير كلمة المرور
      await user?.updatePassword(newPassword);
      print("Password updated successfully");

    } catch (e) {
      print('Error updating password: $e');
      if (e is FirebaseAuthException) {
        if (e.code == 'requires-recent-login') {
          // إذا كانت العملية تتطلب إعادة تسجيل الدخول
          print("Please log in again to change your password");
        }
      }
    }
  }