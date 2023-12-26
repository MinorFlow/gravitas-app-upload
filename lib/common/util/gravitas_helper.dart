import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import 'package:gravitas_app/common/util/login_status_provider.dart';
import 'package:gravitas_app/common/api/api_helper.dart';
import 'package:gravitas_app/common/util/secure_manager.dart';


class GravitasHelper {
  final secureManager = SecureManager();
  final apiHelper = APIHelper();

  void detectLogin(BuildContext context) async {
    final token = await secureManager.readUserToken();
    if (token != null) {
      var result = await apiHelper.getUserInfo(token);
      if (!context.mounted) return;
      context.read<LoginStatusProvider>().userInfoModel = result;
      context.read<LoginStatusProvider>().setLogined();
    }
  }

  String convertDate(String str, String template) {
    return Jiffy.parseFromMillisecondsSinceEpoch(int.parse(str)).format(pattern: template);
  }
}