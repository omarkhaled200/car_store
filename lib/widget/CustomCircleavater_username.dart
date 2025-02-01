import 'package:car_store/models/UserDate.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomCircleavater_nameuser extends StatelessWidget {
  CustomCircleavater_nameuser({super.key, required this.uid});

  final String uid;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserData?>(
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
        return  Column(
            children: [
              CircleAvatar(
                radius: 160,
                backgroundColor: Colors.lightBlue[900],
                child: CircleAvatar(
                  radius: 150,
                  backgroundColor: Colors.white,
                  child: Image.asset(
                    'assets/car_lolo1.png' ,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
               Text(
                userData.name,
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
              )
            ],
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
