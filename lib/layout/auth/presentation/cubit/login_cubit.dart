import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softagi/core/database/api/end_points.dart';
import 'package:softagi/layout/auth/data/models/login_model.dart';
import 'package:softagi/layout/auth/data/repository/auth_repository.dart';
import 'package:softagi/layout/auth/presentation/cubit/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.authRepo) : super(LoginInitial());
  final AuthRepository authRepo;
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoginPasswordShown = true;
  IconData suffixIocn = Icons.visibility;
  void changeLoginPasswordSuffixIcon() {
    isLoginPasswordShown = !isLoginPasswordShown;
    suffixIocn = isLoginPasswordShown? Icons.visibility: Icons.visibility_off;
    emit(ChangeLoginPasswordSuffixIcon());
  }
  LoginModel? loginModel;
  void login() async {
    emit(LoginLoadingState());
    /*final result = await authRepo.login(email: emailController.text, password: passwordController.text);
    result.fold((l) => emit(LoginErrorState(l)), (r) {
      loginModel = r;
      emit(LoginSuccessState());
    });*/

    String email = emailController.text;
    String password = passwordController.text;

    var dio = Dio();
    var url = '${EndPoint.baseURL}${EndPoint.login}';

    try {
      var response = await dio.post(
        url,
        data: json.encode({
          'email': email,
          'password': password,
        }),
      );

      // var responseData = json.decode(response.data);

      if (response.statusCode == 200) {
        print(response.data);
        if(response.data.containsValue(true)) {
          log('true');
          emit(LoginSuccessState());
          emailController.clear();
          passwordController.clear();
        } else {
          log('false');
          emit(LoginErrorState('Wrong email or password'));
        }
      } else {
        // Login failed
      }
    } catch (error) {
      print('Error: $error');
      emit(LoginErrorState(error.toString()));
    }
  }
}
