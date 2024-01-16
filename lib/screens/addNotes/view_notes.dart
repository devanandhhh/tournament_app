import 'package:flutter/material.dart';
import 'package:tournament_creator/hive_model/notes.dart';
import 'package:tournament_creator/screens/addNotes/widgets/refactoring.dart';
import 'package:tournament_creator/screens/create_tounament/reuse_widgets/reuse_widgets.dart';

// ignore: must_be_immutable
class ViewScreen extends StatelessWidget {
  const ViewScreen({super.key, this.notes});

  final Notes? notes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbardecorations(name: 'View Notes'),
      backgroundColor: Colors.yellow[100],
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sizedbox10(),
              Text(
                'Title',
                style: fontW30(),
              ),
              Text(
                notes!.title!,
                style: fontW24(),
              ),
              Text(
                'Content ',
                style: fontW30(),
              ),
              Text(
                notes!.content!,
                style: fontW24(),
              )
        ]),
      ),
    );
  }

  
}
