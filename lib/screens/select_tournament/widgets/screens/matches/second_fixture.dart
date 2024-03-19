import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tournament_creator/screens/addNotes/widgets/refactoring.dart';
import 'package:tournament_creator/screens/create_tounament/reuse_widgets/reuse_widgets.dart';
import 'package:tournament_creator/screens/home/reuse_widgets/refactoring.dart';
import 'package:tournament_creator/screens/select_tournament/widgets/reusable.dart';
import 'package:tournament_creator/screens/select_tournament/widgets/screens/matches/refactoringfixtures.dart';
import 'package:tournament_creator/screens/select_tournament/widgets/screens/matches/third_fixture.dart';

// ignore: must_be_immutable
class SecondFixture extends StatefulWidget {
  SecondFixture(
      {super.key, required this.docs, required this.winners, this.secondRound});
  var docs;
  var secondRound;
  List<Map<String, dynamic>> winners;

  @override
  State<SecondFixture> createState() => _SecondFixtureState();
}

class _SecondFixtureState extends State<SecondFixture> {
  String? fixtureName = 'secondRound';

  bool? isValue;
  @override
  void initState() {
    flagFunction1();

    print(isValue);
    super.initState(); 
  }

  flagFunction1() async {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await FirebaseFirestore.instance
            .collection('tournament')
            .doc(widget.docs)
            .get();
    isValue = documentSnapshot.get('flagthree');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellow[100],
        appBar: appbardecorations(name: 'Second Round Fixtures'),
        body:
         
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('secondRound')
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
                            fixtureName: fixtureName);
                      },
                      separatorBuilder: (context, index) => sizedbox30(),
                      itemCount: snapshot.data!.docs.length);
                }),
        bottomNavigationBar: InkWell(
          onTap: () async {
            print('is value is :$isValue');
            QuerySnapshot snapshot = await FirebaseFirestore.instance
                .collection('secondRound')
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
//adding
            if (finalcheckTrueOrFalse) {
              for (var doc in snapshot.docs) {
                String winnerName = doc['winnerName'];
                String winnerImg = doc['winnerImg'];
                winners.add({'winnerName': winnerName, 'winnerImg': winnerImg});
              }
              print('winners :$winners');

              if (isValue == true) {
                print('is oke is :$isValue');
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text(
                          'After creating  3nd fixtures you cant edit the 2st fixtures'),
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
                                  .update({'flagthree': false});
                              setState(() {});

                              List<Widget> thirdroundWidget = [];

                              for (int i = 0; i < winners.length - 1; i += 2) {
                                var teamA = winners[i];
                                var teamB = winners[i + 1];
                                thirdroundWidget.add(fixtures(
                                    team1: teamA['winnerName'],
                                    team2: teamB['winnerName'],
                                    image1: teamA['winnerImg'],
                                    image2: teamB['winnerImg'],
                                    doc1: null,
                                    scoreA: '',
                                    scoreB: '',
                                    fixtureName: fixtureName));

                                FirebaseFirestore.instance
                                    .collection('thirdRound')
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
                                  screen: ThirdFixture(
                                    docs: widget.docs,
                                    thirdRound: thirdroundWidget,
                                    winners: winners,
                                    // secondRound: secondroundWidget,
                                    // docs: widget.docs,
                                    // winners: winners,
                                  ));
                                  navigatorPOP(context); 
                            },
                            child: const Text('Create 3nd Round'))
                      ],
                    );
                  },
                );
              } else {
                navigatorPush(
                    ctx: context,
                    screen: ThirdFixture(
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
            //adding
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
        ));
  }
}
