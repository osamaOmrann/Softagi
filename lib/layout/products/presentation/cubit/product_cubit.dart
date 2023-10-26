import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softagi/core/error/exceptions.dart';
import 'package:softagi/layout/products/data/repository/product_repository.dart';
import 'package:softagi/layout/products/presentation/cubit/product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit(this.productRepository) : super(ProductInitial());
  final ProductRepository productRepository;
  void getProduct() async {
    try{
      final result = await productRepository.getProduct();
      result.fold((l) => emit(ProductError(message: l)), (r) {
        emit(ProductLoaded(productModel: r));
      });
      // emit(ProductLoaded(productModel: result.));
    } on ServerException catch (error) {
      //emit
    }
  }
}