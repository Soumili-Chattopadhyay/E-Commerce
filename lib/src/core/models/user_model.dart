import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String userId;
  String userEmail;

  UserModel({
    required this.userId,
    required this.userEmail,
  });

  factory UserModel.fromJson(Map json) {
    return UserModel(
      userId: json['uid'],
      userEmail: json['email'],
    );
  }

  Map<String, dynamic> data() {
    Map<String, dynamic> data = <String, dynamic>{};

    data['userId'] = userId;
    data['userEmail'] = userEmail;

    return data;
  }
}
