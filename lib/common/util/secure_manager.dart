import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:gravitas_app/common/models/request_login_model.dart';
import 'package:gravitas_app/common/models/read_login_model.dart';

class SecureManager {
  static const storage = FlutterSecureStorage();
  
  Future<bool> setLoginInfo(RequestLoginModel res) async {
    if (res.token == null) return false;
    String token = res.token!;
    Map<String, dynamic> payload = JWT.decode(token).payload;
    var test = jsonEncode({
      'token': token,
      'handle': payload['handle'],
      'nickname': payload['nickname']
    });
    await storage.write(key: 'login_info', value: test);
    return true;
  }

  Future<ReadLoginModel> readLoginInfo() async {
    ReadLoginModel readLoginModel = ReadLoginModel(isLogined: false);
    final test = await storage.read(key: 'login_info');
    if (test != null) {
      try {
        final mTest = jsonDecode(test);
        readLoginModel.token = mTest['token'];
        readLoginModel.handle = mTest['handle'];
        readLoginModel.nickname = mTest['nickname'];
        return readLoginModel;
      } catch(e) {
        readLoginModel.isLogined = false;
      }
    }
    return readLoginModel;
  }

  Future<String?> readUserToken() async {
    final secureUserInfo = await storage.read(key: 'login_info');
    if (secureUserInfo != null) {
      try {
        final jsonData = jsonDecode(secureUserInfo);
        return jsonData['token'];
      } catch(e) {
        return null;
      }
    }
    return null;
  }

  Future<bool> deleteLoginInfo() async {
    try {
      await storage.delete(key: 'login_info');
      return true;
    } catch(e) {
      return false;
    }
  }
}