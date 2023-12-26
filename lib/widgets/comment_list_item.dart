import 'package:flutter/material.dart';
import 'package:gravitas_app/common/models/comment_info_model.dart';
import 'package:gravitas_app/common/util/gravitas_helper.dart';

class CommentListItem extends StatefulWidget {
  const CommentListItem({super.key, required this.commentInfoModel, required this.idx});
  final int idx;
  final CommentInfoModel commentInfoModel;

  @override
  State<CommentListItem> createState() => _CommentListItemState();
}

class _CommentListItemState extends State<CommentListItem> {

  GravitasHelper gravitasHelper = GravitasHelper();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.idx != 0) const Divider(height: 0,),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text('${widget.commentInfoModel.nickname}', style: const TextStyle(fontSize: 13),),
                  const SizedBox(width: 6,),
                  Text(widget.commentInfoModel.date != null ? gravitasHelper.convertDate(widget.commentInfoModel.date!, 'yyyy.MM.dd HH:mm:ss') : 'null', style: const TextStyle(fontSize: 13))
                ],
              ),
              const SizedBox(height: 2,),
              Text('${widget.commentInfoModel.content}', style: const TextStyle(fontSize: 13))
            ],
          ),
        ),
      ],
    );
  }
}