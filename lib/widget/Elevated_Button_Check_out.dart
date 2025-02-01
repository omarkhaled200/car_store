import 'package:car_store/Screens/Check_out_screen.dart';
import 'package:car_store/Screens/Checkout_success.dart';
import 'package:car_store/Services/Order%20management/post_make_order_user.dart';
import 'package:car_store/models/Order_model.dart';
import 'package:flutter/material.dart';

class ElevatedButtonCheckOut extends StatelessWidget {
  const ElevatedButtonCheckOut({
    super.key,
    required this.formkey,
    required this.productid,
    required this.userid,
    required this.order,
  });
  final GlobalKey<FormState> formkey;
  final String productid;
  final String userid;
  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              minimumSize: Size(MediaQuery.of(context).size.width * 0.7, 70),
              backgroundColor: Colors.amber,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16))),
          onPressed: () {
            print('product id is : $productid');
            print('user id is : $userid');
            if (formkey.currentState!.validate())
            {
              PostMakeOrderUser().PostMakeOrderUserrequset(
                  productid: productid, userid: userid, order: order);
              Navigator.pushNamed(context, CheckoutSuccess.id);
            }
          },
          child: const Text(
            'Check Out',
            style: TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.w500),
          )),
    );
  }
}
