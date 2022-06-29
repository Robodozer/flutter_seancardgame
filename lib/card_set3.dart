import 'package:flutter_seancardgame/card.dart';

/* 
Set 1 of Sean Cards
 Includes the following
 - Ninja Sean
 - 
*/

// -------------- NINJA SEAN ------------------
class GoldenSean extends SeanCard {
  GoldenSean()
      : super("Golden Sean",
            attackPoints: 400,
            healthPoints: 490,
            level: 1,
            rarity: Rarity.Exotic,
            power:
                "blind opponents OPEG (Once Per Every Game) skipping their turn");
}

class BalletSean extends SeanCard {
  BalletSean()
      : super("Ballet Sean",
            attackPoints: 75,
            healthPoints: 175,
            level: 2,
            rarity: Rarity.Epic,
            power: "every 3 turns, deal 50 extra damage to all opponents");
}

class DancingSean extends SeanCard {
  DancingSean()
      : super("Dancing Sean",
            attackPoints: 70,
            healthPoints: 150,
            level: 1,
            rarity: Rarity.SuperRare,
            power: "every 5 turns, deal 50 extra damage to all opponents");
}

class DepressedSean extends SeanCard {
  DepressedSean()
      : super("Depressed Sean",
            attackPoints: 50,
            healthPoints: 300,
            level: 1,
            rarity: Rarity.Legendary,
            power:
                "every successful attack, increase your attack damage by 100");

  @override
  void attackCard(SeanCard target, {int turn = 0, int? points}) {
    super.attackCard(target, turn: turn, points: points);
    attackPoints += 100;
  }
}

class BountyHunterSean extends SeanCard {
  BountyHunterSean()
      : super("Bounty Hunter Sean",
            attackPoints: 300,
            healthPoints: 500,
            level: 1,
            rarity: Rarity.Legendary,
            power: "every kill, this card gains 150 attack");
}

class BabySean extends SeanCard {
  BabySean()
      : super("Baby Sean",
            attackPoints: 100,
            healthPoints: 215,
            level: 1,
            rarity: Rarity.Legendary,
            power: "every 3 turns, do 300 extra damage");
}

class PsychoSean extends SeanCard {
  PsychoSean()
      : super("Psycho Sean",
            attackPoints: 100,
            healthPoints: 500,
            level: 1,
            rarity: Rarity.Legendary,
            power: "every 5 turns, reflect all damage");
}

class WallSean extends SeanCard {
  WallSean()
      : super("Wall Sean",
            attackPoints: 10,
            healthPoints: 100,
            level: 1,
            rarity: Rarity.Legendary,
            power: "every turn, shield teammates 100 attack");
}

class PossessedSean extends SeanCard {
  PossessedSean()
      : super("Possessed Sean",
            attackPoints: 800,
            healthPoints: 1000,
            level: 1,
            rarity: Rarity.Legendary,
            power: "every 5 attacks, deal 200 extra damage");
}
