// ignore_for_file: must_be_immutable

import 'package:e_commerce/src/core/preferences/user_preference.dart';
import 'package:e_commerce/src/views/auth/login.dart';
import 'package:e_commerce/src/views/dashboard/dashboard.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final UserPreference _userPreference = UserPreference();

  String? currentUser;

  Future<dynamic> fetchUserStatus() async {
    final dynamic temp = await _userPreference.getUser();
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: fetchUserStatus(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return const Dashboard();
            }
            return const Login();
          }
          return const Center(
            child: Image(
              image: AssetImage(
                'asset/image/splash.png',
              ),
            ),
          );
        }),
      ),
    );
  }
}
