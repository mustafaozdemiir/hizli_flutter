import '/models/main_model.dart';

class Comment extends MainModel {
  int _id;
  int _userId;
  String _userName;
  int _postId;
  String _content;
  int _numberOfLikes;
  DateTime _createdAt;
  DateTime _updatedAt;

  Comment({
    int id,
    int userId,
    String userName,
    int postId,
    String content,
    int numberOfLikes,
    DateTime createdAt,
    DateTime updatedAt,
  }) {
    this._id = id;
    this._userId = userId;
    this._userName = userName;
    this._postId = postId;
    this._content = content;
    this._numberOfLikes = numberOfLikes;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
  }


  int get id => _id;

  set id(int value) {
    _id = value;
  }

  DateTime get updatedAt => _updatedAt;

  set updatedAt(DateTime value) {
    _updatedAt = value;
  }

  DateTime get createdAt => _createdAt;

  set createdAt(DateTime value) {
    _createdAt = value;
  }

  int get numberOfLikes => _numberOfLikes;

  set numberOfLikes(int value) {
    _numberOfLikes = value;
  }

  String get content => _content;

  set content(String value) {
    _content = value;
  }

  int get postId => _postId;

  set postId(int value) {
    _postId = value;
  }

  String get userName => _userName;

  set userName(String value) {
    _userName = value;
  }

  int get userId => _userId;

  set userId(int value) {
    _userId = value;
  }


  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: int.tryParse(json['id']),
      userId: int.tryParse(json['userId']),
      userName: json['userName'],
      postId: int.tryParse(json['postId']),
      content: json['content'],
      numberOfLikes: int.tryParse(json['numberOfLikes']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  @override
  Map<String, dynamic> toJson() => {
    'userId': userId,
    'userName': userName,
    'postId': postId,
    'content': content,
    'numberOfLikes': numberOfLikes,
  };
}





