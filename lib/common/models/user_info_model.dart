class UserInfoModel {
  bool? success;
  String? uid;
  String? nickname;
  String? joindate;

  UserInfoModel({this.success, this.uid, this.nickname, this.joindate});

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    uid = json['uid'];
    nickname = json['nickname'];
    joindate = json['joindate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['uid'] = uid;
    data['nickname'] = nickname;
    data['joindate'] = joindate;
    return data;
  }
}
