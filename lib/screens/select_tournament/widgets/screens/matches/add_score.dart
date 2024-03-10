// import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tournament_creator/screens/addNotes/widgets/refactoring.dart';
import 'package:tournament_creator/screens/home/reuse_widgets/refactoring.dart';
import 'package:tournament_creator/screens/select_tournament/widgets/reusable.dart';
// import 'package:tournament_creator/screens/addNotes/widgets/refactoring.dart';
// import 'package:tournament_creator/screens/home/reuse_widgets/refactoring.dart';
// import 'package:tournament_creator/screens/select_tournament/widgets/reusable.dart';
// import 'package:tournament_creator/screens/select_tournament/widgets/screens/matches/players_view/players_view.dart';

// ignore: must_be_immutable
class AddScore extends StatelessWidget {
  AddScore(
      {super.key,
      required this.team1,
      required this.team2,
      required this.image1,
      required this.image2,
      required this.doc1,
      required this.scoreA,
      required this.scoreB});
  String? scoreA;
  String? scoreB;
  TextEditingController team1ScoreController = TextEditingController();
  TextEditingController team2ScoreController = TextEditingController();
  String? image1;
  String? image2;
  String? team1;
  String? team2;
  var doc1;
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[100],
      appBar: AppBar(
        backgroundColor: Colors.yellow[100],
        title: Text(
          'Add Score',
          style: tealcolor(),
        ),
        actions: [
          IconButton(
            onPressed: () {
              if (formkey.currentState!.validate()) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Do you want to Save? '),
                    actions: [
                      TextButton(
                          onPressed: () {
                            navigatorPOP(context);
                          },
                          child: const Text('No')),
                      TextButton(
                          onPressed: () async {
                            bool falseOrNot;
                            navigatorPOP(context);
                            navigatorPOP(context);
                            team1ScoreController.text ==
                                    team2ScoreController.text
                                ? falseOrNot = false
                                : falseOrNot = true;

                            await FirebaseFirestore.instance
                                .collection('fixtures')
                                .doc(doc1)
                                .update({
                              'scoreA': team1ScoreController.text,
                              'scoreB': team2ScoreController.text,
                              'scoreAdded': falseOrNot
                            });

                            print('score added true');
                          },
                          child: const Text('Yes ')),
                    ],
                  ),
                );
              } else {
                print(' please enter score');
              }
            },
            icon: const Icon(
              Icons.check_circle_outline_outlined,
              size: 30,
            ),
          ),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      body: Column(
        // crossAxisAlignment : CrossAxisAlignment.start ,
        children: [
//

          Padding(
            padding: const EdgeInsets.only(left: 30, top: 10, right: 30),
            child: Container(
              height: 140,
              width: 330,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.amber[100]),
              child: Column(children: [
                sizedbox30(),
                Form(
                  key: formkey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const SizedBox(
                        width: 5,
                      ),
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                            color: Colors.teal,
                            borderRadius: BorderRadius.circular(10)),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              image1!,
                              fit: BoxFit.cover,
                            )
                            //  Image.file(
                            //   File(image1!),
                            //   fit: BoxFit.cover,
                            // ),
                            ),
                      ),
                      Container(
                        height: 40,
                        width: 25,
                        //   decoration: BoxDecoration(
                        color: Colors.amber[100],
                        //     borderRadius: BorderRadius.circular(10)),
                        child: TextFormField(
                          maxLength: 1,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return 'Null';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: '  $scoreA',
                              counter: SizedBox.shrink()),
                          controller: team1ScoreController,
                          keyboardType: TextInputType.number,
                          style: font17(),
                        ),
                      ),
                      Text(
                        'VS',
                        style: font17(),
                      ),
                      Container(
                        height: 40,
                        width: 25,
                        //  decoration: BoxDecoration(
                        color: Colors.amber[100],
                        //   borderRadius: BorderRadius.circular(10)),
                        child: TextFormField(
                          maxLength: 1,
                          decoration: InputDecoration(
                            hintText: '  $scoreB',
                            counter: SizedBox.shrink(),
                          ),
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return 'Null';
                            }
                            return null;
                          },
                          controller: team2ScoreController,
                          keyboardType: TextInputType.number,
                          style: font17(),
                        ),
                      ),
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                            color: Colors.teal,
                            borderRadius: BorderRadius.circular(10)),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              image2!,
                              fit: BoxFit.cover,
                            )
                            // Image.file(
                            //   File(image2!),
                            //   fit: BoxFit.cover,
                            // ),
                            ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(team1 ?? 'team1'),
                    SizedBox(
                      width: 10,
                    ),
                    Text(team2 ?? 'team2')
                  ],
                )
              ]),
            ),
          ),
          //  sizedbox70(),
          Padding(
            padding: const EdgeInsets.all(28.0),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center ,
              children: [
                Divider(),
                Text(
                  'Add Highlights',
                  style: tealcolor(),
                ),
                Divider()
              ],
            ),
          )
        ],
      ),
    );
  }
}
