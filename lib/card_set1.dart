import 'package:flutter_seancardgame/card.dart';

/* 
Set 1 of Sean Cards
 Includes the following
 - Power Sean
 - Super Sean
 - Ultra Sean
 - Legendary Sean
 - Fart Sean
 - THe Farrell Family
 - The Farrell Family (Ex)
 - Rock Sean
 - Zombie Sean
*/

// -------------- POWER SEAN ------------------
class PowerSean extends SeanCard {
  PowerSean() : super("Power Sean", 20, 40, 1, 10, Rarity.common, "None");
}

// -------------- SUPER SEAN ------------------
class SuperSean extends SeanCard {
  // Has this been used this game?
  bool used = false;
  SuperSean()
      : used = false,
        super("Super Sean", 50, 75, 2, 15, Rarity.uncommon,
            "Shield 40 damage OPEG (Once Per Every Game)");

  @override
  void processIncomingAttack(SeanCard attackingCard,
      {int turn = 0, int? points}) {
    points ??= attackingCard.attackPoints;
    // Shield 40 damage the first time, then mark as used up
    if (!used) {
      used = true;
      points -= 40;
    }
    applyAttack(points);
  }
}

// -------------- ULTRA SEAN ------------------
class UltraSean extends SeanCard {
  UltraSean()
      : super("Ultra Sean", 100, 150, 3, 30, Rarity.rare,
            "This card reflects 25% when 50 or more damage taken");

  @override
  void processIncomingAttack(SeanCard attackingCard,
      {int turn = 0, int? points}) {
    points ??= attackingCard.attackPoints;

    if (points >= 50) {
      // Reflect 25% damage to the attacking card
      attackingCard.processIncomingAttack(this,
          turn: turn, points: points ~/ 4);
      // Adjust my damage to 75%
      points = (points * 3) ~/ 4;
    }
    applyAttack(points);
  }
}

// -------------- LEGENDARY SEAN ------------------
class LegendarySean extends SeanCard {
  LegendarySean()
      : super("Legendary Sean", 200, 375, 4, 100, Rarity.legendary,
            "All attacks reduced by 25%");

  @override
  void processIncomingAttack(SeanCard attackingCard,
      {int turn = 0, int? points}) {
    points ??= attackingCard.attackPoints;

    // Reduce damage by 25%
    points = (points * 3) ~/ 4;
    applyAttack(points);
  }
}

// -------------- FART SEAN ------------------
class FartSean extends SeanCard {
  bool apply100ExtraDamageThisTurn = false;

  FartSean()
      : super("Fart Sean", 50, 125, 1, 100, Rarity.legendary,
            '''In every attack, this card farts on opponents, poisoning them,
            and dealing 100 extra damage every turn for 2 turns''');
}
