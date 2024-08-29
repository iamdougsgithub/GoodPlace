// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:good_place/core/resourcers/firebase_utils.dart';
import 'package:good_place/logger.dart';
import 'package:showcaseview/showcaseview.dart';

class TutorialManager extends FirebaseUtils {
  TutorialManager._() {
    assert(keyMap.length == TutorialKeys.values.length,
        "keyMap.length must be equal to  TutorialKeys.values.length");
  }

  static final TutorialManager _instance = TutorialManager._();

  static TutorialManager get ins => _instance;

  static final GlobalKey _calendar = GlobalKey(debugLabel: "calendar");
  static final GlobalKey _aiChat = GlobalKey(debugLabel: "aiChat");
  static final GlobalKey _createHabit = GlobalKey(debugLabel: "create habit");
  static final GlobalKey _motivationCard = GlobalKey(debugLabel: "motivation");
  static final GlobalKey _seeAll = GlobalKey(debugLabel: "see all");
  static final GlobalKey _habitCard = GlobalKey(debugLabel: "habit card");
  static final GlobalKey _statCard = GlobalKey(debugLabel: "stat card");
  static final GlobalKey _aiWriter = GlobalKey(debugLabel: "ai wirtie");
  static final GlobalKey _sortHabits = GlobalKey(debugLabel: "sort habit");
  static final GlobalKey _habitTile = GlobalKey(debugLabel: "habit tile");
  static final GlobalKey _imageContainer =
      GlobalKey(debugLabel: "Image Container");
  static final GlobalKey _habitDetailMotivationCard =
      GlobalKey(debugLabel: "_habitDetailMotivationCard");

  static Map _tutorialState = {};

  Map get tutorialState => _tutorialState;

  /// ```
  /// {
  /// TutorialKeys:GlobalKey
  /// }
  /// ```
  static Map<TutorialKeys, GlobalKey> keyMap = {
    TutorialKeys.calendar: _calendar,
    TutorialKeys.aiChat: _aiChat,
    TutorialKeys.createHabit: _createHabit,
    TutorialKeys.motivationCard: _motivationCard,
    TutorialKeys.seeAll: _seeAll,
    TutorialKeys.habitCard: _habitCard,
    TutorialKeys.statCard: _statCard,
    TutorialKeys.aiWriter: _aiWriter,
    TutorialKeys.sortHabits: _sortHabits,
    TutorialKeys.habitTile: _habitTile,
    TutorialKeys.imageContainer: _imageContainer,
    TutorialKeys.habitDetailMotivationCard: _habitDetailMotivationCard,
  };

  bool checkTutorialState(List<TutorialKeys> keys) {
    for (var key in keys) {
      if (_tutorialState.containsKey(key.name)) {
        return true;
      }
    }

    return false;
  }

  static List<TutorialKeys> habitDetailPageKeyList = [
    TutorialKeys.habitDetailMotivationCard,
  ];
  static List<TutorialKeys> homeTutorialKeList = [
    TutorialKeys.aiChat,
    TutorialKeys.calendar,
    TutorialKeys.motivationCard,
    TutorialKeys.seeAll,
    TutorialKeys.habitCard,
    TutorialKeys.createHabit,
    TutorialKeys.statCard,
  ];
  static List<TutorialKeys> createHabitPageTutorialKeList = [
    TutorialKeys.aiWriter,
    TutorialKeys.imageContainer,
  ];
  static List<TutorialKeys> myHabitsPageTutorialKeList = [
    TutorialKeys.sortHabits,
    TutorialKeys.habitTile,
  ];

  /// This function shows a [Showcase].
  show(BuildContext context, List<TutorialKeys> keys) {
    List<GlobalKey<State<StatefulWidget>>> _keyList =
        _convertTutorialKeysListToKeyList(keys);
    if (_keyList.isNotEmpty) {
      if (context.mounted) {
        Future.microtask(
            () => ShowCaseWidget.of(context).startShowCase(_keyList));
      }
    }
  }

  _convertTutorialKeysListToKeyList(List<TutorialKeys> keys) {
    List<GlobalKey<State<StatefulWidget>>> _keyList = [];
    for (var key in keys) {
      if (tutorialState[key.name] == null) {
        _keyList.add(keyMap[key]!);
      }
    }

    return _keyList;
  }

  onAutoPlayComplete(GlobalKey p1) async {
    var _key = keyMap.entries.where((e) => e.value == p1).first.key;
    await updateTutorialStateInFirebase({
      _key.name: true,
    });
  }

  Future updateTutorialStateInFirebase(
    Map<String, bool> tutorialData,
  ) async {
    tutorialState.addAll(tutorialData);
    await firestore.collection("users").doc(uid).update({
      "tutorialState": tutorialState,
    });
    await fetchTutorialStateFromFirebase();
  }

  Future fetchTutorialStateFromFirebase() async {
    final DocumentSnapshot<Map<String, dynamic>> userData =
        await firestore.collection("users").doc(uid).get();

    final Map fetchedTutorialState = userData.data()!["tutorialState"] ?? {};
    _tutorialState = fetchedTutorialState;
    // logger.i(_tutorialState);
  }
}

enum TutorialKeys {
  calendar(
      "Here, you can see the days you've completed your habits. If you tap on a specific day, you'll see a list of the habits you completed on that day.c"),
  aiChat(
      "Tap this button to chat with the AI about your habits. You can get suggestions and advice to improve your habits."),
  aiWriter("You can get suggestions and advice to improve your habits."),
  createHabit("Tap this button to create a new habit."),
  motivationCard(
      "This card displays a motivational message. Tap on it to change the message."),
  seeAll("Tap this to view all of your habits."),
  habitCard(
      "Tap this card to go to the habit details page. From this card, you can also mark the habit as completed."),
  statCard("StatCard Desc"),
  sortHabits(
      "Tap this button to sort your habits. You can organize them based on different criteria."),
  habitTile(
      "You can tap these cards to see your habit's detail. Also you can slide it right to check the habit and slide it left to delete it."),
  imageContainer("You can click here and search pictures from Unsplash."),
  habitDetailMotivationCard(
      "This card shows a personalized motivational message generated by our AI system to keep you inspired and on track with your habit goals."),
  ;

  final String tutorialDesc;
  const TutorialKeys(this.tutorialDesc);
}
