import 'package:flutter/material.dart';
import 'package:tournament_creator/screens/select_tournament/widgets/reusable.dart';
import 'package:tournament_creator/screens/select_tournament/widgets/screens/matches/match_screen.dart';
import 'package:tournament_creator/screens/select_tournament/widgets/screens/teams/team_screen.dart';
import 'package:tournament_creator/screens/view_details/view_details.dart';

//import 'package:tournament_creator/screens/create_tounament/reuse_widgets/reuse_widgets.dart';

// ignore: must_be_immutable
class Firstscreen extends StatelessWidget {
  Firstscreen(
      {super.key,
      required this.title,
      required this.doc1,
      required this.details,
      });
// ignore: prefer_typing_uninitialized_variables
  final title;
// ignore: prefer_typing_uninitialized_variables
  var doc1;
  List<String> details;
  
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
            actions: [
              PopupMenuButton(
                icon: const Icon(
                  Icons.more_vert,
                  size: 30,
                ),
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                        child: const Text('View '),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ViewTournamentDetails(
                                      imageView: details[0],
                                      name: details[1],
                                      place: details[2],
                                      date: details[3],
                                      category: details[4],
                                      limit: details[5])));
                        }),
                    PopupMenuItem(
                      child: const Text('Edit '),
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => 
                        //            ));
                      },
                    ) 
                  ];
                },
              ),
              const SizedBox(
                width: 20,
              )
            ],
            bottom: TabBar(
              labelStyle: font17(),
              indicator: underlineDecoration(),
              indicatorColor: Colors.grey,
              labelColor: Colors.teal,
              tabs: [tabtext('Teams'), tabtext('Matches'), tabtext('Players')],
            ),
          ),
          body: TabBarView(children: [
            Teamscreen(
              doc1: doc1,
            ),
        const    Matchscreen(),
            Center(
              child: Text('players are here'),
            )
          ]),
        ));
  }
}
