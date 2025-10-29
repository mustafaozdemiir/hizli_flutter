import 'package:flutter/material.dart';

class PageViewKod extends StatefulWidget {
  @override
  _PageViewKodState createState() => _PageViewKodState();
}

class _PageViewKodState extends State<PageViewKod> {
  PageController _controller = PageController(
    initialPage: 0,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      scrollDirection: Axis.vertical,
      controller: _controller,
      children: [
        PageSayfa1(),
        PageSayfa2(),
        PageSayfa3(),
      ],
    );
  }
}

class PageSayfa1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Sayfa 1"),
          Icon(Icons.arrow_downward),
        ],
      ),
    );
  }
}

class PageSayfa2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.arrow_upward),
          Text("Sayfa 2"),
          Icon(Icons.arrow_downward),
        ],
      ),
    );
  }
}

class PageSayfa3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.arrow_upward),
          Text("Sayfa 3"),
        ],
      ),
    );
  }
}
