import 'dart:ui';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hizliflutter/controllers/widget_model_controller.dart';
import 'package:hizliflutter/services/functions.dart';
import '/app_string.dart';
import '/controllers/auth/auth_controller.dart';
import '/controllers/favorite_controller.dart';
import '/models/widget_model.dart';
import 'widget_code_detail_page.dart';
import 'dart:math';

class ListWidgetPage extends StatefulWidget {
  @override
  _ListWidgetPageState createState() => _ListWidgetPageState();
}

class _ListWidgetPageState extends State<ListWidgetPage> {
  final FavoriteController fetchController = Get.put(FavoriteController());
  final WidgetModelController widgetModelController =
      Get.put(WidgetModelController());
  AuthController authController = Get.put(AuthController());
  TextEditingController _searchEdit = TextEditingController();

  bool _isSearch = true;
  String _searchText = "";

  List<WidgetModel> _liste;
  List<WidgetModel> _arananliste;

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
        ],
      ),
      backgroundColor: Colors.white,
      body: GetBuilder<WidgetModelController>(
        initState: (_) {
          Get.find<WidgetModelController>().getWidgetsApi();
        },
        builder: (s) {
          return s.widgetList == null
              ? Center(
                  child: Text('Eklenmiş Widget Bulunmuyor !'),
                )
              : s.widgetList.length < 1 || s.widgetList.isEmpty
                  ? Functions.loadingView()
                  : Column(
                      children: [
                        _search(),
                        _isSearch ? _listView(s) : _searchListView(s)
                      ],
                    );
        },
      ),
    );
  }

  Widget _search() {
    return FadedScaleAnimation(
      child: Card(
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
      ),
    );
  }

  Widget _listView(WidgetModelController s) {
    return Expanded(
      child: ListView.builder(
          itemCount: s.widgetList.length,
          itemBuilder: (context, int index) {
            Widget cesit;
            switch (s.widgetList[index].kind) {
              case 'Layout':
                cesit = Text(
                  s.widgetList[index].kind,
                  style: TextStyle(
                    color: Colors.yellow[900].withOpacity(.7),
                  ),
                );
                break;
              case 'Widget':
                cesit = Text(
                  s.widgetList[index].kind,
                  style: TextStyle(
                    color: Colors.blue.withOpacity(.7),
                  ),
                );
                break;
              default:
                cesit = Text(
                  s.widgetList[index].kind,
                  style: TextStyle(
                    color: Color(
                      (Random().nextDouble() * 0xFFFFFF).toInt(),
                    ).withOpacity(1.0),
                  ),
                );
            }
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WidgetCodeDetailPage(
                      s.widgetList[index],
                    ),
                  ),
                );
              },
              child: FadedScaleAnimation(
                child: Container(
                  padding: EdgeInsets.all(8),
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
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(children: [
                              Container(
                                width: 45,
                                height: 45,
                                child: CircleAvatar(
                                  backgroundColor: Colors.blue,
                                  child: Text(
                                    s.widgetList[index].kind[0],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Flexible(
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Text(
                                          s.widgetList[index].name,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        s.widgetList[index].subTitle,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: TextStyle(
                                          color: Colors.grey[500],
                                        ),
                                      ),
                                    ]),
                              )
                            ]),
                          ),
                          GestureDetector(
                            onTap: () => fetchController.favWidget(
                                type: FavType.Widget, id: s.widgetList[index].id),
                            child: Obx(
                              () => AnimatedContainer(
                                  height: 35,
                                  padding: EdgeInsets.all(5),
                                  duration: Duration(milliseconds: 300),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: (fetchController.isFavWidgetList[
                                                    s.widgetList[index].id]) &&
                                                fetchController.isFavWidgetList[
                                                        s.widgetList[index].id] !=
                                                    null
                                            ? Colors.red.shade100
                                            : Colors.grey.shade300,
                                      )),
                                  child: Center(
                                      child: (fetchController.isFavWidgetList[
                                                  s.widgetList[index].id]) &&
                                              fetchController.isFavWidgetList[
                                                      s.widgetList[index].id] !=
                                                  null
                                          ? Icon(
                                              Icons.favorite,
                                              color: Colors.red,
                                            )
                                          : Icon(
                                              Icons.favorite_outline,
                                              color: Colors.grey.shade600,
                                            ))),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 15),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.grey.shade200),
                                  child: cesit,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                /* Container(
                                  padding:
                                  EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    'Level',
                                  ),
                                ),*/
                              ],
                            ),
                            Text(
                              Functions.convertToAgo(
                                  s.widgetList[index].createdAt),
                              style: TextStyle(
                                  color: Colors.grey.shade800, fontSize: 12),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  Widget _searchListView(WidgetModelController s) {
    _liste = <WidgetModel>[];
    for (int i = 0; i < s.widgetList.length; i++) {
      _liste.add(s.widgetList[i]);
    }

    _arananliste = <WidgetModel>[];
    for (int i = 0; i < _liste.length; i++) {
      var item = _liste[i];

      if (item.name.toLowerCase().contains(_searchText.toLowerCase())) {
        _arananliste.add(item);
      }
    }
    return _searchAddList(s);
  }

  Widget _searchAddList(WidgetModelController s) {
    return Expanded(
      child: ListView.builder(
          itemCount: _arananliste.length,
          itemBuilder: (context, int index) {
            Widget cesit;
            switch (s.widgetList[index].kind) {
              case 'Layout':
                cesit = Text(
                  s.widgetList[index].kind,
                  style: TextStyle(
                    color: Colors.yellow[900].withOpacity(.7),
                  ),
                );
                break;
              case 'Widget':
                cesit = Text(
                  s.widgetList[index].kind,
                  style: TextStyle(
                    color: Colors.blue.withOpacity(.7),
                  ),
                );
                break;
              default:
                cesit = Text(
                  s.widgetList[index].kind,
                  style: TextStyle(
                    color: Color(
                      (Random().nextDouble() * 0xFFFFFF).toInt(),
                    ).withOpacity(1.0),
                  ),
                );
            }
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WidgetCodeDetailPage(
                      s.widgetList[_liste.indexOf(_arananliste[index])],
                    ),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.all(8),
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
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(children: [
                            Container(
                              width: 45,
                              height: 45,
                              child: CircleAvatar(
                                backgroundColor: Colors.blue,
                                child: Text(
                                  s
                                      .widgetList[
                                          _liste.indexOf(_arananliste[index])]
                                      .kind[0],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Flexible(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Text(
                                        s
                                            .widgetList[_liste
                                                .indexOf(_arananliste[index])]
                                            .name,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      s
                                          .widgetList[_liste
                                              .indexOf(_arananliste[index])]
                                          .subTitle,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: TextStyle(
                                        color: Colors.grey[500],
                                      ),
                                    ),
                                  ]),
                            )
                          ]),
                        ),
                        GestureDetector(
                          onTap: () => fetchController.favWidget(
                              type: FavType.Widget, id: s.widgetList[index].id),
                          child: Obx(
                            () => AnimatedContainer(
                                height: 35,
                                padding: EdgeInsets.all(5),
                                duration: Duration(milliseconds: 300),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: (fetchController.isFavWidgetList[s
                                                  .widgetList[_liste.indexOf(
                                                      _arananliste[index])]
                                                  .id]) &&
                                              fetchController.isFavWidgetList[s
                                                      .widgetList[_liste
                                                          .indexOf(_arananliste[
                                                              index])]
                                                      .id] !=
                                                  null
                                          ? Colors.red.shade100
                                          : Colors.grey.shade300,
                                    )),
                                child: Center(
                                    child: (fetchController.isFavWidgetList[s
                                                .widgetList[_liste.indexOf(
                                                    _arananliste[index])]
                                                .id]) &&
                                            fetchController.isFavWidgetList[s
                                                    .widgetList[_liste.indexOf(
                                                        _arananliste[index])]
                                                    .id] !=
                                                null
                                        ? Icon(
                                            Icons.favorite,
                                            color: Colors.red,
                                          )
                                        : Icon(
                                            Icons.favorite_outline,
                                            color: Colors.grey.shade600,
                                          ))),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 15),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.grey.shade200),
                                child: cesit,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              /* Container(
                                padding:
                                EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  'Level',
                                ),
                              ),*/
                            ],
                          ),
                          Text(
                            Functions.convertToAgo(s
                                .widgetList[_liste.indexOf(_arananliste[index])]
                                .createdAt),
                            style: TextStyle(
                                color: Colors.grey.shade800, fontSize: 12),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
