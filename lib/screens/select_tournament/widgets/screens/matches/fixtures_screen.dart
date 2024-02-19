import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tournament_creator/screens/create_tounament/reuse_widgets/reuse_widgets.dart';
import 'package:tournament_creator/screens/home/reuse_widgets/refactoring.dart';
// import 'package:tournament_creator/screens/home/reuse_widgets/refactoring.dart';
import 'package:tournament_creator/screens/select_tournament/widgets/screens/matches/refactoringfixtures.dart';

// ignore: must_be_immutable
class FixtureScreen extends StatelessWidget {
  FixtureScreen({
    super.key,
    this.docs,
    required this.documentlength,
  });
//List<List<String?>>groupedTeams;
  var docs;
  int documentlength;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbardecorations(name: 'Matches'),
      backgroundColor: Colors.yellow[100],
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
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
            return ListView.separated(
              itemBuilder: (context, index) {
                var docu = snapshot.data!.docs[index];
               // List<DocumentSnapshot>docx=snapshot.data!.docs;
                for (int i = 0; i < documentlength - 1; ) {
                  String? teamA = docu['teamName'];
i++;
                  String? teamB = docu['teamName'];
                  print('Team A :$teamA ,Team b :$teamB');
                 return fixtures(team1: teamA, team2: teamB);  
                }
                return null;
                
              },
              itemCount: (documentlength/2).ceil(),
              separatorBuilder: (BuildContext context, int index) {
                return sizedbox30(); 
              },
            );
          }

//       {
//         var docu=snapshot.data!.docs[index];
// for(int i=0;i<documentlength-1;i++){

//   fixtures(team1: team1, team2: team2)
// }

//       },
          ),
      // body: SafeArea(
      //     child: Column(
      //   children: [
      //     sizedbox10(),
      //   fixtures(team1: 'Team 1',team2: 'Team 2') ,
      //   sizedbox30(),
      //    fixtures(team1: 'Team 3',team2: 'Team 4') ,
      //    sizedbox30(),
      //     fixtures(team1: 'Team 5',team2: 'Team 6') ,
      //   sizedbox30(),
      //     fixtures(team1: 'Team 7',team2: 'Team 8') ,

      //   ],
      // )),
    );
  }

  fixturedisplay({required List<List<String?>> grouped1}) {
    for (int i = 0; i < grouped1.length; i++) {
      List<String?> g1 = grouped1[i];
      group(groups: g1);
    }
  }

  group({required List<String?> groups}) {
    String? a = groups[0];
    String? b = groups[1];
    return fixtures(team1: a!, team2: b!);
  }
}
