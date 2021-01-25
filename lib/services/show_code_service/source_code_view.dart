import 'dart:math';
import 'package:animated_floatactionbuttons/animated_floatactionbuttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;
import 'syntax_highlighter.dart';

class SourceCodeView extends StatefulWidget {
  final String filePath;
  final String codeLinkPrefix;

  const SourceCodeView({Key key, @required this.filePath, this.codeLinkPrefix})
      : super(key: key);

  String get codeLink => this.codeLinkPrefix == null
      ? null
      : '${this.codeLinkPrefix}';

  @override
  _SourceCodeViewState createState() {
    return _SourceCodeViewState();
  }
}

class _SourceCodeViewState extends State<SourceCodeView> {
  double _textScaleFactor = 1.0;

  Widget _getCodeView(String codeContent, BuildContext context) {
    codeContent = codeContent.replaceAll('\r\n', '\n');
    final SyntaxHighlighterStyle style =
        Theme.of(context).brightness == Brightness.dark
            ? SyntaxHighlighterStyle.darkThemeStyle()
            : SyntaxHighlighterStyle.lightThemeStyle();
    return Container(
      constraints: BoxConstraints.expand(),
      child: Scrollbar(
        child: SingleChildScrollView(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SelectableText.rich(
              TextSpan(
                style: TextStyle(fontFamily: 'monospace', fontSize: 12.0)
                    .apply(fontSizeFactor: this._textScaleFactor),
                children: <TextSpan>[
                  DartSyntaxHighlighter(style).format(codeContent)
                ],
              ),
              style: DefaultTextStyle.of(context)
                  .style
                  .apply(fontSizeFactor: this._textScaleFactor),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildFloatingButtons() {
    return <Widget>[
      if (this.widget.codeLink != null)
        FloatingActionButton(
          heroTag: null,
          child: Icon(Icons.content_copy),
          tooltip: 'Kod linki kopyalandı!',
          onPressed: () {
            Clipboard.setData(ClipboardData(text: this.widget.codeLink));
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text('Kod kopyalandı!'),
            ));
          },
        ),
      if (this.widget.codeLink != null)
        FloatingActionButton(
          heroTag: null,
          child: Icon(Icons.open_in_new),
          tooltip: 'Tarayıcıda Göster',
          onPressed: () => url_launcher.launch(this.widget.codeLink),
        ),
      FloatingActionButton(
        heroTag: null,
        child: Icon(Icons.zoom_out),
        tooltip: 'Uzaklaştır',
        onPressed: () => setState(() {
          this._textScaleFactor = max(0.8, this._textScaleFactor - 0.1);
        }),
      ),
      FloatingActionButton(
        heroTag: null,
        child: Icon(Icons.zoom_in),
        tooltip: 'Yakınlaştır',
        onPressed: () => setState(() {
          this._textScaleFactor += 0.1;
        }),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DefaultAssetBundle.of(context).loadString(widget.filePath) ??
          'Yüklenirken Hata Oluştu Dizin:  $this.filePath',
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            body: Padding(
              padding: EdgeInsets.all(4.0),
              child: _getCodeView(snapshot.data, context),
            ),
            floatingActionButton: AnimatedFloatingActionButton(
              fabButtons: _buildFloatingButtons(),
              colorStartAnimation: Colors.black,
              colorEndAnimation: Colors.grey,
              animatedIconData: AnimatedIcons.menu_close,
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
