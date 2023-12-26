import 'package:flutter/material.dart';
import 'package:gravitas_app/common/api/api_helper.dart';
import 'package:gravitas_app/common/util/gravitas_helper.dart';
import 'package:gravitas_app/common/util/login_status_provider.dart';
import 'package:gravitas_app/common/util/secure_manager.dart';
import 'package:gravitas_app/pages/dashboard_page.dart';
import 'package:gravitas_app/pages/calendar_page.dart';
import 'package:gravitas_app/pages/activity_page.dart';
import 'package:gravitas_app/pages/planet_list_page.dart';
import 'package:gravitas_app/pages/profile_page.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  await initializeDateFormatting();
  // runApp(const GravitasApp());
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LoginStatusProvider(),
        )
      ],
      child: const GravitasApp(),
    )
  );
}

class GravitasApp extends StatelessWidget {
  const GravitasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate
        ],
        title: 'Gravitas',
        theme: ThemeData(
          fontFamily: 'Noto Sans KR',
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Gravitas'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final pageController = PageController();

  NavigationDestinationLabelBehavior labelBehavior = NavigationDestinationLabelBehavior.alwaysShow;

  int currentPageIndex = 0;

  final secureManager = SecureManager();
  final apiHelper = APIHelper();
  final gravitasHelper = GravitasHelper();

  final List<Widget> _children = const [
    DashboardPage(),
    PlanetListPage(),
    ActivityPage(),
    CalendarPage(),
    ProfilePage()
  ];

  void onPageChanged(int index) {
    setState(() {
      pageController.jumpToPage(index);
      currentPageIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      gravitasHelper.detectLogin(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        labelBehavior: labelBehavior,
        selectedIndex: currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
            pageController.jumpToPage(index);
          });
        },
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.public),
            label: 'Planets',
          ),
          NavigationDestination(
            icon: Icon(Icons.directions_run),
            label: 'Activity',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_month),
            label: 'Calendar',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Profile',
          )
        ],
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              
            },
          )
        ],
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: const NeverScrollableScrollPhysics(),
        children: _children,
      ),
    );
  }
}
