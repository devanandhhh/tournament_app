import 'package:flutter/material.dart';
import 'package:tournament_creator/hive_model/notes.dart';
import 'package:tournament_creator/screens/addNotes/widgets/dbfunctions.dart';

fontW30() {
  return const TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );
}

fontW24() {
  return const TextStyle(fontWeight: FontWeight.normal, fontSize: 24);
}

fontW17() {
  return const TextStyle(
      fontSize: 18, letterSpacing: 2, fontWeight: FontWeight.w500);
}

scaffoldmessenger(BuildContext ctx) {
  return ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
    content: Text('Delete Sucessfully'),
    backgroundColor: Colors.green,
  ));
}

navigatorPOP(ctx) {
  return Navigator.of(ctx).pop();
}

updateToDataBase(String key, String titleText, String contentText) {
  final title = titleText;
  final content = contentText;
  update(Notes(title: title, content: content, key: key));
}

scaffoldmessAdded(ctx) {
  return ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
    content: Text('Added sucessfully'),
    backgroundColor: Colors.green,
  ));
}
