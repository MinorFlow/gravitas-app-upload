import 'package:flutter/material.dart';
import 'package:gravitas_app/common/models/horizon_info_model.dart';
import 'package:gravitas_app/common/util/gravitas_helper.dart';
import 'package:gravitas_app/pages/horizon_detail_page.dart';

class HorizonListItem extends StatefulWidget {
  const HorizonListItem({super.key, required this.horizonInfoModel, required this.planetName, required this.customMargin});
  final HorizonInfoModel horizonInfoModel;
  final String planetName;
  final EdgeInsets customMargin;

  @override
  State<HorizonListItem> createState() => _HorizonListItemState();
}

class _HorizonListItemState extends State<HorizonListItem> {

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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${widget.horizonInfoModel.name}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text('${widget.horizonInfoModel.desc}'),
                  Text('유형: ${widget.horizonInfoModel.type == 1 ? "정기" : "비정기"}'),
                  const SizedBox(height: 8,),
                  Row(
                    children: [
                      Icon(Icons.build, size: 14, color: Colors.black.withOpacity(0.3),),
                      const SizedBox(width: 4,),
                      Text(gravitasHelper.convertDate(widget.horizonInfoModel.createRaw!, 'yyyy.MM.dd'), style: TextStyle(color: Colors.black.withOpacity(0.5)))
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.person, size: 14, color: Colors.black.withOpacity(0.3),),
                      const SizedBox(width: 4,),
                      Text('${widget.horizonInfoModel.nickname}', style: TextStyle(color: Colors.black.withOpacity(0.5)))
                    ],
                  ),
                ],
              )
            ],
          )
        ),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => HorizonDetailPage(horizonInfoModel: widget.horizonInfoModel, planetName: widget.planetName)));
        },
      ),
    );
  }
}