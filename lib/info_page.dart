import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({Key? key}) : super(key: key);

  Widget infoText() {
    return RichText(
      text: TextSpan(
        style: const TextStyle(fontSize: 30),
        children: [
          const TextSpan(
            text: "HOW TO PLAY: First, press the ",
          ),
          const WidgetSpan(
            child: Icon(Icons.auto_fix_normal, color: Colors.blue, size: 40),
          ),
          const TextSpan(
            text:
                " at the bottom right of the card you want to play. If you want to cancel playing that card, just press the ",
          ),
          const WidgetSpan(
            child: Icon(Icons.undo, color: Colors.blue, size: 40),
          ),
          const TextSpan(
            text: " at the bottom right of the selected card. Then, press the ",
          ),
          const WidgetSpan(
            child: Icon(Icons.ads_click, color: Colors.red, size: 40),
          ),
          const TextSpan(
            text:
                " at the bottom right of the card you want to attack. If you want to cancel attacking that card, just press the ",
          ),
          const WidgetSpan(
            child: Icon(Icons.undo, color: Colors.orange, size: 40),
          ),
          const TextSpan(
            text: ". If you want to target that card, just press the ",
          ),
          WidgetSpan(
              child: FloatingActionButton.extended(
            icon: const Icon(Icons.play_arrow, size: 20),
            label: const Text("Play Turn"),
            extendedTextStyle: const TextStyle(fontSize: 15),
            onPressed: () {},
          )),
        ],
      ),
    );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Info'),
      ),
      body: infoText(),
    );
  }
}
