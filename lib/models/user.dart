class User {
  int _id;
  String _name;
  String _email;
  String _password;

  User({
    int id,
    String name,
    String email,
    String password,
  }) {
    this._id = id;
    this._name = name;
    this._email = email;
    this._password = password;
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

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  set name(String value) {
    _name = value;
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        password: json['path']);
  }

  Map<String, dynamic> toJson() => {
        'id': _id,
        'name': _name,
        'email': _email,
        'password': _password,
      };
}
