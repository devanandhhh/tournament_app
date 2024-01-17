import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tournament_creator/screens/create_tounament/reuse_widgets/reuse_widgets.dart';
import 'package:tournament_creator/screens/list_Tournament/widgets/reuse.dart';
import 'package:tournament_creator/screens/select_tournament/first_page.dart';
import 'package:tournament_creator/screens/view_details/view_details.dart';

class TournmentList extends StatefulWidget {
  const TournmentList({super.key});

  @override
  State<TournmentList> createState() => _TournmentListState();
}

class _TournmentListState extends State<TournmentList> {
  List categories = ['7s', '9s', '11s'];
  List limitOfTeams = ['8 teams', '16 teams', '32 teams'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbardecorations(name: "Tournament List "),
        backgroundColor: Colors.yellow[100],
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('tournament_details')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text('no data available'),
              );
            }
            return ListView.separated(
                itemBuilder: (context, index) {
                  var docs = snapshot.data!.docs[index];
                  String tournamentName = docs['TournamentName'] ?? "";
                  String date = docs['Date'] ?? "";
                  String image = docs['TournamentImage'];
                  String place = docs['Place'];
                  String categoryy = docs['Category'];
                  String limits = docs['LimitOfTeam'];

                  TextEditingController tournamentNameController =
                      TextEditingController(text: docs['TournamentName']);
                  TextEditingController dateController =
                      TextEditingController(text: docs['Date']);
                  TextEditingController placeController =
                      TextEditingController(text: docs['Place']);

                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListTile(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Firstscreen(title:tournamentName,)));
                      },
                      leading: CircleAvatar(
                        backgroundColor: Colors.teal,
                        child: ClipOval(
                            child: Image.file(
                          File(image),
                          fit: BoxFit.cover,
                          width: 35,
                          height: 35,
                        )),
                      ),
                      title: Text(tournamentName),
                      subtitle: Text(date),
                      trailing: PopupMenuButton(
                        icon: const Icon(Icons.more_vert),
                        itemBuilder: (context) {
                          return [
                            PopupMenuItem(
                              child: const Text('View'),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ViewTournamentDetails(imageView: image,
                                                name: tournamentName,
                                                place: place,
                                                date: date,
                                                category: categoryy,
                                                limit: limits)));
                              },
                            ),
                            PopupMenuItem(
                              child: const Text('Edit'),
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        scrollable: true,
                                        title: const Text('Edit Data'),
                                        content: Column(children: [
                                          CircleAvatar(
                                            backgroundImage:
                                                FileImage(File(image)),
                                            maxRadius: 70,
                                            child: GestureDetector(
                                              onTap: () async {
                                                String? pickimage =
                                                    await pickImageFromGallery();
                                                setState(() {
                                                  image = pickimage!;
                                                });
                                              },
                                              child: ClipOval(
                                                  child: Image.file(
                                                File(image),
                                                fit: BoxFit.cover,
                                                width: 140,
                                                height: 140,
                                              )),
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              editingtextform(
                                                  labeltxt: 'Tournament Name',
                                                  controller:
                                                      tournamentNameController),
                                              editingtextform(
                                                  labeltxt: 'Date',
                                                  controller: dateController),
                                              editingtextform(
                                                  labeltxt: "Place",
                                                  controller: placeController),
                                              sizedbox10(),
                                              const Text('Category'),
                                              DropdownButtonFormField(
                                                  hint: Text(categoryy),
                                                  items: categories.map((e) {
                                                    return DropdownMenuItem(
                                                        value: e,
                                                        child: Text(e));
                                                  }).toList(),
                                                  onChanged: (value) {
                                                    //   setState(() {
                                                    //   categoryy=value.toString();
                                                    // });
                                                    if (categoryy != value) {
                                                      categoryy =
                                                          value.toString();
                                                    }
                                                  }),
                                              sizedbox10(),
                                              const Text('Limit of Team'),
                                              DropdownButtonFormField(
                                                  hint: Text(limits),
                                                  items: limitOfTeams.map((e) {
                                                    return DropdownMenuItem(
                                                      child: Text(e),
                                                      value: e,
                                                    );
                                                  }).toList(),
                                                  onChanged: (value) {
                                                    if (limits != value) {
                                                      limits = value.toString();
                                                    }
                                                  })
                                            ],
                                          ),
                                        ]),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('Cancel')),
                                          TextButton(
                                              onPressed: () async {
                                                await FirebaseFirestore.instance
                                                    .collection(
                                                        'tournament_details')
                                                    .doc(docs.id)
                                                    .update({
                                                  'TournamentName':
                                                      tournamentNameController
                                                          .text,
                                                  'Date': dateController.text,
                                                  "Place": placeController.text,
                                                  'Category': categoryy,
                                                  'LimitOfTeam': limits
                                                });
                                                tournamentNameController
                                                    .clear();
                                                dateController.clear();

                                                Navigator.of(context).pop();
                                                dataSucessSnackbar();
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                        updateSucessSnackbar());
                                              },
                                              child: const Text('Save'))
                                        ],
                                      );
                                    });
                              },
                            ),
                            PopupMenuItem(
                              child: const Text("Delete"),
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: ((BuildContext context) =>
                                        alertDialog1(
                                            ctx: context, docss: docs)));
                              },
                            )
                          ];
                        },
                      ),
                      // trailing: Row(
                      //   mainAxisSize: MainAxisSize.min,
                      //   children: [
                      //     IconButton(
                      //         onPressed: () {
                      //           showDialog(
                      //               context: context,
                      //               builder: (BuildContext context) {
                      //                 return AlertDialog(
                      //                   title: Text('Edit Data'),
                      //                   content: Column(children: [
                      //                     editingtextform(
                      //                         labeltxt: 'Tournament Name',
                      //                         controller:
                      //                             tournamentNameController),
                      //                     editingtextform(
                      //                         labeltxt: 'Date',
                      //                         controller: dateController)
                      //                   ]),
                      //                   actions: [
                      //                     TextButton(
                      //                         onPressed: () {
                      //                           Navigator.of(context).pop();
                      //                         },
                      //                         child: const Text('Cancel')),
                      //                     TextButton(
                      //                         onPressed: () async {
                      //                           await FirebaseFirestore.instance
                      //                               .collection(
                      //                                   'tournament_details')
                      //                               .doc(docs.id)
                      //                               .update({
                      //                             'TournamentName':
                      //                                 tournamentNameController
                      //                                     .text,
                      //                             'Date': dateController.text
                      //                           });
                      //                           tournamentNameController
                      //                               .clear();
                      //                           dateController.clear();

                      //                           Navigator.of(context).pop();
                      //                           print(
                      //                               'Data edited sucessfully ');
                      //                           ScaffoldMessenger.of(context)
                      //                               .showSnackBar(
                      //                                   const SnackBar(
                      //                             content: Text(
                      //                                 'Updated data Sucessfully '),
                      //                             backgroundColor: Colors.green,
                      //                           ));
                      //                         },
                      //                         child: const Text('Save'))
                      //                   ],
                      //                 );
                      //               });
                      //         },
                      //         icon: const Icon(Icons.edit)),
                      //     IconButton(
                      //       icon: const Icon(Icons.delete),
                      //       onPressed: () {
                      //         showDialog(
                      //             context: context,
                      //             builder: ((BuildContext context) =>
                      //                 alertDialog1(ctx: context, docss: docs)));
                      //       },
                      //     ),
                      //   ],
                      // ),
                      tileColor: Colors.amber[100],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(),
                itemCount: snapshot.data!.docs.length);
          },
        ));
  }
}
