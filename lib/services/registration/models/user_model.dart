import 'package:graduation_project/network/mapper.dart';

class UserModel extends SingleMapper {
  String? message;
  UserData? data;

  UserModel({this.message, this.data});

  UserModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new UserData.fromJson(json['data']) : null;
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
    return UserModel.fromJson(json);
  }
}

class UserData {
  User? user;
  String? token;

  UserData({this.user, this.token});

  UserData.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}

class User {
  String? name;
  String? email;
  String? updatedAt;
  String? createdAt;
  int? id;

  User({this.name, this.email, this.updatedAt, this.createdAt, this.id});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
