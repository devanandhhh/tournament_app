import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tournament_creator/screens/addNotes/widgets/refactoring.dart';

tabtext(text) {
  return Tab(
    text: text,
  );
}

tealcolor() {
  return const TextStyle(
      color: Colors.teal, fontWeight: FontWeight.bold, fontSize: 30);
}

font17() {
  return const TextStyle(
      color: Colors.black, fontSize: 17, fontWeight: FontWeight.w500);
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

alertdialog2(ctx, doc1, doc2) {
  return showDialog(
      context: ctx,
      builder: (context) {
        return AlertDialog(
            title: const Text('Delete Team'),
            content: const Text('Are you sure you want to delete Team '),
            actions: [
              TextButton(
                  onPressed: () {
                    navigatorPOP(ctx);
                  },
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () async {
                    navigatorPOP(ctx);
                    await FirebaseFirestore.instance
                        .collection('tournament_details')
                        .doc(doc1)
                        .collection('team_details')
                        .doc(doc2.id)
                        .delete();
                    scaffoldmessenger(ctx);
                  },
                  child: const Text('Ok'))
            ]);
      });
}

addTeamtxtController(TextEditingController teamController, String hinttext) {
  return TextFormField(
    controller: teamController,
    decoration: const InputDecoration(border: OutlineInputBorder()),
    validator: (value) => value == null || value.isEmpty ? hinttext : null,
  );
}

addTeamPhoneController({required numbercontroller,required String? hintText}) {
  return TextFormField(
    controller: numbercontroller,
    decoration: const InputDecoration(
      border: OutlineInputBorder(),
    ),
    keyboardType: TextInputType.number,
    validator: (value) => value == null || value.isEmpty ? hintText : null,
  );
}
