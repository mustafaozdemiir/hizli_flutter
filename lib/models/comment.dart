import '/models/main_model.dart';

class Comment extends MainModel {
  int? _id;
  int? _userId;
  String? _userName;
  int? _postId;
  String? _content;
  int? _numberOfLikes;
  DateTime? _createdAt;
  DateTime? _updatedAt;

  Comment({
    int? id,
    int? userId,
    String? userName,
    int? postId,
    String? content,
    int? numberOfLikes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    _id = id;
    _userId = userId;
    _userName = userName;
    _postId = postId;
    _content = content;
    _numberOfLikes = numberOfLikes;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  int? get id => _id;

  set id(int? value) {
    _id = value;
  }

  DateTime? get updatedAt => _updatedAt;

  set updatedAt(DateTime? value) {
    _updatedAt = value;
  }

  DateTime? get createdAt => _createdAt;

  set createdAt(DateTime? value) {
    _createdAt = value;
  }

  int? get numberOfLikes => _numberOfLikes;

  set numberOfLikes(int? value) {
    _numberOfLikes = value;
  }

  String? get content => _content;

  set content(String? value) {
    _content = value;
  }

  int? get postId => _postId;

  set postId(int? value) {
    _postId = value;
  }

  String? get userName => _userName;

  set userName(String? value) {
    _userName = value;
  }

  int? get userId => _userId;

  set userId(int? value) {
    _userId = value;
  }

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'] != null
          ? (json['id'] is int
              ? json['id'] as int
              : int.tryParse(json['id'].toString()))
          : null,
      userId: json['userId'] != null
          ? (json['userId'] is int
              ? json['userId'] as int
              : int.tryParse(json['userId'].toString()))
          : null,
      userName: json['userName'],
      postId: json['postId'] != null
          ? (json['postId'] is int
              ? json['postId'] as int
              : int.tryParse(json['postId'].toString()))
          : null,
      content: json['content'],
      numberOfLikes: json['numberOfLikes'] != null
          ? (json['numberOfLikes'] is int
              ? json['numberOfLikes'] as int
              : int.tryParse(json['numberOfLikes'].toString()))
          : null,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'].toString())
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'].toString())
          : null,
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'id': id?.toString(),
        'userId': userId?.toString(),
        'userName': userName,
        'postId': postId?.toString(),
        'content': content,
        'numberOfLikes': numberOfLikes?.toString(),
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
}
