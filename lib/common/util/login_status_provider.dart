import 'package:flutter/material.dart';
import 'package:gravitas_app/common/models/user_info_model.dart';

class LoginStatusProvider with ChangeNotifier {
  bool _isLogined = false;
  UserInfoModel userInfoModel = UserInfoModel();
  
  bool get isLogined => _isLogined;

  void setLogined() {
    _isLogined = true;
    notifyListeners();
  }

  void unsetLogined() {
    _isLogined = false;
    notifyListeners();
  }
}