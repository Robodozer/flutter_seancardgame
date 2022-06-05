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

  @override
  String paramString() {
    return "${super.paramString()} Used: $used";
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
  SeanCard? targetToApply100Damage;

  FartSean()
      : super("Fart Sean", 50, 125, 1, 100, Rarity.legendary,
            '''In every attack, this card farts on opponents, poisoning them,
            and dealing 100 extra damage every turn for 2 turns''');

  // Attack another card
  @override
  void attackCard(SeanCard target, {int turn = 0, int? points}) {
    points ??= attackPoints;
    if (targetToApply100Damage == null) {
      targetToApply100Damage = target;
      points += 100;
    }
    target.processIncomingAttack(this, turn: turn, points: points);
  }

  @override
  void applyEveryTurnPowers(List<SeanCard> cards, int turn) {
    // If there is a target card we need to deliver 100 damage to, do it
    if (targetToApply100Damage != null) {
      targetToApply100Damage!
          .processIncomingAttack(this, turn: turn, points: 100);
      targetToApply100Damage = null;
    }
  }
}

// -------------- THE FARRELL FAMILY ------------------
class TheFarrellFamily extends SeanCard {
  TheFarrellFamily()
      : super("The Farrell Family", 25, 25, 1, 30, Rarity.superRare,
            "This card has 4 lives");

  int lives = 4;

  @override
  void applyAttack(int points) {
    super.applyAttack(points);
    if (!alive && lives > 1) {
      lives--;
      healthPoints = 25;
      alive = true;
    }
  }

  @override
  String paramString() {
    return "${super.paramString()} Lives: $lives";
  }
}

// -------------- THE FARRELL FAMILY (EX) ------------------
class TheFarrellFamilyEx extends SeanCard {
  TheFarrellFamilyEx()
      : super("The Farrell Family (ex)", 25, 30, 2, 10, Rarity.legendary,
            "This card has 8 lives");

  int lives = 8;

  @override
  void applyAttack(int points) {
    super.applyAttack(points);
    if (!alive && lives > 1) {
      lives--;
      healthPoints = 30;
      alive = true;
    }
  }

  @override
  String paramString() {
    return "${super.paramString()} Lives: $lives";
  }
}

// -------------- ROCK SEAN ------------------
class RockSean extends SeanCard {
  RockSean() : super("Rock Sean", 50, 75, 1, 15, Rarity.uncommon, "None");

  // TODO: Figure out what to do with this guy
}

// -------------- ZOMBIE SEAN ------------------
class ZombieSean extends SeanCard {
  ZombieSean() : super("Zombie Sean", 50, 75, 1, 15, Rarity.uncommon, "None");
}
