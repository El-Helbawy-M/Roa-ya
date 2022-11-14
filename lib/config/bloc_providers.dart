

import 'package:flutter_bloc/src/bloc_provider.dart'
    show BlocProvider, BlocProviderSingleChildWidget;
import 'package:graduation_project/services/registration/bloc/register_bloc.dart';
import 'package:graduation_project/services/registration/bloc/signIn_bloc.dart';

abstract class ProviderList {
  static List<BlocProviderSingleChildWidget> providers = [
    BlocProvider<SignInBloc>(create: (_) => SignInBloc()),
    BlocProvider<RegisterBloc>(create: (_) => RegisterBloc()),
  ];
}
