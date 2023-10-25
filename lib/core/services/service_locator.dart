import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:softagi/core/bloc/cubit/global_cubit.dart';
import 'package:softagi/core/database/api/api_consumer.dart';
import 'package:softagi/core/database/api/dio_consumer.dart';
import 'package:softagi/core/database/cache/cache_helper.dart';
import 'package:softagi/layout/auth/data/repository/auth_repository.dart';
import 'package:softagi/layout/auth/presentation/cubit/login_cubit.dart';

final sl = GetIt.instance;

void initServiceLocator() {
  sl.registerLazySingleton(() => GlobalCubit());
  sl.registerLazySingleton(() => CacheHelper());
  sl.registerLazySingleton(() => AuthRepository());
  sl.registerLazySingleton<APIConsumer>(() => DioConsumer(GetIt.instance()));
  sl.registerLazySingleton(() => Dio());
  // sl.registerLazySingleton(() => LoginCubit(sl()));
}