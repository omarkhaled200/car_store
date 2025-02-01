import 'package:car_store/helper/Api_class.dart';
import 'package:car_store/models/product_model.dart';

class GetCategoryLatestService {
  Future<List<ProductModel>> getCarsByCategory(String category) async {
    try {
      Map<String, dynamic> data = await ApiClass().get(
          url:
              'https://car-store-api-production.up.railway.app/api/home/getCategoriesLatest');
      
      List<ProductModel> productList = [];

      if (data.containsKey(category)) {
        // البيانات التي تحت المفتاح category
        List<dynamic> categoryData = data[category];

        // التكرار على كل عنصر من عناصر الـ List
        categoryData.forEach((item) {
          // item هنا سيكون عبارة عن Map
          item.forEach((key, value) {
            // تحويل القيمة إلى كائن ProductModel
            productList.add(ProductModel.fromjson(value, id: key));
          });
        });
      }

      return productList;
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }
}
