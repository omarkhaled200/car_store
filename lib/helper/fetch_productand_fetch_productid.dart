import 'dart:convert';
import 'package:car_store/constant.dart';
import 'package:http/http.dart' as http;

Future<List<Map<String, dynamic>>> fetchProducts() async {
  final url =
      Uri.parse('$baseurl/products');
  
  // إذا كنت بحاجة إلى توكين
  // final token = 'YOUR_TOKEN_HERE';

  final response = await http.get(
    url,
    headers: {
      'Content-Type': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    // تحويل الرد إلى JSON
    final List<dynamic> data = jsonDecode(response.body);

    // إعادة المنتجات كقائمة من الخرائط
    return data.map((product) => product as Map<String, dynamic>).toList();
  } else {
    throw Exception('Failed to fetch products. Status code: ${response.statusCode}');
  }
}



Future<List<String>> fetchProductIds() async {
  final products = await fetchProducts();
  
  // استخراج الـ IDs من كل منتج
  return products.map((product) => product['id'] as String).toList();
}
