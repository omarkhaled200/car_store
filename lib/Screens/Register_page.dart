import 'dart:math';

import 'package:car_store/Screens/login_screen.dart';
import 'package:car_store/Screens/main_page.dart';
import 'package:car_store/helper/show_snakbar.dart';
import 'package:car_store/widget/custom_button.dart';
import 'package:car_store/widget/custom_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});
  static String id = 'RegisterPage';

  @override
  State<RegisterPage> createState() => _SignUpState();
}

class _SignUpState extends State<RegisterPage> {
  String? fullname;
  String? email;

  String? password;
  String? confirm_password;

  GlobalKey<FormState> formkey = GlobalKey();

  bool isloading = false;

  CollectionReference users = FirebaseFirestore.instance.collection('users');

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
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(100),
                        bottomRight: Radius.circular(100))),
                child: Column(
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    Image.asset(
                      'assets/pngwing.com.png',
                      height: 250,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Luxury Car',
                      style: TextStyle(
                          fontFamily: 'Pacifico-Regular',
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 80,
              ),
              Container(
                padding: EdgeInsets.all(8),
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'REGISTER',
                      style: TextStyle(fontSize: 25, color: Colors.black),
                    ),
                    CustomTextField(
                      hinttext: 'your Full name',
                      labeltext: 'Full name',
                      onchanged: (data) {
                        fullname = data;
                      },
                      valdiate: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter  your Full name';
                        }
                      },
                    ),
                    CustomTextField(
                      hinttext: 'your Last Email',
                      labeltext: 'Email',
                      onchanged: (data) {
                        email = data;
                      },
                      valdiate: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email li  ......@gmail.com';
                        }
                        if (!valdiateuser().valdiateemail(email: email) ||
                            !valdiate().valdiateemail(email: email)) {
                          return 'Please enter a valid email';
                        }
                      },
                    ),
                    CustomTextField(
                      hinttext: 'Enter your password',
                      labeltext: 'Password',
                      onchanged: (data) {
                        password = data;
                      },
                      valdiate: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please  Enter your password';
                        }
                        if (!valdiateuser()
                                .valdiatepassword(password: password) ||
                            !valdiate().valdiatepassword(password: password)) {
                        return 'It must contain at least one uppercase letter (e.g., A, B, C...)\nIt must contain at least one lowercase letter (e.g., a, b, c...) \nIt must contain at least one number (e.g., 0, 1, 2...).\nIt must contain at least one special character (e.g., !, @, #, &, *, ~).\nIt must be at least 8 characters long';
    }
                      },
                    ),
                    CustomTextField(
                      hinttext: 'Enter your Confirm password',
                      labeltext: 'Confirm Password',
                      onchanged: (data) {
                        confirm_password = data;
                      },
                      valdiate: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter your Confirm password';
                        }
                        if (value != password) {
                          return 'Confirm password not match password';
                        }
                        if (!valdiateuser()
                                .valdiatepassword(password: password) ||
                            !valdiate().valdiatepassword(password: password)) {
                          return 'Please enter a valid email';
                        }
                      },
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    CustomButton(
                        text: 'Register',
                        onpressed: () async {
                          if (formkey.currentState!.validate()) {
                            if (password == confirm_password &&
                                valdiate().valdiateemail(email: email) &&
                                valdiate()
                                    .valdiatepassword(password: password)) {
                              isloading = true;
                              setState(() {});
                              try {
                                await registeruser();
                                showSnackbar(context, 'Created Successfully');
                                Navigator.pushNamed(context, LoginScreen.id);
                              } on FirebaseAuthException catch (ex) {
                                print(ex.code);
                                if (ex.code == 'weak-password') {
                                  showSnackbar(context, 'The password is Weak');
                                } else if (ex.code == 'email-already-in-use') {
                                  showSnackbar(context, 'email already exists');
                                }
                              } catch (ex) {
                                showSnackbar(context, "there was an error");
                              }
                              isloading = false;
                              setState(() {});
                            } else {}
                          } else {}
                        }),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account? ',
                            style: TextStyle(color: Colors.black),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: InkWell(
                                child: Text(
                                  'Sign In',
                                  style: TextStyle(
                                      color: Colors.grey[700], fontSize: 16),
                                ),
                                onTap: () {
                                  Navigator.pushNamed(context, LoginScreen.id);
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

  Future<void> registeruser() async {
    UserCredential user =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    );
    String uid = FirebaseAuth.instance.currentUser!.uid;
    users.doc(uid).set({
      'Uid': FirebaseAuth.instance.currentUser!.uid,
      'Full name': fullname,
      'email': email,
      'password': password,
      'confirm password': confirm_password
    });
  }
}

class valdiate {
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
