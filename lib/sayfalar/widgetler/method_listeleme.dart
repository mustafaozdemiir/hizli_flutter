import 'package:flutter/material.dart';
import 'package:hizliflutter/modeller/widget_model.dart';

class MethodListeleme extends StatefulWidget {
  List<WidgetMetod> metodlistem;

  MethodListeleme(List<WidgetMetod> liste) {
    this.metodlistem = liste;
  }

  @override
  _MethodListelemeState createState() => _MethodListelemeState(metodlistem);
}

class _MethodListelemeState extends State<MethodListeleme> {
  List<WidgetMetod> metodListe;

  TextEditingController _searchEdit = TextEditingController();

  bool _isSearch = true;
  String _searchText = "";

  List<String> _liste;
  List<String> _arananliste;

  _MethodListelemeState(List<WidgetMetod> liste) {
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
     _liste =  List<String>();
    for (int i = 0; i < metodListe.length; i++) {
        _liste.add(metodListe[i].adi);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            child: Column(
              children: <Widget>[
                _metodarama(),
                SizedBox(
              height: 8,
            ),
            _isSearch ? _metodlistView() : _metodsearchListView()
              ],
            )
        ),
      ),
    );
  }

  Widget _metodarama() {
    return  Card(
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
          hintText: "Özellik Ara...",
          hintStyle:  TextStyle(color: Colors.grey[300]),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _metodlistView() {
    return  Flexible(
      child:  ListView.builder(
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
                    child: Text(metodListe[index].adi),
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: Text(
                        metodListe[index].turu,
                        style: TextStyle(color: Colors.deepOrange),
                      )),
                ),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 6,right: 18,bottom: 10,left: 10),
                    child: Center(
                        child: Text(
                          metodListe[index].aciklama,
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
    _arananliste =  List<String>();
    for (int i = 0; i < _liste.length; i++) {
      var item = _liste[i];

      if (item.toLowerCase().contains(_searchText.toLowerCase())) {
        _arananliste.add(item);
      }
    }
    return _metodsearchAddList();
  }

  Widget _metodsearchAddList() {
    return  Flexible(
      child:  ListView.builder(
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
                    child: Text(metodListe[_liste.indexOf(_arananliste[index])].adi),
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: Text(
                        metodListe[_liste.indexOf(_arananliste[index])].turu,
                        style: TextStyle(color: Colors.deepOrange),
                      )),
                ),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Center(
                        child: Text(
                          metodListe[_liste.indexOf(_arananliste[index])].aciklama,
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
