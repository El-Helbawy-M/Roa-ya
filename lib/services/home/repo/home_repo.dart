import 'package:graduation_project/config/api_names.dart';
import 'package:graduation_project/network/network_helper.dart';
import 'package:graduation_project/services/home/models/latest_appoinemts_mode.dart';

class HomeRepo {
  Future<LatestAppoimentsModel> getAppoinments() async {
    return await NetworkHelper().get(url: ApiNames.latestAppoinments, model: LatestAppoimentsModel());
  }
}
