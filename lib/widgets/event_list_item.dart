import 'package:flutter/material.dart';
import 'package:gravitas_app/common/models/event_simple_model.dart';
import 'package:gravitas_app/common/util/gravitas_helper.dart';

class EventListItem extends StatefulWidget {
  const EventListItem({super.key, required this.eventSimpleModel, required this.customMargin});
  final EventSimpleModel eventSimpleModel;
  final EdgeInsets customMargin;

  @override
  State<EventListItem> createState() => _EventListItemState();
}

class _EventListItemState extends State<EventListItem> {

  GravitasHelper gravitasHelper = GravitasHelper();
  
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: widget.customMargin,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8)
          ),
          child: Row(
            children: [
              const SizedBox(
                height: 48,
                width: 48,
                child: CircleAvatar(
                  backgroundColor: Colors.black,
                ),
              ),
              const SizedBox(width: 16,),
              Expanded(
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${widget.eventSimpleModel.name}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        Text('${widget.eventSimpleModel.content}'),
                        const SizedBox(height: 8,),
                        Row(
                          children: [
                            Icon(Icons.star, size: 14, color: Colors.black.withOpacity(0.3),),
                            const SizedBox(width: 4,),
                            Text('${widget.eventSimpleModel.nickname}', style: TextStyle(color: Colors.black.withOpacity(0.5)))
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.access_time, size: 14, color: Colors.black.withOpacity(0.3),),
                            const SizedBox(width: 4,),
                            Text(gravitasHelper.convertDate(widget.eventSimpleModel.date!, 'yyyy.MM.dd'), style: TextStyle(color: Colors.black.withOpacity(0.5)))
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.place, size: 14, color: Colors.black.withOpacity(0.3),),
                            const SizedBox(width: 4,),
                            Text('${widget.eventSimpleModel.location}', style: TextStyle(color: Colors.black.withOpacity(0.5)))
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )
        ),
        onTap: () {
          
        },
      ),
    );
  }
}