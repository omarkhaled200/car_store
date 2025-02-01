import 'dart:convert';
import 'package:car_store/models/product_model.dart';
import 'package:http/http.dart' as http;

class HandleWishlist {
  Future<void> addProductToWishlist({
    required String userId,
    required String productId,
    required ProductModel product,
  }) async {
    final url =
        'https://car-store-api-production.up.railway.app/api/wishlist/handle/$userId?id=$productId';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": product.carname,
          "description": product.descriptoin,
          "price": product.price,
          "rating": product.rating,
          "category": product.category,
          "seats": product.seats,
          "speed": product.speed,
          "engine": product.engine,
          "image": product.image, // إرسال الصورة كـ String (رابط URL)
        }),
      );

      if (response.statusCode == 200) {
        print('Product added to wishlist successfully.');
        print('Response: ${response.body}');
      } else {
        print('Failed to add product. Status code: ${response.statusCode}');
        print('Response: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
