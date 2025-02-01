
import 'package:flutter/material.dart';

class Custom_user_data_details extends StatelessWidget {
   Custom_user_data_details({
    super.key, required this.titledata, required this.descdata,
  });

  final String titledata;
  final String descdata;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 12),
      alignment: Alignment.centerLeft,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(24)),
      child:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              titledata,
              style:const TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
            Padding(
              padding:const EdgeInsets.only(left:  12.0,top: 8,bottom: 8),
              child: Text(
                descdata,
                style:const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
