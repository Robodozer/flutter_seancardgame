import 'package:flutter_seancardgame/card.dart';

/* 
Set 1 of Sean Cards
 Includes the following
 - Ninja Sean
 - 
*/

// -------------- NINJA SEAN ------------------
class MadSean extends SeanCard {
  MadSean()
      : super("Mad Sean",
            attackPoints: 15,
            healthPoints: 30,
            level: 1,
            rarity: Rarity.Common,
            power: "None");
}

class RageSean extends SeanCard {
  RageSean()
      : super("Rage Sean",
            attackPoints: 50,
            healthPoints: 75,
            level: 2,
            rarity: Rarity.Rare,
            power: "every 5 attacks, deal 25 extra damage");
}

class ExplodingSean extends SeanCard {
  ExplodingSean()
      : super("Exploding Sean",
            attackPoints: 100,
            healthPoints: 150,
            level: 3,
            rarity: Rarity.Epic,
            power: "every 3 attacks, deal extra 50 damage");
}
