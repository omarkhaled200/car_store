import 'package:car_store/Screens/description_screen.dart';
import 'package:car_store/widget/Custom_app_bar.dart';
import 'package:car_store/widget/Custom_card_car.dart';
import 'package:car_store/widget/custom_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ViewallProduct extends StatelessWidget {
  const ViewallProduct({super.key});
  static String id = 'ViewallProduct';
  @override
  Widget build(BuildContext context) {
    var cars =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    print(cars); // طباعة الكائن المرسل لفحص محتوياته

    var products = cars['products'] as List; // تأكد من أنها قائمة المنتجات
    print(products.runtimeType); // طباعة نوع البيانات للتحقق إذا كانت قائمة

    var title = cars['title'];
    var userid=cars['userid'];
    print(title); // طباعة العنوان للتحقق من صحته

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 80,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24))),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0,
        foregroundColor: Colors.white,
        title: Text(
          title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
        child: GridView.builder(
            itemCount: products.length,
            clipBehavior: Clip.none,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.5,
              crossAxisSpacing: 10,
              mainAxisSpacing: 20,
            ),
            itemBuilder: (coontext, index) {
              return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, DescriptionScreen.id,
                        arguments: products[index]);
                  },
                  child: Custom_card_car(userid:userid,
                    product: products[index],
                  ));
            }),
      ),
    );
  }
}
