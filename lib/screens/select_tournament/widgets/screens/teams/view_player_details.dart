
import 'package:flutter/material.dart';
import 'package:tournament_creator/screens/create_tounament/reuse_widgets/reuse_widgets.dart';
import 'package:tournament_creator/screens/select_tournament/widgets/reusable.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';

// ignore: camel_case_types, must_be_immutable
class View_player_details extends StatelessWidget {
  View_player_details(
      {super.key,
      required this.teamName,
      required this.playerphoto,
      required this.playerName,
      required this.playerDoB,
      required this.playerProff});
  String playerphoto;
  String playerName;
  String playerDoB;
  String playerProff;
  String teamName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbardecorations(name: 'Player details'),
      backgroundColor: Colors.yellow[100],
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'Team Name   ',
              style: font17(),
            ),
            sizedbox10(),
            Text(
              teamName,
              style:googleFont()
              // TextStyle(fontSize: 23, fontWeight: FontWeight.w300),
            ),
            sizedbox10(),
            Text(
              'Player Photo',
              style: font17(),
            ),
            sizedbox10(),
            Container(
              height: 200,
              width: 180,
              decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.circular(10)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: InstaImageViewer(
                  child: Image.network(
                    playerphoto,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            sizedbox10(),
            Text(
              'Player Name',
              style: font17(),
            ),
            sizedbox10(),
            Text(
              playerName,
              style:googleFont()
            ),
            sizedbox10(),
            Text(
              'Date of Birth',
              style: font17(),
            ),
            sizedbox10(),
            Text(playerDoB,style: googleFont(),),
            sizedbox10(),
            Text(
              'Player ID Proof',
              style: font17(),
            ),
            sizedbox10(),
            Container(
              height: 200,
              width: 380,
              decoration: BoxDecoration(
                color: Colors.green[100],
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: InstaImageViewer(
                  child: Image.network(
                    playerProff,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),sizedbox10()
          ]),
        ),
      ),
    );
  }
}
