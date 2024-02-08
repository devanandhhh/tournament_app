import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tournament_creator/database/dbfuntions.dart';
import 'package:tournament_creator/screens/create_tounament/reuse_widgets/reuse_widgets.dart';
import 'package:tournament_creator/screens/list_Tournament/widgets/datePicker.dart';
import 'package:tournament_creator/screens/list_Tournament/widgets/reuse.dart';
import 'package:tournament_creator/screens/select_tournament/first_page.dart';
import 'package:tournament_creator/screens/view_details/reuse/reuse.dart';
import 'package:tournament_creator/screens/view_details/view_details.dart';

class TournmentList extends StatefulWidget {
  const TournmentList({super.key});

  @override
  State<TournmentList> createState() => _TournmentListState();
}

class _TournmentListState extends State<TournmentList> {
  final GlobalKey<ScaffoldMessengerState> scaffoldkey = GlobalKey();
  String? selectedImage;
  List categories = ['7s', '9s', '11s'];
  List <String> limitOfTeams = ['8 teams', '16 teams', '32 teams'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldkey,
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
                  List<String> viewDetails = [];
                  String tournamentName = docs['TournamentName'];
                  String date = docs['Date'];
                  String image = docs['TournamentImage'];
                  String place = docs['Place'];
                  String categoryy = docs['Category'];
                  String limits = docs['LimitOfTeam'];

                  selectedImage = image;
                  viewDetails.addAll(
                      [image, tournamentName, place, date, categoryy, limits]);
                     
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Firstscreen(
                                    title: tournamentName,
                                    doc1: docs.id,
                                    details: viewDetails,
                                    categories:categories,
                                    limitOfTeams: limitOfTeams,
                                    

                                   // detailsView: detailsView,
                                   // dateController: dateController,
                                    
                                    
                                   )));
                      },
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.teal,
                        child: ClipOval(
                            child: Image.file(
                          File(image),
                          fit: BoxFit.cover,
                          width: 50,
                          height: 50,
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
                                            ViewTournamentDetails(
                                                imageView: image,
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
                                        title: Text(
                                          'Edit Data',
                                          style: stylefont(),
                                        ),
                                        content: StatefulBuilder(
                                          builder: (context, setState) =>
                                              SingleChildScrollView(
                                            child: Column(children: [
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
                                                ),
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  editingtextform(
                                                      labeltxt:
                                                          'Tournament Name',
                                                      controller:
                                                          tournamentNameController),
                                                  DatePicker(
                                                      controller:
                                                          dateController,
                                                      labeltxt: 'Date'),
                                                  // editingtextformOntap(
                                                  //     labeltxt: 'Date',
                                                  //     controller:
                                                  //         dateController,context: context),

                                                  editingtextform(
                                                      labeltxt: "Place",
                                                      controller:
                                                          placeController),
                                                  sizedbox10(),
                                                  const Text('Category'),
                                                  DropdownButtonFormField(
                                                      hint: Text(categoryy),
                                                      items:
                                                          categories.map((e) {
                                                        return DropdownMenuItem(
                                                            value: e,
                                                            child: Text(e));
                                                      }).toList(),
                                                      onChanged: (value) {
                                                        if (categoryy !=
                                                            value) {
                                                          categoryy =
                                                              value.toString();
                                                        }
                                                      }),
                                                  sizedbox10(),
                                                  const Text('Limit of Team'),
                                                  DropdownButtonFormField(
                                                      hint: Text(limits),
                                                      items:
                                                          limitOfTeams.map((e) {
                                                        return DropdownMenuItem(
                                                          value: e,
                                                          child: Text(e),
                                                        );
                                                      }).toList(),
                                                      onChanged: (value) {
                                                        if (limits != value) {
                                                          limits =
                                                              value.toString();
                                                        }
                                                      })
                                                ],
                                              ),
                                            ]),
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                setState(() {
                                                  selectedImage = image;
                                                });
                                              },
                                              child: const Text('Cancel')),
                                          TextButton(
                                              onPressed: () async {
                                                await DatabaseFunctions
                                                    .editTournament(
                                                        documentId: docs.id,
                                                        tournamentImage: image,
                                                        tournamentNameController:
                                                            tournamentNameController,
                                                        dateController:
                                                            dateController,
                                                        placeController:
                                                            placeController,
                                                        category: categoryy,
                                                        limits: limits);
                                                tournamentNameController
                                                    .clear();
                                                dateController.clear();
                                                // ignore: use_build_context_synchronously
                                                Navigator.of(context).pop();
                                                dataSucessSnackbar();
                                                // ignore: use_build_context_synchronously
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
                                            ctx: context, docss: docs.id)));
                              },
                            )
                          ];
                        },
                      ),
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
