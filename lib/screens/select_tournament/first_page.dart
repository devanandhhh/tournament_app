import 'package:flutter/material.dart';
import 'package:tournament_creator/screens/select_tournament/widgets/reusable.dart';
import 'package:tournament_creator/screens/select_tournament/widgets/screens/matches/match_screen.dart';
import 'package:tournament_creator/screens/select_tournament/widgets/screens/players/players_screen.dart';
import 'package:tournament_creator/screens/select_tournament/widgets/screens/teams/team_screen.dart';
import 'package:tournament_creator/screens/view_details/view_details.dart';

// ignore: must_be_immutable
class Firstscreen extends StatefulWidget {
  Firstscreen(
      {super.key,
      required this.title,
      required this.doc1,
      required this.details,
      required this.limits,
      required this.limitOfTeams,
      this.uniqueId});
  final String title;
  dynamic doc1;
  late String limits;
  List? limitOfTeams;
  List<String> details;
  String? uniqueId;

  @override
  State<Firstscreen> createState() => _FirstscreenState();
}

class _FirstscreenState extends State<Firstscreen> {
  // ignore: prefer_typing_uninitialized_variables
  var docs;
  String? selectedImage;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.yellow[100],
          title: Text(
            widget.title,
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
                                  imageView: widget.details[0],
                                  name: widget.details[1],
                                  place: widget.details[2],
                                  date: widget.details[3],
                                  category: widget.details[4],
                                  limit: widget.details[5])));
                    },
                  ),
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
        body: TabBarView(
          children: [
            Teamscreen(
              doc1: widget.doc1,
              limit: widget.limits,
              uniqueId: widget.uniqueId,
            ),
            Matchscreen(docss: widget.doc1, limit: widget.limits),
            PlayerScreen(
              doc1: widget.doc1,
              uniqueId: widget.uniqueId,
            )
          ],
        ),
      ),
    );
  }
}
