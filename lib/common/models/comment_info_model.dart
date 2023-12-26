class CommentInfoModel {
  String? uid;
  String? writer;
  String? postDt;
  String? replyDt;
  String? content;
  String? emoUid;
  String? date;
  String? nickname;

  CommentInfoModel({
    this.uid,
    this.writer,
    this.postDt,
    this.replyDt,
    this.content,
    this.emoUid,
    this.date,
    this.nickname
  });

  CommentInfoModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    writer = json['writer'];
    postDt = json['post_dt'];
    replyDt = json['reply_dt'];
    content = json['content'];
    emoUid = json['emo_uid'];
    date = json['date'];
    nickname = json['nickname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['writer'] = writer;
    data['post_dt'] = postDt;
    data['reply_dt'] = replyDt;
    data['content'] = content;
    data['emo_uid'] = emoUid;
    data['date'] = date;
    data['nickname'] = nickname;
    return data;
  }
}
