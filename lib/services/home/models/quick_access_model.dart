import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/helpers/shared_helper.dart';
import 'package:graduation_project/router/navigator.dart';
import 'package:graduation_project/router/routes.dart';
import 'package:graduation_project/services/patients_folders/blocs/patients_bloc.dart';

class QuickAccessOptions {
  int length = 3;
  QuickAccessOptions(BuildContext context) {
    actions = [
      () {
        var bloc = context.read<PatientsCubit>();
        return CustomNavigator.push(Routes.diseaseDetection, arguments: bloc.model.data!.patients);
      },
      () {
        var bloc = context.read<PatientsCubit>();
        return CustomNavigator.push(Routes.gelecomaDetection, arguments: bloc.model.data!.patients);
      },
      () {},
    ];
  }
  List<String> names = [
    "Diseases Detection",
    "Gelecoma Detection",
    "Coming Soon",
  ];
  List<String> icons = [
    "eye_fundus",
    "eye_fundus",
    "soon",
  ];

  List<Function()> actions = [];
}
