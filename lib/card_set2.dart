import 'package:flutter_seancardgame/card.dart';

/* 
Set 1 of Sean Cards
 Includes the following
 - Ninja Sean
 - 
*/

// -------------- NINJA SEAN ------------------
class NinjaSean extends SeanCard {
  NinjaSean()
      : super("Ninja Sean",
            attackPoints: 50,
            healthPoints: 50,
            level: 1,
            rarity: Rarity.Rare,
            power: "Attacks 2 targets");
}
