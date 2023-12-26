import 'package:flutter/material.dart';
import 'package:gravitas_app/common/api/api_helper.dart';
import 'package:gravitas_app/common/models/post_simple_model.dart';
import 'package:gravitas_app/widgets/empty_cover.dart';
import 'package:gravitas_app/widgets/post_list_item.dart';
import 'package:gravitas_app/widgets/group_circle_link.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> with AutomaticKeepAliveClientMixin {
  
  @override
  bool get wantKeepAlive => true;

  APIHelper apiHelper = APIHelper();
  List<PostSimpleModel> bposts = [];

  void refreshBestPostList() async {
    final res = await apiHelper.getPostListAll();
    setState(() {
      bposts = res;
    });
  }

  @override
  void initState() {
    super.initState();
    refreshBestPostList();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        Column(
          children: [
            const SizedBox(height: 4,),
            Row(
              children: [
                const SizedBox(width: 8,),
                const Icon(Icons.arrow_left_sharp, color: Colors.black, size: 32,),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: const Text('2024.01.01 [HUB_NAME] [SCHE_NAME]'),
                  ),
                ),
                const Icon(Icons.arrow_right_sharp, color: Colors.black, size: 32),
                const SizedBox(width: 8,),
              ],
            ),
            const SizedBox(height: 4,),
          ],
        ),
        Container(
          width: double.infinity,
          height: 80,
          color: Colors.black,
          child: const Image(image: AssetImage('lib/assets/ad.jpg'), fit: BoxFit.fitWidth,),
        ),
        Container(
          color: Colors.black.withOpacity(0.08),
          child: Column(
            children: [
              const SizedBox(height: 6,),
              Row(
                textBaseline: TextBaseline.alphabetic,
                children: [
                  const SizedBox(width: 16,),
                  Container(
                    padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      border: Border.all(color: Colors.black)
                    ),
                    child: const Text('NOTICE', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                  ),
                  const SizedBox(width: 8,),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(width: 0.5)),
                    ),
                    child: Text('[운영] 안녕하세요, Minorflow 입니다.')
                  ),
                ],
              ),
              const SizedBox(height: 6,),
            ],
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: const Text('가입한 Planet', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        SizedBox(
          height: 96,
          child: ListView.separated(
            itemCount: 6,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => const GroupCircleLink(),
            separatorBuilder: (context, index) => const SizedBox(width: 16),
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          ),
        ),
        Container(
          color: Colors.black.withOpacity(0.08),
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          alignment: Alignment.centerLeft,
          child: const Text('🔥 베스트 게시글', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        Expanded(
          child: RefreshIndicator(
            child: bposts.isNotEmpty ? ListView.separated(
              itemCount: bposts.length,
              itemBuilder: (context, index) => PostListItem(postSimpleModel: bposts[index]),
              separatorBuilder: (context, index) => const Divider(height: 0,),
            ) : LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: SizedBox(height: constraints.maxHeight, child: const EmptyCover()),
                );
              }
            ),
            onRefresh: () async {
              refreshBestPostList();
            },
          )
        )
      ],
    );
  }
}