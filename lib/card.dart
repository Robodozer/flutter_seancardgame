enum Rarity {
  common,
  cncommon,
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
  final int level = 1;
  final int cost = 1; // Cost in post-its
  final Rarity rarity = Rarity.common;
  final String power = "None";

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

  // Apply powers when this card is played
  void applyPowersWhenPlayed(List<SeanCard> cards, int turn) {}

  // This card is attacked. Returns modified attack points
  int attacked(int points, int turn) { return points;}
}

class PowerSean extends SeanCard {
  PowerSean() :
    name : "Power Sean",
    attackPoints : 20,
    healthPoints : 40,
    level : 1,
    cost : 10,
    rarity : Rarity.common,
    power : "None";
}

class SuperSean extends SeanCard {

  // Has this been used this game?
  bool used = false;
  SuperSean() :
    name : "Super Sean",
    attackPoints : 50,
    healthPoints : 75,
    level : 2,
    cost : 15,
    rarity : Rarity.uncommon,
    power : "Shield 40 damage OPEG (Once Per Every Game)",
    used : false,
  {}

  // TODO: Figure out how to choose to apply the shield power 
  int attacked(int attackPoints, int turn)

}

class UltraSean extends SeanCard {
  UltraSean() :
    name : "Ultra Sean",
    attackPoints : 100,
    healthPoints : 150,
    level : 3,
    cost : 30,
    rarity : Rarity.rare,
    power : "This card reflects 25% when 50 or more damage taken",
    used : false,
  {}

}