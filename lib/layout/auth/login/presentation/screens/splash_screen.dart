import 'package:flutter/material.dart';
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
    Future.delayed(Duration(seconds: 3)).then((value) => navigateAndFinish(context: context, route: Routes.login));
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
