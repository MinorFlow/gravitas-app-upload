import 'package:flutter/material.dart';
import 'package:gravitas_app/common/api/api_helper.dart';
import 'package:gravitas_app/common/util/secure_manager.dart';

enum ScheType { fixed, unfixed }

class HorizonCreatePage extends StatefulWidget {
  const HorizonCreatePage({super.key, required this.uid});
  final String uid;

  @override
  State<HorizonCreatePage> createState() => _HorizonCreatePageState();
}

class _HorizonCreatePageState extends State<HorizonCreatePage> {

  ScheType scheType = ScheType.fixed;

  final secureManager = SecureManager();
  final apiHelper = APIHelper();

  final nameTextEditController = TextEditingController();
  final descTextEditController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Horizon Create')
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              width: 2,
              color: Theme.of(context).colorScheme.inversePrimary
            )
          ),
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 8,),
              const Icon(Icons.connect_without_contact, color: Colors.amber, size: 64,),
              const SizedBox(height: 24,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 4),
                    child: const Text('Horizon 이름', style: TextStyle(fontWeight: FontWeight.bold),)
                  ),
                  const SizedBox(height: 4,),
                  TextField(
                    controller: nameTextEditController,
                    decoration: const InputDecoration(
                      isDense: true,
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(12)
                    ),
                    style: const TextStyle(height: 1.0),
                  )
                ],
              ),
              const SizedBox(height: 16,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 4),
                    child: const Text('Horizon 설명', style: TextStyle(fontWeight: FontWeight.bold),)
                  ),
                  const SizedBox(height: 4,),
                  TextField(
                    controller: descTextEditController,
                    decoration: const InputDecoration(
                      isDense: true,
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(12)
                    ),
                    style: const TextStyle(height: 1.0),
                  )
                ],
              ),
              const SizedBox(height: 16,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 4),
                    child: const Text('이벤트 유형', style: TextStyle(fontWeight: FontWeight.bold),)
                  ),
                  const SizedBox(height: 4,),
                  Row(
                    children: [
                      Expanded(
                        child: SegmentedButton<ScheType>(
                          segments: const [
                            ButtonSegment(value: ScheType.fixed, label: Text('정기')),
                            ButtonSegment(value: ScheType.unfixed, label: Text('비정기')),
                          ],
                          selected: <ScheType>{scheType},
                          onSelectionChanged: (Set<ScheType> value) {
                            setState(() {
                              scheType = value.first;
                            });
                          },
                        ),
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(height: 8,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.topRight,
                      child: ElevatedButton(
                        child: const Text('생성', style: TextStyle(fontWeight: FontWeight.bold)),
                        onPressed: () async {
                          try {
                            final token = await secureManager.readUserToken();
                            if (token != null) {
                              final nameValue = nameTextEditController.text;
                              final descValue = descTextEditController.text;
                              final typeValue = scheType.index + 1;
                              if (nameValue != '' && descValue != '') {
                                final res = await apiHelper.createHorizon(token, nameValue, descValue, typeValue, widget.uid);
                                if (res == true) {
                                  if (!mounted) return;
                                  Navigator.pop(context, true);
                                }
                              }
                            }
                          } catch(e) {
                            // error
                          }
                        },
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      )
    );
  }
}
