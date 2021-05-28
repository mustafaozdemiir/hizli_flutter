class Question {
  int _id;
  String _heading;
  String _difficulty;
  String _answer;
  List<String> _answers;
  int _point;
  int _time;

  Question(
      {int id,
      String heading,
      String difficulty,
      String answer,
      List<String> answers,
      int point,
      int time}) {
    this._id = id;
    this._heading = heading;
    this.difficulty = difficulty;
    this._answer = answer;
    this._answers = answers;
    this._point = point;
    this._time = time;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  int get time => _time;

  set time(int value) {
    _time = value;
  }

  int get point => _point;

  set point(int value) {
    _point = value;
  }

  List<String> get answers => _answers;

  set answers(List<String> value) {
    _answers = value;
  }

  String get answer => _answer;

  set answer(String value) {
    _answer = value;
  }

  String get difficulty => _difficulty;

  set difficulty(String value) {
    _difficulty = value;
  }

  String get heading => _heading;

  set heading(String value) {
    _heading = value;
  }

  factory Question.fromJson(Map<String, dynamic> json) {
    List<String> answerss = [];
    var answersss = json['answers'].toString().split('*');
    for (int i = 0; i < 4; i++) {
      if (answersss[i].isNotEmpty && answersss[i] != null) {
        answerss.add(answersss[i]);
      }
    }
    answerss.shuffle();
    return Question(
      id: json['id'],
      heading: json['heading'].toString().replaceAll("/n", "\n"),
      difficulty: json['difficulty'],
      answer: json['answer'],
      point: json['point'],
      time: json['time'],
      answers: answerss,
    );
  }
}
