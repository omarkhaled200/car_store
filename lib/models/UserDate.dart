import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserData {
  final String name;
  final String email;
  final String password;
  final String image;

  UserData({
    required this.image,
    required this.name,
    required this.email,
    required this.password,
  });

  // دالة لتحويل البيانات من Map
  factory UserData.fromMap(Map<String, dynamic> data) {
    return UserData(
      image: data['image'] ?? 'No image',
      name: data['Full name'] ?? 'No Name',
      email: data['email'] ?? 'No Email',
      password: data['password'] ?? 'No password',
    );
  }
}
