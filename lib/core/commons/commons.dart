import 'package:flutter/material.dart';

void navigate({required BuildContext context, required String route, dynamic arg}) {
  Navigator.pushNamed(context, route, arguments: arg);
}

void navigateAndFinish({required BuildContext context, required String route, dynamic arg}) {
  Navigator.pushNamedAndRemoveUntil(context, route, (route) => false, arguments: arg);
}