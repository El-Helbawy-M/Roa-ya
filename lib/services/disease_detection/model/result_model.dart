import 'package:graduation_project/network/mapper.dart';

class ResultModel extends ListMapper{
  List<Result>? results;
  ResultModel();
  ResultModel.fromJsonList(List<Map<String, dynamic>> data) {
    
    results = <Result>[];
    if (data != null) {
      data.forEach((v) {
        results!.add(new Result.fromJson(v));
      });
    }
  }
  
  @override
  Mapper fromJsonList(List json) {
    return ResultModel.fromJsonList(json as List<Map<String,dynamic>>);  
  }

  
}

class Result {
  String? value;
  Result({this.value});

  Result.fromJson(Map<String, dynamic> json) {
    value = json['attachment']!=null?json['attachment'].cast<String>().first:null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['attachment'] = this.value;
    return data;
  }
}