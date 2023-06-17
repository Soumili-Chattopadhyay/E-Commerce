// ignore_for_file: no_leading_underscores_for_local_identifiers
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreference{
  Future<void> addUser(User user) async {
    final SharedPreferences _preferences = await SharedPreferences.getInstance();

    _preferences.setStringList('user', [user.uid, user.displayName??'no name', user.email??'no email',]);
  }

  Future<List<String>?> getUser() async {
    final SharedPreferences _preferences = await SharedPreferences.getInstance();

    final List<String>? currentUser =  _preferences.getStringList('user');

    return currentUser;
  }

  Future<void> removeUser() async {
    final SharedPreferences _preferences = await SharedPreferences.getInstance();

    _preferences.remove('user');
  }
}