import 'package:car_store/constant.dart';
import 'package:car_store/helper/Api_class.dart';
import 'package:car_store/models/Order_model.dart';
import 'package:car_store/models/product_model.dart';

class GetOrderService {
  Future<List<OrderModel>> GetOrder(
      {required List<String> productid, required String userid}) async {
    List<OrderModel> products = [];
    Map<String, dynamic> data = {};
    for (String productId in productid) {
      Map<String, dynamic> data = await ApiClass().get(
          url:
              'https://car-store-api-production.up.railway.app/api/order/getOrder/$userid/$productId');
      for (int i = 0; i < productid.length; i++) {
        print('number of iteration is $i');
        if (i == 0) {
          products.add(OrderModel.fromjson(jsondata: data['msg']));
          break;
        }
      }
    }
    print("the products is : $products");
    return products;
  }
}
