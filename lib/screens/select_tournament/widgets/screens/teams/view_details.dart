
import 'package:flutter/material.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:tournament_creator/screens/create_tounament/reuse_widgets/reuse_widgets.dart';
import 'package:tournament_creator/screens/view_details/reuse/reuse.dart';

// ignore: must_be_immutable
class ViewTeamDetails extends StatelessWidget {
  ViewTeamDetails(
      {super.key,
      required this.imageview,
      required this.teamName,
      required this.managerName,
      required this.phoneNumber,
      required this.placeName});
  String imageview;
  String teamName;
  String managerName;
  String phoneNumber;
  String placeName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbardecorations(name: 'Details of Team'),
      backgroundColor: Colors.yellow[100],
      body: Center(
          child: Container(
        height: 550,
        width: 300,
        decoration: BoxDecoration(
            color: Colors.amber[100], borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            InstaImageViewer(
              child: CircleAvatar(
                radius: 105,
                backgroundColor: Colors.teal,
                child: ClipOval(
                    child: Image.network(
                  imageview,
                  fit: BoxFit.cover,
                  width: 200,
                  height: 200,
                )),
              ),
            ),
            Text(
              'Team Name ',
              style: stylefont(),
            ),
            sizedbox10(),
            Text(
              teamName,
              style: styleTeal(),
            ),
            sizedbox10(),
            Text(
              'Manager Name',
              style: stylefont(),
            ),
            sizedbox10(),
            Text(
              managerName,
              style: styleTeal(),
            ),
            sizedbox10(),
            Text(
              'Phone Number',
              style: stylefont(),
            ),
            sizedbox10(),
            Text(
              phoneNumber,
              style: styleTeal(),
            ),
            sizedbox10(),
            Text(
              'Place',
              style: stylefont(),
            ),
            sizedbox10(),
            Text(
              placeName,
              style: styleTeal(),
            ),
            sizedbox10(),
          ]),
        ),
      )),
    );
  }
}
