import 'package:car_store/constant.dart';
import 'package:car_store/helper/Api_class.dart';
import 'package:car_store/models/product_model.dart';

class GetLatestProductsService {
  Future<List<ProductModel>> getlatestproduct() async {
    try {
      Map<String,dynamic> data = await ApiClass().get(url: '$baseurl/products/latest');
      List<ProductModel> productmodellist = [];
      
      data.forEach((key, value) {
        productmodellist.add(ProductModel.fromjson(id: key, value));
      });
      return productmodellist;
    } catch (e) {
      print('error: $e');
      return [];
    }
  }
}
