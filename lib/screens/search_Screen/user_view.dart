import 'package:flutter/material.dart';
import 'package:tournament_creator/screens/search_Screen/2screens/match_screen.dart';
import 'package:tournament_creator/screens/search_Screen/2screens/team_screen1.dart';
import 'package:tournament_creator/screens/select_tournament/widgets/reusable.dart';

// ignore: must_be_immutable
class UserView extends StatefulWidget {
  UserView({super.key, required this.tournamentname, required this.doc1});
  String tournamentname;
  var doc1;

  @override
  State<UserView> createState() => _UserViewState();
}


class _UserViewState extends State<UserView> {
  @override
  Widget build(BuildContext context) {
    print('userview ${widget.doc1}');
    return DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: Scaffold(
          backgroundColor: Colors.yellow[100],
          appBar: AppBar(
            backgroundColor: Colors.yellow[100],
            title: Text(
              widget.tournamentname,
              style: tealcolor(),
            ),
            
            bottom: TabBar(
                labelStyle: font17(),
                indicator: underlineDecoration(),
                indicatorColor: Colors.grey,
                labelColor: Colors.teal,
                tabs: [tabtext('Team'), tabtext('Matches')]),
          ),
          body: TabBarView(children: [
            TeamScreenView(
              doc1: widget.doc1.toString(),
            ),
            MatchScreenView(
              docu: widget.doc1,
            )
          ]),
        ));
  }
}
