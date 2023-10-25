import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:softagi/core/commons/commons.dart';
import 'package:softagi/core/routes/routes.dart';
import 'package:softagi/core/utils/colors.dart';
import 'package:softagi/core/utils/validation_utils.dart';
import 'package:softagi/layout/auth/presentation/cubit/login_cubit.dart';
import 'package:softagi/layout/auth/presentation/cubit/login_state.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height,
        width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Log in'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * .05),
        child: SingleChildScrollView(
          child: BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              if(state is LoginSuccessState) {
                Fluttertoast.showToast(msg: 'Successful login ✔');
              }
              if(state is LoginErrorState ) {
                Fluttertoast.showToast(msg: state.message);
              }
            },
            builder: (context, state) {
              return Form(
                key: BlocProvider.of<LoginCubit>(context).loginKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: height * .1,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Email address is required';
                        }
                        if (!ValidationUtils.isValidEmail(text)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: 'Email'),
                      controller: BlocProvider.of<LoginCubit>(context).emailController,
                    ),
                    SizedBox(
                      height: height * .03,
                    ),
                    TextFormField(
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Password is required';
                        }
                        return null;
                      },
                      obscureText: BlocProvider.of<LoginCubit>(context).isLoginPasswordShown,
                      decoration: InputDecoration(
                          labelText: 'Password',
                          suffixIcon: InkWell(
                              onTap: () => BlocProvider.of<LoginCubit>(context).changeLoginPasswordSuffixIcon(),
                              child: Icon(BlocProvider.of<LoginCubit>(context).suffixIocn))),
                      controller: BlocProvider.of<LoginCubit>(context).passwordController,
                    ),
                    SizedBox(
                      height: height * .03,
                    ),
                    state is LoginLoadingState? SpinKitSpinningLines(color: AppColors.primary, size: height * .0525,):ElevatedButton(onPressed: () {
                      if(BlocProvider.of<LoginCubit>(context).loginKey.currentState!.validate()) {
                        BlocProvider.of<LoginCubit>(context).login();
                      }
                    }, child: Text('Log in')),
                    TextButton(
                        onPressed: () {
                          navigateAndFinish(
                              context: context, route: Routes.register);
                        },
                        child: Text(
                          'Don\'t have account? Sign up',
                        ))
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
