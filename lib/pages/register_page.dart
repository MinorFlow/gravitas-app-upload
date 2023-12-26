import 'package:flutter/material.dart';
import 'package:gravitas_app/common/api/api_helper.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gravitas_app/widgets/validation_alert_dialog.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final apiHelper = APIHelper();

  final idTextEditController = TextEditingController();
  final pwTextEditController = TextEditingController();
  final cpwTextEditController = TextEditingController();
  final nicknameTextEditController = TextEditingController();

  String? idValue;
  String? pwValue;
  String? cpwValue;
  String? nicknameValue;

  bool checking = false;
  bool? isChecked;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Register')
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
              const Icon(Icons.app_registration, color: Colors.amber, size: 64,),
              const SizedBox(height: 24,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 4),
                    child: const Text('아이디', style: TextStyle(fontWeight: FontWeight.bold),)
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: idTextEditController,
                          decoration: const InputDecoration(
                            isDense: true,
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.all(12)
                          ),
                          style: const TextStyle(height: 1.0),
                          onChanged: (value) {
                            setState(() {
                              isChecked = null;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 16,),
                      SizedBox(
                        width: 96,
                        child: ElevatedButton(
                          child: checking ? SpinKitFadingCircle(color: Theme.of(context).colorScheme.primary, size: 16,)
                          : const Text('중복확인', style: TextStyle(fontWeight: FontWeight.bold)),
                          onPressed: () async {
                            setState(() {
                              checking = true;
                            });
                            final idValue = idTextEditController.text;
                            if (idValue.isNotEmpty) {
                              var result = await apiHelper.checkID(idValue);
                              setState(() {
                                isChecked = result;
                              });
                            }
                            setState(() {
                              checking = false;
                            });
                          },
                        ),
                      )
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 4),
                    child: Text(isChecked == null ? '아이디 중복확인을 해주세요' : isChecked == true ? '사용가능한 아이디 입니다' : '사용할 수 없는 아이디 입니다', style: TextStyle(fontWeight: FontWeight.bold, color: isChecked == true ? Colors.green : Colors.red),)
                  ),
                ],
              ),
              const SizedBox(height: 16,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 4),
                    child: const Text('패스워드', style: TextStyle(fontWeight: FontWeight.bold),)
                  ),
                  const SizedBox(height: 4,),
                  TextField(
                    controller: pwTextEditController,
                    obscureText: true,
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
                    child: const Text('패스워드 확인', style: TextStyle(fontWeight: FontWeight.bold),)
                  ),
                  const SizedBox(height: 4,),
                  TextField(
                    controller: cpwTextEditController,
                    obscureText: true,
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
                    child: const Text('닉네임', style: TextStyle(fontWeight: FontWeight.bold),)
                  ),
                  const SizedBox(height: 4,),
                  TextField(
                    controller: nicknameTextEditController,
                    decoration: const InputDecoration(
                      isDense: true,
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(12)
                    ),
                    style: const TextStyle(height: 1.0),
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
                        child: const Text('회원가입', style: TextStyle(fontWeight: FontWeight.bold)),
                        onPressed: () async {
                          try {
                            if (isChecked == null) throw "ID_NOT_CHECK";
                            if (isChecked == false) throw "ID_NOT_USABLE";
                            final idValue = idTextEditController.text;
                            final pwValue = pwTextEditController.text;
                            final cpwValue = cpwTextEditController.text;
                            final nicknameValue = nicknameTextEditController.text;
                            if (pwValue != cpwValue) throw "PW_NOT_EQUAL";
                            if (nicknameValue.isEmpty) throw "NICKNAME_EMPTY";
                            var result = await apiHelper.requestRegister(idValue, pwValue, nicknameValue);
                            if (result == true) {
                              if (!mounted) return;
                              Navigator.pop(context, true);
                            }
                          } catch(e) {
                            if (!mounted) return;
                            if (e == "ID_NOT_CHECK") {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => const ValidationAlertDialog(title: '오류', desc: '아이디 중복확인을 해주세요')
                              );
                            } else if (e == "ID_NOT_USABLE") {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => const ValidationAlertDialog(title: '오류', desc: '사용불가능한 아이디 입니다')
                              );
                            } else if (e == "PW_NOT_EQUAL") {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => const ValidationAlertDialog(title: '오류', desc: '패스워드가 일치하지 않습니다')
                              );
                            } else if (e == "NICKNAME_EMPTY") {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => const ValidationAlertDialog(title: '오류', desc: '닉네임을 입력해주세요')
                              );
                            }
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