import 'dart:io';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'sayfalar/haber/flutter_haber.dart';
import 'sayfalar/ornekler/ornekler.dart';
import 'sayfalar/sorular/flutter_soru.dart';
import 'sayfalar/widgetler/widget_listeleme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hızlı Flutter',
      theme: ThemeData(primarySwatch: Colors.lightBlue),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseMessaging _fcm = FirebaseMessaging();

  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
  List<Widget> _sayfalar = [
    WidgetListeleme(),
    FlutterHaber(),
    FlutterSoru(),
    Ornekler(),
  ];

  @override
  void initState() {
    super.initState();
    /*  if (Platform.isIOS) {
      iosSubscription = _fcm.onIosSettingsRegistered.listen((data) {
        // save the token  OR subscribe to a topic here
      });*/
    bool kisweb;
    try{
      if(Platform.isAndroid||Platform.isIOS) {
        kisweb=false;
      } else {
        kisweb=true;
      }
    } catch(e){
      kisweb=true;
    }

    if(!kisweb){

      _fcm.requestNotificationPermissions(IosNotificationSettings());

      _fcm.configure(
        onMessage: (Map<String, dynamic> message) async {
          print("onMessage: $message");
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
                  child: Text('Tamam'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          );
        },
        onLaunch: (Map<String, dynamic> message) async {
          print("onLaunch: $message");
          // TODO optional
        },
        onResume: (Map<String, dynamic> message) async {
          print("onResume: $message");
          // TODO optional
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 0,
          height: 60.0,
          items: <Widget>[
            Icon(
              Icons.widgets,
              size: 35,
              color: Colors.white,
            ),
            Icon(
              Icons.assignment,
              size: 35,
              color: Colors.white,
            ),
            Icon(
              Icons.assignment_turned_in,
              size: 35,
              color: Colors.white,
            ),
            Icon(
              Icons.phone_android,
              size: 35,
              color: Colors.white,
            ),
          ],
          color: Colors.lightBlue,
          buttonBackgroundColor: Colors.lightBlue,
          backgroundColor: Colors.white,
          animationCurve: Curves.fastOutSlowIn,
          animationDuration: Duration(milliseconds: 300),
          onTap: (index) {
            setState(() {
              _page = index;
            });
          },
        ),
        body: _sayfalar[_page]);
  }
}
