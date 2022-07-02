import 'package:flutter/material.dart';
import 'package:flutter_seancardgame/card.dart';
import 'package:flutter_seancardgame/card_set1.dart';
import 'package:flutter_seancardgame/card_set2.dart';
import 'package:flutter_seancardgame/card_set3.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'dart:math' as math;

class AllCards {
  List<SeanCard> allCards = [
    PowerSean(),
    SuperSean(),
    UltraSean(),
    LegendarySean(),
    FartSean(),
    TheFarrellFamily(),
    TheFarrellFamilyEx(),
    RockSean(),
    ZombieSean(),
    NinjaSean(),
    HappySean(),
    ThinkerSean(),
    Sean(),
    SatanSean(),
    CoolSean(),
    SuperiorSean(),
    RedSean(),
    OrangeSean(),
    GoldenSean(),
    BalletSean(),
    DancingSean(),
    DepressedSean(),
  ];
  final _random = math.Random.secure();

  SeanCard getRandomCard() {
    return allCards[_random.nextInt(allCards.length)];
  }

  SeanCard getRandomCardCopy() {
    return SeanCard.clone(getRandomCard());
  }

  // Should get rid of this eventually
  Widget allCardsWidget(eventCallback) {
    return LayoutGrid(
        columnSizes: [300.px, 300.px, 300.px],
        rowSizes: const [auto],
        rowGap: 40, // equivalent to mainAxisSpacing
        columnGap: 24,
        children: allCards.map((f) => f.cardWidget(eventCallback)).toList());
  }
}

class AllCardsPage extends StatelessWidget {
  const AllCardsPage({Key? key}) : super(key: key);

  Widget allCards() {
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
      body: allCards(),
    );
  }
}
