import 'package:graduation_project/config/api_names.dart';
import 'package:graduation_project/network/network_helper.dart';
import 'package:graduation_project/services/patients_folders/models/patients_model.dart';

class PatientsRepo {
  Future<PatientsModel> getAllPatients() async {
    return await NetworkHelper().get(url: ApiNames.patients, model: PatientsModel());
  }
}
