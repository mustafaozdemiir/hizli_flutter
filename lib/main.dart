import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'app_string.dart';
import 'pages/news//news_page.dart';
import 'pages/post/post_page.dart';
import 'pages/sample//samples.dart';
import 'pages/question//questions_page.dart';
import 'pages/splash_page.dart';
import 'pages/widgets//list_widget_page.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppString.appTitle,
      theme: ThemeData(
          primarySwatch: Colors.lightBlue,
          textTheme: GoogleFonts.alatsiTextTheme(
            Theme.of(context).textTheme,
          )),
      home: SafeArea(
        child: SplashPage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  static int page = 0;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseMessaging _fcm = FirebaseMessaging();
  List<Widget> _pages = [
    ListWidgetPage(),
    NewsPage(),
    PostPage(),
    QuestionsPage(),
    Samples(),
  ];

  @override
  void initState() {
    super.initState();
    /*  if (Platform.isIOS) {
      iosSubscription = _fcm.onIosSettingsRegistered.listen((data) {
        // save the token  OR subscribe to a topic here
      });*/
    bool kisweb;
    try {
      if (Platform.isAndroid || Platform.isIOS) {
        kisweb = false;
      } else {
        kisweb = true;
      }
    } catch (e) {
      kisweb = true;
    }

    if (!kisweb) {
      _fcm.requestNotificationPermissions(IosNotificationSettings());
      _fcm.configure(
        onMessage: (Map<String, dynamic> message) async {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(message['notification']['title']),
              content: ListTile(
                title: Text(message['notification']['body']),
                //subtitle: Text(message['notification']['body']),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text(AppString.ok),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          );
        },
        onLaunch: (Map<String, dynamic> message) async {},
        onResume: (Map<String, dynamic> message) async {},
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: Container(
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(blurRadius: 20, color: Colors.white.withOpacity(.1))
          ]),
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
              child: GNav(
                  gap: 8,
                  activeColor: Colors.white,
                  iconSize: 20,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  duration: Duration(milliseconds: 800),
                  tabBackgroundColor: Colors.black,
                  tabs: buildTab(),
                  selectedIndex: MyHomePage.page,
                  onTabChange: (index) {
                    setState(() {
                      MyHomePage.page = index;
                    });
                  }),
            ),
          ),
        ),
        body: _pages[MyHomePage.page]);
  }

  List<GButton> buildTab() {
    List<GButton> tabs = [
      GButton(
        icon: Icons.apps,
        text: AppString.widget,
      ),
      GButton(
        icon: Icons.library_books,
        text: AppString.news,
      ),
      GButton(
        icon: FlutterIcons.post_mco,
        text: AppString.post,
      ),
      GButton(
        icon: Icons.question_answer,
        text: AppString.answer,
      ),
      GButton(
        icon: Icons.app_registration,
        text: AppString.examples,
      ),
    ];
    return tabs;
  }
}
