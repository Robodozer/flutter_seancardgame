import 'package:flutter/material.dart';
import 'package:flutter_seancardgame/card.dart';
import 'package:flutter_seancardgame/card_set1.dart';
import 'package:google_fonts/google_fonts.dart';

enum GameTurn { mine, yours }

enum GamePlayState {
  waitStartTurn,
  playCard,
  unplayCard,
  waitSelectTarget,
  selectTarget,
  unselectTarget,
  waitConfirmTurn,
  turnFinished,

  //waitStartYourTurn,
  //playYourCard,
  //unplayYourCard,
  //waitSelectYourTarget,
  //selectYourTarget,
  //unselectYourTarget,
  //waitConfirmYourTurn,
  //yourTurnFinished,
}

class GamePlay {
  List<SeanCard> myCards = [];
  List<SeanCard> yourCards = [];

  GameTurn turn = GameTurn.mine;
  GamePlayState playState = GamePlayState.waitStartTurn;

  String cardPlayedId = ''; // ID of card being played
  String cardTargetedId = ''; // ID of card being targeted

  void dealCards() {
    print('dealCards');
    myCards = [
      SuperSean(),
      TheFarrellFamilyEx(),
      LegendarySean(),
    ];

    yourCards = [
      FartSean(),
      PowerSean(),
      RockSean(),
    ];
  }

  GamePlay() {
    dealCards();
  }

  SeanCard findCard(String id) {
    return myCards.firstWhere((e) => e.id == id,
        orElse: (() => yourCards.firstWhere((f) => f.id == id)));
  }

  setCardModes(List<SeanCard> playerCards, List<SeanCard> targetCards) {
    switch (playState) {
      case GamePlayState.waitStartTurn:
        playerCards.map((e) => e.setMode(CardMode.canBePlayed));
        targetCards.map((e) => e.setMode(CardMode.disabled));
        break;

      case GamePlayState.playCard:
        // The card being played, has set its mode already
        findCard(cardPlayedId).setMode(CardMode.canBeUnplayed);
        break;

      case GamePlayState.waitSelectTarget:
        targetCards.map((e) => e.setMode(CardMode.canBeTargeted));
        break;

      case GamePlayState.selectTarget:
        // The card being played, has set its mode already
        targetCards.map((e) => e.setMode(CardMode.disabled));
        findCard(cardTargetedId).setMode(CardMode.canBeUntargeted);
        break;

      case GamePlayState.unplayCard:
        playerCards.map((e) => e.setMode(CardMode.canBePlayed));
        targetCards.map((e) => e.setMode(CardMode.disabled));
        cardPlayedId = '';
        break;

      case GamePlayState.waitConfirmTurn:
        findCard(cardPlayedId).setMode(CardMode.attacking);
        break;

      case GamePlayState.unselectTarget:
        targetCards.map((e) => e.setMode(CardMode.canBeTargeted));
        findCard(cardPlayedId).setMode(CardMode.canBeUnplayed);
        cardTargetedId = '';
        break;

      case GamePlayState.turnFinished:
        playerCards.map((e) => e.setMode(CardMode.disabled));
        targetCards.map((e) => e.setMode(CardMode.disabled));
        break;
    }
  }

  Widget playModeWidget() {
    return Container(
        alignment: Alignment.center,
        child: Stack(children: [
          Text('${GamePlayState.values[playState.index]}'.substring(14),
              textAlign: TextAlign.center,
              style: GoogleFonts.lexendDeca(
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 6
                    ..color = Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 19)),
          Text('${GamePlayState.values[playState.index]}'.substring(14),
              textAlign: TextAlign.center,
              style: GoogleFonts.lexendDeca(
                  fontWeight: FontWeight.bold, fontSize: 19)),
        ]));
  }

  List<Widget> yourCardWidgets() {
    for (var e in yourCards) print('build after dealing cards: ${e}');
    return yourCards.map((f) => f.cardWidget()).toList();
  }

  List<Widget> myCardWidgets() {
    for (var e in myCards) print('build after dealing cards: ${e}');
    return myCards.map((f) => f.cardWidget()).toList();
  }

  void playCard(String id) {
    if (turn == GameTurn.mine) {}
  }
}
