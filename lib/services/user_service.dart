import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_eaters/config/constanst.dart';
import 'package:social_eaters/models/place_model.dart';
import 'package:social_eaters/models/user_model.dart';

class UserService {
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
      Response response = await Dio()
          .get(AppConstants.apiUrl + "/getUserInfoById", queryParameters: data);
      //TODO ["Users"][0] ?? needs solution
      user = UserModel.fromMap(response.data["Users"][0]);
    } catch (e) {
      print("something went wrong");
    } finally {
      return user;
    }
  }

  Future<bool> recordPlace(Place place) async {
    bool hasRecorded = false;
    Map map = place.toMap();
    map["userId"] = FirebaseAuth.instance.currentUser!.uid;
    try {
      Response response =
          await Dio().post(AppConstants.apiUrl + "/recordPlace", data: map);
      if (response.data != null) {
        hasRecorded = true;
      }
    } catch (e) {
      hasRecorded = false;
      print("something went wrong");
    } finally {
      return hasRecorded;
    }
  }

  recordUser(String? name, String? surname, String? mail, String id) {
    Map<String, dynamic> data = {
      "name": name,
      "surname": surname,
      "mail": mail,
      "id": id,
    };
    try {
      Dio().post(AppConstants.apiUrl + "/createUser", data: data);
    } catch (e) {
      print(e);
    }
  }
}
