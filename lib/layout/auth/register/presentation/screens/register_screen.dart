import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:softagi/core/commons/commons.dart';
import 'package:softagi/core/database/api/end_points.dart';
import 'package:softagi/core/routes/routes.dart';
import 'package:softagi/core/utils/validation_utils.dart';
import 'package:softagi/layout/products/reset_product_data_screen.dart';

class RegisterScreen extends StatelessWidget {
TextEditingController nameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController passwordIIController = TextEditingController();
var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height, width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text('Create account'),),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * .05),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(height: height * .1,),
                TextFormField(
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return 'Name is required';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: 'Name'
                  ),
                  controller: nameController,
                ),
                SizedBox(height: height * .03,),
                TextFormField(
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return 'Email address is required';
                    }
                    if (!ValidationUtils.isValidEmail(text)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: 'Email'
                  ),
                  controller: emailController,
                ),
                SizedBox(height: height * .03,),
                TextFormField(
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return 'Password is required';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: 'Password'
                  ),
                  controller: passwordController,
                ),
                SizedBox(height: height * .03,),
                TextFormField(
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return 'Password confirmation is required';
                    }
                    if(text != passwordController.text) {
                      return 'Two passwords are not identical';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: 'Confirm password'
                  ),
                  controller: passwordIIController,
                ),
                SizedBox(height: height * .03,),
                ElevatedButton(onPressed: () {
                  if (formKey.currentState?.validate() == false) {
                    return;
                  }
                  register(context);
                }, child: Text(
                  'Sign Up'
                )),
                TextButton(onPressed: () {
                  navigateAndFinish(context: context, route: Routes.login);
                }, child: Text(
                  'Already have an account? Sign in'
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }

void register(BuildContext context) async {
  var url = '${EndPoint.baseURL}${EndPoint.register}';

  var dio = Dio();

  try {
    var response = await dio.post(
      url,
      data: {
        'name': nameController.text,
        'email': emailController.text,
        'password': passwordController.text,
      },
    );

    if (response.statusCode == 200) {
      // Request successful
      print('Data posted successfully');
      ResetProductDataScreen.name= nameController.text;
      navigateAndFinish(context: context, route: Routes.resetProductData);
    } else {
      // Request failed
      print('Failed to post data. Error: ${response.statusCode}');
      Fluttertoast.showToast(msg: response.statusCode.toString());
    }
  } catch (error) {
    // Exception occurred during request
    print('Error while making the request: $error');
    Fluttertoast.showToast(msg: error.toString());
  }
}
}
