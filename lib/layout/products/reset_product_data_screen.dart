import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:softagi/core/commons/commons.dart';
import 'package:softagi/core/routes/routes.dart';

class ResetProductDataScreen extends StatelessWidget {
  static String? name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name!),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateAndFinish(context: context, route: Routes.login);
        },
        child: Icon(
          Icons.logout
        ),
      ),
    );
  }
}
