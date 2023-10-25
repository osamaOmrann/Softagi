import 'package:flutter/material.dart';
import 'package:softagi/core/commons/commons.dart';
import 'package:softagi/core/routes/routes.dart';

class LoginScreen extends StatelessWidget {
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height, width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text('Log in'),),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * .05),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: height * .1,),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Email'
                ),
                controller: emailController,
              ),
              SizedBox(height: height * .03,),
              TextField(
                decoration: InputDecoration(
                    labelText: 'Password'
                ),
                controller: passwordController,
              ),
              SizedBox(height: height * .03,),
              ElevatedButton(onPressed: () {
              }, child: Text(
                'Log in'
              )),
              TextButton(onPressed: () {
                navigateAndFinish(context: context, route: Routes.register);
              }, child: Text(
                'Don\'t have account? Sign up',
              ))
            ],
          ),
        ),
      ),
    );
  }
}
