import 'package:car_store/models/product_model.dart';
import 'package:car_store/widget/Features_container.dart';
import 'package:flutter/material.dart';

class Features_data_car extends StatelessWidget {
   Features_data_car({super.key, required this.featuresproduct});
final  ProductModel featuresproduct;
  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Features_container(
          icon:const Icon(
            Icons.event_seat_rounded,
            size: 28,
          ),
          title1: 'total Capacity',
          title2: '${featuresproduct.seats} seats',
        ),
        Features_container(
          icon:const Icon(
            Icons.speed,
            size: 28,
          ),
          title1: 'Highest Speed',
          title2: '${featuresproduct.speed} KM/H',
        ),
        Features_container(
          icon:const Icon(
            Icons.bolt,
            size: 28,
          ),
          title1: 'Engine Output',
          title2: '${featuresproduct.engine} HP',
        ),
      ],
    );
  }
}
