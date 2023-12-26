class PlanetInfoModel {
  String? uid;
  String? name;
  String? desc;
  String? iconUrl;
  String? manager;
  int? createY;
  int? createM;
  int? createD;
  String? createRaw;
  String? nickname;

  PlanetInfoModel({
    this.uid,
    this.name,
    this.desc,
    this.iconUrl,
    this.manager,
    this.createY,
    this.createM,
    this.createD,
    this.createRaw,
    this.nickname
  });

  PlanetInfoModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    desc = json['desc'];
    iconUrl = json['icon_url'];
    manager = json['manager'];
    createY = json['create_y'];
    createM = json['create_m'];
    createD = json['create_d'];
    createRaw = json['create_raw'];
    nickname = json['nickname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['name'] = name;
    data['desc'] = desc;
    data['icon_url'] = iconUrl;
    data['manager'] = manager;
    data['create_y'] = createY;
    data['create_m'] = createM;
    data['create_d'] = createD;
    data['create_raw'] = createRaw;
    data['nickname'] = nickname;
    return data;
  }
}