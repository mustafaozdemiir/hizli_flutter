import 'package:hizliflutter/models/main_model.dart';

class Question extends MainModel {
  final int id;
  final String heading;
  final String difficulty;
  final String answer;
  final List<String> answers;
  final int point;
  final int time;

  Question({
    required this.id,
    required this.heading,
    required this.difficulty,
    required this.answer,
    required this.answers,
    required this.point,
    required this.time,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    List<String> answersList = [];
    var answersString = (json['answers'] ?? '').toString();
    if (answersString.isNotEmpty) {
      var answersArray = answersString.split('*');
      for (var ans in answersArray) {
        if (ans.toString().isNotEmpty) {
          answersList.add(ans.toString());
        }
      }
      answersList.shuffle();
    }

    return Question(
      id: (json['id'] is int)
          ? json['id'] as int
          : int.tryParse(json['id']?.toString() ?? '') ?? 0,
      heading: json['heading']?.toString().replaceAll("/n", "\n") ?? '',
      difficulty: json['difficulty']?.toString() ?? '',
      answer: json['answer']?.toString() ?? '',
      point: (json['point'] is int)
          ? json['point'] as int
          : int.tryParse(json['point']?.toString() ?? '') ?? 0,
      time: (json['time'] is int)
          ? json['time'] as int
          : int.tryParse(json['time']?.toString() ?? '') ?? 0,
      answers: answersList,
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'heading': heading,
        'difficulty': difficulty,
        'answer': answer,
        'answers': answers,
        'point': point,
        'time': time,
      };
}
