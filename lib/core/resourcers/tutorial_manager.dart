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

  static final GlobalKey _calendar = GlobalKey();
  static final GlobalKey _aiChat = GlobalKey();
  static final GlobalKey _createHabit = GlobalKey();
  static final GlobalKey _motivationCard = GlobalKey();
  static final GlobalKey _seeAll = GlobalKey();
  static final GlobalKey _habitCard = GlobalKey();
  static final GlobalKey _statCard = GlobalKey();

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
  };

  /// This function shows a [Showcase].
  show(BuildContext context, List<TutorialKeys> keys) {
    List<GlobalKey<State<StatefulWidget>>> _keyList = _checkTutorialState(keys);
    if (_keyList.isNotEmpty) {
      if (context.mounted) {
        Future.microtask(
            () => ShowCaseWidget.of(context).startShowCase(_keyList));
      }
    }
  }

  _checkTutorialState(List<TutorialKeys> keys) {
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
  }
}

enum TutorialKeys {
  calendar("Calendar Desc"),
  aiChat("AIChat Desc"),
  createHabit("CreateHabit Desc"),
  motivationCard("Motivation Desc"),
  seeAll("See All Desc"),
  habitCard("HabitCard Desc"),
  statCard("StatCard Desc"),
  ;

  final String tutorialDesc;
  const TutorialKeys(this.tutorialDesc);
}
