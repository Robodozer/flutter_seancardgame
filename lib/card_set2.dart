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

class HappySean extends SeanCard {
  HappySean()
      : super("Happy Sean",
            attackPoints: 0,
            healthPoints: 50,
            level: 1,
            rarity: Rarity.Uncommon,
            power: "heals 25 HP to all teammates every other turn");
}

class ThinkerSean extends SeanCard {
  ThinkerSean()
      : super("Thinker Sean",
            attackPoints: 0,
            healthPoints: 100,
            level: 1,
            rarity: Rarity.Epic,
            power:
                "give all teammates a damage boost of 100 AT OPEG (Once Per Every Game)");
}

class Sean extends SeanCard {
  Sean()
      : super("Sean",
            attackPoints: 1000,
            healthPoints: 1500,
            level: 1,
            rarity: Rarity.Secret,
            power: "blind opponents every 2 turns, skipping their turn");
}

class SatanSean extends SeanCard {
  SatanSean()
      : super("Satan Sean",
            attackPoints: 75,
            healthPoints: 100,
            level: 1,
            rarity: Rarity.Epic,
            power: "every 5 turns, opponents deal no damage");
}

class CoolSean extends SeanCard {
  CoolSean()
      : super("Cool Sean",
            attackPoints: 75,
            healthPoints: 175,
            level: 1,
            rarity: Rarity.SuperRare,
            power: "heal 50 HP every 2 turns");
}

class SuperiorSean extends SeanCard {
  SuperiorSean()
      : super("Superior Sean",
            attackPoints: 15,
            healthPoints: 35,
            level: 1,
            rarity: Rarity.Uncommon,
            power:
                "all other uncommon cards on the other team deal 10 less damage every turn");
}

class RedSean extends SeanCard {
  RedSean()
      : super("Red Sean",
            attackPoints: 200,
            healthPoints: 290,
            level: 1,
            rarity: Rarity.Mythic,
            power: "None");
}

class OrangeSean extends SeanCard {
  OrangeSean()
      : super("Orange Sean",
            attackPoints: 170,
            healthPoints: 255,
            level: 5,
            rarity: Rarity.Epic,
            power: "None");
}
