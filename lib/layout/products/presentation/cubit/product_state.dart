import 'package:softagi/layout/products/data/models/product_model.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}
class ProductLoaded extends ProductState {
  final ProductModel productModel;

  ProductLoaded({required this.productModel});
}
class ProductError extends ProductState {
  final String message;

  ProductError({required this.message});
}
