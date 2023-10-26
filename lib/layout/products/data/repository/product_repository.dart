import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:softagi/core/database/api/api_consumer.dart';
import 'package:softagi/core/database/api/dio_consumer.dart';
import 'package:softagi/core/database/api/end_points.dart';
import 'package:softagi/core/error/exceptions.dart';
import 'package:softagi/core/services/service_locator.dart';
import 'package:softagi/layout/products/data/models/product_model.dart';

class ProductRepository {
  Future<Either<String, ProductModel>> getProduct() async {
    try {
      final SharedPreferences s = await SharedPreferences.getInstance();
      String? token = await s.getString('token');
      final response = await sl<APIConsumer>().get('${EndPoint.baseURL}${EndPoint.product}', queryParameters: {
        'lang': 'ar',
        'Content-Type': 'application/json',
        'Authorization': token,
      });
      log(response.data.toString());
      return Right(ProductModel.fromJson(response.data));
    } on ServerException catch (error) {
      return Left(error.errorModel.errorMessage);
    } on DioException catch (e) {
      var error = DioConsumer(Dio()).handleDioException(e);
      log(error.toString(), name: 'Newoooo');
      log(e.response.toString(), name: 'Dio Mohamed');
      return left(e.response?.data.toString() ?? '');
    }
  }
}
