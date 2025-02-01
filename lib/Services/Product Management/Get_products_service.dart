import 'package:car_store/constant.dart';
import 'package:car_store/helper/Api_class.dart';
import 'package:car_store/models/product_model.dart';

class GetAllProductService {
 Future<List<ProductModel>> getallproduct() async {
    try {
      Map<String, dynamic> data = await ApiClass().get(url: '$baseurl/products');
      List<ProductModel> productmodellist = [];

      data.forEach((key, value) {
        // قم باستخدام المفتاح (key) مع البيانات (value)
        productmodellist.add(ProductModel.fromjson(id: key,  value));
      });

      return productmodellist;
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

}
