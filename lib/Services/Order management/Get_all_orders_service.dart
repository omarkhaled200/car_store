import 'package:car_store/constant.dart';
import 'package:car_store/helper/Api_class.dart';
import 'package:car_store/models/Order_model.dart';
import 'package:car_store/models/product_model.dart';

class GetAllOrdersService {
  Future<List<OrderModel>> getAllorder() async {
    Map<String, dynamic> data =
        await ApiClass().get(url: '$baseurl/order/getAllOrders');

    Map<String, dynamic> orders = data['msg'];
    List<OrderModel> orderlist = [];
    // التكرار عبر المفاتيح الرئيسية
    orders.forEach((outerKey, innerMap) {
      // التكرار عبر الكائن الداخلي
      (innerMap as Map<String, dynamic>).forEach((key, value) {
        // تحويل الكائن الداخلي إلى ProductModel
        orderlist.add(OrderModel.fromjson(jsondata: value));
      });
    });
    print('the order list is :${orderlist}');
    return orderlist;
  }

Future<Map<String, List<String>>> extractKeysAsMap() async {
  try {
    Map<String, dynamic> data =
        await ApiClass().get(url: '$baseurl/order/getAllOrders');

    Map<String, dynamic> msg = data['msg'];
    Map<String, List<String>> resultMap = {};

    // التكرار على المستوى الخارجي
    msg.forEach((outerKey, innerMap) {
      // إنشاء قائمة لتخزين المفاتيح الداخلية
      List<String> innerKeys = [];

      // التكرار على المستوى الداخلي (المفاتيح الفرعية)
      (innerMap as Map<String, dynamic>).forEach((innerKey, value) {
        innerKeys.add(innerKey);
      });

      // تخزين المفتاح الأساسي وقائمة المفاتيح الداخلية في الخريطة
      resultMap[outerKey] = innerKeys;
    });

    print('Extracted Map: $resultMap');
    return resultMap;
  } catch (e) {
    print('Error extracting keys as Map: $e');
    return {};
  }
}

}


