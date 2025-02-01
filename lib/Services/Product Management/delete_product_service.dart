import 'package:car_store/constant.dart';
import 'package:car_store/helper/Api_class.dart';


class DeleteProductService {
  Future<void> deleteproduct({required String prductid}) async {
   await ApiClass().delete(url: '$baseurl/product/delete/$prductid');
  }
}




