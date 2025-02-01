import 'package:car_store/constant.dart';
import 'package:car_store/helper/Api_class.dart';
import 'package:car_store/models/Order_model.dart';

class PostMakeOrderUser {
  // إرسال الطلب بدون ملف
  Future<OrderModel> PostMakeOrderUserrequset({
    required String productid,
    required String userid,
    required OrderModel order,
  }) async {
    try {
      // إنشاء بيانات الطلب
      Map<String, dynamic> requestData = {
        "card_number": order.cardnumber ?? '', // تعيين قيمة افتراضية فارغة
        'cvc': order.cvc ?? '',
        'date': order.date ?? '',
        'expire_date': order.expiredate ?? '',
        'location': order.location ?? '',
        'time': order.time ?? '',
      };

      // التأكد من وجود جميع الحقول المطلوبة
      if (requestData.values.contains(null)) {
        throw Exception('All fields must be filled.');
      }

      print('Request Data: $requestData');
      print('Card number: ${order.cardnumber}');
      print('CVC: ${order.cvc}');
      print('Date: ${order.date}');
      print('Expire date: ${order.expiredate}');
      print('Location: ${order.location}');
      print('Time: ${order.time}');

      // إرسال الطلب باستخدام الـ API
      Map<String, dynamic> data = await ApiClass().post(
        url: '$baseurl/order/make/$userid/$productid',
        body: requestData,
      );
      // تحويل البيانات المستلمة إلى نموذج OrderModel
      return OrderModel.fromjson(jsondata: data);
    } catch (e) {
      print('Error while making order: $e');
      rethrow; // إعادة الرمي للاستفادة من الخطأ في مستوى أعلى
    }
  }
}
