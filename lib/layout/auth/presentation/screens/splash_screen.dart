import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:softagi/core/commons/commons.dart';
import 'package:softagi/core/routes/routes.dart';
import 'package:softagi/core/utils/colors.dart';

class SplashScreen extends StatefulWidget {

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateAfter3Seconds();
  }
  void navigateAfter3Seconds() {
    Future.delayed(Duration(seconds: 3)).then((value) async {
      final SharedPreferences s = await SharedPreferences.getInstance();
      String? token = await s.getString('token');
      navigateAndFinish(context: context, route: token == null || token == ''? Routes.login: Routes.products);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Text('SOFTAGI', style: Theme.of(context).textTheme.displayLarge,)
      ),
    );
  }
}
