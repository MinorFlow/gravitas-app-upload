import 'package:flutter/material.dart';
import 'package:gravitas_app/common/models/post_simple_model.dart';
import 'package:gravitas_app/common/util/gravitas_helper.dart';
import 'package:gravitas_app/pages/post_detail_page.dart';

class PostListItem extends StatefulWidget {
  const PostListItem({super.key, required this.postSimpleModel});
  final PostSimpleModel postSimpleModel;

  @override
  State<PostListItem> createState() => _PostListItemState();
}

class _PostListItemState extends State<PostListItem> {

  GravitasHelper gravitasHelper = GravitasHelper();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
        child: Row(
          children: [
            Icon(
              widget.postSimpleModel.viewCnt! >= 30 ? Icons.local_fire_department : Icons.text_snippet,
              color: widget.postSimpleModel.viewCnt! >= 30 ? Colors.red.withOpacity(0.8) : Colors.black.withOpacity(0.2),),
            const SizedBox(width: 16,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${widget.postSimpleModel.title}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                const SizedBox(height: 4,),
                Row(
                  children: [
                    Text('${widget.postSimpleModel.nickname}', style: const TextStyle(fontSize: 13),),
                    const SizedBox(width: 6,),
                    Text(widget.postSimpleModel.date != null ? gravitasHelper.convertDate(widget.postSimpleModel.date!, 'yyyy.MM.dd') : 'null', style: const TextStyle(fontSize: 13),),
                    const SizedBox(width: 6,),
                    const Icon(Icons.remove_red_eye_outlined, size: 16,),
                    const SizedBox(width: 2,),
                    Text('${widget.postSimpleModel.viewCnt}', style: const TextStyle(fontSize: 13),),
                    const SizedBox(width: 6,),
                    const Icon(Icons.thumb_up_alt_outlined, size: 16),
                    const SizedBox(width: 2,),
                    Text('${widget.postSimpleModel.rcmdCnt}', style: const TextStyle(fontSize: 13),)
                  ],
                ),
              ],
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerRight,
                child: Text('${widget.postSimpleModel.uid}'.substring(0, 6))
              )
            )
          ],
        ),
      ),
      onTap: () async {
        await Navigator.push(context, MaterialPageRoute(builder: (context) => PostDetailPage(uid: widget.postSimpleModel.uid!)));
      },
    );
  }
}