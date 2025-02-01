import 'package:car_store/Screens/User_edit_account.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomAppBar extends StatelessWidget {
  CustomAppBar(
      {super.key,
      required this.conatianercolorback,
      required this.textcolor,
      required this.actionicon,
      required this.text, this.ontap});
  final Color conatianercolorback;
  final Icon actionicon;
  final Color textcolor;
  final String text;
  final void Function()? ontap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: conatianercolorback,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Icon(
                  Icons.arrow_back_rounded,
                  size: 28,
                  color: Colors.white,
                )),
          ),
          Text(
            text,
            style: TextStyle(
              color: textcolor,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          GestureDetector(
            onTap: ontap,
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
