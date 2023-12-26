class PostSimpleModel {
  String? uid;
  String? title;
  String? nickname;
  String? date;
  int? viewCnt;
  int? rcmdCnt;

  PostSimpleModel({
    this.uid,
    this.title,
    this.nickname,
    this.date,
    this.viewCnt,
    this.rcmdCnt
  });

  PostSimpleModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    title = json['title'];
    nickname = json['nickname'];
    date = json['date'];
    viewCnt = json['view_cnt'];
    rcmdCnt = json['rcmd_cnt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['title'] = title;
    data['nickname'] = nickname;
    data['date'] = date;
    data['view_cnt'] = viewCnt;
    data['rcmd_cnt'] = rcmdCnt;
    return data;
  }
}
