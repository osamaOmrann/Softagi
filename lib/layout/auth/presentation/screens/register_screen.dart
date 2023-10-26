import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:softagi/core/commons/commons.dart';
import 'package:softagi/core/database/api/end_points.dart';
import 'package:softagi/core/routes/routes.dart';
import 'package:softagi/core/utils/colors.dart';
import 'package:softagi/core/utils/validation_utils.dart';
import 'package:softagi/layout/products/presentation/screens/products_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController passwordIIController = TextEditingController();

  bool isLoading = false;

  String phoneNumber = '';

  bool securePassword = true;

  bool securePasswordConfirm = true;

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height,
        width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Create account'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * .05),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(
                  height: height * .1,
                ),
                TextFormField(
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return 'Name is required';
                    }
                    return null;
                  },
                  decoration: InputDecoration(labelText: 'Name'),
                  controller: nameController,
                ),
                SizedBox(
                  height: height * .03,
                ),
                IntlPhoneField(
                  validator: (number) {
                    if(number!.completeNumber.length < 5) {
                      return 'Please enter valid phone number';
                    }
                    return null;
                  },
                  initialCountryCode: 'EG',
                  decoration: InputDecoration(labelText: 'Phone Number'),
                  onChanged: (phone) {
                    phoneNumber = phone.completeNumber;
                  },
                ),
                SizedBox(
                  height: height * .03,
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
                  controller: emailController,
                ),
                SizedBox(
                  height: height * .03,
                ),
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
                        onTap: () => setState(() {
                          securePassword = !securePassword;
                        }),
                        child: Icon(securePassword
                            ? Icons.visibility_off
                            : Icons.visibility),
                      )),
                  controller: passwordController,
                ),
                SizedBox(
                  height: height * .03,
                ),
                TextFormField(
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return 'Password confirmation is required';
                    }
                    if (text != passwordController.text) {
                      return 'Two passwords are not identical';
                    }
                    return null;
                  },
                  obscureText: securePasswordConfirm,
                  decoration: InputDecoration(
                      labelText: 'Confirm password',
                      suffixIcon: GestureDetector(
                        onTap: () => setState(() {
                          securePasswordConfirm = !securePasswordConfirm;
                        }),
                        child: Icon(securePasswordConfirm
                            ? Icons.visibility_off
                            : Icons.visibility),
                      )),
                  controller: passwordIIController,
                ),
                SizedBox(
                  height: height * .03,
                ),
                isLoading? SpinKitSpinningLines(color: AppColors.primary, size: height * .0525,):ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState?.validate() == false) {
                        return;
                      }
                      register();
                    },
                    child: Text('Sign Up')),
                TextButton(
                    onPressed: () {
                      navigateAndFinish(context: context, route: Routes.login);
                    },
                    child: Text('Already have an account? Sign in'))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void register() async {
    if(phoneNumber.length < 5) {
      Fluttertoast.showToast(msg: 'Enter a valid phone number');
      return;
    }
    setState(() {
      isLoading = true;
    });
    var url = '${EndPoint.baseURL}${EndPoint.register}';

    var dio = Dio();

    try {
      var response = await dio.post(
        url,
        data: {
          'name': nameController.text,
          'phone': phoneNumber,
          'email': emailController.text,
          'password': passwordController.text,
        },
      );

      if (response.statusCode == 200) {
        // Request successful
        print('Data posted successfully');
        if (response.data.containsValue(true)) {
          final SharedPreferences s = await SharedPreferences.getInstance();
          await s.setString('token', response.data["data"]["token"] ?? '');
          await s.setString('name', response.data["data"]["name"] ?? '');
          log(response.data["data"]["token"]);
          ProductsScreen.name = response.data["data"]["name"];
          navigateAndFinish(context: context, route: Routes.products);
          emailController.clear();
          nameController.clear();
          passwordController.clear();
          passwordIIController.clear();
        } else {
          Fluttertoast.showToast(
              msg: 'Entered email or phone number is already used for an account');
          setState(() {
            isLoading = false;
          });
        }
      } else {
        // Request failed
        print('Failed to post data. Error: ${response.statusCode}');
        Fluttertoast.showToast(msg: response.statusCode.toString());
        setState(() {
          isLoading = false;
        });
      }
    } catch (error) {
      // Exception occurred during request
      print('Error while making the request: $error');
      Fluttertoast.showToast(msg: error.toString());
      setState(() {
        isLoading = false;
      });
    }
    setState(() {
      isLoading = false;
    });
  }
}
