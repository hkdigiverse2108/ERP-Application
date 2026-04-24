import 'package:ai_setu/data/model/user_model.dart';

class LoginResponseModel {
  final UserModel user;

  LoginResponseModel({required this.user});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(user: UserModel.fromMap(json));
  }
}
