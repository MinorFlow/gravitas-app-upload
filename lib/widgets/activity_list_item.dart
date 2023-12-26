import 'package:flutter/material.dart';

class ActivityListItem extends StatefulWidget {
  const ActivityListItem({super.key, required this.type});
  final int type;

  @override
  State<ActivityListItem> createState() => _ActivityListItemState();
}

class _ActivityListItemState extends State<ActivityListItem> {
  @override
  Widget build(BuildContext context) {
    if (widget.type == 0) {
      return InkWell(
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
          child: Row(
            children: [
              Icon(Icons.notifications, color: Colors.black.withOpacity(0.5),),
              const SizedBox(width: 16,),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('알림 제목', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Row(
                    children: [
                      Text('허브 이름', style: TextStyle(fontSize: 13)),
                      SizedBox(width: 6,),
                      Text('XXXX.XX.XX HH:MM:SS', style: TextStyle(fontSize: 13),),
                    ],
                  ),
                  Text('알림 설명', style: TextStyle(fontSize: 13),)
                ],
              )
            ],
          )
        ),
        onTap: () {
          
        },
      );
    } else if (widget.type == 1) {
      return InkWell(
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
          child: Row(
            children: [
              Icon(Icons.chat_bubble, color: Colors.black.withOpacity(0.5),),
              const SizedBox(width: 16,),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('대상 게시물 제목', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Row(
                    children: [
                      Text('허브 이름', style: TextStyle(fontSize: 13)),
                      SizedBox(width: 6,),
                      Text('XXXX.XX.XX HH:MM:SS', style: TextStyle(fontSize: 13),),
                    ],
                  ),
                  Text('댓글 내용', style: TextStyle(fontSize: 13),)
                ],
              )
            ],
          )
        ),
        onTap: () {
          
        },
      );
    } else {
      return InkWell(
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
          child: Row(
            children: [
              Icon(Icons.forum, color: Colors.black.withOpacity(0.5),),
              const SizedBox(width: 16,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('대상 댓글 내용', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const Row(
                    children: [
                      Text('허브 이름', style: TextStyle(fontSize: 13)),
                      SizedBox(width: 6,),
                      Text('XXXX.XX.XX HH:MM:SS', style: TextStyle(fontSize: 13),),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.subdirectory_arrow_right, size: 13, color: Colors.black.withOpacity(0.5),),
                      const SizedBox(width: 2,),
                      const Text('대댓글 내용', style: TextStyle(fontSize: 13),)
                    ],
                  )
                ],
              )
            ],
          )
        ),
        onTap: () {

        },
      );
    }
  }
}