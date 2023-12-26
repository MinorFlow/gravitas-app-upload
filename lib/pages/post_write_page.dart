import 'package:flutter/material.dart';
import 'package:gravitas_app/common/api/api_helper.dart';
import 'package:gravitas_app/common/util/secure_manager.dart';

class PostWritePage extends StatefulWidget {
  const PostWritePage({super.key, required this.writeType, required this.uid});
  final int writeType;
  final String uid;

  @override
  State<PostWritePage> createState() => _PostWritePageState();
}

class _PostWritePageState extends State<PostWritePage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final secureManager = SecureManager();
  final apiHelper = APIHelper();

  final titleTextEditController = TextEditingController();
  final contentTextEditController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Write Post')
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
              const Icon(Icons.edit, color: Colors.amber, size: 64,),
              const SizedBox(height: 24,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 4),
                    child: const Text('제목', style: TextStyle(fontWeight: FontWeight.bold),)
                  ),
                  const SizedBox(height: 4,),
                  TextField(
                    controller: titleTextEditController,
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
                    child: const Text('내용', style: TextStyle(fontWeight: FontWeight.bold),)
                  ),
                  const SizedBox(height: 4,),
                  TextField(
                    maxLines: 6,
                    textInputAction: TextInputAction.newline,
                    controller: contentTextEditController,
                    decoration: const InputDecoration(
                      isDense: true,
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(12)
                    ),
                    style: const TextStyle(),
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
                        child: const Text('업로드', style: TextStyle(fontWeight: FontWeight.bold)),
                        onPressed: () async {
                          try {
                            final token = await secureManager.readUserToken();
                            if (token != null) {
                              final titleValue = titleTextEditController.text;
                              final contentValue = contentTextEditController.text;
                              final res = await apiHelper.writePost(token, widget.writeType, widget.uid, titleValue, contentValue);
                              if (res == true) {
                                if (!mounted) return;
                                Navigator.pop(context, true);
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
