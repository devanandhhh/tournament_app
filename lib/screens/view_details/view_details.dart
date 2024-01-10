import 'package:flutter/material.dart';
import 'package:tournament_creator/screens/create_tounament/reuse_widgets/reuse_widgets.dart';

class ViewTournamentDetails extends StatelessWidget {
   ViewTournamentDetails(
      {super.key,
      required this.name,
      required this.place,
      required this.date,
      required this.category,
      required this.limit});
  String name;
  String place;
  String date;
  String category;
  String limit;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbardecorations(name: "View details"),
      backgroundColor: Colors.yellow[100],
      body: Center(
          child: Container(
        height: 600,
        width: 300,
        decoration: BoxDecoration(
          color: Colors.amber[100],
          borderRadius: BorderRadius.circular(18),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Tournament Name'),
            Text(name),
          ]),
        ),
      )),
    );
  }
}
