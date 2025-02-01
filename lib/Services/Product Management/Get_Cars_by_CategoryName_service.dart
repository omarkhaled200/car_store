import 'package:car_store/constant.dart';
import 'package:car_store/helper/Api_class.dart';
import 'package:car_store/models/product_model.dart';

class CategoryService {
  Future<List<ProductModel>> getcategoryproduct(
      {required String categoryname}) async {
    Map<String,dynamic> data = await ApiClass().get(url: '$baseurl/products/$categoryname');
    List<ProductModel> productmodellist = [];
    data.forEach((key, value) {
      productmodellist.add(ProductModel.fromjson(value));
    });
    return productmodellist;
  }
}
