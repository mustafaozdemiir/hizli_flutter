import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:hizliflutter/app_string.dart';
import 'package:hizliflutter/controllers/auth_controller.dart';
import 'package:hizliflutter/controllers/fetch_controller.dart';
import 'widget_code_detail_page.dart';
import 'dart:math';

class ListWidgetPage extends StatefulWidget {
  @override
  _ListWidgetPageState createState() => _ListWidgetPageState();
}

class _ListWidgetPageState extends State<ListWidgetPage> {
  final FetchController fetchController = Get.put(FetchController());
  AuthController authController = Get.put(AuthController());

  TextEditingController _searchEdit = TextEditingController();

  bool _isSearch = true;
  String _searchText = "";

  List<String> _liste;
  List<String> _arananliste;

  _ListWidgetPageState() {
    _searchEdit.addListener(() {
      if (_searchEdit.text.isEmpty) {
        setState(() {
          _isSearch = true;
          _searchText = "";
        });
      } else {
        setState(() {
          _isSearch = false;
          _searchText = _searchEdit.text;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _searchEdit.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(AppString.widget),
          actions: [
            IconButton(
              icon: Icon(
                Icons.logout,
                color: Colors.red,
              ),
              onPressed: () => authController.logout(),
            ),
          ]),
      backgroundColor: Colors.white,
      body: GetBuilder<FetchController>(
        initState: (_) => Get.find<FetchController>().getWidgetsApi(),
        builder: (s) {
          return s.widgetListe.length < 1
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    _arama(),
                    _isSearch ? _listView(s) : _searchListView(s)
                  ],
                );
        },
      ),
    );
  }

  Widget _arama() {
    return Card(
      shadowColor: Colors.black,
      shape: OutlineInputBorder(
        borderSide: BorderSide(width: 3, color: Colors.grey[700]),
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(38),
          topLeft: Radius.circular(38),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          autofocus: false,
          controller: _searchEdit,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Widget Ara...",
            hintStyle: TextStyle(color: Colors.grey[300]),
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _listView(FetchController s) {
    return Expanded(
      child: ListView.builder(
          itemCount: s.widgetListe.length,
          itemBuilder: (context, int index) {
            String messageBanner;
            Color bannerColor;
            Color bannerTextColor;
            Widget cesit;

            switch (s.widgetListe[index].type) {
              case 'basit':
                messageBanner = AppString.easy;
                bannerColor = Colors.green.withOpacity(.4);
                bannerTextColor = Colors.white;
                break;
              case 'orta':
                messageBanner = AppString.middle;
                bannerColor = Colors.yellow.withOpacity(.7);
                bannerTextColor = Colors.black;
                break;
              case 'zor':
                messageBanner = AppString.hard;
                bannerColor = Colors.red.withOpacity(.5);
                bannerTextColor = Colors.white;
                break;
            }

            switch (s.widgetListe[index].kind) {
              case 'Layout':
                cesit = Text(
                  s.widgetListe[index].kind,
                  style: TextStyle(color: Colors.yellow[900].withOpacity(.7)),
                );
                break;
              case 'Widget':
                cesit = Text(
                  s.widgetListe[index].kind,
                  style: TextStyle(color: Colors.blue.withOpacity(.7)),
                );
                break;
              default:
                cesit = Text(
                  s.widgetListe[index].kind,
                  style: TextStyle(
                      color: Color((Random().nextDouble() * 0xFFFFFF).toInt())
                          .withOpacity(1.0)),
                );
            }

            return Container(
              margin: EdgeInsets.all(8),
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 3, color: Colors.black),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(14),
                    topRight: Radius.circular(14),
                  ),
                ),
              ),
              child: ListTile(
                leading: Container(width: Get.width * 0.12, child: cesit),
                trailing: Container(
                  width: Get.width * 0.12,
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          Positioned(
                            child: IconButton(
                              onPressed: () => likeWidget(),
                              icon: Icon(
                                FlutterIcons.favorite_border_mdi,
                                color: Colors.blue,
                                size: 35,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          WidgetCodeDetailPage(s.widgetListe[index]),
                    ),
                  );
                },
                title: Center(
                  child: Text(
                    s.widgetListe[index].name,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                subtitle: Center(
                  child: Container(
                    width: Get.width * 0.88,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        s.widgetListe[index].subTitle,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            );
            /* return Banner(
              message: messageBanner,
              location: BannerLocation.topStart,
              color: bannerColor,
              textStyle: TextStyle(color: bannerTextColor),
              child: Card(
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 3, color: Colors.black),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(14),
                    topRight: Radius.circular(14),
                  ),
                ),
                child: Column(
                  children: [
                    ListTile(
                      trailing: cesit,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                WidgetCodeDetailPage(s.widgetListe[index]),
                          ),
                        );
                      },
                      title: Center(
                        child: Text(
                          s.widgetListe[index].name,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      subtitle: Center(
                        child: Container(
                          width: Get.width * 0.65,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              s.widgetListe[index].subTitle,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Text('18'),
                            IconButton(
                              onPressed: () => likeWidget(),
                              icon: Icon(
                                FlutterIcons.like1_ant,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                        /*  IconButton(
                          onPressed: () => comment(),
                          icon: Icon(
                            FlutterIcons.comment_dots_faw5s,
                            color: Colors.blue,
                          ),
                        ),*/
                        Row(
                          children: [
                            Text('25'),
                            IconButton(
                              onPressed: () => dislikeWidget(),
                              icon: Icon(
                                FlutterIcons.dislike1_ant,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ); */
          }),
    );
  }

  Widget _searchListView(FetchController s) {
    _liste = List<String>();
    for (int i = 0; i < s.widgetListe.length; i++) {
      _liste.add(s.widgetListe[i].name);
    }

    _arananliste = List<String>();
    for (int i = 0; i < _liste.length; i++) {
      var item = _liste[i];

      if (item.toLowerCase().contains(_searchText.toLowerCase())) {
        _arananliste.add(item);
      }
    }
    return _searchAddList(s);
  }

  Widget _searchAddList(FetchController s) {
    return Flexible(
      child: ListView.builder(
          itemCount: _arananliste.length,
          itemBuilder: (context, int index) {
            String messageBanner;
            Color bannerColor;
            Color bannerTextColor;
            Widget cesit;

            switch (s.widgetListe[index].type) {
              case 'basit':
                messageBanner = AppString.easy;
                bannerColor = Colors.green.withOpacity(.4);
                bannerTextColor = Colors.white;
                break;
              case 'orta':
                messageBanner = AppString.middle;
                bannerColor = Colors.yellow.withOpacity(.7);
                bannerTextColor = Colors.black;
                break;
              case 'zor':
                messageBanner = AppString.hard;
                bannerColor = Colors.red.withOpacity(.5);
                bannerTextColor = Colors.white;
                break;
            }
            switch (s.widgetListe[index].kind) {
              case 'Layout':
                cesit = Text(
                  s.widgetListe[index].kind,
                  style: TextStyle(color: Colors.yellow[900]),
                );
                break;
              case 'Widget':
                cesit = Text(
                  s.widgetListe[index].kind,
                  style: TextStyle(color: Colors.blue),
                );
                break;
              default:
                cesit = Text(
                  s.widgetListe[index].kind,
                  style: TextStyle(
                      color: Color((Random().nextDouble() * 0xFFFFFF).toInt())
                          .withOpacity(1.0)),
                );
            }
            return Banner(
              message: messageBanner,
              location: BannerLocation.topStart,
              color: bannerColor,
              textStyle: TextStyle(color: bannerTextColor),
              child: Card(
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 6, color: Colors.black),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(28),
                    topRight: Radius.circular(28),
                  ),
                ),
                child: ListTile(
                  trailing: cesit,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WidgetCodeDetailPage(
                            s.widgetListe[_liste.indexOf(_arananliste[index])]),
                      ),
                    );
                  },
                  title: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(s
                          .widgetListe[_liste.indexOf(_arananliste[index])]
                          .name),
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(s
                          .widgetListe[_liste.indexOf(_arananliste[index])]
                          .subTitle),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  likeWidget() {}

  comment() {}
}
