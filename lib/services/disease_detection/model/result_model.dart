import 'package:graduation_project/network/mapper.dart';

class ResultModel extends SingleMapper {
  String? results;
  ResultModel();
  ResultModel.fromJson(Map<String, dynamic> data) {
    results = data["prediction"];
  }

  @override
  Mapper fromJson(Map<String, dynamic> json) {
    return ResultModel.fromJson(json);
  }
}
