import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DatabaseFunctions {

  //----For Tournaments------
  static addTournament1(
      {required selectImage,
      required uniquefileName,
      required tournamentNameController,
      required placeController,
      required dateController,
      required categoryCN,
      required limitsCN,
      required user}) async {
    await FirebaseFirestore.instance.collection('tournament').add({
      'TournamentImage': selectImage,
      'UniqueFileName': uniquefileName,
      "TournamentName": tournamentNameController.text,
      'Place': placeController.text,
      'Date': dateController.text,
      'Category': categoryCN,
      'LimitOfTeam': limitsCN,
      'userID': user,
      'flag': true,
      'flagtwo': true,
      'flagthree': true
    });
  }

  static edittournament1(
      {required document1,
      required image,
      required tournamentNameController,
      required dateController,
      required placeController,
      required categoryy,
      required uniquefileName,
      required limits}) async {
    await FirebaseFirestore.instance
        .collection('tournament')
        .doc(document1)
        .update({
      'TournamentImage': image,
      'UniqueFileName': uniquefileName,
      'TournamentName': tournamentNameController.text,
      'Date': dateController.text,
      "Place": placeController.text,
      'Category': categoryy,
      'LimitOfTeam': limits,
    });
  }
  

  //--------For Teams ------------
  static addteam1(
      {required document,
      required teamNameController,
      required managerNameController,
      required phoneNumberController,
      required placeController,
      required seletedImage,
      required uniquenumber}) async {
    await FirebaseFirestore.instance
        .collection('tournament')
        .doc(document)
        .collection('team')
        .add({
      'teamName': teamNameController.text,
      'managerName': managerNameController.text,
      'phoneNumber': phoneNumberController.text,
      'place': placeController.text,
      'teamImage': seletedImage,
      'uniqueFileName': uniquenumber
    });
  }

  static editteam1(
      {required document1,
      required document2,
      required teamImage,
      required teamNameController,
      required managerNameController,
      required phoneNumberController,
      required placeController,
      required uniquenumber}) async {
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
      'place': placeController.text,
      'uniqueFileName': uniquenumber
    });
  }



  //------For Players---------------
  static addplayer1(
      {required playerImage,
      required playerNameController,
      required playerAgeController,
      required playerID,
      required document1,
      required document2,
      required uniquenumber1,
      required uniquenumber2}) async {
    await FirebaseFirestore.instance.collection('players').add({
      'PlayerPhoto': playerImage,
      'PlayerName': playerNameController.text,
      'DateOfBirth': playerAgeController.text,
      'PlayerId': playerID,
      'tournamentID': document1,
      'teamID': document2,
      'uniqueFileName1': uniquenumber1,
      'uniqueFileName2': uniquenumber2
    });
  }

  static editplayer1(
      {required document3,
      required playerphoto,
      required playerNameEditController,
      required playerAgeEditController,
      required playerid,
      required uniquenumber1,
      required uniquenumber2}) async {
    await FirebaseFirestore.instance
        .collection('players')
        .doc(document3)
        .update({
      'PlayerPhoto': playerphoto,
      'PlayerName': playerNameEditController.text,
      'DateOfBirth': playerAgeEditController.text,
      'PlayerId': playerid,
      'uniqueFileName1': uniquenumber1,
      'uniqueFileName2': uniquenumber2
    });
  }

  //------------------------------------------------------------------

  //For Delete File   <--
  static Future<void> deleteFile(
      {required String fileName, required foldername}) async {
    try {
      await FirebaseStorage.instance
          .ref()
          .child(foldername)
          .child(fileName)
          .delete();
    } catch (e) {
      // print('error got it : $e');
      log('error got it : $e');
    }
  }

  static Future<void> deleteFileteam({required String fileName}) async {
    try {
      await FirebaseStorage.instance
          .ref()
          .child('TeamImages')
          .child(fileName)
          .delete();
    } catch (e) {
      log('error got it : $e');
    }
  }

  static Future<void> deleteFiletournament({required unique}) async {
    try {
      await FirebaseStorage.instance
          .ref()
          .child('TournamentImages')
          .child(unique)
          .delete();
      //print('delete from storage');
      log('delete from storage');
    } catch (e) {
      log('error got it : $e');
    }
  }
}
