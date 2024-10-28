import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tournament_creator/screens/addNotes/widgets/refactoring.dart';
import 'package:tournament_creator/screens/home_Screen/reuse_widgets/refactoring.dart';
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
  bool? value1;
  @override
  State<Matchscreen> createState() => _MatchscreenState();
}

class _MatchscreenState extends State<Matchscreen> {
  bool isLoading = false;
  List<String?> teamNames = [];
  bool? value1;
  flagFunction1() async {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await FirebaseFirestore.instance
            .collection('tournament')
            .doc(widget.docss)
            .get();
    value1 = documentSnapshot.get('flag');
  }

  @override
  void initState() {
    super.initState();
    flagFunction1();
  }

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
                      if (value1 == true) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title:const Text(
                                    'After creating Fixtures you cant edit the Team details'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      navigatorPOP(context);
                                    },
                                    child:const Text('Go Back'),
                                  ),
                                  TextButton(
                                      onPressed: () async {
                                        navigatorPOP(context);
                                        navigatorPush(
                                            ctx: context,
                                            screen: FixtureScreen(
                                              docs: widget.docss,
                                              documentlength: documentlength,
                                              trueorFalse: value1!,
                                            ));
                                        await FirebaseFirestore.instance
                                            .collection('tournament')
                                            .doc(widget.docss)
                                            .update({'flag': false});
                                        setState(() {});
                                      },
                                      child:const Text('Go to Fixtures'))
                                ],
                              );
                            });
                      } else {
                        navigatorPush(
                            ctx: context,
                            screen: FixtureScreen(
                              docs: widget.docss,
                              documentlength: documentlength,trueorFalse: value1!,
                            ));
                      }
                    } else {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Need $iteamCount1 teams '),
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
