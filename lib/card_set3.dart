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
}