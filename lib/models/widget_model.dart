class WidgetMetod {
  int _id;
  String _name;
  String _explanation;
  String _type;

  WidgetMetod({int id, String name, String explanation, String type}) {
    this._id = id;
    this._name = name;
    this._explanation = explanation;
    this._type = type;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get type => _type;

  set type(String value) {
    _type = value;
  }

  String get explanation => _explanation;

  set explanation(String value) {
    _explanation = value;
  }

  factory WidgetMetod.fromJson(Map<String, dynamic> json) => WidgetMetod(
        id: int.parse(json['id']),
        name: json['name'],
        explanation: json['explanation'],
        type: json['type'],
      );
}

class WidgetModel {
  int _id;
  String _name;
  String _subTitle;
  String _title;
  String _path;
  String _type;
  String _kind;
  List<WidgetMetod> _methods;

  WidgetModel({
    int id,
    String name,
    String subTitle,
    String title,
    String path,
    String type,
    String kind,
    List<WidgetMetod> methods,
  }) {
    this._id = id;
    this._name = name;
    this._subTitle = subTitle;
    this._title = title;
    this._path = path;
    this._type = type;
    this._kind = kind;
    this._methods = methods;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get subTitle => _subTitle;

  set subTitle(String value) {
    _subTitle = value;
  }

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  List<WidgetMetod> get methods => _methods;

  set methods(List<WidgetMetod> value) {
    _methods = value;
  }

  String get path => _path;

  set path(String value) {
    _path = value;
  }

  String get type => _type;

  set type(String value) {
    _type = value;
  }

  String get kind => _kind;

  set kind(String value) {
    _kind = value;
  }

  factory WidgetModel.fromJson(Map<String, dynamic> json) {
    var list = json['methods'] as List;
    List<WidgetMetod> metodList =
        list.map((e) => WidgetMetod.fromJson(e)).toList();
    return WidgetModel(
        name: json['name'].toString().replaceAll("/n", "\n"),
        subTitle: json['subTitle'],
        title: json['title'],
        path: json['path'],
        type: json['type'],
        kind: json['kind'],
        methods: metodList);
  }
}
