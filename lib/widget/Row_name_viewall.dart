import 'package:flutter/material.dart';

class Row_name_viewall extends StatelessWidget {
   Row_name_viewall({super.key, required this.name, this.ontap});

  final String name;
  final void Function()? ontap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0, top: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: const TextStyle(
                color: Colors.black, fontSize: 28, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            width: 400,
          ),
          GestureDetector(
            onTap: ontap,
            child: Text(
              'View All',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
