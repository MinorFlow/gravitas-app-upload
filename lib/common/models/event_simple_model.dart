class EventSimpleModel {
  String? uid;
  String? target;
  String? host;
  String? name;
  String? date;
  String? location;
  String? content;
  String? nickname;

  EventSimpleModel({
    this.uid,
    this.target,
    this.host,
    this.name,
    this.date,
    this.location,
    this.content,
    this.nickname
  });

  EventSimpleModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    target = json['target'];
    host = json['host'];
    name = json['name'];
    date = json['date'];
    location = json['location'];
    content = json['content'];
    nickname = json['nickname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['target'] = target;
    data['host'] = host;
    data['name'] = name;
    data['date'] = date;
    data['location'] = location;
    data['content'] = content;
    data['nickname'] = nickname;
    return data;
  }
}
