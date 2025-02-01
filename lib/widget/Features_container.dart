import 'package:flutter/material.dart';

class Features_container extends StatelessWidget {
  const Features_container({
    super.key,
    required this.title1,
    required this.title2,
    required this.icon,
  });
  final String title1;
  final String title2;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: 200,
      decoration: BoxDecoration(
          color: const Color(0xffE1E3E5),
          borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0, left: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18)),
                child: icon),
            const SizedBox(
              height: 70,
            ),
            Text(
              title1,
              style: TextStyle(fontSize: 22, color: Colors.grey[600]),
            ),
          const  SizedBox(height: 5,),
            Text(
              title2,
              style: const TextStyle(fontSize: 22, color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
