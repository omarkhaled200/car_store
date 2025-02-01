import 'dart:ffi';

import 'package:car_store/Screens/Admin_Panel_pages.dart';

import 'package:car_store/Screens/Register_page.dart';
import 'package:car_store/Screens/main_page.dart';
import 'package:car_store/helper/show_snakbar.dart';
import 'package:car_store/widget/custom_button.dart';
import 'package:car_store/widget/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  static String id = 'loginscreen';
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? email;

  String? password;
  String? Uid;

  GlobalKey<FormState> formkey = GlobalKey();

  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isloading,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: formkey,
          child: ListView(
            children: [
              Container(
                decoration: const BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(100),
                        bottomRight: Radius.circular(100))),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    Image.asset(
                      'assets/car-967470_1920.png',
                      height: 300,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Luxury Car',
                      style: TextStyle(
                          fontFamily: 'Pacifico-Regular',
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Container(
                padding: const EdgeInsets.all(8),
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Sign In',
                      style: TextStyle(fontSize: 25, color: Colors.black),
                    ),
                    CustomTextField(
                      hinttext: 'Enter your Email',
                      labeltext: 'Email',
                      onchanged: (data) {
                        email = data;
                      },
                      valdiate: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                      },
                    ),
                    CustomTextField(
                        obscuretext: true,
                        hinttext: 'Enter your password',
                        labeltext: 'Password',
                        onchanged: (data) {
                          password = data;
                        },
                        valdiate: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                        }),
                    const SizedBox(
                      height: 35,
                    ),
                    CustomButton(
                      text: 'Sign In',
                      onpressed: () async {
                        if (formkey.currentState!.validate()) {
                          isloading = true;
                          setState(() {});

                          // تحقق من صحة البريد الإلكتروني وكلمة المرور أولا
                        

                          try {
                            await loginuser();

                            if (valdiate().valdiateemail(email: email) &&
                                valdiate()
                                    .valdiatepassword(password: password)) {
                              Navigator.pushNamed(context, AdminPanelPages.id);
                            } else if (valdiateuser()
                                    .valdiateemail(email: email) &&
                                valdiateuser()
                                    .valdiatepassword(password: password)) {
                              Navigator.pushNamed(context, MainPage.id,
                                  arguments: Uid);
                            }
                          } on FirebaseAuthException catch (ex) {
                            // التحقق من أنواع الأخطاء
                            if (ex.code == 'user-not-found') {
                              showSnackbar(
                                  context, 'No user found for that email');
                            } else if (ex.code == 'wrong-password') {
                              showSnackbar(context,
                                  'Wrong password provided for that user.');
                            } else {
                              // عرض الخطأ في حالة عدم وجود أخطاء محددة
                              showSnackbar(
                                  context, "Firebase Error: ${ex.message}");
                            }
                          } catch (ex) {
                            // عرض رسالة الخطأ العامة في حالة حدوث أي استثناء آخر
                            print('the error is :$ex');
                            showSnackbar(context, "There was an error: $ex");
                          }

                          isloading = false;
                          setState(() {});
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'don\'t have an account? ',
                            style: TextStyle(color: Colors.black),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: InkWell(
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(
                                      color: Colors.grey[700], fontSize: 16),
                                ),
                                onTap: () {
                                  Navigator.pushNamed(context, RegisterPage.id);
                                }),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> loginuser() async {
    UserCredential user =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email!,
      password: password!,
    );
    String uid = FirebaseAuth.instance.currentUser!.uid;
    print("User UID: $uid"); // طباعة الـ UID للتأكد
    Uid = uid;
  }
}

class valdiate {
  int? num;
  RegExp patternEmail = RegExp(r'^admin\d+@admin\.org$');
  RegExp pattern_password = RegExp(r'^admin\d+$');
  bool? isValidEmail;
  bool? isValidpassword;

  bool valdiateemail({required String? email}) {
    isValidEmail = patternEmail.hasMatch(email!);
    return isValidEmail!;
  }

  bool valdiatepassword({required String? password}) {
    // isValidpassword = RegExp(pattern_password).hasMatch(password!);
    isValidpassword = pattern_password.hasMatch(password!);
    return isValidpassword!;
  }
}

class valdiateuser {
  String patternEmail = r'^[a-zA-Z0-9._%+-]+@gmail\.com$';
  String pattern_password =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  bool? isValidEmail;
  bool? isValidpassword;

  bool valdiateemail({required String? email}) {
    isValidEmail = RegExp(patternEmail).hasMatch(email!);
    return isValidEmail!;
  }

  bool valdiatepassword({required String? password}) {
    isValidpassword = RegExp(pattern_password).hasMatch(password!);
    return isValidpassword!;
  }
}
