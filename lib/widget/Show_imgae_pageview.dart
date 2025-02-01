import 'package:car_store/models/product_model.dart';
import 'package:flutter/material.dart';

class Show_image_pageview extends StatelessWidget {
   Show_image_pageview({
    super.key, required this.carproduct,
  });

  final ProductModel carproduct;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: PageView(
        scrollDirection: Axis.horizontal,
        children: [
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
              ),
              clipBehavior: Clip.hardEdge,
              child: Image.network(
                carproduct.image,
                fit: BoxFit.cover,
              )),
        ],
      ),
    
    );
  }
}
