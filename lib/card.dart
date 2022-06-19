import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum Rarity {
  common,
  uncommon,
  rare,
  superRare,
  epic,
  mythic,
  legendary,
  exotic,
  insane,
  secret,
}

Map<Rarity, int> rarityToCost = {
  Rarity.common: 10,
  Rarity.uncommon: 15,
  Rarity.rare: 20,
  Rarity.superRare: 30,
  Rarity.epic: 40,
  Rarity.mythic: 50,
  Rarity.legendary: 100,
  Rarity.exotic: 100,
  Rarity.insane: 150,
  Rarity.secret: 10000,
};

class SeanCard {
  String name = "";
  int attackPoints = 0;
  int healthPoints = 0;
  int level = 1;
  int cost = 1; // Cost in post-its
  Rarity rarity = Rarity.common;
  String power = "None";
  IconData icon = Icons.card_travel;
  bool alive = true;

  SeanCard(this.name,
      {this.attackPoints = 0,
      this.healthPoints = 0,
      this.level = 1,
      this.rarity = Rarity.common,
      this.power = "None",
      this.icon = Icons.card_travel}) {
    cost = rarityToCost[rarity] ?? 10;
  }

  String getCost() {
    if (cost < 100) return "$cost post-its (square)";
    int packs = cost ~/ 100;
    int postits = cost % 100;
    if (postits == 0) return "$packs post-it ${packs == 1 ? "pack" : "packs"}";
    if (postits == 50) return "$packs½ post-it packs";
    return "$packs ${packs == 1 ? "pack" : "packs"} $postits post-its";
  }

  // Return parameters in a string for debugging
  String paramString() {
    return "${alive ? "[ALIVE] " : "[DEAD]  "} Name: $name, AT: $attackPoints, HP: $healthPoints, LVL: $level, Cost: $cost, Rarity: $rarity, Power: $power";
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

  Widget _pointColumn(Color color, IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
          color: Color.fromARGB(200, 200, 200, 200),
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      child: Column(
        children: [
          Icon(icon, color: color),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _titleBar() {
    return Stack(children: [
      Image.asset('images/tilepic.webp'),
      Column(children: [
        Align(
          alignment: Alignment.topCenter,
          child: Container(
              margin: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                  color: Color.fromARGB(200, 200, 200, 200),
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              child: ListTile(
                  //leading: Icon(icon),
                  title: Text(name,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lexendDeca(
                          fontWeight: FontWeight.bold, fontSize: 19)))),
        ),
        const SizedBox(height: 30),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          _pointColumn(const Color.fromARGB(255, 22, 126, 22),
              Icons.health_and_safety_rounded, '$healthPoints HP'),
          _pointColumn(Color.fromARGB(255, 160, 15, 15),
              Icons.local_fire_department, '$attackPoints AP'),
        ])
      ])
    ]);
  }

  Widget powerBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(power,
          style: GoogleFonts.ptSans(fontSize: 15, color: Colors.grey)),
    );
  }

  Widget _buttonBar({bool enablePlay = false, bool enableTarget = false}) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      Column(
        children: [
          const Icon(
            Icons.monetization_on,
            color: Colors.grey,
            size: 16,
          ),
          Text('${Rarity.values[rarity.index]}'.substring(7),
              style: const TextStyle(fontSize: 10, color: Colors.grey))
        ],
      ),
      ButtonBar(
        children: [
          ElevatedButton(
            onPressed: enablePlay ? () {} : null,
            child: const Text("Play"),
          ),
          ElevatedButton(
            onPressed: enableTarget ? () {} : null,
            child: const Text("Target"),
          ),
        ],
      )
    ]);
  }

  Widget cardWidget({bool enablePlay = false, bool enableTarget = false}) {
    return Card(
        clipBehavior: Clip.antiAlias,
        child: Column(children: [
          _titleBar(),
          const SizedBox(height: 10),
          Expanded(child: powerBar()),
          _buttonBar(enablePlay: enablePlay, enableTarget: enableTarget)
        ]));
  }
}
