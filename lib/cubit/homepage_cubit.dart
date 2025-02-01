import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:car_store/Services/Home%20page%20management/Get_Category_latest_service.dart';
import 'package:car_store/models/product_model.dart';
import 'package:meta/meta.dart';

part 'homepage_state.dart';

class HomepageCubit extends Cubit<HomepageState> {
  HomepageCubit() : super(HomepageInitial());

  final StreamController<List<ProductModel>> _carsController = StreamController<List<ProductModel>>();

  Stream<List<ProductModel>> get carsStream => _carsController.stream;

  void startListeningForCars(String category) async {
    emit(HomepageLoading());
    while (true) {
      try {
        final cars = await GetCategoryLatestService().getCarsByCategory(category);
        if (cars != null && cars.isNotEmpty) {
          _carsController.add(cars); // بث البيانات إلى Stream
          emit(HomepageSuccess(cars: cars));
        } else {
          _carsController.add([]); // بث قائمة فارغة إذا لم تكن هناك بيانات
          emit(HomepageFailure());
        }
      } catch (e) {
        print('Error fetching $category cars: $e');
        emit(HomepageFailure());
      }
      await Future.delayed(const Duration(seconds: 5)); // تحديث البيانات كل 5 ثوانٍ
    }
  }

  @override
  Future<void> close() {
    _carsController.close(); // إغلاق StreamController عند الإغلاق
    return super.close();
  }
}
