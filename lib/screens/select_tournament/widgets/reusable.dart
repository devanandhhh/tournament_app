import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tournament_creator/database/dbfuntions.dart';
import 'package:tournament_creator/screens/addNotes/widgets/refactoring.dart';

tabtext(text) {
  return Tab(
    text: text,
  );
}

tealcolor() {
  return GoogleFonts.oswald(
      fontSize: 30, fontWeight: FontWeight.bold, color: Colors.teal);
  // const TextStyle(
  //     color: Colors.teal, fontWeight: FontWeight.bold, fontSize: 30);
}

font17() {
  return GoogleFonts.oswald(
      fontSize: 20,
      letterSpacing: 1,
      fontWeight: FontWeight.w500,
      color: Colors.black);
  // const TextStyle(
  //     color: Colors.black, fontSize: 17, fontWeight: FontWeight.w500);
}

underlineDecoration() {
  return UnderlineTabIndicator(
      borderSide: const BorderSide(width: 3.0, color: Colors.grey),
      borderRadius: BorderRadius.circular(6),
      insets: const EdgeInsets.symmetric(horizontal: 66.0));
}

boxteal() {
  return const TextStyle(
      color: Colors.white, fontSize: 17, fontWeight: FontWeight.w500);
}

textfontsize17({required String text}) {
  return Text(
    text,
    style: font17(),
  );
}

decorationshowdiag(String text) {
  return InputDecoration(border: const OutlineInputBorder(), labelText: text);
}

alertdialog2(
    {required ctx,
    required doc1,
    required doc2,
    required fileName,
    required foldername}) {
  return showDialog(
      context: ctx,
      builder: (context) {
        return AlertDialog(
            title: const Text('Delete Team'),
            content: const Text('Are you sure you want to delete Team '),
            actions: [
              TextButton(
                onPressed: () async {
                  try {
                    DatabaseFunctions.deleteFileteam(
                      fileName: fileName,
                    );
                  } catch (e) {
                    print('error in delete player :$e');
                  }

                  //navigatorPOP(context);
                  await FirebaseFirestore.instance
                      .collection('tournament')
                      .doc(doc1)
                      .collection('team')
                      .doc(doc2)
                      .delete();
                  // await FirebaseFirestore.instance
                  //     .collection('tournament_details')
                  //     .doc(doc1)
                  //     .collection('team_details')
                  //     .doc(doc2.id)
                  //     .delete();
                  try {
                    QuerySnapshot playerSnapshot = await FirebaseFirestore
                        .instance
                        .collection('players')
                        .where('teamID', isEqualTo: doc2)
                        .get();
                    for (DocumentSnapshot doc in playerSnapshot.docs) {
                      await doc.reference.delete();
                    }
                  } catch (e) {
                    print('Error is $e');
                  }

                  // ignore: use_build_context_synchronously
                  scaffoldmessenger(context);
                  // navigatorPOP(context);
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                },
                child: const Text('Yes'),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    // navigatorPOP(context);
                    print('doc2 is ${doc2}');
                  },
                  child: const Text('No'))
            ]);
      });
}

addTeamtxtController(TextEditingController teamController, String hinttext) {
  return TextFormField(
    autovalidateMode: AutovalidateMode.onUserInteraction,
    controller: teamController,
    decoration: const InputDecoration(border: OutlineInputBorder()),
    validator: (value) =>
        value == null || value.trim().isEmpty ? hinttext : null,
  );
}

addTeamPhoneController({required numbercontroller, required String? hintText}) {
  return TextFormField(
      maxLength: 10,
      controller: numbercontroller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return hintText;
        }
        if (value.length != 10) {
          return 'Phone number must be 10 digits.';
        }
        return null;
        // ? hintText : null,
      });
}

googleFont() {
  return GoogleFonts.ubuntu(
      color: Colors.teal, fontSize: 20, fontWeight: FontWeight.bold);
}

Future<int> getPlayerCount(String teamid) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('players')
      .where('teamID', isEqualTo: teamid)
      .get();
  return snapshot.docs.length;
}
