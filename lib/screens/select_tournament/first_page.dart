import 'package:flutter/material.dart';
import 'package:tournament_creator/screens/select_tournament/widgets/reusable.dart';
import 'package:tournament_creator/screens/select_tournament/widgets/screens/matches/match_screen.dart';
import 'package:tournament_creator/screens/select_tournament/widgets/screens/teams/team_screen.dart';
//import 'package:tournament_creator/screens/create_tounament/reuse_widgets/reuse_widgets.dart';

// ignore: must_be_immutable
class Firstscreen extends StatelessWidget {
   Firstscreen({super.key, required this.title, this.doc1});
// ignore: prefer_typing_uninitialized_variables
  final title;
// ignore: prefer_typing_uninitialized_variables
var doc1;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 0,
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.yellow[100],
            title: Text(
              title,
              style: tealcolor(),
            ),
            bottom: TabBar(
              labelStyle:font17(),
             indicator: underlineDecoration(),
              indicatorColor: Colors.grey,
              labelColor: Colors.teal,
              tabs: [
                tabtext('Teams'),
                tabtext('Matches'),
                tabtext('Players')
              ],
            ),
          ),
          body:  TabBarView(children: [
            Teamscreen(doc1: doc1,),
            Matchscreen(),
            Center(
              child: Text('players are here'),
            )
          ]),
        ));
  }
}
