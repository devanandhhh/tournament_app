
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

  static addTournament1(
      {required selectImage,
      required tournamentNameController,
      required placeController,
      required dateController,
      required categoryCN,
      required limitsCN,
      required user}) async {
    await FirebaseFirestore.instance.collection('tournament').add({
      'TournamentImage': selectImage,
      "TournamentName": tournamentNameController.text,
      'Place': placeController.text,
      'Date': dateController.text,
      'Category': categoryCN,
      'LimitOfTeam': limitsCN,
      'userID': user
    });
  }

  static edittournament1(
      {required document1,
      required image,
      required tournamentNameController,
      required dateController,
      required placeController,
      required categoryy,
      required limits}) async {
    await FirebaseFirestore.instance
        .collection('tournament')
        .doc(document1)
        .update({
      'TournamentImage': image,
      'TournamentName': tournamentNameController.text,
      'Date': dateController.text,
      "Place": placeController.text,
      'Category': categoryy,
      'LimitOfTeam': limits,
    });
  }

  static addteam1(
      {required document,
      required teamNameController,
      required managerNameController,
      required phoneNumberController,
      required placeController,
      required seletedImage}) async {
    await FirebaseFirestore.instance
        .collection('tournament')
        .doc(document)
        .collection('team')
        .add({
      'teamName': teamNameController.text,
      'managerName': managerNameController.text,
      'phoneNumber': phoneNumberController.text,
      'place': placeController.text,
      'teamImage': seletedImage
    });
  }

  static editteam1({
    required document1,
    required document2,
    required teamImage,
    required teamNameController,
    required managerNameController,
    required phoneNumberController,
    required placeController,
  }) async {
    await FirebaseFirestore.instance
        .collection('tournament')
        .doc(document1)
        .collection('team')
        .doc(document2)
        .update({
      'teamImage': teamImage,
      "teamName": teamNameController.text,
      'managerName': managerNameController.text,
      'phoneNumber': phoneNumberController.text,
      'place': placeController.text
    });
  }

  static addplayer1(
      {required playerImage,
      required playerNameController,
      required playerAgeController,
      required playerID,
      required document1,
      required document2}) async {
    await FirebaseFirestore.instance.collection('players').add({
      'PlayerPhoto': playerImage,
      'PlayerName': playerNameController.text,
      'DateOfBirth': playerAgeController.text,
      'PlayerId': playerID,
      'tournamentID': document1,
      'teamID': document2,
    });
  }

  static editplayer1(
      {required document3,
      required playerphoto,
      required playerNameEditController,
      required playerAgeEditController,
      required playerid}) async {
    await FirebaseFirestore.instance
        .collection('players')
        .doc(document3)
        .update({
      'PlayerPhoto': playerphoto,
      'PlayerName': playerNameEditController.text,
      'DateOfBirth': playerAgeEditController.text,
      'PlayerId': playerid,
    });
  }
}
 