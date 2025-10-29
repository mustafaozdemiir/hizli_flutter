import 'package:animation_wrappers/animations/faded_scale_animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hizliflutter/app_string.dart';
import 'package:hizliflutter/controllers/auth/auth_controller.dart';
import 'package:hizliflutter/controllers/question_controller.dart';
import 'package:hizliflutter/services/functions.dart';

class QuestionsPage extends StatefulWidget {
  @override
  _QuestionsPageState createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  final QuestionController questionController = Get.put(QuestionController());
  final AuthController authController = Get.put(AuthController());

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    if (questionController.timer != null) {
      questionController.stopTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(AppString.answer),
        actions: [
          Functions.loginLogoutButton(),
        ],
      ),
      body: buildQuestionScreen(),
    );
  }

  Widget buildQuestionScreen() {
    return Obx(
      () {
        final s = questionController;
        final hasQuestions = s.soruListe != null && s.soruListe!.isNotEmpty;
        final isQuestionAvailable =
            hasQuestions ? (s.soruNo.value < s.soruListe!.length) : false;

        if (hasQuestions && isQuestionAvailable) {
          if (s.timer == null) {
            s.startTimer(s.soruListe![s.soruNo.value].time);
          }

          final question = s.soruListe![s.soruNo.value];
          final bannerMessage = _getBannerMessage(question.difficulty);
          final bannerColor = _getBannerColor(question.difficulty);
          final bannerTextColor = _getBannerTextColor(question.difficulty);

          return Column(
            children: [
              Banner(
                location: BannerLocation.topStart,
                message: bannerMessage,
                color: bannerColor,
                textStyle: TextStyle(color: bannerTextColor),
                child: Card(
                  color: Colors.grey.shade300,
                  child: ListTile(
                    title: Text(
                      question.heading,
                      style: TextStyle(color: Colors.black),
                    ),
                    leading: Text(
                      (s.soruNo.value + 1).toString(),
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: question.answers.length,
                  itemBuilder: (context, index) {
                    final option =
                        String.fromCharCode('A'.codeUnitAt(0) + index);
                    return FadedScaleAnimation(
                      child: Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: Card(
                          child: ListTile(
                            tileColor: Colors.grey.shade300,
                            leading: Text(option),
                            title: Text(question.answers[index]),
                            onTap: () {
                              s.stopTimer();
                              s.cevapKontrol(question, question.answers[index]);
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Center(
                child: Text(
                  s.timerTime.value.toString(),
                  style: TextStyle(fontSize: 30),
                ),
              ),
              Banner(
                location: BannerLocation.bottomEnd,
                message: s.sonCevap.value ? AppString.correct : AppString.wrong,
                color: s.sonCevap.value ? Colors.green : Colors.red,
                textStyle: TextStyle(color: Colors.white),
                child: Card(
                  color: Colors.blue.withOpacity(.1),
                  child: Container(
                    child: ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildStatRow(
                              Icons.done, Colors.green, s.dogruSayisi.value),
                          _buildStatRow(
                              Icons.clear, Colors.red, s.yanlisSayisi.value),
                        ],
                      ),
                      trailing: Padding(
                        padding: const EdgeInsets.only(left: 60, right: 60.0),
                        child: Wrap(
                          children: [
                            Icon(
                              Icons.leaderboard_outlined,
                              size: 25,
                              color: Colors.indigo,
                            ),
                            SizedBox(width: 10),
                            Text(
                              s.toplamPuan.toStringAsFixed(0),
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        } else {
          return Center(child: Text('Eklenmiş soru bulunamadı'));
        }
      },
    );
  }

  String _getBannerMessage(String difficulty) {
    switch (difficulty) {
      case "kolay":
        return AppString.easy;
      case "orta":
        return AppString.middle;
      case "zor":
        return AppString.hard;
      default:
        return '';
    }
  }

  Color _getBannerColor(String difficulty) {
    switch (difficulty) {
      case "kolay":
        return Colors.green.withOpacity(.4);
      case "orta":
        return Colors.yellow.withOpacity(.7);
      case "zor":
        return Colors.red.withOpacity(.5);
      default:
        return Colors.green.withOpacity(.4);
    }
  }

  Color _getBannerTextColor(String difficulty) {
    switch (difficulty) {
      case "kolay":
        return Colors.white;
      case "orta":
        return Colors.black;
      case "zor":
        return Colors.white;
      default:
        return Colors.white;
    }
  }

  Widget _buildStatRow(IconData icon, Color color, int value) {
    return Row(
      children: [
        Icon(icon, size: 40, color: color),
        Text(value.toString(), style: TextStyle(fontSize: 20)),
      ],
    );
  }
}
