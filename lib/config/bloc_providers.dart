import 'package:flutter_bloc/src/bloc_provider.dart' show BlocProvider, BlocProviderSingleChildWidget;
import 'package:graduation_project/services/disease_detection/bloc/uploader_bloc.dart';
import 'package:graduation_project/services/patients_folders/blocs/patients_bloc.dart';

import '../services/home/blocs/latest_appoinments_bloc.dart';

abstract class ProviderList {
  static List<BlocProviderSingleChildWidget> providers = [
    BlocProvider<PatientsCubit>(create: (_) => PatientsCubit()..getPatients()),
    BlocProvider<LatestAppoinmentsCubit>(create: (_) => LatestAppoinmentsCubit()..getAppoinments()),
  ];
}
