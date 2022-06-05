import 'package:test/test.dart';
import 'package:flutter_seancardgame/card.dart';
import 'package:flutter_seancardgame/card_set1.dart';

// -------------- TEST SEAN ------------------
class TestSean extends SeanCard {
  TestSean(int attackP, int healthP)
      : super("Power Sean", attackP, healthP, 1, 10, Rarity.common, "None");
}

void main() {
  group('PowerSean', () {
    test('PowerSean initializes', () {
      final power = PowerSean();
      expect(power.name, 'Power Sean');
    });

    test('PowerSean attack stays alive', () {
      final t = PowerSean(); // target
      final a = TestSean(20, 20); // attacker
      a.attackCard(t);
      expect(t.alive, true);
    });

    test('PowerSean attack dead', () {
      final t = PowerSean();
      final a = TestSean(20, 20);
      a.attackCard(t);
      expect(t.alive, true);
      expect(t.healthPoints, 20);
      // attack with points override
      a.attackCard(t);
      expect(t.alive, false);
    });

    test('PowerSean cost strings', () {
      final t = PowerSean();
      expect(t.getCost(), "10 post-its (square)");
      t.cost = 100;
      expect(t.getCost(), "1 post-it pack");
      t.cost = 120;
      expect(t.getCost(), "1 pack 20 post-its");
      t.cost = 150;
      expect(t.getCost(), "1½ post-it packs");
      t.cost = 200;
      expect(t.getCost(), "2 post-it packs");
      t.cost = 260;
      expect(t.getCost(), "2 packs 60 post-its");
    });
  });

  group('SuperSean', () {
    test('SuperSean shields damage', () {
      final t = SuperSean();
      final a = TestSean(80, 200); // attack with 80 points
      expect(t.healthPoints, 75);
      // Attack with 80; stays alive since we shielded 40
      a.attackCard(t);
      expect(t.alive, true);
      expect(t.healthPoints, 75 - (80 - 40));
      // Second attack roasts the card
      a.attackCard(t);
      expect(t.alive, false);
    });
  });

  group('UltraSean', () {
    test('UltraSean attack with <50', () {
      final t = UltraSean();
      final a = TestSean(40, 40);
      expect(t.healthPoints, 150);
      // Attack with 40; takes full damage
      a.attackCard(t);
      expect(t.alive, true);
      expect(t.healthPoints, 110);
      // Attack with 40; takes full damage
      a.attackCard(t);
      expect(t.alive, true);
      expect(t.healthPoints, 70);
      // Attack with 40; takes full damage
      a.attackCard(t);
      expect(t.alive, true);
      expect(t.healthPoints, 30);
      // Attack with 40; takes full damage and dies
      a.attackCard(t);
      expect(t.alive, false);
    });

    test('UltraSean attack with >=50, reflect 25%', () {
      final a = TestSean(60, 40);
      final t = UltraSean();
      expect(t.healthPoints, 150);
      // Attack with 60; reflect 25%
      a.attackCard(t);
      expect(t.alive, true);
      expect(t.healthPoints, 105);
      // c took damage as well
      expect(a.healthPoints, 25);
    });
  });

  group('LegendarySean', () {
    test('LegendarySean reduces attacks by 25%', () {
      final t = LegendarySean();
      final a = TestSean(80, 80);
      expect(t.healthPoints, 375);
      // Attack with 80; only 60 damage taken
      a.attackCard(t);
      expect(t.alive, true);
      expect(t.healthPoints, 375 - (80 * 0.75));
    });
  });
  /*
  group('FartSean', () {
    test('FartSean reduces attacks by 25%', () {
      final c = FartSean();
      final s = PowerSean();
      s.healthPoints = 1000;

      expect(c.attackPoints, 50);
      // Attack the first time, expect 150 damage
      expect(s.attack(c, turn: 1), true);
      expect(s.healthPoints, 315);

      // Now
    });
  });
  */

  group('FartSean', () {
    test('FartSean adds 100 extra damage on attack', () {
      final a = FartSean();
      final t = TestSean(20, 1000);
      a.attackCard(t);
      // Should have been dropped by 150
      expect(t.healthPoints, 850);
      // FartSean tracks the card it's going to hit next time
      expect(a.targetToApply100Damage, t);
    });

    test('FartSean adds 100 extra damage on NEXT attack', () {
      final a1 = FartSean();
      final a2 = PowerSean();
      final t1 = TestSean(20, 1000);
      final t2 = TestSean(20, 500);
      List<SeanCard> myCards = [a1, a2];
      List<SeanCard> yourCards = [t1, t2];
      t1.healthPoints = 1000; // Boost the target
      t2.healthPoints = 500;

      // First turn
      for (var c in myCards) {
        c.applyEveryTurnPowers(myCards, 0);
      }
      a1.attackCard(t1);
      expect(t1.healthPoints, 850);

      // Second turn. PowerSean attacks UltraSean. FartSean will also take
      // 100 off the LegendarySean
      for (var c in myCards) {
        c.applyEveryTurnPowers(myCards, 0);
      }
      a2.attackCard(t2);
      expect(t1.healthPoints, 750);
      expect(t2.healthPoints, 500 - a2.attackPoints);
      expect(a1.targetToApply100Damage, null);
    });

    test('FartSean attacks LegendarySean, and attacks are reduced', () {
      final a = FartSean();
      final t = LegendarySean();
      int i = t.healthPoints;
      a.attackCard(t);
      // Should have been dropped by 150, but Legendary shielded 25%
      expect(t.healthPoints, i - 112);
      // FartSean tracks the card it's going to hit next time
      expect(a.targetToApply100Damage, t);
    });

    test('FartSean second attack on LegendarySean also reduced', () {
      final a1 = FartSean();
      final a2 = PowerSean();
      final t1 = LegendarySean();
      final t2 = UltraSean();
      List<SeanCard> myCards = [a1, a2];
      List<SeanCard> yourCards = [t1, t2];
      t1.healthPoints = 1000; // Boost the target
      t2.healthPoints = 500;

      // First turn
      for (var c in myCards) {
        c.applyEveryTurnPowers(myCards, 0);
      }
      a1.attackCard(t1);
      expect(t1.healthPoints, 888);
      for (var c in myCards) {
        c.applyEveryTurnPowers(myCards, 0);
      }
      a2.attackCard(t2);
      expect(t1.healthPoints, 813);
    });
  });

  group('TheFarrellFamily', () {
    test('TheFarrellFamily is restored after attacks', () {
      final t = TheFarrellFamily();
      final a = TestSean(80, 40);
      expect(t.healthPoints, 25);
      // Attack with 15, stays alive
      a.attackCard(t, points: 15);
      expect(t.alive, true);
      expect(t.healthPoints, 10);
      expect(t.lives, 4);
      // Attack with 80; lives drop to 3 and health restored to 25
      a.attackCard(t);
      expect(t.alive, true);
      expect(t.healthPoints, 25);
      expect(t.lives, 3);
      // Two more attacks drops lives to 1
      a.attackCard(t);
      expect(t.alive, true);
      a.attackCard(t);
      expect(t.alive, true);
      expect(t.healthPoints, 25);
      expect(t.lives, 1);
      // Final attacks roast the card
      a.attackCard(t, points: 15);
      expect(t.alive, true);
      expect(t.healthPoints, 10);
      a.attackCard(t);
      expect(t.alive, false);
    });
  });

  group('TheFarrellFamilyEx', () {
    test('TheFarrellFamilyEx is restored after attacks', () {
      final t = TheFarrellFamilyEx();
      final a = TestSean(100, 40);
      expect(t.healthPoints, 30);
      expect(t.lives, 8);
      // Attack with 15, stays alive
      a.attackCard(t, points: 15);
      expect(t.alive, true);
      expect(t.healthPoints, 15);

      // 7 attacks with power 100 each should keep dropping lives
      for (int i = 7; i >= 1; i--) {
        // Attack with 100; lives drop by 1 and health restored to 30
        a.attackCard(t);
        expect(t.alive, true);
        expect(t.healthPoints, 30);
        expect(t.lives, i);
      }
      // Last attack destroys the card
      a.attackCard(t);
      expect(t.alive, false);
    });
  });

  group('ZombieSean', () {
    test('ZombieSean basic tests', () {
      final t = ZombieSean();
      final a = TestSean(40, 40);
      expect(t.healthPoints, 75);
      a.attackCard(t);
      expect(t.alive, true);
      expect(t.healthPoints, 35);
      // Second attack roasts the card
      a.attackCard(t);
      expect(t.alive, false);
    });
  });
}
