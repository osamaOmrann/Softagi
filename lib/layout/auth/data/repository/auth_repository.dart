import 'package:dartz/dartz.dart';
import 'package:softagi/core/database/api/api_consumer.dart';
import 'package:softagi/core/database/api/end_points.dart';
import 'package:softagi/core/error/exceptions.dart';
import 'package:softagi/core/services/service_locator.dart';
import 'package:softagi/layout/auth/data/models/login_model.dart';

class AuthRepository {
  Future<Either<String, LoginModel>> login(
      {required String email, required String password}) async {
    try {
      final response = await sl<APIConsumer>().post(EndPoint.login,
          data: {APIKeys.email: email, APIKeys.password: password});
      return Right(LoginModel.fromJson(response));
    } on ServerException catch (error) {
      return Left(error.errorModel.errorMessage);
    }
  }
}
