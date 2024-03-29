import 'package:flutter/material.dart';
import 'package:hizliflutter/app_string.dart';
import 'package:hizliflutter/models/widget_model.dart';

class ListMethodPage extends StatefulWidget {
  List<WidgetMetod> metodlistem;

  ListMethodPage(List<WidgetMetod> liste) {
    this.metodlistem = liste;
  }

  @override
  _ListMethodPageState createState() => _ListMethodPageState(metodlistem);
}

class _ListMethodPageState extends State<ListMethodPage> {
  List<WidgetMetod> metodListe;

  TextEditingController _searchEdit = TextEditingController();

  bool _isSearch = true;
  String _searchText = "";

  List<String> _liste;
  List<String> _arananliste;

  _ListMethodPageState(List<WidgetMetod> liste) {
    this.metodListe = liste;

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
    _liste = [];
    for (int i = 0; i < metodListe.length; i++) {
      _liste.add(metodListe[i].name);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            child: Column(
          children: <Widget>[
            _metodSearch(),
            SizedBox(
              height: 8,
            ),
            _isSearch ? _metodlistView() : _metodsearchListView()
          ],
        )),
      ),
    );
  }

  Widget _metodSearch() {
    return Card(
      shadowColor: Colors.black,
      shape: OutlineInputBorder(
        borderSide: BorderSide(width: 3, color: Colors.grey[700]),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(38),
          topRight: Radius.circular(38),
        ),
      ),
      child: TextField(
        autofocus: false,
        controller: _searchEdit,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: AppString.featureSearch,
          hintStyle: TextStyle(color: Colors.grey[300]),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _metodlistView() {
    return Flexible(
      child: ListView.builder(
          itemCount: metodListe.length,
          itemBuilder: (context, int index) {
            return Card(
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 3, color: Colors.black),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(14),
                  topLeft: Radius.circular(14),
                ),
              ),
              child: ExpansionTile(
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(metodListe[index].name),
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: Text(
                    metodListe[index].type,
                    style: TextStyle(color: Colors.deepOrange),
                  )),
                ),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 6, right: 18, bottom: 10, left: 10),
                    child: Center(
                        child: Text(
                      metodListe[index].explanation,
                      style: TextStyle(backgroundColor: Colors.transparent),
                    )),
                  ),
                ],
              ),
            );
          }),
    );
  }

  Widget _metodsearchListView() {
    _arananliste = [];
    for (int i = 0; i < _liste.length; i++) {
      var item = _liste[i];

      if (item.toLowerCase().contains(_searchText.toLowerCase())) {
        _arananliste.add(item);
      }
    }
    return _metodsearchAddList();
  }

  Widget _metodsearchAddList() {
    return Flexible(
      child: ListView.builder(
          itemCount: _arananliste.length,
          itemBuilder: (context, int index) {
            return Card(
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 6, color: Colors.black),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28),
                  topRight: Radius.circular(28),
                ),
              ),
              child: ExpansionTile(
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                        metodListe[_liste.indexOf(_arananliste[index])].name),
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: Text(
                    metodListe[_liste.indexOf(_arananliste[index])].type,
                    style: TextStyle(color: Colors.deepOrange),
                  )),
                ),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Center(
                        child: Text(
                      metodListe[_liste.indexOf(_arananliste[index])]
                          .explanation,
                      style: TextStyle(backgroundColor: Colors.transparent),
                    )),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
