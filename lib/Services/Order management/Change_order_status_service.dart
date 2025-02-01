
import 'package:car_store/helper/Api_class.dart';
import 'package:car_store/models/Order_model.dart';
import 'package:car_store/models/product_model.dart';


class ChangeOrderStatusService {
  Future<OrderModel> updateproduct({
    required OrderModel product,
    required String id,
  }) async {
    Map<String, dynamic> data = await ApiClass().post(
        url:
            '',
        body:{});
    return OrderModel.fromjson(jsondata: data, id: id);
  }
}
