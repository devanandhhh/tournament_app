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
class FixtureScreen extends StatelessWidget {
  FixtureScreen(
      {super.key,
      this.docs,
      required this.documentlength,
      required this.trueorFalse});
//List<List<String?>>groupedTeams;
  var docs;
  int documentlength;
  bool trueorFalse;
  final user = FirebaseAuth.instance.currentUser!;
  late List<int> fixture2nd;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbardecorations(name: 'Matches'),
      backgroundColor: Colors.yellow[100],
      body: trueorFalse
          ? StreamBuilder(
              stream: FirebaseFirestore.instance
                  // .collection('fixtures')
                  // .where('tournamentID', isEqualTo: docs)
                  // .snapshots(),
                  .collection('tournament')
                  .doc(docs)
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

                //FirebaseFirestore.instance.collection('tournament').doc(docs).get();
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
                      scoreB: ''));
                  if (trueorFalse) {
                    FirebaseFirestore.instance.collection('fixtures').add({
                      'teamA': teamA['teamName'],
                      'teamB': teamB['teamName'],
                      'image1': teamA['teamImage'],
                      'image2': teamB['teamImage'],
                      'tournamentID': docs,
                      'scoreA': null,
                      'scoreB': null,
                      'scoreAdded': false
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
                  .where('tournamentID', isEqualTo: docs)
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
                          scoreB: scoreB);
                    },
                    separatorBuilder: (context, index) => sizedbox30(),
                    itemCount: snapshot.data!.docs.length);
              }),
      bottomNavigationBar: InkWell(
        onTap: () async {
          QuerySnapshot snapshot = await FirebaseFirestore.instance
              .collection('fixtures')
              .where('tournamentID', isEqualTo: docs)
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
          bool finalcheckTrueOrFalse = !trueorFalseList.contains(false);
          if (finalcheckTrueOrFalse) {
            //  QuerySnapshot fixturesnapshot =await FirebaseFirestore.instance.collection('fixtures').where('tournamentID',isEqualTo: docs).get();

            // for( var doc1 in snapshot.docs){
            //   int scoreA =doc1['scoreA'];
            //   int scoreB =doc1['scoreB'];
            //   if(scoreA<scoreB){
            //     fixture2nd.add()

            //   }
            // }

            navigatorPush(ctx: context, screen: const SecondFixture());
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
}
