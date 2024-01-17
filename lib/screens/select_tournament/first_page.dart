import 'package:flutter/material.dart';
import 'package:tournament_creator/screens/select_tournament/widgets/reusable.dart';
import 'package:tournament_creator/screens/select_tournament/widgets/screens/teams/team_screen.dart';
//import 'package:tournament_creator/screens/create_tounament/reuse_widgets/reuse_widgets.dart';

class Firstscreen extends StatelessWidget {
  const Firstscreen({super.key, required this.title});
// ignore: prefer_typing_uninitialized_variables
  final title;

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
          body: const TabBarView(children: [
            Teamscreen(),
            Center(
              child: Text('Mathes are here'),
            ),
            Center(
              child: Text('players are here'),
            )
          ]),
        ));
  }
}
