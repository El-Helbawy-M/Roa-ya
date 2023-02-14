import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/app_events.dart';
import '../../../core/app_states.dart';
import '../../../helpers/shared_helper.dart';
import '../../../router/navigator.dart';
import '../models/user_model.dart';

class UserBloc extends Bloc<AppEvent, AppState> {
  UserModel? _model;

  UserModel? get user => _model;

  UserBloc() : super(Start());

  static UserBloc get instance => BlocProvider.of(CustomNavigator.navigatorState.currentContext!);

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    yield Loading();
    if (event is Click) {
      UserModel _sharedModel = await SharedHelper.sharedHelper!.getUser();
      _model = _sharedModel;
      yield Done(model: _sharedModel);
    } else if (event is Update) {
      UserModel _sharedModel = await SharedHelper.sharedHelper!.getUser();
      _model = _sharedModel;
      yield Done(model: _sharedModel, reload: false);
    }
  }
}
