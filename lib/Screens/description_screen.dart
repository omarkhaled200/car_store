import 'package:car_store/models/product_model.dart';

import 'package:car_store/widget/Custom_app_bar.dart';
import 'package:car_store/widget/Description_Word_page.dart';

import 'package:car_store/widget/Show_imgae_pageview.dart';
import 'package:flutter/material.dart';

class DescriptionScreen extends StatelessWidget {
  const DescriptionScreen({super.key});
  static String id = 'DescriptionScreen';

  @override
  Widget build(BuildContext context) {
    var arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    ProductModel carproduct = arguments['productmodel'];
    String userid = arguments['userid'];
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomAppBar(
              conatianercolorback: const Color(0xff373B3F),
              actionicon: const Icon(
                Icons.favorite,
                color: Colors.red,
              ),
              text: 'Car Details',
              textcolor: Colors.white,
            ),
            const SizedBox(
              height: 30,
            ),
            Show_image_pageview(
              carproduct: carproduct,
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24))),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Description_word_page(car_prodcut: carproduct,userid: userid,),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
