import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tournament_creator/screens/addNotes/widgets/refactoring.dart';
import 'package:tournament_creator/screens/list_Tournament/widgets/reuse.dart';

class DatabaseFunctions {
  static editPlayer(
      {required document1,
      required document2,
      required document3ID,
      required String playerphoto,
      required playerNameEditController,
      required playerAgeEditController,
      required String playerid,
      required ctx}) async {
    await FirebaseFirestore.instance
        .collection('tournament_details')
        .doc(document1)
        .collection('team_details')
        .doc(document2)
        .collection('player_details')
        .doc(document3ID)
        .update({
      'PlayerPhoto': playerphoto,
      'PlayerName': playerNameEditController.text,
      'DateOfBirth': playerAgeEditController.text,
      'PlayerId': playerid
    });
    playerNameEditController.clear();
    playerAgeEditController.clear();
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(ctx).showSnackBar(updateSucessSnackbar());

    // ignore: use_build_context_synchronously
    navigatorPOP(ctx);
  }

  static deletePlayer(
      {required document1,
      required document2,
      required documentID,
      required ctx}) async {
    await FirebaseFirestore.instance
        .collection('tournament_details')
        .doc(document1)
        .collection('team_details')
        .doc(document2)
        .collection('player_details')
        .doc(documentID)
        .delete();
    navigatorPOP(ctx);
    scaffoldmessenger(ctx);
  }
}
