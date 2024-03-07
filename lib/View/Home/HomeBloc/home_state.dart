import 'package:flutterwebtest/Models/category_model.dart';

abstract class HomeState {}

abstract class HomeActionState extends HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  List<CategoryModel>? categoryList;
  HomeLoaded(this.categoryList);
}

class HomeError extends HomeState {}

class HomeNavigateToImageAddState extends HomeActionState {
  String? url;
  HomeNavigateToImageAddState(this.url);
}
