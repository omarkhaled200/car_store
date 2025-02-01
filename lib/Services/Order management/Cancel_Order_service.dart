
import 'package:car_store/constant.dart';
import 'package:car_store/helper/Api_class.dart';


class CancelOrderService {
  Future<void> CancelOrder({required String prductid,required String userid}) async {
        // إرسال الطلب باستخدام الـ API
      Map<String, dynamic> data = await ApiClass().post(
        url: '$baseurl/order/cancelOrder/$userid/$prductid',
        body: {}
      );

  }
}




