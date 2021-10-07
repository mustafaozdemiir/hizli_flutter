import '/models/comment.dart';
import 'main_model.dart';

class Post extends MainModel{
  int _id;
  String _heading;
  String _content;
  String _type;
  int _userId;
  String _userName;
  List<Comment> _comments;
  int _numberOfLikes;
  int _numberOfComment;
  DateTime _createdAt;
  DateTime _updatedAt;

  Post({
    int id,
    String heading,
    String content,
    String type,
    int userId,
    String userName,
    List<Comment> comments,
    int numberOfLikes,
    int numberOfComment,
    DateTime createdAt,
    DateTime updatedAt,
  }) {
    this._id = id;
    this._heading = heading;
    this._content = content;
    this._type = type;
    this._userId = userId;
    this._userName = userName;
    this._comments = comments;
    this._numberOfLikes = numberOfLikes;
    this._numberOfComment = numberOfComment;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
  }

  DateTime get updatedAt => _updatedAt;

  set updatedAt(DateTime value) {
    _updatedAt = value;
  }

  DateTime get createdAt => _createdAt;

  set createdAt(DateTime value) {
    _createdAt = value;
  }

  int get numberOfComment => _numberOfComment;

  set numberOfComment(int value) {
    _numberOfComment = value;
  }

  int get numberOfLikes => _numberOfLikes;

  set numberOfLikes(int value) {
    _numberOfLikes = value;
  }

  List<Comment> get comments => _comments;

  set comments(List<Comment> value) {
    _comments = value;
  }

  String get userName => _userName;

  set userName(String value) {
    _userName = value;
  }

  int get userId => _userId;

  set userId(int value) {
    _userId = value;
  }

  String get type => _type;

  set type(String value) {
    _type = value;
  }

  String get content => _content;

  set content(String value) {
    _content = value;
  }

  String get heading => _heading;

  set heading(String value) {
    _heading = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

 

  factory Post.fromJson(Map<String, dynamic> json) {
    var list = json['comments'] as List;
    List<Comment> commentList = list.map((e) => Comment.fromJson(e)).toList();
    commentList=commentList.reversed.toList();
    return Post(
      id: int.tryParse(json['id']),
      heading: json['heading'],
      content: json['content'],
      type: json['type'],
      userId: int.tryParse(json['userId']),
      userName: json['userName'],
      comments: commentList,
      numberOfLikes: int.tryParse(json['numberOfLikes']),
      numberOfComment: int.tryParse(json['numberOfComment']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  @override
  Map<String, dynamic> toJson() => {
    'heading': heading,
    'content': content,
    'type': type,
    'userId': userId,
    'userName': userName,
    'numberOfLikes': numberOfLikes,
    'numberOfComment': numberOfComment,
  };



}
