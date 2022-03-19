import 'package:dio/dio.dart';
import 'package:social_eaters/models/user_model.dart';

class UserService {
  static const apiURL =
      "http://ec2-3-72-104-77.eu-central-1.compute.amazonaws.com:8080/api/rest/";
  static final UserService _instance = UserService._init();
  UserService._init();

  static UserService get instance {
    return _instance;
  }

  factory UserService() {
    return _instance;
  }
  Future<UserModel?> getUserInfoById(String id) async {
    Map<String, dynamic> data = {"id": id};
    UserModel? user;
    try {
      Response response =
          await Dio().post(apiURL + "getUserInfoById", data: data);
      //TODO ["Users"][0] ?? needs solution
      user = UserModel.fromMap(response.data["Users"][0]);
    } catch (e) {
      print("something went wrong");
    } finally {
      return user;
    }
  }
}
