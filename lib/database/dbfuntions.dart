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

  static addTournament(
      {required selectImage,
      required tournamentNameController,
      required placeController,
      required dateController,
      required category,
      required limits}) async {
    await FirebaseFirestore.instance.collection('tournament_details').add({
      "TournamentImage": selectImage,
      'TournamentName': tournamentNameController.text,
      "Place": placeController.text,
      "Date": dateController.text,
      "Category": category,
      "LimitOfTeam": limits,
    });
  }

  static editTournament(
      {required documentId,
      required tournamentImage,
      required tournamentNameController,
      required dateController,
      required placeController,
      required category,
      required limits}) async {
    await FirebaseFirestore.instance
        .collection('tournament_details')
        .doc(documentId)
        .update({
      'TournamentImage': tournamentImage,
      'TournamentName': tournamentNameController.text,
      'Date': dateController.text,
      "Place": placeController.text,
      'Category': category,
      'LimitOfTeam': limits,
    });
  }

  static addTeam(
      {required document1,
      required teamNameController,
      required managerNameController,
      required phoneNumberController,
      required placeController,
      required imageSeleted}) async {
    await FirebaseFirestore.instance
        .collection('tournament_details')
        .doc(document1)
        .collection('team_details')
        .add({
      'teamName': teamNameController.text,
      'managerName': managerNameController.text,
      'phoneNumber': phoneNumberController.text,
      'place': placeController.text,
      'teamImage': imageSeleted
    });
  }

  static editTeam(
      {required document1,
      required document2ID,
      required teamImage,
      required teamNameController,
      required managerNameController,
      required phoneNumberController,
      required placeController}) async {
    await FirebaseFirestore.instance
        .collection('tournament_details')
        .doc(document1)
        .collection('team_details')
        .doc(document2ID)
        .update({
      'teamImage': teamImage,
      "teamName": teamNameController.text,
      'managerName': managerNameController.text,
      'phoneNumber': phoneNumberController.text,
      'place': placeController.text
    });
  }
  // static addUser({
  //   required
  // })
}
