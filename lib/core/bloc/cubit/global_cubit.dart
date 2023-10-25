import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softagi/core/bloc/cubit/global_state.dart';

class GlobalCubit extends Cubit<GlobalState> {
  GlobalCubit() : super(GlobalInitial());
}
