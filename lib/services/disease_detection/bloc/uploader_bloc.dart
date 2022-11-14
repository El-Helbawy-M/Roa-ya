import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/app_states.dart';

import '../../../core/app_events.dart';
import '../../../router/navigator.dart';

class UploaderBloc extends Bloc<AppEvent,AppState>{
  UploaderBloc():super(Start());
  static UploaderBloc get instance=>  BlocProvider.of(CustomNavigator.navigatorState.currentContext!);
  
}