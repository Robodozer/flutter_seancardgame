enum Rarity {
  common,
  uncommon,
  rare,
  superRare,
  legendary,
  epic,
  mythic,
  secret,
  exotic,
  insane,
}

class SeanCard {
  String name = "";
  int attackPoints = 0;
  int healthPoints = 0;
  int level = 1;
  int cost = 1; // Cost in post-its
  Rarity rarity = Rarity.common;
  String power = "None";
  bool alive = true;

  SeanCard(this.name, this.attackPoints, this.healthPoints, this.level,
      this.cost, this.rarity, this.power);

  String getCost() {
    if (cost < 100) return "$cost post-its (square)";
    int packs = cost ~/ 100;
    int postits = cost % 100;
    if (postits == 0) return "$packs post-it ${packs == 1 ? "pack" : "packs"}";
    if (postits == 50) return "$packs½ post-it packs";
    return "$packs ${packs == 1 ? "pack" : "packs"} $postits post-its";
  }

  int getAttackPoints() {
    return attackPoints;
  }

  int getHealthPoints() {
    return healthPoints;
  }

  // Apply every-turn powers to this and all other cards in my hand
  void applyEveryTurnPowers(List<SeanCard> cards, int turn) {}

  // Attack another card
  void attackCard(SeanCard target, {int turn = 0, int? points}) {
    target.processIncomingAttack(this, turn: turn, points: points);
  }

  // This card is attacked. Apply points and return if this card is still alive
  void _applyAttack(int points) {
    if (points < healthPoints) {
      healthPoints -= points;
    } else {
      healthPoints = 0;
      alive = false;
    }
  }

  // Handle attack from another card
  void processIncomingAttack(SeanCard attackingCard,
      {int turn = 0, int? points}) {
    points ??= attackingCard.attackPoints;
    _applyAttack(points);
  }
}

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
  bool attack(SeanCard attackingCard, {int turn = 0, int? points}) {
    points ??= attackingCard.attackPoints;

    if (!used) {
      used = true;
      points -= 40;
    }
    return applyAttack(points);
  }
}

// -------------- ULTRA SEAN ------------------
class UltraSean extends SeanCard {
  UltraSean()
      : super("Ultra Sean", 100, 150, 3, 30, Rarity.rare,
            "This card reflects 25% when 50 or more damage taken");

  @override
  bool attack(SeanCard attackingCard, {int turn = 0, int? points}) {
    points ??= attackingCard.attackPoints;

    if (points >= 50) {
      // Reflect 25% damage
      attackingCard.attack(this, turn: turn, points: points ~/ 4);
      points = (points * 3) ~/ 4;
    }
    return applyAttack(points);
  }
}

// -------------- LEGENDARY SEAN ------------------
class LegendarySean extends SeanCard {
  LegendarySean()
      : super("Legendary Sean", 200, 375, 4, 100, Rarity.legendary,
            "All attacks reduced by 25%");

  @override
  bool attack(SeanCard attackingCard, {int turn = 0, int? points}) {
    points ??= attackingCard.attackPoints;

    // Reduce damage by 25%
    points = (points * 3) ~/ 4;
    return applyAttack(points);
  }
}

// -------------- FART SEAN ------------------
class FartSean extends SeanCard {
  bool apply100ExtraDamageThisTurn = false;

  FartSean()
      : super("Fart Sean", 50, 125, 1, 100, Rarity.legendary,
            '''In every attack, this card farts on opponents, poisoning them,
            and dealing 100 extra damage every turn for 2 turns''');

  @override
  bool attack(SeanCard attackingCard, {int turn = 0, int? points}) {
    points ??= attackingCard.attackPoints;

    // Reduce damage by 25%
    points = (points * 3) ~/ 4;
    return applyAttack(points);
  }
}
