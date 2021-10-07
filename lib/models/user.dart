import 'package:hizliflutter/models/main_model.dart';

class User extends MainModel{
  int _id;
  String _name;
  String _email;
  String _password;
  String _passwordAgain;
  String _token;

  User(
      {int id,
      String name,
      String email,
      String password,
      String passwordAgain,
      String token}) {
    this._id = id;
    this._name = name;
    this._email = email;
    this._password = password;
    this._passwordAgain = passwordAgain;
    this._token = token;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  String get name => _name;

  String get password => _password;

  set password(String value) {
    _password = value;
  }

  String get passwordAgain => _passwordAgain;

  set passwordAgain(String value) {
    _passwordAgain = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  set name(String value) {
    _name = value;
  }

  String get token => _token;

  set token(String value) {
    _token = value;
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      passwordAgain: json['password_confirmation'],
      token: json['token'],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'id': _id,
        'name': _name,
        'email': _email,
        'password': _password,
        'password_confirmation': _passwordAgain,
        'token': _token
      };
}
