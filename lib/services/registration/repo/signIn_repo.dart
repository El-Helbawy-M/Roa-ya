import 'package:dio/dio.dart';
import 'package:graduation_project/services/registration/models/user_model.dart';
import 'package:graduation_project/config/api_names.dart';
import 'package:graduation_project/network/network_helper.dart';

abstract class RegistrationRepo {
  static Future<UserModel> signIn({required FormData data}) async {
    return await NetworkHelper().post(url: ApiNames.login, body: data, model: UserModel(), headers: {'accept': "application/json"}, withToken: false);
  }

  static Future<UserModel> register({required FormData data}) async {
    return await NetworkHelper().post(url: ApiNames.register, body: data, model: UserModel(), withToken: false);
  }
}
