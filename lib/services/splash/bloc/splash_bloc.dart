import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/services/registration/bloc/user_bloc.dart';

import '../../../core/app_events.dart';
import '../../../core/app_states.dart';
import '../../../helpers/shared_helper.dart';
import '../../../router/navigator.dart';
import '../../../router/routes.dart';

class SplashBloc extends Bloc<AppEvent, AppState> {
  SplashBloc() : super(Start());

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is Click) {
      SharedHelper helper = SharedHelper();
      bool? isLogin = await helper.readBoolean(CachingKey.IS_LOGIN);
      bool? skip = await helper.readBoolean(CachingKey.SKIP);
      if (isLogin) {
        UserBloc.instance.add(Click());
        CustomNavigator.push(Routes.main, clean: true);
      } else
        CustomNavigator.push(Routes.onboarding, clean: true);
    }
  }
}
