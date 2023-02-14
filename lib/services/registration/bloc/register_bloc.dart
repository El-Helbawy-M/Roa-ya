import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/helpers/app_colors.dart';
import 'package:graduation_project/helpers/app_error_handeler.dart';
import 'package:graduation_project/services/registration/bloc/user_bloc.dart';
import 'package:graduation_project/services/registration/repo/signIn_repo.dart';
import 'package:rxdart/rxdart.dart';
import '../../../core/app_core.dart';
import '../../../core/app_events.dart';
import '../../../core/app_notification.dart';
import '../../../core/app_states.dart';
import '../../../core/validator.dart';
import '../../../helpers/shared_helper.dart';
import '../../../router/navigator.dart';
import '../../../router/routes.dart';
import '../models/user_model.dart';

class RegisterBloc extends Bloc<AppEvent, AppState> {
  final email = BehaviorSubject<String?>();
  final password = BehaviorSubject<String?>();
  final name = BehaviorSubject<String?>();
  final confirmPassword = BehaviorSubject<String?>();
  String generatedPassword = '';
  final condations = BehaviorSubject<bool?>();
  static RegisterBloc get instance => BlocProvider.of(CustomNavigator.navigatorState.currentContext!);

  RegisterBloc() : super(Start()) {
    updateCondations(false);
  }

  Function(String?) get updateName => name.sink.add;
  Function(bool?) get updateCondations => condations.sink.add;
  Function(String?) get updatePassword => password.sink.add;

  Function(String?) get updateConfirmPassword => confirmPassword.sink.add;
  Function(String?) get updateEmail => email.sink.add;

  Stream<String?> get nameStream => name.stream.asBroadcastStream();
  Stream<bool?> get condationsStream => condations.stream.asBroadcastStream();
  Stream<String?> get passwordStream => password.stream.asBroadcastStream();
  Stream<String?> get emailStream => email.stream.asBroadcastStream();

  Stream<String?> get confirmPasswordStream => confirmPassword.stream.asBroadcastStream();

  Stream<bool> get submitStream => Rx.combineLatest4(nameStream, emailStream, confirmPasswordStream, passwordStream, (a, b, c, d) {
        if (NameValidator.nameValidator(a as String) == null && EmailValidator.emailValidator(b as String) == null && PasswordValidator.passwordValidator(c as String?) == null && PasswordConfirmationValidator.passwordValidator(d as String, c as String) == null) {
          return true;
        }
        return false;
      });

  clear() {
    updateEmail(null);
    updatePassword(null);
    updateConfirmPassword(null);
    updateName(null);
  }

  @override
  Future<void> close() {
    email.close();
    password.close();
    confirmPassword.close();
    name.close();
    return super.close();
  }

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    yield Loading();
    try {
      if (event is Post) {
        //condations.valueOrNull!
        if (true) {
          FormData data = FormData.fromMap({
            "name": name.valueOrNull!,
            "email": email.valueOrNull!,
            "password": password.valueOrNull!,
          });
          UserModel model = await RegistrationRepo.register(data: data);
          if (model.errors == null && model.message == null) {
            SharedHelper.sharedHelper!.saveUser(model, remember: false, password: password.valueOrNull);
            UserBloc.instance.add(Click());
            CustomNavigator.push(Routes.main, clean: true);
            //arguments: VerificationModel(model.user!.email!, model.user!.verificationCode!));
            AppCore.showSnackBar(notification: AppNotification(message: "You logged in successfully", backgroundColor: AppColors.active, iconName: "check-circle"));
            yield Done();
          } else {
            ErrorHandler(title: "Authentaction Error", message: model.message ?? "").showDefaultErrorMessage();
            yield Error();
          }
        } else {
          AppCore.showSnackBar(notification: AppNotification(message: "Please agree to the terms", backgroundColor: AppColors.inActive, iconName: "fill-close-circle"));
          yield Error();
        }
      }
    } catch (e) {
      ErrorHandler(title: "Authentaction Error", message: e.toString()).showDefaultErrorMessage();
      yield Error();
    }
  }
}
