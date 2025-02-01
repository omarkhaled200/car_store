import 'package:car_store/constant.dart';
import 'package:car_store/helper/Api_class.dart';
import 'package:car_store/models/product_model.dart';

class GetProductService {
  Future<List<ProductModel>> getProduct({required List<String> productid}) async {
    List<ProductModel> products = [];
    for (String productId in productid) {
      Map<String, dynamic> data = await ApiClass().get(
          url: 'https://car-store-api-production.up.railway.app/api/product/$productId');
      print("data equal :$data");
      
      // التأكد من أن data ليست فارغة أو مفقودة
      if (data != null && data.isNotEmpty) {
        products.add(ProductModel.fromjson(data, id: productId));
      }
    }
    print("the products is : $products");
    return products;
  }
}
