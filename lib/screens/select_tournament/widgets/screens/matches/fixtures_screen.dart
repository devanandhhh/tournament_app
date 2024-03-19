
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tournament_creator/screens/addNotes/widgets/refactoring.dart';
import 'package:tournament_creator/screens/create_tounament/reuse_widgets/reuse_widgets.dart';
import 'package:tournament_creator/screens/home/reuse_widgets/refactoring.dart';
import 'package:tournament_creator/screens/select_tournament/widgets/reusable.dart';

import 'package:tournament_creator/screens/select_tournament/widgets/screens/matches/refactoringfixtures.dart';
import 'package:tournament_creator/screens/select_tournament/widgets/screens/matches/second_fixture.dart';

// ignore: must_be_immutable
class FixtureScreen extends StatefulWidget {
  FixtureScreen(
      {super.key,
      this.docs,
      required this.documentlength,
      required this.trueorFalse});
//List<List<String?>>groupedTeams;
  var docs;
  int documentlength;
  bool trueorFalse;
  

  @override
  State<FixtureScreen> createState() => _FixtureScreenState();
}

class _FixtureScreenState extends State<FixtureScreen> {
  final user = FirebaseAuth.instance.currentUser!;
bool? isoke ;
@override
  void initState() {
    flagFunction1();
   
    print(isoke);
    super.initState();
  
  }
 String? fixtureName='fixtures';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbardecorations(name: 'Matches'),
      backgroundColor: Colors.yellow[100],
      body: widget.trueorFalse
          ? StreamBuilder(
              stream: FirebaseFirestore.instance
                 
                  .collection('tournament')
                  .doc(widget.docs)
                  .collection('team')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text('no data available'),
                  );
                }

                List<Map<String, dynamic>> teams = [];
                for (var doc in snapshot.data!.docs) {
                  teams.add({
                    'teamName': doc['teamName'],
                    'teamImage': doc['teamImage']
                  });
                }

                
                //generate matches
                List<Widget> fixtureWidget = [];

                for (int i = 0; i < teams.length - 1; i += 2) {
              
                  var teamA = teams[i];
                  var teamB = teams[i + 1];
                  fixtureWidget.add(fixtures(
                      team1: teamA['teamName'],
                      team2: teamB['teamName'],
                      image1: teamA['teamImage'],
                      image2: teamB['teamImage'],
                      doc1: null,
                      scoreA: '',
                      scoreB: '',
                      fixtureName: fixtureName
                    ));
                  if (widget.trueorFalse) {
                    FirebaseFirestore.instance.collection('fixtures').add({
                      'teamA': teamA['teamName'],
                      'teamB': teamB['teamName'],
                      'image1': teamA['teamImage'],
                      'image2': teamB['teamImage'],
                      'tournamentID': widget.docs,
                      'scoreA': null,
                      'scoreB': null,
                      'scoreAdded': false,
                      'winnerName': null,
                      'winnerImg': null
                    });
                    print('score added false');
                  }
                }
                //return listview
                return ListView.separated(
                    itemBuilder: (context, index) {
                      //return
                      return fixtureWidget[index];
                    },
                    separatorBuilder: (context, index) => sizedbox30(),
                    itemCount: fixtureWidget.length);
              })
          : StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('fixtures')
                  .where('tournamentID', isEqualTo: widget.docs)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text('no data available'),
                  );
                }
                return ListView.separated(
                    itemBuilder: (context, index) {
                      var docc = snapshot.data!.docs[index];
                      String teamA = docc['teamA'];
                      String teamB = docc['teamB'];
                      String image1 = docc['image1'];
                      String image2 = docc['image2'];
                      String scoreA = docc['scoreA'] ?? '';
                      String scoreB = docc['scoreB'] ?? '';
                      return fixtures(
                          team1: teamA,
                          team2: teamB,
                          image1: image1,
                          image2: image2,
                          ctx: context,
                          doc1: docc.id,
                          scoreA: scoreA,
                          scoreB: scoreB,
                          fixtureName: fixtureName
                          );
                    },
                    separatorBuilder: (context, index) => sizedbox30(),
                    itemCount: snapshot.data!.docs.length);
              }),
      bottomNavigationBar: InkWell(
        onTap: () async {
              print('isoke is $isoke');
            
          QuerySnapshot snapshot = await FirebaseFirestore.instance
              .collection('fixtures')
              .where('tournamentID', isEqualTo: widget.docs)
              .get();

          if (snapshot.docs.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('No data available')));
            return;
          }

          List<bool> trueorFalseList = [];

          for (var doc in snapshot.docs) {
            bool isyesorNo = doc['scoreAdded'];
            trueorFalseList.add(isyesorNo);
            print(trueorFalseList);
          }
          List<Map<String, dynamic>> winners = [];
          bool finalcheckTrueOrFalse = !trueorFalseList.contains(false);

          if (finalcheckTrueOrFalse) {
            for (var doc in snapshot.docs) {
              String winnerName = doc['winnerName'];
              String winnerImg = doc['winnerImg'];
              winners.add({'winnerName': winnerName, 'winnerImg': winnerImg});
            }
            print('winners :$winners');

          
            if (isoke == true) {
              print('is oke is :$isoke');
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text(
                        'After creating  2nd fixtures you cant edit the 1st fixtures'),
                    actions: [
                      TextButton(
                          onPressed: () {
                           
                            navigatorPOP(context);
                          },
                          child: const Text('Go Back')),
                      TextButton(
                          onPressed: () async {
                           await FirebaseFirestore.instance
                                            .collection('tournament')
                                            .doc(widget.docs)
                                            .update({'flagtwo': false});
                                        setState(() {}); 

                           
                          
                            List<Widget> secondroundWidget = [];

                            for (int i = 0; i < winners.length - 1; i += 2) {
                              var teamA = winners[i];
                              var teamB = winners[i + 1];
                              secondroundWidget.add(fixtures(
                                  team1: teamA['winnerName'],
                                  team2: teamB['winnerName'],
                                  image1: teamA['winnerImg'],
                                  image2: teamB['winnerImg'],
                                  doc1: null,
                                  scoreA: '',
                                  scoreB: '',
                                  fixtureName: fixtureName
                                 ));

                              FirebaseFirestore.instance
                                  .collection('secondRound')
                                  .add({
                                'teamA': teamA['winnerName'],
                                'teamB': teamB['winnerName'],
                                'image1': teamA['winnerImg'],
                                'image2': teamB['winnerImg'],
                                'tournamentID': widget.docs,
                                'scoreA': null,
                                'scoreB': null,
                                'scoreAdded': false,
                                'winnerName': null,
                                'winnerImg': null
                              });
                              print('score added false');
                            }
                            //for disable the edit option in score screen
                            // await FirebaseFirestore.instance
                            //     .collection('tournament')
                            //     .doc(widget.docs)
                            //     .update({'flag2': false});
                            // setState(() {});

                            navigatorPush(
                                ctx: context,
                                screen: SecondFixture(
                                  secondRound: secondroundWidget,
                                  docs: widget.docs,
                                  winners: winners,
                                ));
                                navigatorPOP(context);
                          },
                          child: const Text('Create 2nd Round'))
                    ],
                  );
                },
              );
            } else {
            
              navigatorPush(
                  ctx: context,
                  screen: SecondFixture(
                    docs: widget.docs,
                    winners: winners,
                  ));
            }
           
          } else {
            trueorFalseList.clear();
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  scrollable: true,
                  title: Text(
                    'Go to Next Fixture',
                    style: tealcolor(),
                  ),
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Divider(),
                      Text(
                        'Conditions',
                        style: font17(),
                      ),
                      const Divider(),
                      Text(
                        'Score Not Be Null',
                        style: fontW24(),
                      ),
                      sizedbox10(),
                      Text(
                        'Add the Penalty score also ',
                        style: fontW24(),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          navigatorPOP(context);
                        },
                        child: const Text('Ok'))
                  ],
                );
              },
            );
            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Add the score , also the add the penalty score')));
          }
        },
        child: Container(
          decoration: const BoxDecoration(color: Colors.teal),
          height: 50,
          child: Center(
              child: Text(
            'Next Matches',
            style: font17(),
          )),
        ),
      ),
    );
  }
   flagFunction1() async {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await FirebaseFirestore.instance
            .collection('tournament')
            .doc(widget.docs)
            .get();
    isoke = documentSnapshot.get('flagtwo');
  }
}
