
import 'dart:convert';
import 'dart:io';

import 'package:car_store/constant.dart';
import 'package:car_store/helper/Api_class.dart';
import 'package:car_store/models/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class UpdateProductService {
  Future<ProductModel> updateproduct({
    required ProductModel product,
    required String id,
  }) async {
    Map<String, dynamic> data = await ApiClass().post(
        url:
            'https://car-store-api-production.up.railway.app/api/product/update/$id?name=${product.carname}&description=${product.descriptoin}&price=${product.price}&rating=${product.rating}&category=${product.category}&seats=${product.seats}&speed=${product.speed}&engine=${product.engine}',
        body: {"image": product.image});
    return ProductModel.fromjson(data,id: id);
  }

updateprodcutRequestWithfile(
      {required ProductModel product, required File file,  required String id,}) async {
    var request = http.MultipartRequest(
        "POST",
        Uri.parse(
            'https://car-store-api-production.up.railway.app/api/product/update/$id?'));
    var lenght = await file.length();
    var stream = http.ByteStream(file.openRead());
    var multipartFile = http.MultipartFile("image", stream, lenght,
        filename: basename(file.path));
    request.files.add(multipartFile);

print('Sending data:');
print('carname: ${product.carname}');
print('description: ${product.descriptoin}');
print('price: ${product.price}');
print('category: ${product.category}');
// porsche Cayenne



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


