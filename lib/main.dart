import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:flutter_seancardgame/gameplay.dart';
import 'package:flutter_seancardgame/card.dart';
import 'package:flutter_seancardgame/info_page.dart';
import 'package:flutter_seancardgame/all_cards.dart';

import 'dart:developer';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'A Casual & Relaxed Game Of Sean Cards',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Rubik',
      ),
      home: const MyHomePage(title: 'The Great Sean Cards Game'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GamePlay gamePlay = GamePlay();

  _MyHomePageState() : super() {
    log("START OF GAME: Dealing cards");
    gamePlay.dealCards();
  }

  void noEventCallback(String id, CardEvent event) {
    log("Event happened: $id $event");
  }

  void eventCallback(String id, CardEvent event) {
    log("Event happened: $id $event");
    setState(() {
      gamePlay.eventClicked(id, event);
    });
  }

  @override
  Widget build(BuildContext context) {
    //double width = MediaQuery.of(context).size.width;
    //double height = MediaQuery.of(context).size.height;
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
          title: Row(children: [
        Expanded(child: Text(widget.title)),
        /*
        IconButton(
            icon: const Icon(Icons.amp_stories_outlined),
            iconSize: 44,
            onPressed: () {
              log("Pressed INFO");
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return AllCardsPage();
              }));
            }),*/
        IconButton(
            icon: const Icon(Icons.info_outline),
            iconSize: 44,
            onPressed: () {
              log("Pressed INFO");
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const InfoPage();
              }));
            })
      ])),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: //gamePlay.allCardsWidget(noEventCallback)),
            Column(children: [
          LayoutGrid(
              columnSizes: [300.px, 300.px, 300.px],
              rowSizes: const [auto],
              rowGap: 40, // equivalent to mainAxisSpacing
              columnGap: 24,
              children: gamePlay.yourCardWidgets(eventCallback)),
          const SizedBox(
            height: 60, //height - 800 - 80,
          ),
          LayoutGrid(
              columnSizes: [300.px, 300.px, 300.px],
              rowSizes: const [auto],
              rowGap: 40, // equivalent to mainAxisSpacing
              columnGap: 20,
              children: gamePlay.myCardWidgets(eventCallback)),
        ]),
      ),
      floatingActionButton: gamePlay.floatingActionButtonWidget(eventCallback),
    );
  }
}
