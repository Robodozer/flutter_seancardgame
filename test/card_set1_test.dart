import 'package:test/test.dart';
import 'package:flutter_seancardgame/card_set1.dart';

void main() {
  group('PowerSean', () {
    test('PowerSean initializes', () {
      final power = PowerSean();
      expect(power.name, 'Power Sean');
    });

    test('PowerSean attack stays alive', () {
      final t = PowerSean(); // target
      final a = PowerSean(); // attacker
      a.attackPoints = 20;
      a.attackCard(t);
      expect(t.alive, true);
    });

    test('PowerSean attack dead', () {
      final t = PowerSean();
      final a = PowerSean();
      a.attackCard(t);
      expect(t.alive, true);
      expect(t.healthPoints, 20);
      // attack with points override
      a.attackCard(t, points: t.healthPoints + 1);
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
      final a = PowerSean();
      expect(t.healthPoints, 75);
      // Attack with 80; stays alive since we shielded 40
      a.attackCard(t, points: 80);
      expect(t.alive, true);
      expect(t.healthPoints, 75 - (80 - 40));
      // Second attack roasts
      a.attackCard(t, points: 50);
      expect(t.alive, false);
    });
  });

  group('UltraSean', () {
    test('UltraSean attack with <50', () {
      final a = PowerSean();
      final t = UltraSean();
      expect(t.healthPoints, 150);
      // Attack with 40; takes full damage
      a.attackPoints = 40;
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
      final a = PowerSean();
      final t = UltraSean();
      expect(t.healthPoints, 150);
      expect(a.healthPoints, 40);
      // Attack with 60; reflect 25%
      a.attackCard(t, points: 60);
      expect(t.alive, true);
      expect(t.healthPoints, 150 - (60 * 0.75));
      // c took damage as well
      expect(a.healthPoints, 40 - (60 * 0.25));
    });
  });

  group('LegendarySean', () {
    test('LegendarySean reduces attacks by 25%', () {
      final t = LegendarySean();
      final a = PowerSean();
      expect(t.healthPoints, 375);
      // Attack with 80; only 60 damage taken
      a.attackCard(t, points: 80);
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
}
