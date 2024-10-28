import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tournament_creator/screens/addNotes/home_notes.dart';
import 'package:tournament_creator/screens/addNotes/widgets/refactoring.dart';
import 'package:tournament_creator/screens/create_tounament/reuse_widgets/reuse_widgets.dart';
import 'package:tournament_creator/screens/home_Screen/reuse_widgets/refactoring.dart';
import 'package:tournament_creator/screens/select_tournament/widgets/reusable.dart';

// ignore: must_be_immutable
class AddScore extends StatefulWidget {
  AddScore(
      {super.key,
      required this.team1,
      required this.team2,
      required this.image1,
      required this.image2,
      required this.doc1,
      required this.scoreA,
      required this.scoreB,
      required this.fixtureName});
  String? scoreA;
  String? scoreB;
  String? image1;
  String? image2;
  String? team1;
  String? team2;
  String fixtureName;
  var doc1;

  @override
  State<AddScore> createState() => _AddScoreState();
}

class _AddScoreState extends State<AddScore> {
  TextEditingController team1ScoreController = TextEditingController();

  TextEditingController team2ScoreController = TextEditingController();

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
            onPressed: () async {
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
                            //checking
                            team1ScoreController.text ==
                                    team2ScoreController.text
                                ? falseOrNot = false
                                : falseOrNot = true;
                            String? winnerName;
                            String? winnerImage;
                            int team1Score =
                                int.parse(team1ScoreController.text);
                            int team2Score =
                                int.parse(team2ScoreController.text);

                            if (falseOrNot) {
                              if (team1Score > team2Score) {
                                winnerName = widget.team1;
                                winnerImage = widget.image1;
                              } else {
                                winnerName = widget.team2;
                                winnerImage = widget.image2;
                              }
                            }

                            await FirebaseFirestore.instance
                                .collection(widget.fixtureName)
                                .doc(widget.doc1)
                                .update({
                              'scoreA': team1ScoreController.text,
                              'scoreB': team2ScoreController.text,
                              'scoreAdded': falseOrNot,
                              'winnerName': winnerName,
                              'winnerImg': winnerImage
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
      body: SingleChildScrollView(
        child: Column(
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
                                widget.image1!,
                                //error builder
                                errorBuilder: ((context, error, stackTrace) =>
                                    Center(child: const Text('😢'))),
                                //loading builder
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  final totalBytes =
                                      loadingProgress?.expectedTotalBytes;
                                  final bytesLoaded =
                                      loadingProgress?.cumulativeBytesLoaded;
                                  if (totalBytes != null &&
                                      bytesLoaded != null) {
                                    return Center(
                                      child: CircularProgressIndicator(
                                        backgroundColor: Colors.white70,
                                        value: bytesLoaded / totalBytes,
                                        color: Colors.teal[900],
                                        strokeWidth: 5.0,
                                      ),
                                    );
                                  } else {
                                    return child;
                                  }
                                },
                                fit: BoxFit.cover,
                              )),
                        ),
                        Container(
                          height: 40,
                          width: 25,
                          color: Colors.amber[100],
                          child: TextFormField(
                            maxLength: 1,
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return 'Null';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                hintText: '  ${widget.scoreA}',
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
                              hintText: '  ${widget.scoreB}',
                              counter: const SizedBox.shrink(),
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
                                widget.image2!,
                                //error builder
                                errorBuilder: ((context, error, stackTrace) =>
                                    const Text('😢')),
                                //loading builder
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  final totalBytes =
                                      loadingProgress?.expectedTotalBytes;
                                  final bytesLoaded =
                                      loadingProgress?.cumulativeBytesLoaded;
                                  if (totalBytes != null &&
                                      bytesLoaded != null) {
                                    return Center(
                                      child: CircularProgressIndicator(
                                        backgroundColor: Colors.white70,
                                        value: bytesLoaded / totalBytes,
                                        color: Colors.teal[900],
                                        strokeWidth: 5.0,
                                      ),
                                    );
                                  } else {
                                    return child;
                                  }
                                },
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
                      Text(widget.team1 ?? 'team1'),
                      SizedBox(
                        width: 10,
                      ),
                      Text(widget.team2 ?? 'team2')
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
                    'Add Notes Here',
                    style: tealcolor(),
                  ),
                  Divider(),
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 150),
                      child: InkWell(
                        child: containerButtonCR(txt: 'Click here'),
                        onTap: () {
                          navigatorPush(ctx: context, screen: AddNotes());
                        },
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
