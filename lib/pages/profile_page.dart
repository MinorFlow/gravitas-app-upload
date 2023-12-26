import 'package:flutter/material.dart';
import 'package:gravitas_app/common/api/api_helper.dart';
import 'package:gravitas_app/common/util/gravitas_helper.dart';
import 'package:gravitas_app/pages/login_page.dart';
import 'package:gravitas_app/pages/register_page.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:gravitas_app/common/util/secure_manager.dart';
import 'package:gravitas_app/common/util/login_status_provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final secureManager = SecureManager();
  final apiHelper = APIHelper();
  final gravitasHelper = GravitasHelper();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SettingsList(
      lightTheme: const SettingsThemeData(
        settingsListBackground: Colors.white,
        dividerColor: Colors.green,

      ),
      platform: DevicePlatform.android,
      sections: [
        CustomSettingsSection(
          child: CustomSettingsTile(
            child: Card(
              elevation: 2,
              margin: const EdgeInsets.all(16),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                child: Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 45,
                      child: Icon(Icons.person, size: 50,),
                    ),
                    const SizedBox(width: 24,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(context.watch<LoginStatusProvider>().isLogined ? '${context.watch<LoginStatusProvider>().userInfoModel.nickname}' : '로그인해주세요!', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                            const SizedBox(width: 8,),
                            Visibility(
                              visible: context.watch<LoginStatusProvider>().isLogined,
                              child: const Icon(
                                Icons.check_circle_outline,
                                color: Colors.green,
                                size: 22
                              ),
                            )

                          ],
                        ),
                        Visibility(
                          visible: context.watch<LoginStatusProvider>().isLogined,
                          child: Text('계정생성: ${context.watch<LoginStatusProvider>().userInfoModel.joindate}', style: const TextStyle(fontSize: 12)),
                        ),
                        const SizedBox(height: 12,),
                        context.watch<LoginStatusProvider>().isLogined ? Row(
                          children: [
                            GestureDetector(
                              child: const Text('프로필수정', style: TextStyle(decoration: TextDecoration.underline, fontSize: 13),),
                              onTap: () {

                              }
                            ),
                            const SizedBox(width: 8,),
                            GestureDetector(
                              child: const Text('정보수정', style: TextStyle(decoration: TextDecoration.underline, fontSize: 13),),
                              onTap: () {

                              }
                            ),
                            const SizedBox(width: 8,),
                            GestureDetector(
                              child: const Text('로그아웃', style: TextStyle(decoration: TextDecoration.underline, fontSize: 13),),
                              onTap: () async {
                                if (await secureManager.deleteLoginInfo()) {
                                  if (!mounted) return;
                                  context.read<LoginStatusProvider>().unsetLogined();
                                }
                              }
                            ),
                          ],
                        ) : Row(
                          children: [
                            GestureDetector(
                              child: const Text('로그인', style: TextStyle(decoration: TextDecoration.underline, fontSize: 13),),
                              onTap: () async {
                                final loginState = await Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()),);
                                if (loginState == true) {
                                  if (!mounted) return;
                                  gravitasHelper.detectLogin(context);
                                }
                              }
                            ),
                            const SizedBox(width: 8,),
                            GestureDetector(
                              child: const Text('회원가입', style: TextStyle(decoration: TextDecoration.underline, fontSize: 13),),
                              onTap: () async {
                                final returnData = await Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterPage()),);
                                if (!mounted) return;
                                if (returnData == true) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('회원가입이 완료되었습니다, 로그인해주세요!'),)
                                  );
                                }
                              }
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        SettingsSection(
          tiles: <SettingsTile>[
            if (context.watch<LoginStatusProvider>().isLogined) SettingsTile.navigation(
              leading: const Icon(Icons.edit),
              title: const Text('작성한 게시글'),
              value: const Text('10개의 항목'),
              onPressed: (BuildContext context) {},
            ),
            if (context.watch<LoginStatusProvider>().isLogined) SettingsTile.navigation(
              leading: const Icon(Icons.thumb_up),
              title: const Text('추천한 게시글'),
              value: const Text('10개의 항목'),
              onPressed: (BuildContext context) {},
            ),
            if (context.watch<LoginStatusProvider>().isLogined) SettingsTile.navigation(
              leading: const Icon(Icons.bookmark),
              title: const Text('북마크 게시글'),
              value: const Text('10개의 항목'),
              onPressed: (BuildContext context) {},
            ),
            SettingsTile.navigation(
              leading: const Icon(Icons.settings),
              title: const Text('환경 설정'),
              onPressed: (BuildContext context) {},
            ),
            if (context.watch<LoginStatusProvider>().isLogined) SettingsTile.navigation(
              leading: const Icon(Icons.emoji_emotions),
              title: const Text('이모티콘 관리'),
              onPressed: (BuildContext context) {},
            ),
            SettingsTile.navigation(
              leading: const Icon(Icons.help),
              title: const Text('고객센터'),
              onPressed: (BuildContext context) {},
            ),
          ],
        ),
      ],
    );
  }
}
