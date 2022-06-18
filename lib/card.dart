import 'package:flutter/material.dart';

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

  Widget _buildTitleBar() {
    return ListTile(
        leading: Icon(icon),
        title: Text(name),
        subtitle: Text('${Rarity.values[rarity.index]}',
            style: TextStyle(color: Colors.black.withOpacity(0.6))));

    /*Container(
        padding: const EdgeInsets.all(32),
        child: Row(
          children: [
            Expanded(
                child: Container(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(name,
                        style: const TextStyle(fontWeight: FontWeight.bold)))),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    '${Rarity.values[rarity.index]}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  'Cost: ${getCost()}',
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ],
        ));*/
  }

  Column _pointColumn(Color color, IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPointsBar() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      _pointColumn(const Color.fromARGB(239, 22, 126, 22),
          Icons.health_and_safety_rounded, '$healthPoints HP'),
      _pointColumn(const Color.fromARGB(240, 240, 30, 30),
          Icons.local_fire_department, '$attackPoints AP'),
    ]);
  }

  Widget _buildPowerBar() {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Text(power),
    );
  }

  Widget cardWidget() {
    return Card(
        clipBehavior: Clip.antiAlias,
        child: Column(children: [
          _buildTitleBar(),
          _buildPointsBar(),
          _buildPowerBar(),
        ]));
  }
}
