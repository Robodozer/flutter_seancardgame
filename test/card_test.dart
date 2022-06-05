import 'package:test/test.dart';
import 'package:flutter_seancardgame/card.dart';

void main() {
  group('PowerSean', () {
    test('PowerSean initializes', () {
      final power = PowerSean();
      expect(power.name, 'Power Sean');
    });

    test('PowerSean attack stays alive', () {
      final power = PowerSean();
      final c = PowerSean();
      c.attackPoints = 20;
      expect(power.attack(c), true);
      expect(power.alive, true);
    });

    test('PowerSean attack dead', () {
      final power = PowerSean();
      final c = PowerSean();
      c.attackPoints = 10;
      expect(power.attack(c), true);
      expect(power.alive, true);
      expect(power.healthPoints, 30);
      // attack with points override
      expect(power.attack(c, points: power.healthPoints + 1), false);
      expect(power.alive, false);
    });

    test('PowerSean cost strings', () {
      final power = PowerSean();
      expect(power.getCost(), "10 post-its (square)");
      power.cost = 100;
      expect(power.getCost(), "1 post-it pack");
      power.cost = 120;
      expect(power.getCost(), "1 pack 20 post-its");
      power.cost = 150;
      expect(power.getCost(), "1½ post-it packs");
      power.cost = 200;
      expect(power.getCost(), "2 post-it packs");
      power.cost = 260;
      expect(power.getCost(), "2 packs 60 post-its");
    });
  });

  group('SuperSean', () {
    test('SuperSean shields damage', () {
      final s = SuperSean();
      final c = PowerSean();
      expect(s.healthPoints, 75);
      // Attack with 80; stays alive since we shielded 40
      expect(s.attack(c, points: 80), true);
      expect(s.healthPoints, 75 + 40 - 80);
      // Second attack roasts
      expect(s.attack(c, points: 50), false);
    });
  });

  group('UltraSean', () {
    test('UltraSean attack with <50', () {
      final c = PowerSean();
      final s = UltraSean();
      expect(s.healthPoints, 150);
      // Attack with 40; takes full damage
      c.attackPoints = 40;
      expect(s.attack(c), true);
      expect(s.healthPoints, 110);
      // Attack with 40; takes full damage
      expect(s.attack(c), true);
      expect(s.healthPoints, 70);
      // Attack with 40; takes full damage
      expect(s.attack(c), true);
      expect(s.healthPoints, 30);
      // Attack with 40; takes full damage and dies
      expect(s.attack(c), false);
      expect(s.healthPoints, 0);
    });
    test('UltraSean attack with >=50, reflect 25%', () {
      final c = PowerSean();
      final s = UltraSean();
      expect(s.healthPoints, 150);
      expect(c.healthPoints, 40);
      // Attack with 60; reflect 25%
      expect(s.attack(c, points: 60), true);
      expect(s.healthPoints, 150 - (60 * 0.75));
      // c took damage as well
      expect(c.healthPoints, 25);
    });
  });

  group('LegendarySean', () {
    test('LegendarySean reduces attacks by 25%', () {
      final s = LegendarySean();
      final c = PowerSean();
      expect(s.healthPoints, 375);
      // Attack with 80; only 60 damage taken
      expect(s.attack(c, points: 80), true);
      expect(s.healthPoints, 315);
    });
  });

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
}
