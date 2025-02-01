import 'package:flutter/material.dart';

class ProductModel {
  final String id;
  String category;
  String descriptoin;
  String engine;
  String carname;
  String price;
  String rating;
  String image;
  String seats;
  String speed;

  ProductModel(
      {required this.id,
      required this.carname,
      required this.descriptoin,
      required this.price,
      required this.image,
      required this.rating,
      required this.category,
      required this.engine,
      required this.seats,
      required this.speed});

  factory ProductModel.fromjson(Map<String, dynamic> jsondata, {@required String? id}) {
    return ProductModel(
        id: id!,
        carname: jsondata['name'],
        descriptoin: jsondata['description'],
        price: jsondata['price'],
        image: jsondata['image'],
        rating: jsondata['rating'],
        category: jsondata['category'],
        engine: jsondata['engine'],
        seats: jsondata['seats'],
        speed: jsondata['speed']);
  }
}
