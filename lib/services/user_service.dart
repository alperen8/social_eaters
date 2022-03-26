import 'package:dio/dio.dart';
import 'package:social_eaters/config/constanst.dart';
import 'package:social_eaters/models/place_model.dart';
import 'package:social_eaters/models/user_model.dart';
import 'package:social_eaters/services/auth_service.dart';

//TODO error and success handling

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
    map["userId"] = AuthenticationService.instance.getUserId();
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

  Future<List<Place>> getfollowingUsersMenus(String id) async {
    Map<String, dynamic> data = {"followerId": id};
    List<Place> places = [];

    Response response = await Dio().get(
        AppConstants.apiUrl + "/followingUsersMenus",
        queryParameters: data);
    List dataList = response.data["Followers"];
    for (Map<String, dynamic> map in dataList) {
      List list = map["followingUsersMenus"];
      for (Map<String, dynamic> innerMap in list) {
        places.add(Place.fromMap(innerMap));
      }
    }

    print(places);
    return places;
  }

  Future<int> getFollowerUserCount(String id) async {
    Map<String, dynamic> data = {"id": id};
    Response response = await Dio().get(
        AppConstants.apiUrl + "/getFollowersIdList",
        queryParameters: data);
    return response.data["Followers"].length;
  }

  Future<int> getFollowingUserCount(String id) async {
    Map<String, dynamic> data = {"id": id};
    Response response = await Dio().get(
        AppConstants.apiUrl + "/getFollowingUsersIdList",
        queryParameters: data);
    return response.data["Followers"].length;
  }

//TODO async
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

  followUser(String followingId) async {
    String currentUserId = AuthenticationService.instance.getUserId();
    Map<String, dynamic> data = {
      "followerId": currentUserId,
      "followingId": followingId
    };

    Response response = await Dio().post(
      AppConstants.apiUrl + "/FollowUser",
      data: data,
    );

    if (response.statusCode == null) {
      throw Exception(response.statusMessage);
    }
  }

  getFollowingList(String id) async {
    Map<String, dynamic> data = {
      "id": id,
    };
    Response response = await Dio().get(
        AppConstants.apiUrl + "/getFollowingUsersByFollowerId",
        queryParameters: data);

    //conversion of response to list of users
    List responseAsList = response.data["Followers"];
    List<UserModel> followingUsers = [];
    responseAsList.every((element) {
      followingUsers.add(UserModel.fromMap(element["followingUsersInfo"][0]));
      return true;
    });

    if (response.statusCode == null) {
      throw Exception(response.statusMessage);
    }
  }
}
