import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tournament_creator/screens/addNotes/widgets/refactoring.dart';
import 'package:tournament_creator/screens/home/reuse_widgets/refactoring.dart';
// import 'package:tournament_creator/screens/select_tournament/first_page.dart';
import 'package:tournament_creator/screens/select_tournament/widgets/reusable.dart';
import 'package:tournament_creator/screens/select_tournament/widgets/screens/matches/fixtures_screen.dart';
import 'package:tournament_creator/screens/select_tournament/widgets/screens/teams/team_screen.dart';

// ignore: must_be_immutable
class Matchscreen extends StatefulWidget {
  Matchscreen({
    super.key,
    this.docss,
    this.limit,
  });
  var docss;
  String? limit;

  @override
  State<Matchscreen> createState() => _MatchscreenState();
}

class _MatchscreenState extends State<Matchscreen> {
  bool isLoading = false;
  List<String?> teamNames = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[100],
      body: Center(
          child: Container(
              height: 50,
              width: 150,
              decoration: BoxDecoration(
                  color: Colors.teal, borderRadius: BorderRadius.circular(8)),
              child: InkWell(
                onTap: () async {
                  await FirebaseFirestore.instance
                      .collection('tournament')
                      .doc(widget.docss)
                      .collection('team')
                      .get()
                      .then((QuerySnapshot querySnapshot) async {
                    int documentlength = querySnapshot.size;

                    int iteamCount1 = iteamCount(a: widget.limit);
                    print(' Document Length  is :$documentlength');
                    print(' Iteam Count is :$iteamCount1');
                    if (documentlength == iteamCount1) {
                      // setState(() {
                      //   isEnabled = false;
                      //   print(isEnabled);
                      // });
                      // if (isEnabled == false) {
                      //   fetchTeamName();
                      //   List<List<String?>>grouped=[];
                      //   teamNames.shuffle();
                      //   for(int i=0;i<teamNames.length;i+=2){
                      //     List<String?>group=teamNames.sublist(i,i+2).toList();
                      //     grouped.add(group);
                      //   }
                      //   navigatorPush(ctx: context, screen: FixtureScreen(groupedTeams: grouped,));
                      // }

                       navigatorPush(ctx: context, screen: FixtureScreen(docs: widget.docss,documentlength: documentlength,));
                    } else {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Teams are not full '),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      navigatorPOP(context);
                                    },
                                    child: Text('Ok'))
                              ],
                            );
                          });
                    }
                  });
                },
                child: Center(
                    child: Text(
                  'View Matches',
                  style: boxteal(),
                )),
              ))),
    );
  }

  void startLoading() {
    setState(() {
      isLoading = true;
      Timer(Duration(seconds: 3), () {
// add the another screen
      });
    });
  }

  Future<void> fetchTeamName() async {
    try {
      QuerySnapshot<Map<String, dynamic>> teams = await FirebaseFirestore
          .instance
          .collection('tournament')
          .doc(widget.docss)
          .collection('team')
          .get();
      setState(() {
        teamNames =
            teams.docs.map((doc) => doc['teamName']).cast<String>().toList();
      });
    } catch (e) {
      print('error is $e');
    }
  }
}
