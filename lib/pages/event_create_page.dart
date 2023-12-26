import 'package:flutter/material.dart';
import 'package:gravitas_app/common/api/api_helper.dart';
import 'package:gravitas_app/common/util/secure_manager.dart';
import 'package:jiffy/jiffy.dart';

enum ScheType { fixed, unfixed }

class EventCreatePage extends StatefulWidget {
  const EventCreatePage({super.key, required this.uid});
  final String uid;

  @override
  State<EventCreatePage> createState() => _EventCreatePageState();
}

class _EventCreatePageState extends State<EventCreatePage> {

  final secureManager = SecureManager();
  final apiHelper = APIHelper();

  final nameTextEditController = TextEditingController();
  final descTextEditController = TextEditingController();
  final locationTextEditController = TextEditingController();
  DateTime? dateTime;
  DateTime? timeOfDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Event Create')
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
              const Icon(Icons.celebration, color: Colors.amber, size: 64,),
              const SizedBox(height: 24,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 4),
                    child: const Text('Event 이름', style: TextStyle(fontWeight: FontWeight.bold),)
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
                    child: const Text('Event 설명', style: TextStyle(fontWeight: FontWeight.bold),)
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
                    child: const Text('Event 장소', style: TextStyle(fontWeight: FontWeight.bold),)
                  ),
                  const SizedBox(height: 4,),
                  TextField(
                    controller: locationTextEditController,
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
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            child: const Text('날짜 선택', style: TextStyle(fontWeight: FontWeight.bold)),
                            onPressed: () async {
                              final selected = await showDatePicker(
                                context: context,
                                locale: const Locale('ko'),
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(3000)
                              );
                              if (selected != null) {
                                setState(() {
                                  dateTime = selected;
                                });
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 4,),
                        Text(
                          dateTime == null ? '선택하지 않음' : Jiffy.parseFromDateTime(dateTime!).format(pattern: "yyyy-MM-dd"),
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            child: const Text('시간 선택', style: TextStyle(fontWeight: FontWeight.bold)),
                            onPressed: () async {
                              final selected = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                                builder: (BuildContext context, Widget? child) {
                                  return Theme(
                                    data: Theme.of(context).copyWith(),
                                    child: Directionality(
                                      textDirection: TextDirection.ltr,
                                      child: MediaQuery(
                                        data: MediaQuery.of(context).copyWith(
                                          alwaysUse24HourFormat: false
                                        ),
                                        child: child!,
                                      ),
                                    ),
                                  );
                                }
                              );
                              if (selected != null) {
                                setState(() {
                                  DateTime temp = DateTime(2023, 1, 1, selected.hour, selected.minute);
                                  timeOfDay = temp;
                                });
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 4,),
                        Text(
                          timeOfDay == null ? '선택하지 않음' : Jiffy.parseFromDateTime(timeOfDay!).format(pattern: 'HH:mm'),
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 32,),
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
                              final locationValue = locationTextEditController.text;
                              if (nameValue != '' && descValue != '' && locationValue != '') {
                                if (dateTime != null && timeOfDay != null) {
                                  DateTime mergedDate = DateTime(dateTime!.year, dateTime!.month, dateTime!.day, timeOfDay!.hour, timeOfDay!.minute);
                                  String dateStr = '${mergedDate.millisecondsSinceEpoch}';
                                  final res = await apiHelper.createEvent(token, widget.uid, nameValue, descValue, locationValue, dateStr);
                                  if (res == true) {
                                    if (!mounted) return;
                                    Navigator.pop(context, true);
                                  }
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
