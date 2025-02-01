import 'dart:convert';
import 'dart:io';

import 'package:car_store/constant.dart';
import 'package:car_store/helper/Api_class.dart';
import 'package:car_store/models/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class AddProductService {
  Future<ProductModel> addproduct({
    required ProductModel product,
  }) async {
    Map<String, dynamic> data =
        await ApiClass().post(url: '$baseurl/product/add?', body: {
      "image": product.image,
      'name': product.carname,
      'description': product.descriptoin,
      'price': product.price,
      'rating': product.rating,
      'category': product.category,
      'seats': product.seats,
      'speed': product.speed,
      'engine': product.engine,
    });

    return ProductModel.fromjson(data);
  }

  addprodcutRequestWithfile(
      {required ProductModel product, required File file}) async {
    var request = http.MultipartRequest(
        "Post",
        Uri.parse(
            'https://car-store-api-production.up.railway.app/api/product/add?'));
    var lenght = await file.length();
    var stream = http.ByteStream(file.openRead());
    var multipartFile = http.MultipartFile("image", stream, lenght,
        filename: basename(file.path));
    request.files.add(multipartFile);
    request.fields['name'] = product.carname;
    request.fields['description'] = product.descriptoin;
    request.fields['price'] = product.price;
    request.fields['rating'] = product.rating;
    request.fields['category'] = product.category;
    request.fields['seats'] = product.seats;
    request.fields['speed'] = product.speed;
    request.fields['engine'] = product.engine;
    var myrequest = await request.send();
    var response = await http.Response.fromStream(myrequest);
    if (myrequest.statusCode == 200) {
      print('added sucessfully');
      return jsonDecode(response.body);
    } else {
      print('Error and Status code is ${myrequest.statusCode}');
      print('Response body: ${response.body}');
    }
  }
}
