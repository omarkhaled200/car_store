import 'package:car_store/constant.dart';
import 'package:car_store/helper/Api_class.dart';
import 'package:car_store/models/product_model.dart';

class GetUserOrdersService {
  Future<List<String>> GetUserOrders(String userid) async {
    try {
      Map<String,dynamic> data = await ApiClass().get(url: 'https://car-store-api-production.up.railway.app/api/order/getUserOrders/$userid');
          // استجابة "msg" تحتوي على المعرفات
      Map<String, dynamic> msg = data['msg'];
      
      List<String> productmodellist = [];
      
      // التكرار عبر المعرفات في "msg"
      msg.forEach((key, value) {
        // بناء كائن من نوع ProductModel باستخدام البيانات المطلوبة
        productmodellist.add(key);
      });
      print('product list is :$productmodellist');

      return productmodellist;
    } catch (e) {
      print('error user data : $e');
      return [];
    }
  }
}
