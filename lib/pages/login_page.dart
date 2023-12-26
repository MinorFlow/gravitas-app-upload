import 'package:flutter/material.dart';
import 'package:gravitas_app/common/api/api_helper.dart';
import 'package:gravitas_app/common/util/secure_manager.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final idTextEditController = TextEditingController();
  final pwTextEditController = TextEditingController();

  final apiHelper = APIHelper();
  final secureManager = SecureManager();

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Login')
      ),
      body: Column(
        children: [
          Container(
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
                const Icon(Icons.key, color: Colors.amber, size: 64,),
                const SizedBox(height: 24,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 4),
                      child: const Text('아이디', style: TextStyle(fontWeight: FontWeight.bold))
                    ),
                    const SizedBox(height: 4,),
                    TextField(
                      controller: idTextEditController,
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
                      child: const Text('패스워드', style: TextStyle(fontWeight: FontWeight.bold))
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
                const SizedBox(height: 8,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 4),
                      child: const Text('패스워드를 잊으셨나요?', style: TextStyle(decoration: TextDecoration.underline)),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.topRight,
                        child: ElevatedButton(
                          child: const Text('로그인', style: TextStyle(fontWeight: FontWeight.bold)),
                          onPressed: () async {
                            final idValue = idTextEditController.text;
                            final pwValue = pwTextEditController.text;
                            if (idValue.isNotEmpty && pwValue.isNotEmpty) {
                              var result = await apiHelper.requestLogin(idValue, pwValue);
                              var secureResult = await secureManager.setLoginInfo(result);
                              if (secureResult == true) {
                                if (!mounted) return;
                                Navigator.pop(context, true);
                              }
                            } else {

                            }
                          },
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      )
    );
  }
}