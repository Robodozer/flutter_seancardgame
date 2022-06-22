// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;
import 'dart:developer';

enum CardMode {
  disabled,
  canBePlayed,
  canBeUnplayed,
  canBeTargeted,
  canBeUntargeted,
  attacking,
  beingAttacked,
}

enum CardEvent {
  playClicked,
  unplayClicked,
  targetClicked,
  untargetClicked,
  turnConfirmed,
}

enum Rarity {
  Common,
  Uncommon,
  Rare,
  SuperRare,
  Epic,
  Mythic,
  Legendary,
  Exotic,
  Insane,
  Secret,
}

Map<Rarity, int> rarityToCost = {
  Rarity.Common: 10,
  Rarity.Uncommon: 15,
  Rarity.Rare: 20,
  Rarity.SuperRare: 30,
  Rarity.Epic: 40,
  Rarity.Mythic: 50,
  Rarity.Legendary: 100,
  Rarity.Exotic: 100,
  Rarity.Insane: 150,
  Rarity.Secret: 10000,
};

Map<Rarity, Color> rarityToColor = {
  Rarity.Common: const Color.fromARGB(0, 255, 255, 255),
  Rarity.Uncommon: Colors.lightGreen,
  Rarity.Rare: Colors.blue,
  Rarity.SuperRare: Colors.purple,
  Rarity.Epic: Colors.red,
  Rarity.Mythic: Colors.grey,
  Rarity.Legendary: Colors.yellow,
  Rarity.Exotic: Colors.pink,
  Rarity.Insane: const Color.fromARGB(128, 0, 255, 0),
  Rarity.Secret: Colors.black,
};

class SeanCard {
  String name = "";
  int attackPoints = 0;
  int healthPoints = 0;
  int level = 1;
  int cost = 1; // Cost in post-its
  Rarity rarity = Rarity.Common;
  String power = "None";
  IconData icon = Icons.card_travel;
  bool alive = true;
  String id = '';
  Color textColor = Colors.white;
  CardMode mode = CardMode.disabled;
  var random = math.Random();

  SeanCard(this.name,
      {this.attackPoints = 0,
      this.healthPoints = 0,
      this.level = 1,
      this.rarity = Rarity.Common,
      this.power = "None",
      this.icon = Icons.card_travel}) {
    cost = rarityToCost[rarity] ?? 10;
    id = getRandomString();
    textColor = rarityToColor[rarity] ?? Colors.white;
  }

  String getRandomString() {
    return String.fromCharCodes(
        List.generate(6, (index) => random.nextInt(26) + 65));
  }

  String getCost() {
    if (cost < 100) return "$cost post-its (square)";
    int packs = cost ~/ 100;
    int postits = cost % 100;
    if (postits == 0) return "$packs post-it ${packs == 1 ? "pack" : "packs"}";
    if (postits == 50) return "$packs½ post-it packs";
    return "$packs ${packs == 1 ? "pack" : "packs"} $postits post-its";
  }

  void setMode(CardMode newMode) {
    log("Setting mode to $newMode");
    mode = newMode;
  }

  void setReadyToPlay() {
    if (alive) mode = CardMode.canBePlayed;
  }

  // Return parameters in a string for debugging
  @override
  String toString() {
    // ignore: prefer_interpolation_to_compose_strings
    return "${alive ? "[ALIVE] " : "[DEAD]  "} Name: $name, ID: $id, " +
        "AT: $attackPoints, HP: $healthPoints, LVL: $level, " +
        "Cost: $cost, Rarity: $rarity, Power: $power, " +
        "Mode: " +
        '${CardMode.values[mode.index]}'.substring(9);
  }

  // Apply every-turn powers to this and all other cards in my hand
  void applyEveryTurnPowers(List<SeanCard> cards, int turn) {}

  // Attack another card
  void attackCard(SeanCard target, {int turn = 0, int? points}) {
    target.processIncomingAttack(this, turn: turn, points: points);
  }

  // This card is attacked. Apply points and return if this card is still alive
  void applyAttack(int points) {
    if (alive && points < healthPoints) {
      healthPoints -= points;
    } else {
      healthPoints = 0;
      alive = false;
    }
  }

  // Handle attack from another card
  void processIncomingAttack(SeanCard attackingCard,
      {int turn = 0, int? points}) {
    points ??= attackingCard.attackPoints;
    applyAttack(points);
  }

  Widget _pointColumn(
      {required Color textColor,
      required Color bgColor,
      required IconData icon,
      String label = ''}) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: bgColor,
          borderRadius: const BorderRadius.all(Radius.circular(15.0))),
      child: Column(
        children: [
          Icon(icon, color: textColor),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _titleBar() {
    return Column(children: [
      Align(
        alignment: Alignment.topCenter,
        child: Container(
            margin: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
                color: Color.fromARGB(120, 200, 200, 200),
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            child: ListTile(
                title: Container(
                    alignment: Alignment.center,
                    child: Stack(children: [
                      Text(name,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lexendDeca(
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 6
                                ..color = mode != CardMode.disabled
                                    ? textColor
                                    : Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 19)),
                      Text(name,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lexendDeca(
                              fontWeight: FontWeight.bold, fontSize: 19)),
                    ])))),
      ),
      const SizedBox(height: 60),
      alive
          ? Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              _pointColumn(
                  textColor: mode != CardMode.disabled
                      ? const Color.fromARGB(255, 18, 131, 18)
                      : Colors.black,
                  bgColor: (mode == CardMode.canBeUntargeted)
                      ? const Color.fromARGB(200, 255, 255, 0)
                      : const Color.fromARGB(200, 200, 200, 200),
                  icon: Icons.health_and_safety_rounded,
                  label: '$healthPoints HP'),
              const SizedBox(width: 90),
              _pointColumn(
                  textColor: mode != CardMode.disabled
                      ? const Color.fromARGB(255, 160, 15, 15)
                      : Colors.black,
                  bgColor: (mode == CardMode.canBeUnplayed ||
                          mode == CardMode.attacking)
                      ? const Color.fromARGB(200, 255, 255, 0)
                      : const Color.fromARGB(200, 200, 200, 200),
                  icon: Icons.local_fire_department,
                  label: '$attackPoints AT'),
            ])
          : const SizedBox(height: 30)
    ]);
  }

  Widget powerBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(power,
          style: GoogleFonts.ptSans(fontSize: 15, color: Colors.grey)),
    );
  }

  Widget _actionButton(Function(String, CardEvent) eventCallback) {
    if (!alive) {
      return const SizedBox(height: 72, width: 54);
    }

    switch (mode) {
      case CardMode.canBePlayed:
        return IconButton(
            icon: const Icon(Icons.auto_fix_normal,
                color: Colors.blue), // Icons.play_circle
            iconSize: 54,
            //label: const Text("Play"),
            onPressed: () {
              eventCallback(id, CardEvent.playClicked);
            });

      case CardMode.canBeUnplayed:
        return IconButton(
            icon: const Icon(Icons.undo,
                color: Colors.lightBlue), // Icons.unpublished
            iconSize: 54,
            //label: const Text("Play"),
            onPressed: () {
              eventCallback(id, CardEvent.unplayClicked);
            });

      case CardMode.canBeTargeted:
        return IconButton(
            icon: const Icon(Icons.ads_click, color: Colors.red),
            iconSize: 54,
            //label: const Text("Play"),
            onPressed: () {
              eventCallback(id, CardEvent.targetClicked);
            });

      case CardMode.canBeUntargeted:
        return IconButton(
            icon: const Icon(Icons.undo, color: Colors.orange),
            iconSize: 54,
            //label: const Text("Play"),
            onPressed: () {
              eventCallback(id, CardEvent.untargetClicked);
            });

      case CardMode.attacking:
      case CardMode.beingAttacked:
        return IconButton(
            icon: const Icon(Icons.task_alt, color: Colors.green),
            iconSize: 54,
            //label: const Text("Play"),
            onPressed: () {
              eventCallback(id, CardEvent.turnConfirmed);
            });

      default:
        return const SizedBox(height: 72, width: 54);
    }
  }

  Widget _buttonBar(Function(String, CardEvent) eventCallback) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      Tooltip(
          message: 'Cost: ${getCost()}',
          child: Column(
            children: [
              const Icon(
                Icons.monetization_on,
                color: Colors.grey,
                size: 16,
              ),
              Text('${Rarity.values[rarity.index]}'.substring(7),
                  style: const TextStyle(fontSize: 10, color: Colors.grey))
            ],
          )),
      const SizedBox(width: 120),
      _actionButton(eventCallback)
    ]);
  }

  Widget _background() {
    if (alive) {
      return mode != CardMode.disabled
          ? Image.asset('images/${Rarity.values[rarity.index]}.jpg')
          : ColorFiltered(
              colorFilter: const ColorFilter.mode(
                Colors.grey,
                BlendMode.saturation,
              ),
              child: Image.asset('images/${Rarity.values[rarity.index]}.jpg'));
    } else {
      return Column(children: [
        const SizedBox(height: 60),
        Image.asset('images/deaddino.jpg')
      ]);
    }
    // Image.asset('images/electricity.jpg'),
  }

  Widget cardWidget(Function(String, CardEvent) eventCallback) {
    return SizedBox(
        width: 480,
        height: 400,
        child: Card(
            clipBehavior: Clip.antiAlias,
            child: Stack(children: [
              _background(),
              Column(children: [
                _titleBar(),
                const SizedBox(height: 10),
                Expanded(
                    child: alive ? powerBar() : const SizedBox(height: 10)),
                _buttonBar(eventCallback)
              ])
            ])));
  }
}
