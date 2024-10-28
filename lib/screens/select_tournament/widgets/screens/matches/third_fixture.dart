import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tournament_creator/screens/create_tounament/reuse_widgets/reuse_widgets.dart';
import 'package:tournament_creator/screens/home_Screen/reuse_widgets/refactoring.dart';
import 'package:tournament_creator/screens/select_tournament/widgets/screens/matches/refactoringfixtures.dart';

// ignore: must_be_immutable
class ThirdFixture extends StatefulWidget {
  ThirdFixture(
      {super.key, required this.docs, required this.winners, this.thirdRound});
  var docs;
  var thirdRound;
  List<Map<String, dynamic>> winners;
  @override
  State<ThirdFixture> createState() => _ThirdFixtureState();
}

class _ThirdFixtureState extends State<ThirdFixture> {
  String? fixtureName = 'thirdRound';
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
    isValue = documentSnapshot.get('flagfour');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[100],
      appBar: appbardecorations(name: 'Third Round Fixture'),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('thirdRound')
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
        },
      ),
    );
  }
}
