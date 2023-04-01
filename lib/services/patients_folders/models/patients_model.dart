import 'package:graduation_project/network/mapper.dart';

class PatientsModel extends SingleMapper {
  String? message;
  Patients? data;

  PatientsModel({this.message, this.data});

  PatientsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? Patients.fromJson(json['data']) : null;
  }

  @override
  Mapper fromJson(Map<String, dynamic> json) {
    return PatientsModel.fromJson(json);
  }
}

class Patients {
  List<Patient> patients = [];

  Patients({this.patients = const []});

  Patients.fromJson(Map<String, dynamic> json) {
    if (json['patients'] != null) {
      patients = [];
      json['patients'].forEach((v) {
        patients.add(Patient.fromJson(v));
      });
    }
  }
}

class Patient {
  String? name;
  String? email;
  String? createdAt;
  String? history;

  Patient({this.name, this.email, this.createdAt, this.history});

  Patient.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    createdAt = json['created_at'];
    history = json['history'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['created_at'] = this.createdAt;
    data['history'] = this.history;
    return data;
  }
}
