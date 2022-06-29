import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({Key? key}) : super(key: key);

  Widget infoText() {
    return RichText(
      text: const TextSpan(
        children: [
          TextSpan(
            text: "'HOW TO PLAY: First, press the ",
          ),
          WidgetSpan(
            child: Icon(Icons.auto_fix_normal, color: Colors.blue),
          ),
          TextSpan(
            text:
                " at the bottom right of the card you want to play. If you want to cancel playing that card, just press the ",
          ),
          WidgetSpan(
            child: Icon(Icons.undo, color: Colors.orange),
          ),
          TextSpan(
            text: " at the bottom right of the selected card. ",
          ),
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
