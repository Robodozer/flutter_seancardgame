import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({Key? key}) : super(key: key);

  Widget infoText() {
    return RichText(
      text: TextSpan(
        children: [
          const TextSpan(
            text: "'HOW TO PLAY: First, press the ",
          ),
          const WidgetSpan(
            child: Icon(Icons.auto_fix_normal, color: Colors.blue),
          ),
          const TextSpan(
            text:
                " at the bottom right of the card you want to play. If you want to cancel playing that card, just press the ",
          ),
          const WidgetSpan(
            child: Icon(Icons.undo, color: Colors.blue),
          ),
          const TextSpan(
            text:
                " at the bottom right of the selected card. Then, press the  ",
          ),
          const WidgetSpan(
            child: Icon(Icons.ads_click, color: Colors.red),
          ),
          const TextSpan(
            text:
                "at the bottom right of the card you want to attack. If you want to cancel attacking that card, just press the ",
          ),
          const WidgetSpan(
            child: Icon(Icons.undo, color: Colors.orange),
          ),
          const TextSpan(
            text: ". If you want to target that card, just press the ",
          ),
          WidgetSpan(
              child: FloatingActionButton.extended(
            icon: const Icon(Icons.play_arrow),
            label: const Text("Play Turn"),
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
