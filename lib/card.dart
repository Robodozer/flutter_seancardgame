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
  void applyAttack(int points) {
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
    applyAttack(points);
  }
}
