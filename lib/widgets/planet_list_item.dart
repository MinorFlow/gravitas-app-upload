import 'package:flutter/material.dart';
import 'package:gravitas_app/common/models/planet_info_model.dart';
import 'package:gravitas_app/common/util/gravitas_helper.dart';
import 'package:gravitas_app/pages/planet_detail_page.dart';

class PlanetListItem extends StatefulWidget {
  const PlanetListItem({super.key, required this.planetInfoModel, required this.customMargin});
  final PlanetInfoModel planetInfoModel;
  final EdgeInsets customMargin;

  @override
  State<PlanetListItem> createState() => _PlanetListItemState();
}

class _PlanetListItemState extends State<PlanetListItem> {
  
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
                  Text('${widget.planetInfoModel.name}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text('${widget.planetInfoModel.desc}'),
                  const SizedBox(height: 8,),
                  Row(
                    children: [
                      Icon(Icons.build, size: 14, color: Colors.black.withOpacity(0.3),),
                      const SizedBox(width: 4,),
                      Text(gravitasHelper.convertDate(widget.planetInfoModel.createRaw!, 'yyyy.MM.dd'), style: TextStyle(color: Colors.black.withOpacity(0.5)))
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.person, size: 14, color: Colors.black.withOpacity(0.3),),
                      const SizedBox(width: 4,),
                      Text('${widget.planetInfoModel.nickname}', style: TextStyle(color: Colors.black.withOpacity(0.5)))
                    ],
                  )
                ],
              )
            ],
          )
        ),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => PlanetDetailPage(planetInfoModel: widget.planetInfoModel)));
        },
      ),
    );
  }
}