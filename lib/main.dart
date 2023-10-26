import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softagi/core/bloc/cubit/global_cubit.dart';
import 'package:softagi/core/bloc/cubit/global_state.dart';
import 'package:softagi/core/routes/routes.dart';
import 'package:softagi/core/services/service_locator.dart';
import 'package:softagi/core/theme/app_theme.dart';
import 'package:softagi/layout/auth/presentation/cubit/login_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServiceLocator();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => sl<GlobalCubit>(),
      ),
      BlocProvider(
        create: (context) => sl<LoginCubit>(),
      ),
    ],
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
