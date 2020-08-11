import 'package:flutter/material.dart';

import 'kod_pageview.dart';

class WidgetOrnekler {
  static Widget ornekgetir(String ornek) {
    switch (ornek) {
      case "Text":
        return Text("Metin");
        break;

      case "Icon":
        return Icon(Icons.account_box);
        break;

      case "AppBar":
        return AppBar(
          backgroundColor: Colors.blue,
          title: Text("Başlık"),
          leading: Icon(Icons.label_important),
        );
        break;

      case "Container":
        return Container(
          color: Colors.amber,
          height: 100,
          width: 100,
        );
        break;

      case "Column":
        return Column(
          children: <Widget>[
            Icon(Icons.looks_one),
            Icon(Icons.looks_two),
            Icon(Icons.looks_3),
          ],
        );
        break;

      case "Row":
        return Row(
          children: <Widget>[
            Icon(Icons.looks_one),
            Icon(Icons.looks_two),
            Icon(Icons.looks_3),
          ],
        );
        break;

      case "RaisedButton":
        return RaisedButton(
          onPressed: () {
            debugPrint("Butona Tıklanıldı!");
          },
          color: Colors.blue,
          child: Text("Buton "),
        );
        break;

      case "Scrollbar":
        return Scrollbar(
          child: ListView.builder(
            itemCount: 100,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text("Widget " + (index + 1).toString()),
              );
            },
          ),
        );
        break;

      case "Placeholder":
        return Container(
          width: 200,
          height: 200,
          color: Colors.white,
          child: Placeholder(
            color: Colors.blue[50],
          ),
        );
        break;

      case "RefreshIndicator":
        return RefreshIndicator(
          onRefresh: () async {
            return await Future.delayed(Duration(seconds: 3));
          },
          child: ListView(
            padding: const EdgeInsets.all(8.0),
            children: <Widget>[
              Container(
                height: 50,
                color: Colors.amber[600],
                child: const Center(child: Text('Hızlı')),
              ),
              Container(
                height: 50,
                color: Colors.amber[500],
                child: const Center(child: Text('Daha Hızlı')),
              ),
              Container(
                height: 50,
                color: Colors.amber[100],
                child: const Center(child: Text('Hızlı Flutter')),
              ),
            ],
          ),
        );
        break;

      case "Scaffold":
        return Scaffold(
          appBar: AppBar(
            title: Text("Scaffold Appbar"),
          ),
          body: Text("Scaffold body"),
          backgroundColor: Colors.green,
          bottomNavigationBar: Text("Bottom Navigation Bar"),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: Icon(
              Icons.add,
              semanticLabel: "Floating Action Button",
            ),
          ),
        );
        break;

      case "NestedScrollView":
        List<String> _tabs = ['One', 'Two', 'Three'];
        return DefaultTabController(
          length: _tabs.length,
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              // These are the slivers that show up in the "outer" scroll view.
              return <Widget>[
                SliverOverlapAbsorber(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: SliverAppBar(
                    title: const Text('Kitaplar'),
                    // This is the title in the app bar.
                    pinned: true,
                    expandedHeight: 150.0,

                    forceElevated: innerBoxIsScrolled,
                    bottom: TabBar(
                      // These are the widgets to put in each tab in the tab bar.
                      tabs:
                          _tabs.map((String name) => Tab(text: name)).toList(),
                    ),
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: _tabs.map((String name) {
                return SafeArea(
                  top: false,
                  bottom: false,
                  child: Builder(
                    builder: (BuildContext context) {
                      return CustomScrollView(
                        key: PageStorageKey<String>(name),
                        slivers: <Widget>[
                          SliverOverlapInjector(
                            handle:
                                NestedScrollView.sliverOverlapAbsorberHandleFor(
                                    context),
                          ),
                          SliverPadding(
                            padding: const EdgeInsets.all(8.0),
                            sliver: SliverFixedExtentList(
                              itemExtent: 48.0,
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  // This builder is called for each child.
                                  // In this example, we just number each list item.
                                  return ListTile(
                                    title: Text('Kitap $index'),
                                  );
                                },
                                childCount: 30,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                );
              }).toList(),
            ),
          ),
        );
        break;

      case "SingleChildScrollView":
        return SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                FlutterLogo(
                  size: 190,
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(),
                SizedBox(
                  height: 15,
                ),
                TextFormField(),
                SizedBox(
                  height: 15,
                ),
                MaterialButton(
                  onPressed: () {},
                  color: Colors.red,
                  minWidth: 160,
                  child: Text(
                    'Google',
                  ),
                ),
                MaterialButton(
                  onPressed: () {},
                  color: Colors.blue,
                  minWidth: 160,
                  child: Text(
                    'Facebook',
                  ),
                ),
                MaterialButton(
                  onPressed: () {},
                  color: Colors.orange,
                  minWidth: 160,
                  child: Text(
                    'E-mail',
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                FlutterLogo(
                  size: 190,
                ),
              ],
            ),
          ),
        );
        break;

      case "PageView":
        PageController _controller = PageController(
          initialPage: 0,
        );
        return PageView(
          scrollDirection: Axis.vertical,
          controller: _controller,
          children: [
            PageSayfa1(),
            PageSayfa2(),
            PageSayfa3(),
          ],
        );
        break;
      default:
        return Text("Örnek İçin Diğer Güncellemeyi Bekleyiniz...");
        break;
    }
  }
}
