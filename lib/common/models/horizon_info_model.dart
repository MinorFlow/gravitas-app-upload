class HorizonInfoModel {
  String? uid;
  String? groupDt;
  String? name;
  String? coverUrl;
  String? desc;
  int? type;
  String? manager;
  String? createRaw;
  String? nickname;

  HorizonInfoModel({
    this.uid,
    this.groupDt,
    this.name,
    this.coverUrl,
    this.desc,
    this.type,
    this.manager,
    this.createRaw,
    this.nickname
  });

  HorizonInfoModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    groupDt = json['group_dt'];
    name = json['name'];
    coverUrl = json['cover_url'];
    desc = json['desc'];
    type = json['type'];
    manager = json['manager'];
    createRaw = json['create_raw'];
    nickname = json['nickname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['group_dt'] = groupDt;
    data['name'] = name;
    data['cover_url'] = coverUrl;
    data['desc'] = desc;
    data['type'] = type;
    data['manager'] = manager;
    data['create_raw'] = createRaw;
    data['nickname'] = nickname;
    return data;
  }
}
