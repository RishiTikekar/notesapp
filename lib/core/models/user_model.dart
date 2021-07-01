import 'dart:core';

class UserModel {
  String email;
  String photoUrl;
  String name;
  UserModel({required this.email, required this.name, required this.photoUrl});
  factory UserModel.fromJson(Map<dynamic, dynamic> jsonData) {
    assert(jsonData != null, 'user data can not be null');
    return UserModel(
        email: jsonData['email'],
        name: jsonData['name'],
        photoUrl: jsonData['photoUrl']);
  }

  static Map<String, dynamic> toJson(UserModel user) {
    assert(user != null, 'user data can not be null');
    return {'email': user.email, 'name': user.name, 'photoUrl': user.photoUrl};
  }
}
