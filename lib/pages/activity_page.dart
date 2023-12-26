import 'package:flutter/material.dart';
import 'package:gravitas_app/widgets/activity_list_item.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  String? categoryValue = '전체 그룹';
  String? searchFilterValue = '전체';

  List<int> sampleData = [0, 1, 2, 1, 2, 0, 2, 1, 0];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 80,
          color: Colors.black,
          child: const Image(image: AssetImage('lib/assets/ad.jpg'), fit: BoxFit.fitWidth,),
        ),
        Row(
          children: [
            const SizedBox(width: 16,),
            SizedBox(
              width: 160,
              child: DropdownButton<String>(
                value: categoryValue,
                style: const TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.bold),
                onChanged:(value) {
                  setState(() {
                    categoryValue = value;
                  });
                },
                items: ["전체 그룹", "그룹 1", "그룹 2", "그룹 3"].map((String value) => DropdownMenuItem(
                  value: value,
                  child: Text(value)
                )).toList(),
                icon: const Icon(Icons.arrow_drop_down, color: Colors.black,),
                dropdownColor: Colors.white,
                isExpanded: true,
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: const Icon(Icons.tune),
                  onPressed: () {
                    
                  },
                )
              ),
            )
          ],
        ),
        const Divider(height: 1,),
        Expanded(
          child: ListView.separated(
            itemCount: sampleData.length,
            itemBuilder: (context, index) => ActivityListItem(type: sampleData[index]),
            separatorBuilder: (context, index) => const Divider(height: 0),
          ),
        ),
        const Divider(height: 1,),
        Row(
          children: [
            const SizedBox(width: 16,),
            SizedBox(
              width: 100,
              child: DropdownButton<String>(
                value: searchFilterValue,
                style: const TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.bold),
                onChanged:(value) {
                  setState(() {
                    searchFilterValue = value;
                  });
                },
                items: ["전체", "제목만", "작성자만", "제목 + 작성자", "내용만"].map((String value) => DropdownMenuItem(
                  value: value,
                  child: Text(value)
                )).toList(),
                icon: const Icon(Icons.arrow_drop_down, color: Colors.black,),
                dropdownColor: Colors.white,
                isExpanded: true,
              ),
            ),
            const SizedBox(width: 16,),
            const Expanded(
              child: SizedBox(
                height: 32,
                child: TextField(
                  decoration: InputDecoration(
                    isDense: true,
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.fromLTRB(12, 12, 12, 10)
                  ),
                  style: TextStyle(fontSize: 16, height: 1.0),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                
              },
            )
          ],
        )
      ],
    );
  }
}