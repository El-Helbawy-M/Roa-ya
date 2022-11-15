import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/app_events.dart';
import 'package:graduation_project/core/app_states.dart';
import 'package:graduation_project/helpers/app_colors.dart';
import 'package:graduation_project/services/registration/bloc/user_bloc.dart';
import 'package:graduation_project/services/registration/repo/signIn_repo.dart';
import 'package:rxdart/rxdart.dart';

import '../../../core/app_core.dart';
import '../../../core/app_notification.dart';
import '../../../core/validator.dart';
import '../../../network/shared_helper.dart';
import '../../../router/navigator.dart';
import '../../../router/routes.dart';
import '../models/user_model.dart';

class SignInBloc extends Bloc<AppEvent, AppState> {
  static SignInBloc get instance =>
      BlocProvider.of(CustomNavigator.navigatorState.currentContext!);

  SignInBloc() : super(Start());
  final email = BehaviorSubject<String?>();
  final password = BehaviorSubject<String?>();
  final rememberMe = BehaviorSubject<bool?>();
  bool remebered = false;
  Function(String?) get updateEmail => email.sink.add;

  Function(String?) get updatePassword => password.sink.add;
  Function(bool?) get updateRememberMe => rememberMe.sink.add;

  Stream<String?> get emailStream => email.stream.asBroadcastStream();

  Stream<String?> get passwordStream => password.stream.asBroadcastStream();
  Stream<bool?> get rememberMeStream => rememberMe.stream.asBroadcastStream();
  Stream<bool> get submitStream =>
      Rx.combineLatest2(emailStream, passwordStream, (n, p) {
        if (NameValidator.nameValidator(n as String?) == null &&
            PasswordValidator.passwordValidator(p as String?) == null) {
          return true;
        }
        return false;
      });

  clear() {
    updateEmail(null);
    updatePassword(null);
    updateRememberMe(null);
  }

  @override
  Future<void> close() {
    email.close();
    password.close();
    updateRememberMe(false);
    return super.close();
  }

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    yield Loading();
    try {
      if (event is Post) {
        UserModel model = await RegistrationRepo.signIn(
          data: FormData.fromMap(
            {"email": email.valueOrNull, "password": password.valueOrNull},
          ),
        );
        if (model.errors == null && model.message == null) {
          SharedHelper.sharedHelper!
              .saveUser(model, remember: false, password: password.valueOrNull);
              UserBloc.instance.add(Click());
          CustomNavigator.push(Routes.main, clean: true);
          clear();
          AppCore.showSnackBar(
            notification: AppNotification(
              message: "You logged in successfully",
              backgroundColor: AppColors.active,
              iconName: "check-circle",
            ),
          );
          
        yield Done();
        }
        else {
            AppCore.showSnackBar(
                notification: AppNotification(
                    message: model.message??(model.errors!.email ?? (model.errors!.password ?? "")),
                    backgroundColor: AppColors.inActive,
                    iconName: "fill-close-circle"));

            yield Error();
          }
      }
    } catch (e) {
      AppCore.showSnackBar(
          notification: AppNotification(
              message: e.toString(),
              backgroundColor: AppColors.inActive,
              iconName: "fill-close-circle"));
      yield Error();
    }
  }
}
