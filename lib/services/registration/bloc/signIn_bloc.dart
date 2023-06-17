import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/app_events.dart';
import 'package:graduation_project/core/app_states.dart';
import 'package:graduation_project/services/registration/bloc/user_bloc.dart';
import 'package:graduation_project/services/registration/repo/signIn_repo.dart';
import 'package:rxdart/rxdart.dart';
import '../../../core/validator.dart';
import '../../../helpers/app_error_handeler.dart';
import '../../../helpers/shared_helper.dart';
import '../../../router/navigator.dart';
import '../../../router/routes.dart';
import '../models/user_model.dart';

class SignInBloc extends Bloc<AppEvent, AppState> {
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
  Stream<bool> get submitStream => Rx.combineLatest2(emailStream, passwordStream, (n, p) {
        if (EmailValidator.emailValidator(n as String?) == null && PasswordValidator.passwordValidator(p as String?) == null) {
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
        if (model.message != "invalid credentials.") {
          SharedHelper.sharedHelper!.saveUser(model, remember: false, password: password.valueOrNull);
          UserBloc.instance.add(Click());
          CustomNavigator.push(Routes.main, clean: true);
          clear();
          yield Done();
        } else {
          ErrorHandler(title: "Authentaction Error", message: "Invalid Credentials").showDefaultErrorMessage();
          yield Error();
        }
      }
    } catch (e) {
      ErrorHandler(title: "Authentaction Error", message: "Something is wrong, please try again later").showDefaultErrorMessage();
      yield Error();
    }
  }
}
