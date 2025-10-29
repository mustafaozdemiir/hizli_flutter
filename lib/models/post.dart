import '/models/comment.dart';
import 'main_model.dart';

class Post extends MainModel {
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
    int id = 0,
    String heading = '',
    String content = '',
    String type = '',
    int userId = 0,
    String userName = '',
    List<Comment> comments = const [],
    int numberOfLikes = 0,
    int numberOfComment = 0,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : _id = id,
        _heading = heading,
        _content = content,
        _type = type,
        _userId = userId,
        _userName = userName,
        _comments = comments,
        _numberOfLikes = numberOfLikes,
        _numberOfComment = numberOfComment,
        _createdAt = createdAt ?? DateTime.now(),
        _updatedAt = updatedAt ?? DateTime.now();

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
    var listRaw = json['comments'];
    List<Comment> commentList = [];
    if (listRaw != null) {
      try {
        var list = (listRaw is List) ? listRaw : List.from(listRaw);
        commentList = list
            .map((e) => Comment.fromJson(e as Map<String, dynamic>))
            .toList();
      } catch (e) {
        commentList = [];
      }
    }
    commentList = commentList.reversed.toList();
    return Post(
      id: (json['id'] is int)
          ? json['id'] as int
          : int.tryParse(json['id']?.toString() ?? '') ?? 0,
      heading: json['heading'] ?? '',
      content: json['content'] ?? '',
      type: json['type'] ?? '',
      userId: (json['userId'] is int)
          ? json['userId'] as int
          : int.tryParse(json['userId']?.toString() ?? '') ?? 0,
      userName: json['userName'] ?? '',
      comments: commentList,
      numberOfLikes: (json['numberOfLikes'] is int)
          ? json['numberOfLikes'] as int
          : int.tryParse(json['numberOfLikes']?.toString() ?? '') ?? 0,
      numberOfComment: (json['numberOfComment'] is int)
          ? json['numberOfComment'] as int
          : int.tryParse(json['numberOfComment']?.toString() ?? '') ?? 0,
      createdAt: DateTime.tryParse(json['created_at']?.toString() ?? '') ??
          DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at']?.toString() ?? '') ??
          DateTime.now(),
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
