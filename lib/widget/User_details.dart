import 'package:car_store/Screens/Order_user_page.dart';
import 'package:car_store/Screens/login_screen.dart';
import 'package:car_store/models/UserDate.dart';
import 'package:car_store/widget/Custom_user_data_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class User_detials extends StatelessWidget {
  User_detials({super.key, required this.uid});
  final String uid;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserData?>(
      future: fetchUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data == null) {
          return Center(child: Text('No user data found'));
        } else {
          final userData = snapshot.data!;
          return Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(24),
                    topLeft: Radius.circular(24),
                  )),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Custom_user_data_details(
                      titledata: 'Name',
                      descdata: userData.name,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Custom_user_data_details(
                      titledata: 'Email',
                      descdata: userData.email,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Custom_user_data_details(
                      titledata: 'Password',
                      descdata: userData.password,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            alignment: Alignment.centerLeft,
                            minimumSize: Size(
                                MediaQuery.of(context).size.height * 0.8, 80),
                            backgroundColor: Colors.grey[200],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            )),
                        onPressed: () {
                          Navigator.pushNamed(context, OrderUserPage.id,arguments: uid);
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'View Order',
                              style:
                                  TextStyle(fontSize: 24, color: Colors.black),
                            ),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 28,
                              color: Colors.black,
                            )
                          ],
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: ()async {
                        await FirebaseAuth.instance.signOut();
                        Navigator.pushNamed(context, LoginScreen.id);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        height: 80,
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(400))),
                        child: const Text(
                          'Logout',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
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
