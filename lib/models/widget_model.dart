import 'package:hizliflutter/models/main_model.dart';

class WidgetMetod extends MainModel {
  late final int _id;
  late final String _name;
  late final String _explanation;
  late final String _type;

  WidgetMetod({
    required int id,
    required String name,
    required String explanation,
    required String type,
  }) {
    _id = id;
    _name = name;
    _explanation = explanation;
    _type = type;
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
    id: int.tryParse(json['id'].toString()) ?? 0,
    name: json['name'] ?? '',
    explanation: json['explanation'] ?? '',
    type: json['type'] ?? '',
  );

  @override
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'explanation': explanation,
    'type': type,
  };
}

class WidgetModel extends MainModel {
  late final int _id;
  late final String _name;
  late final String _subTitle;
  late final String _title;
  late final String _path;
  late final String _type;
  late final String _kind;
  late final List<WidgetMetod> _methods;
  late final DateTime _createdAt;
  late final DateTime _updatedAt;

  WidgetModel({
    required int id,
    required String name,
    required String subTitle,
    required String title,
    required String path,
    required String type,
    required String kind,
    required List<WidgetMetod> methods,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) {
    _id = id;
    _name = name;
    _subTitle = subTitle;
    _title = title;
    _path = path;
    _type = type;
    _kind = kind;
    _methods = methods;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
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

  DateTime get updatedAt => _updatedAt;

  set updatedAt(DateTime value) {
    _updatedAt = value;
  }

  DateTime get createdAt => _createdAt;

  set createdAt(DateTime value) {
    _createdAt = value;
  }

  factory WidgetModel.fromJson(Map<String, dynamic> json) {
    var list = json['methods'] as List<dynamic>;
    List<WidgetMetod> metodList =
    list.map((e) => WidgetMetod.fromJson(e as Map<String, dynamic>)).toList();
    return WidgetModel(
      id: int.tryParse(json['id'].toString()) ?? 0,
      name: json['name']?.toString().replaceAll("/n", "\n") ?? '',
      subTitle: json['subTitle'] ?? '',
      title: json['title'] ?? '',
      path: json['path'] ?? '',
      type: json['type'] ?? '',
      kind: json['kind'] ?? '',
      methods: metodList,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  @override
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'subTitle': subTitle,
    'title': title,
    'path': path,
    'type': type,
    'kind': kind,
    'methods': methods.map((e) => e.toJson()).toList(),
    'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
  };
}
