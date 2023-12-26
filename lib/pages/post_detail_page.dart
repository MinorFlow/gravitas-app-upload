import 'package:flutter/material.dart';
import 'package:gravitas_app/common/api/api_helper.dart';
import 'package:gravitas_app/common/models/comment_info_model.dart';
import 'package:gravitas_app/common/models/post_detail_model.dart';
import 'package:gravitas_app/common/util/gravitas_helper.dart';
import 'package:gravitas_app/common/util/login_status_provider.dart';
import 'package:gravitas_app/common/util/secure_manager.dart';
import 'package:gravitas_app/widgets/empty_cover.dart';
import 'package:gravitas_app/widgets/comment_list_item.dart';
import 'package:provider/provider.dart';

class PostDetailPage extends StatefulWidget {
  const PostDetailPage({super.key, required this.uid});
  final String uid;

  @override
  State<PostDetailPage> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  
  APIHelper apiHelper = APIHelper();
  SecureManager secureManager = SecureManager();
  GravitasHelper gravitasHelper = GravitasHelper();
  PostDetailModel postDetailModel = PostDetailModel();

  final contentTextEditController = TextEditingController();

  List<CommentInfoModel> comments = [];

  void loadPost() async {
    final res = await apiHelper.getPostDetail(widget.uid);
    if (res != null) {
      setState(() {
        postDetailModel = res;
      });
    } else {
      // 뭔가 조금 잘못된 게시물
    }
  }

  void loadComment() async {
    final res = await apiHelper.getCommentList(widget.uid);
    setState(() {
      comments = res;
    });
  }

  @override
  void initState() {
    super.initState();
    loadPost();
    loadComment();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Gravitas'),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${postDetailModel.title}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4,),
                      Row(
                        children: [
                          Text('${postDetailModel.nickname}', style: const TextStyle(fontSize: 12)),
                          const SizedBox(width: 8,),
                          Text(postDetailModel.date != null ? gravitasHelper.convertDate(postDetailModel.date!, 'yyyy.MM.dd HH:mm:ss') : 'null', style: const TextStyle(fontSize: 12))
                        ],
                      ),
                      Row(
                        children: [
                          Text('조회수 ${postDetailModel.viewCnt}', style: const TextStyle(fontSize: 12)),
                          const SizedBox(width: 8,),
                          Text('추천 ${postDetailModel.rcmdCnt}', style: const TextStyle(fontSize: 12)),
                          const SizedBox(width: 8,),
                          Text('비추천 ${postDetailModel.drcmdCnt}', style: const TextStyle(fontSize: 12)),
                        ],
                      )
                    ],
                  ),
                ),
                const Divider(height: 0,),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: Text('${postDetailModel.content}')
                  ),
                ),
                const SizedBox(height: 16,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton.outlined(
                      padding: const EdgeInsets.all(12),
                      icon: const Icon(Icons.thumb_up, size: 36),
                      onPressed: () {
                        
                      },
                    ),
                    const SizedBox(width: 32,),
                    IconButton.outlined(
                      padding: const EdgeInsets.all(12),
                      icon: const Icon(Icons.thumb_down, size: 36),
                      onPressed: () {
                        
                      },
                    )
                  ],
                ),
                const SizedBox(height: 32,),
                Container(
                  color: Colors.black.withOpacity(0.08),
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  alignment: Alignment.centerLeft,
                  child: Text('댓글 (${comments.length})', style: const TextStyle(fontWeight: FontWeight.bold)),
                ),
                if (comments.isNotEmpty) for (int idx = 0; idx < comments.length; idx++) CommentListItem(commentInfoModel: comments[idx], idx: idx,),
                if (comments.isEmpty) const SizedBox(height: 200, child: EmptyCover(),),
                const Divider(height: 0,),
                const SizedBox(height: 16,),
                Row(
                  children: [
                    const SizedBox(width: 16,),
                    Expanded(
                      child: SizedBox(
                        child: TextField(
                          maxLines: 2,
                          textInputAction: TextInputAction.newline,
                          controller: contentTextEditController,
                          decoration: const InputDecoration(
                            isDense: true,
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.fromLTRB(12, 12, 12, 10)
                          ),
                          style: const TextStyle(fontSize: 13),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16,),
                    IconButton.filled(
                      icon: const Icon(Icons.send),
                      onPressed: context.watch<LoginStatusProvider>().isLogined ? () async {
                        try {
                          final token = await secureManager.readUserToken();
                          if (token != null) {
                            final contentValue = contentTextEditController.text;
                            final res = await apiHelper.writeComment(token, widget.uid, contentValue);
                            if (res == true) {
                              contentTextEditController.clear();
                              FocusManager.instance.primaryFocus?.unfocus();
                              loadComment();
                            }
                          }
                        } catch(e) {
                          // error
                        }
                      } : null,
                    ),
                    const SizedBox(width: 16,),
                  ],
                ),
              ],
            ),
          ),
          onRefresh: () async {
            loadPost();
            loadComment();
          },
        ),
      ),
    );
  }
}