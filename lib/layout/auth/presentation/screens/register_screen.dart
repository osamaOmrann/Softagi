import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:softagi/core/commons/commons.dart';
import 'package:softagi/core/database/api/end_points.dart';
import 'package:softagi/core/routes/routes.dart';
import 'package:softagi/core/utils/validation_utils.dart';
import 'package:softagi/layout/products/reset_product_data_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
TextEditingController nameController = TextEditingController();

TextEditingController emailController = TextEditingController();

TextEditingController passwordController = TextEditingController();

TextEditingController passwordIIController = TextEditingController();

bool securePassword = true;

bool securePasswordConfirm = true;

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
                    if (text.trim().length < 6) {
                      return 'Weak password';
                    }
                    return null;
                  },
                  obscureText: securePassword,
                  decoration: InputDecoration(
                      labelText: 'Password',
                    suffixIcon: GestureDetector(
                      onTap: () => setState((){securePassword = !securePassword;}),
                      child: Icon(securePassword? Icons.visibility_off: Icons.visibility),
                    )
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
                  obscureText: securePasswordConfirm,
                  decoration: InputDecoration(
                      labelText: 'Confirm password',
                      suffixIcon: GestureDetector(
                        onTap: () => setState((){securePasswordConfirm = !securePasswordConfirm;}),
                        child: Icon(securePasswordConfirm? Icons.visibility_off: Icons.visibility),
                      )
                  ),
                  controller: passwordIIController,
                ),
                SizedBox(height: height * .03,),
                ElevatedButton(onPressed: () {
                  if (formKey.currentState?.validate() == false) {
                    return;
                  }
                  register();
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

void register() async {
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
      if(response.data.containsValue(true)) {
        ResetProductDataScreen.name= nameController.text;
        navigateAndFinish(context: context, route: Routes.resetProductData);
        emailController.clear();
        nameController.clear();
        passwordController.clear();
        passwordIIController.clear();
      }
      else Fluttertoast.showToast(msg: 'Entered email is already used for an account');
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
