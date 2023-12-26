class PostDetailModel {
  String? uid;
  String? nickname;
  String? title;
  String? content;
  String? date;
  int? viewCnt;
  int? rcmdCnt;
  int? drcmdCnt;

  PostDetailModel({
    this.uid,
    this.nickname,
    this.title,
    this.content,
    this.date,
    this.viewCnt,
    this.rcmdCnt,
    this.drcmdCnt
  });

  PostDetailModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    nickname = json['nickname'];
    title = json['title'];
    content = json['content'];
    date = json['date'];
    viewCnt = json['view_cnt'];
    rcmdCnt = json['rcmd_cnt'];
    drcmdCnt = json['drcmd_cnt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['nickname'] = nickname;
    data['title'] = title;
    data['content'] = content;
    data['date'] = date;
    data['view_cnt'] = viewCnt;
    data['rcmd_cnt'] = rcmdCnt;
    data['drcmd_cnt'] = drcmdCnt;
    return data;
  }
}
