import 'package:car_store/helper/Api_class.dart';
import 'package:car_store/models/product_model.dart';

class CheckWishListItem {
  Future<bool> checkItemExist(String userid, String productid) async {
    try {
      Map<String, dynamic> data = await ApiClass().get(
          url:
              'https://car-store-api-production.up.railway.app/api/wishlist/check/$userid/$productid');
      int? result = data['exists'];
      if (result == 1) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('error check: $e');
      return false;
    }
  }
}
