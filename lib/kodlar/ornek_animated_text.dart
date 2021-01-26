import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrnekAnimatedTextKit extends StatefulWidget {
  @override
  _OrnekAnimatedTextKitState createState() => _OrnekAnimatedTextKitState();
}

class _OrnekAnimatedTextKitState extends State<OrnekAnimatedTextKit> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Container(
          color: Colors.blue,
          height: Get.height * 0.25,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(width: 20.0, height: 100.0),
              Text(
                "Be",
                style: TextStyle(fontSize: 43.0),
              ),
              SizedBox(width: 20.0, height: 100.0),
              RotateAnimatedTextKit(
                  onTap: () {
                    print("On Tap");
                  },
                  text: ["OPTIMISTIC", "AWESOME", "DIFFERENT"],
                  textStyle: TextStyle(fontSize: 40.0, fontFamily: "Horizon"),
                  textAlign: TextAlign.start),
            ],
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          color: Colors.amber,
          height: Get.height * 0.25,
          child: SizedBox(
            width: 250.0,
            child: FadeAnimatedTextKit(
              onTap: () {
                print("Tap Event");
              },
              text: ["do IT!", "do it RIGHT!!", "do it RIGHT NOW!!!"],
              textStyle: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          color: Colors.green,
          height: Get.height * 0.25,
          child: SizedBox(
            width: 250.0,
            child: TyperAnimatedTextKit(
              onTap: () {
                print("Tap Event");
              },
              text: [
                "It is not enough to do your best,",
                "you must know what to do,",
                "and then do your best",
                "- W.Edwards Deming",
              ],
              textStyle: TextStyle(fontSize: 30.0, fontFamily: "Bobbers"),
              textAlign: TextAlign.start,
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          color: Colors.brown,
          height: Get.height * 0.25,
          child: SizedBox(
            width: 250.0,
            child: TypewriterAnimatedTextKit(
              onTap: () {
                print("Tap Event");
              },
              text: [
                "Discipline is the best tool",
                "Design first, then code",
                "Do not patch bugs out, rewrite them",
                "Do not test bugs out, design them out",
              ],
              textStyle: TextStyle(fontSize: 30.0, fontFamily: "Agne"),
              textAlign: TextAlign.start,
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          color: Colors.lightBlueAccent,
          height: Get.height * 0.25,
          child: SizedBox(
            width: 250.0,
            child: ScaleAnimatedTextKit(
              onTap: () {
                print("Tap Event");
              },
              text: ["Think", "Build", "Ship"],
              textStyle: TextStyle(fontSize: 70.0, fontFamily: "Canterbury"),
              textAlign: TextAlign.start,
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          height: Get.height * 0.25,
          child: SizedBox(
            width: 250.0,
            child: ColorizeAnimatedTextKit(
              onTap: () {
                print("Tap Event");
              },
              text: [
                "Larry Page",
                "Bill Gates",
                "Steve Jobs",
              ],
              textStyle: TextStyle(fontSize: 50.0, fontFamily: "Horizon"),
              colors: [
                Colors.purple,
                Colors.blue,
                Colors.yellow,
                Colors.red,
              ],
              textAlign: TextAlign.start,
              isRepeatingAnimation: true,
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          height: Get.height * 0.25,
          child: SizedBox(
            width: 250.0,
            child: TextLiquidFill(
              text: 'FLUTTER',
              waveColor: Colors.black,
              boxBackgroundColor: Colors.blue,
              textStyle: TextStyle(
                fontSize: 80.0,
                fontWeight: FontWeight.bold,
              ),
              boxHeight: Get.height * 0.25,
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          color: Colors.orange,
          height: Get.height * 0.25,
          child: WavyAnimatedTextKit(
            textStyle: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
            text: [
              "Hello World",
              "Look at the waves",
            ],
            isRepeatingAnimation: true,
          ),
        ),
      ],
    );
  }
}
