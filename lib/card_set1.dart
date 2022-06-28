import 'package:flutter_seancardgame/card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
  PowerSean() : super("Power Sean", attackPoints: 20, healthPoints: 40);
}

// -------------- SUPER SEAN ------------------
class SuperSean extends SeanCard {
  // Has this been used this game?
  bool used = false;
  SuperSean()
      : used = false,
        super("Super Sean",
            attackPoints: 50,
            healthPoints: 75,
            level: 2,
            rarity: Rarity.Uncommon,
            power: "Shield 40 damage OPEG (Once Per Every Game)");

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
  String toString() {
    return "${super.toString()} Used: $used";
  }
}

// -------------- ULTRA SEAN ------------------
class UltraSean extends SeanCard {
  UltraSean()
      : super("Ultra Sean",
            attackPoints: 100,
            healthPoints: 150,
            level: 3,
            rarity: Rarity.Rare,
            power: "This card reflects 25% when 50 or more damage taken");

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
      : super("Legendary Sean",
            attackPoints: 200,
            healthPoints: 375,
            level: 4,
            rarity: Rarity.Legendary,
            power: "All attacks reduced by 25%");

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
      : super("Fart Sean",
            attackPoints: 50,
            healthPoints: 125,
            level: 1,
            rarity: Rarity.Legendary,
            power:
                'In every attack, this card farts on opponents, poisoning them and dealing 100 extra damage every turn for 2 turns');

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
      : super("The Farrell Family",
            attackPoints: 25,
            healthPoints: 25,
            level: 1,
            rarity: Rarity.SuperRare,
            power: "This card has 4 lives");

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
  String toString() {
    return "${super.toString()} Lives: $lives";
  }

  @override
  Widget powerBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: RichText(
          text: TextSpan(
              style: GoogleFonts.ptSans(fontSize: 15, color: Colors.grey),
              children: [
            const TextSpan(text: 'This card has '),
            TextSpan(
              text: '$lives of 4',
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            const TextSpan(text: ' lives remaining'),
          ])),
    );
  }
}

// -------------- THE FARRELL FAMILY (EX) ------------------
class TheFarrellFamilyEx extends SeanCard {
  TheFarrellFamilyEx()
      : super("The Farrell Family (extended)",
            attackPoints: 25,
            healthPoints: 30,
            level: 2,
            rarity: Rarity.Legendary,
            power: "This card has 8 lives");

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
  String toString() {
    return "${super.toString()} Lives: $lives";
  }

  @override
  Widget powerBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: RichText(
          text: TextSpan(
              style: GoogleFonts.ptSans(fontSize: 15, color: Colors.grey),
              children: [
            const TextSpan(text: 'This card has '),
            TextSpan(
              text: '$lives of 8',
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            const TextSpan(text: ' lives remaining'),
          ])),
    );
  }
}

// -------------- ROCK SEAN ------------------
class RockSean extends SeanCard {
  RockSean()
      : super("Rock Sean",
            attackPoints: 15,
            healthPoints: 800,
            level: 1,
            rarity: Rarity.Legendary,
            power: "shield other cards 500 AT");

  // ignore: todo
  // TODO: Figure out what to do with this guy
}

// -------------- ZOMBIE SEAN ------------------
class ZombieSean extends SeanCard {
  ZombieSean()
      : super("Zombie Sean",
            attackPoints: 50,
            healthPoints: 75,
            level: 1,
            rarity: Rarity.Uncommon,
            power: "None");
}
