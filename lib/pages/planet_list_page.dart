import 'package:flutter/material.dart';
import 'package:gravitas_app/common/api/api_helper.dart';
import 'package:gravitas_app/common/models/planet_info_model.dart';
import 'package:gravitas_app/widgets/empty_cover.dart';
import 'package:gravitas_app/pages/planet_create_page.dart';
import 'package:gravitas_app/widgets/planet_list_item.dart';
import 'package:provider/provider.dart';
import 'package:gravitas_app/common/util/login_status_provider.dart';

class PlanetListPage extends StatefulWidget {
  const PlanetListPage({super.key});

  @override
  State<PlanetListPage> createState() => _PlanetListPageState();
}

class _PlanetListPageState extends State<PlanetListPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  APIHelper apiHelper = APIHelper();
  List<PlanetInfoModel> planets = [];

  void refreshPlanetList() async {
    final res = await apiHelper.getPlanetList();
    setState(() {
      planets = res;
    });
  }

  @override
  void initState() {
    super.initState();
    refreshPlanetList();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
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
                    refreshPlanetList();
                  },
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: SizedBox(
                child: ElevatedButton(
                  onPressed: context.watch<LoginStatusProvider>().isLogined ? () async {
                    final createState = await Navigator.push(context, MaterialPageRoute(builder: (context) => const PlanetCreatePage()));
                    if (createState == true) refreshPlanetList();
                  } : null,
                  child: const Text('Planet 생성', style: TextStyle(fontWeight: FontWeight.bold),),
                ),
              ),
            ),
          ],
        ),
        const Divider(height: 1,),
        Expanded(
          child: RefreshIndicator(
            child: planets.isNotEmpty ? ListView.builder(
              itemCount: planets.length,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return PlanetListItem(planetInfoModel: planets[index], customMargin: const EdgeInsets.fromLTRB(16, 16, 16, 16),);
                } else {
                  return PlanetListItem(planetInfoModel: planets[index], customMargin: const EdgeInsets.fromLTRB(16, 0, 16, 16),);
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
              refreshPlanetList();
            },
          ),
        )
      ],
    );
  }
}
