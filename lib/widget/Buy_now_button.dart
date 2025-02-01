import 'package:car_store/Screens/Check_out_screen.dart';
import 'package:car_store/models/product_model.dart';
import 'package:flutter/material.dart';

class BuyNowButton extends StatelessWidget {
const  BuyNowButton({
    super.key,
    required this.carproduct, required this.userid,
  });

  final ProductModel carproduct;
  final String userid;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, CheckOutScreen.id, arguments: {'carproduct':carproduct,'userid':userid});
      },
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width * 0.5,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(44),
        ),
        child: const Text(
          'Buy Now',
          style: TextStyle(
              color: Colors.white, fontSize: 28, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
