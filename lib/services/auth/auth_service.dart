import 'dart:convert';

import '/models/user.dart';
import 'package:frontend/services/config/database_connection.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  static const storage = FlutterSecureStorage();
  static Future<bool> login(User user) async {
    Database db = await Mydatabase.getDatabase();
    List<Map> _user = await db.query("USERS",
        where: "email = ? and password = ?",
        whereArgs: [user.email, user.password]);
    if (_user.isEmpty) {
      return false;
    }
    await storage.write(
        key: 'token',
        value: json.encode(_user.first),
        aOptions: AuthService._getAndroidOptions());
    return true;
  }

  static Future<bool> register(User user) async {
    Database db = await Mydatabase.getDatabase();
    List<Map> _user =
        await db.query("USERS", where: "email = ?", whereArgs: [user.email]);
    if (_user.isEmpty) {
      await db.insert("USERS", user.toMap());
      return true;
    }
    return false;
  }

  static Future<bool> isLogged() async {
    return storage.containsKey(
        key: 'token', aOptions: AuthService._getAndroidOptions());
  }

  static AndroidOptions _getAndroidOptions() {
    return const AndroidOptions(
      encryptedSharedPreferences: true,
    );
  }

  static Future<void> logOut() async {
    await storage.delete(
        key: 'token', aOptions: AuthService._getAndroidOptions());
  }
}
