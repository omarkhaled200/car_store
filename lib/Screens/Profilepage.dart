import 'package:car_store/Screens/User_edit_account.dart';
import 'package:car_store/widget/CustomCircleavater_username.dart';
import 'package:car_store/widget/User_details.dart';
import 'package:flutter/material.dart';

class Profilepage extends StatelessWidget {
   Profilepage({super.key, required this.uid});
final  String uid;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppBarProfilepage(uid: uid,
          conatianercolorback: const Color(0xff373B3F),
          textcolor: Colors.black,
          actionicon: const Icon(
            Icons.mode_edit_outlined,
            size: 28,
            color: Colors.white,
          ),
          text: 'Profile',
        ),
        const SizedBox(
          height: 20,
        ),
         CustomCircleavater_nameuser(uid:  uid,),
        const SizedBox(
          height: 30,
        ),
         User_detials(uid: uid,),
      ],
    );
  }
}

class CustomAppBarProfilepage extends StatelessWidget {
  CustomAppBarProfilepage(
      {super.key,
      required this.conatianercolorback,
      required this.textcolor,
      required this.actionicon,
      required this.text, required this.uid});
  final Color conatianercolorback;
  final Icon actionicon;
  final Color textcolor;
  final String text;
final  String uid; 
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextStyle(
              color: textcolor,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, UserEditAccount.id,arguments: uid);
            },
            child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: conatianercolorback,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: actionicon),
          ),
        ],
      ),
    );
  }
}
