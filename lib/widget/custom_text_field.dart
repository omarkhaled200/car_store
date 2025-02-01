
import 'package:car_store/Screens/login_screen.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {required this.hinttext, required this.labeltext, this.onchanged,this.obscuretext=false,required this.valdiate, });
  String? hinttext;
  String? labeltext;
  bool? obscuretext;
  final String? Function(String?)? valdiate;
  Function(String)? onchanged;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: TextFormField(
        obscureText:obscuretext! ,
          validator: valdiate,
          onChanged: onchanged,
          style:const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide:const BorderSide(color: Colors.black),
            ),
            hintText: hinttext,
            labelText: labeltext,
            labelStyle:
            const    TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
            hintStyle:const TextStyle(color: Colors.white, fontSize: 13),
          )),
    );
  }
}
