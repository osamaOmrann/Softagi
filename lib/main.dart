import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softagi/core/bloc/cubit/global_cubit.dart';
import 'package:softagi/core/bloc/cubit/global_cubit.dart';
import 'package:softagi/core/bloc/cubit/global_state.dart';
import 'package:softagi/core/routes/routes.dart';
import 'package:softagi/core/theme/app_theme.dart';

void main() {
  runApp(BlocProvider(
    create: (context) => GlobalCubit(),
    child: Softagi(),
  ));
}

class Softagi extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalCubit, GlobalState>(
      builder: (context, state) {
        return MaterialApp(
          initialRoute: Routes.initialRoute,
          onGenerateRoute: AppRoutes.generateRoute,
          theme: getAppTheme(),
        );
      },
    );
  }
}
