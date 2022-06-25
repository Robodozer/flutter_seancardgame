import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_seancardgame/card.dart';
import 'package:flutter_seancardgame/card_set1.dart';
import 'package:flutter_seancardgame/card_set2.dart';
import 'package:flutter_seancardgame/card_set3.dart';
import 'package:google_fonts/google_fonts.dart';

enum GameTurn { mine, yours }

enum GamePlayState {
  waitStartTurn,
  waitSelectTarget,
  waitConfirmTurn,
}

List<SeanCard> allCards = [
  PowerSean(),
  SuperSean(),
  UltraSean(),
  LegendarySean(),
  FartSean(),
  TheFarrellFamily(),
  TheFarrellFamilyEx(),
  RockSean(),
  ZombieSean(),
  NinjaSean(),
  HappySean(),
  ThinkerSean(),
  Sean(),
  SatanSean(),
  CoolSean(),
  SuperiorSean(),
  RedSean(),
  OrangeSean(),
];

class GamePlay {
  List<SeanCard> myCards = [];
  List<SeanCard> yourCards = [];

  GameTurn turn = GameTurn.mine;
  GamePlayState playState = GamePlayState.waitStartTurn;

  String cardPlayedId = ''; // ID of card being played
  String cardTargetedId = ''; // ID of card being targeted

  void dealCards() {
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

    turn = GameTurn.mine;
    playState = GamePlayState.waitStartTurn;
    cardPlayedId = '';
    cardTargetedId = '';
    setCardModes(myCards, CardMode.canBePlayed);
    setCardModes(yourCards, CardMode.disabled);
  }

  SeanCard findCard(String id) {
    return myCards.firstWhere((e) => e.id == id,
        orElse: (() => yourCards.firstWhere((f) => f.id == id)));
  }

  setCardModes(List<SeanCard> cards, CardMode mode) {
    for (var e in cards) {
      e.setMode(mode);
    }
  }

  Widget playModeWidget(Function(String, CardEvent) eventCallback) {
    return Container(
        alignment: Alignment.center,
        child: IconButton(
            icon: const Icon(Icons.play_circle_fill), // Icons.unpublished
            iconSize: 72,
            onPressed: playState != GamePlayState.waitConfirmTurn
                ? null
                : () {
                    eventCallback("", CardEvent.turnConfirmed);
                  }));
  }

  List<Widget> yourCardWidgets(Function(String, CardEvent) eventCallback) {
    for (var e in yourCards) {
      log('build after dealing cards: $e');
    }
    return yourCards.map((f) => f.cardWidget(eventCallback)).toList();
  }

  List<Widget> myCardWidgets(Function(String, CardEvent) eventCallback) {
    for (var e in myCards) {
      log('build after dealing cards: $e');
    }
    return myCards.map((f) => f.cardWidget(eventCallback)).toList();
  }

  void eventClicked(String id, CardEvent event) {
    var playerCards = myCards;
    var targetCards = yourCards;
    if (turn == GameTurn.yours) {
      playerCards = yourCards;
      targetCards = myCards;
    }

    switch (event) {
      case CardEvent.playClicked:
        assert(playState == GamePlayState.waitStartTurn);
        assert(cardPlayedId == '');
        assert(cardTargetedId == '');
        cardPlayedId = id;
        setCardModes(playerCards, CardMode.disabled);
        findCard(cardPlayedId).setMode(CardMode.canBeUnplayed);
        setCardModes(targetCards, CardMode.canBeTargeted);
        playState = GamePlayState.waitSelectTarget;
        break;

      case CardEvent.unplayClicked:
        assert(playState == GamePlayState.waitSelectTarget);
        assert(cardPlayedId != '');
        assert(cardPlayedId == id);
        assert(cardTargetedId == '');
        cardPlayedId = '';
        setCardModes(playerCards, CardMode.canBePlayed);
        setCardModes(targetCards, CardMode.disabled);
        playState = GamePlayState.waitStartTurn;
        break;

      case CardEvent.targetClicked:
        assert(playState == GamePlayState.waitSelectTarget);
        assert(cardPlayedId != '');
        assert(cardTargetedId == '');
        cardTargetedId = id;
        setCardModes(targetCards, CardMode.disabled);
        findCard(cardPlayedId).setMode(CardMode.attacking);
        findCard(cardTargetedId).setMode(CardMode.canBeUntargeted);
        playState = GamePlayState.waitConfirmTurn;
        break;

      case CardEvent.untargetClicked:
        assert(playState == GamePlayState.waitConfirmTurn);
        assert(cardPlayedId != '');
        assert(cardTargetedId != '');
        assert(cardTargetedId == id);
        cardTargetedId = '';
        setCardModes(targetCards, CardMode.canBeTargeted);
        findCard(cardPlayedId).setMode(CardMode.canBeUnplayed);
        playState = GamePlayState.waitSelectTarget;
        break;

      case CardEvent.turnConfirmed:
        assert(playState == GamePlayState.waitConfirmTurn);
        assert(cardPlayedId != '');
        assert(cardTargetedId != '');
        findCard(cardPlayedId).setMode(CardMode.attacking);
        findCard(cardTargetedId).setMode(CardMode.beingAttacked);
        log("PLAYING TURN - Card $cardPlayedId attacking Card $cardTargetedId");
        log('ATTACKER: ${findCard(cardPlayedId)}');
        log('TARGET: ${findCard(cardTargetedId)}');

        // swap turn
        turn = (turn == GameTurn.mine) ? GameTurn.yours : GameTurn.mine;
        playState = GamePlayState.waitStartTurn;
        setCardModes(targetCards, CardMode.canBePlayed);
        setCardModes(playerCards, CardMode.disabled);
        cardPlayedId = '';
        cardTargetedId = '';
        break;

      default:
        assert(false);
    }
  }
}
