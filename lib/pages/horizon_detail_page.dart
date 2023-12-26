import 'package:flutter/material.dart';
import 'package:gravitas_app/common/api/api_helper.dart';
import 'package:gravitas_app/common/models/event_simple_model.dart';
import 'package:gravitas_app/common/models/horizon_info_model.dart';
import 'package:gravitas_app/common/models/post_simple_model.dart';
import 'package:gravitas_app/common/util/login_status_provider.dart';
import 'package:gravitas_app/widgets/empty_cover.dart';
import 'package:gravitas_app/widgets/post_list_item.dart';
import 'package:gravitas_app/pages/event_create_page.dart';
import 'package:gravitas_app/widgets/event_list_item.dart';
import 'package:gravitas_app/pages/post_write_page.dart';
import 'package:provider/provider.dart';

class HorizonDetailPage extends StatefulWidget {
  const HorizonDetailPage({super.key, required this.horizonInfoModel, required this.planetName});
  final HorizonInfoModel horizonInfoModel;
  final String planetName;

  @override
  State<HorizonDetailPage> createState() => _HorizonDetailPageState();
}

class _HorizonDetailPageState extends State<HorizonDetailPage> {

  bool test = false;

  APIHelper apiHelper = APIHelper();
  List<PostSimpleModel> posts = [];
  List<EventSimpleModel> events = [];

  void refreshPostList() async {
    final res = await apiHelper.getPostList(2, widget.horizonInfoModel.uid!);
    setState(() {
      posts = res;
    });
  }

  void refreshEventList() async {
    final res = await apiHelper.getEventList(widget.horizonInfoModel.uid!);
    setState(() {
      events = res;
    });
  }

  @override
  void initState() {
    super.initState();
    refreshPostList();
    refreshEventList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 80,
              color: Colors.black,
              child: const Image(image: AssetImage('lib/assets/ad.jpg'), fit: BoxFit.fitWidth,),
            ),
            const SizedBox(height: 16,),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(
                  height: 48,
                  width: 48,
                  child: CircleAvatar(
                    backgroundColor: Colors.black,
                  ),
                ),
                const SizedBox(width: 16,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('HORIZON', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.orange.withOpacity(0.8))),
                      Text('${widget.horizonInfoModel.name}', overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                      Text('${widget.horizonInfoModel.desc}'),
                      const SizedBox(height: 8,),
                      const Text('정착민 XXX명')
                    ],
                  ),
                ),
                IconButton.outlined(
                  color: test ? Colors.green : Colors.black,
                  icon: test ? const Icon(Icons.check) : const Icon(Icons.add),
                  onPressed: context.watch<LoginStatusProvider>().isLogined ? () {
                    setState(() {
                      test = !test;
                    });
                  } : null,
                ),
                const SizedBox(width: 16,)
              ],
            ),
            const SizedBox(height: 16,),
            Container(
              color: Colors.black.withOpacity(0.08),
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Text('${widget.planetName} ', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                  const Text('Planet', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.blue)),
                  const Text('의 ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                  const Text('Horizon', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.orange)),
                ],
              ),
            ),
            Expanded(
              child: DefaultTabController(
                initialIndex: 0,
                length: 3,
                child: Column(
                  children: [
                    const TabBar(
                      tabs: [
                        Tab(text: "자유게시판"),
                        Tab(text: "행사 목록"),
                        Tab(text: "Horizon 정보")
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.fromLTRB(16, 8, 0, 8),
                                    child: SizedBox(
                                      child: ElevatedButton(
                                        child: const Text('새로고침', style: TextStyle(fontWeight: FontWeight.bold),),
                                        onPressed: () {
                                          refreshPostList();
                                        },
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16,),
                                  IconButton.filled(
                                    icon: const Icon(Icons.edit),
                                    onPressed: context.watch<LoginStatusProvider>().isLogined ? () async {
                                      final createState = await Navigator.push(context, MaterialPageRoute(builder: (context) => PostWritePage(writeType: 2, uid: widget.horizonInfoModel.uid!)));
                                      if (createState == true) refreshPostList();
                                    } : null,
                                  ),
                                  const SizedBox(width: 16,)
                                ],
                              ),
                              const Divider(height: 1,),
                              Expanded(
                                child: RefreshIndicator(
                                  child: posts.isNotEmpty ? ListView.separated(
                                    itemCount: posts.length,
                                    itemBuilder: (context, index) => PostListItem(postSimpleModel: posts[index],),
                                    separatorBuilder: (context, index) => const Divider(height: 0),
                                  ) : LayoutBuilder(
                                    builder: (context, constraints) {
                                      return SingleChildScrollView(
                                        physics: const AlwaysScrollableScrollPhysics(),
                                        child: SizedBox(height: constraints.maxHeight, child: const EmptyCover()),
                                      );
                                    }
                                  ),
                                  onRefresh: () async {
                                    refreshPostList();
                                  },
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.fromLTRB(16, 8, 0, 8),
                                    child: SizedBox(
                                      child: ElevatedButton(
                                        child: const Text('새로고침', style: TextStyle(fontWeight: FontWeight.bold),),
                                        onPressed: () {
                                          refreshEventList();
                                        },
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16,),
                                  Container(
                                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                                    child: SizedBox(
                                      child: ElevatedButton(
                                        onPressed: context.watch<LoginStatusProvider>().isLogined ? () async {
                                          final createState = await Navigator.push(context, MaterialPageRoute(builder: (context) => EventCreatePage(uid: widget.horizonInfoModel.uid!)));
                                          if (createState == true) refreshEventList();
                                        } : null,
                                        child: const Text('행사 개최', style: TextStyle(fontWeight: FontWeight.bold),),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16,)
                                ],
                              ),
                              const Divider(height: 1,),
                              Expanded(
                                child: RefreshIndicator(
                                  child: events.isNotEmpty ? ListView.builder(
                                    itemCount: events.length,
                                    itemBuilder: (context, index) {
                                      if (index == 0) {
                                        return EventListItem(eventSimpleModel: events[index], customMargin: const EdgeInsets.all(16),);
                                      } else {
                                        return EventListItem(eventSimpleModel: events[index], customMargin: const EdgeInsets.fromLTRB(16, 0, 16, 16),);
                                      }
                                    },
                                  ) : LayoutBuilder(
                                    builder: (context, constraints) {
                                      return SingleChildScrollView(
                                        physics: const AlwaysScrollableScrollPhysics(),
                                        child: SizedBox(height: constraints.maxHeight, child: const EmptyCover()),
                                      );
                                    }
                                  ),
                                  onRefresh: () async {
                                    refreshEventList();
                                  },
                                ),
                              )
                            ],
                          ),
                          const EmptyCover(str: '정보가 없어요',)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}