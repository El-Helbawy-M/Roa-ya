

import 'package:flutter_bloc/src/bloc_provider.dart'
    show BlocProvider, BlocProviderSingleChildWidget;
import 'package:graduation_project/services/registration/bloc/register_bloc.dart';
import 'package:graduation_project/services/registration/bloc/signIn_bloc.dart';
import 'package:graduation_project/services/registration/bloc/user_bloc.dart';
import 'package:graduation_project/services/splash/bloc/splash_bloc.dart';

abstract class ProviderList {
  static List<BlocProviderSingleChildWidget> providers = [
    BlocProvider<SignInBloc>(create: (_) => SignInBloc()),
    BlocProvider<RegisterBloc>(create: (_) => RegisterBloc()),
    BlocProvider<SplashBloc>(create: (_) => SplashBloc()),
    BlocProvider<UserBloc>(create: (_) => UserBloc()),
  ];
}
