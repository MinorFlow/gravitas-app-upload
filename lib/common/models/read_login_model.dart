class ReadLoginModel {
  bool isLogined;
  String? token;
  String? handle;
  String? nickname;

  ReadLoginModel({required this.isLogined, this.token, this.handle, this.nickname});
}