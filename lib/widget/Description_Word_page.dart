import 'package:car_store/models/product_model.dart';
import 'package:car_store/widget/Buy_now_button.dart';
import 'package:car_store/widget/Features_data_car.dart';
import 'package:flutter/material.dart';

class Description_word_page extends StatelessWidget {
  const Description_word_page({
    super.key,
    required this.car_prodcut, required this.userid,
  });

  final ProductModel car_prodcut;
  final String userid;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              car_prodcut.carname,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 32,
                  fontWeight: FontWeight.w600),
            ),
            Row(
              children: [
                const Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 28,
                ),
                Text(
                  '(${car_prodcut.rating})',
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.w500),
                )
              ],
            )
          ],
        ),
        Text(
          car_prodcut.descriptoin,
          style: const TextStyle(
            fontSize: 22,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          'Features',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 10,
        ),
        Features_data_car(
          featuresproduct: car_prodcut,
        ),
        const SizedBox(
          height: 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Price',
                  style: TextStyle(fontSize: 24, color: Colors.grey[500]),
                ),
                Text(
                  r'$' '${car_prodcut.price}',
                  style: const TextStyle(
                      fontSize: 28,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            BuyNowButton(
              userid: userid,
              carproduct: car_prodcut,
            )
          ],
        )
      ],
    );
  }
}
