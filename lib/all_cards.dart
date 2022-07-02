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

  Widget allCardsWidget() {
    return LayoutGrid(
        columnSizes: [300.px, 300.px, 300.px],
        rowSizes: const [auto],
        rowGap: 40, // equivalent to mainAxisSpacing
        columnGap: 24,
        children: allCards
            .map((f) => f.cardWidget((String s, CardEvent e) {}))
            .toList());
  }
}

class AllCardsPage extends StatelessWidget {
  AllCardsPage({Key? key}) : super(key: key);

  AllCards allCards = AllCards();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Info'),
      ),
      body: allCards.allCardsWidget(),
    );
  }
}
