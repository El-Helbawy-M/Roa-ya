import 'package:graduation_project/network/mapper.dart';

class LatestAppoimentsModel extends SingleMapper {
  String? message;
  CommingAppoimentsData? data;

  LatestAppoimentsModel({this.message, this.data});

  LatestAppoimentsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? CommingAppoimentsData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }

  @override
  Mapper fromJson(Map<String, dynamic> json) {
    return LatestAppoimentsModel.fromJson(json);
  }
}

class CommingAppoimentsData {
  List<Appoiment> comingAppointments = [];

  CommingAppoimentsData({this.comingAppointments = const []});

  CommingAppoimentsData.fromJson(Map<String, dynamic> json) {
    if (json['appointments'] != null) {
      comingAppointments = <Appoiment>[];
      json['appointments'].forEach((v) {
        comingAppointments.add(new Appoiment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.comingAppointments != null) {
      data['coming_appointments'] = this.comingAppointments.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Appoiment {
  int? id;
  String? patient;
  String? date;
  String? time;

  Appoiment({this.id, this.patient, this.date, this.time});

  Appoiment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    patient = json['patient'];
    date = json['date'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['patient'] = this.patient;
    data['date'] = this.date;
    data['time'] = this.time;
    return data;
  }
}
