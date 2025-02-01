
import 'package:flutter/material.dart';

class CustomLocationdata extends StatelessWidget {
  CustomLocationdata({
    super.key,
    required this.labeltext,
    required this.icon,
    this.onchange,
  });

  final String labeltext;
  final Icon icon;
  final void Function(String)? onchange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: TextFormField(
          onChanged: onchange,
          validator: (data) {
            if (data!.isEmpty) {
              return 'Field is required';
            }
          },
          // onChanged: onchanged,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            fillColor: const Color(0xff303A46),
            filled: true,
            suffixIcon: icon,
            suffixIconColor: Colors.amber,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.white),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.white),
            ),
            labelText: labeltext,
            labelStyle: const TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
          )),
    );
  }
}
