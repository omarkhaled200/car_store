part of 'homepage_cubit.dart';

@immutable
sealed class HomepageState {}

final class HomepageInitial extends HomepageState {}
final class HomepageLoading extends HomepageState {}
final class HomepageSuccess extends HomepageState {
   final List<ProductModel> cars;
  HomepageSuccess({required this.cars});
}
final class HomepageFailure extends HomepageState {}
