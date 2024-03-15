import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tournament_creator/screens/home/reuse_widgets/refactoring.dart';
import 'package:tournament_creator/screens/select_tournament/widgets/reusable.dart';
import 'package:tournament_creator/screens/select_tournament/widgets/screens/matches/refactoringfixtures.dart';

// ignore: must_be_immutable
class MatchScreenView extends StatelessWidget {
  MatchScreenView({super.key, required this.docu});
  var docu;

  @override
  Widget build(BuildContext context) {
    // return const Scaffold(body: Center(child: Text('Match  Screen')));
    return Scaffold(
      backgroundColor: Colors.yellow[100],
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                   Divider(),
                  Text('1st Fixture',style: tealcolor(),),  
                  Divider(),
                  Flexible(
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('fixtures')
                          .where('tournamentID', isEqualTo: docu)
                          .snapshots(),
                      builder: (context, snapshot) {
                        print('halo $docu');
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
                            return fixtureForUser(
                              team1: teamA,
                              team2: teamB,
                              image1: image1,
                              image2: image2,
                              scoreA: scoreA,
                              scoreB: scoreB,
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return sizedbox30();
                          },
                          itemCount: snapshot.data!.docs.length,
                        );
                      },
                    ),
                  ),
                  Divider(),
                  Text('2nd fixture',style: tealcolor(),), 
                  Divider(),
                 
                ],
              ),
            ),
             SizedBox(
              height:400 ,
              child: Column(
                children: [
                  
                  Flexible(
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('secondRound')  
                          .where('tournamentID', isEqualTo: docu)
                          .snapshots(),
                      builder: (context, snapshot) {
                        print('halo $docu');
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
                            return fixtureForUser(
                              team1: teamA,
                              team2: teamB,
                              image1: image1,
                              image2: image2,
                              scoreA: scoreA,
                              scoreB: scoreB,
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return sizedbox30();
                          },
                          itemCount: snapshot.data!.docs.length,
                        );
                      },
                    ),
                  ),
                   Divider(),
                  Text('3rd round',style: tealcolor(),),   
                  Divider(),
                ],
              ),
            ),  
               SizedBox(
              height:250 ,
              child: Column(
                children: [
                  
                  Expanded(
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('thirdRound')
                          .where('tournamentID', isEqualTo: docu)
                          .snapshots(),
                      builder: (context, snapshot) {
                        print('halo $docu');
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
                            return fixtureForUser(
                              team1: teamA,
                              team2: teamB,
                              image1: image1,
                              image2: image2,
                              scoreA: scoreA,
                              scoreB: scoreB,
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return sizedbox30();
                          },
                          itemCount: snapshot.data!.docs.length,
                        );
                      },
                    ),
                  ),
                   Divider(),
                  Text('Finished ',style: tealcolor(),),  
                  Divider(),
                ],
              ),
            ), 
          ],
        ),
      ),
    );
  }
}
