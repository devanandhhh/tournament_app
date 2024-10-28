import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:tournament_creator/database/firebase_model/dbfuntions.dart';
import 'package:tournament_creator/screens/addNotes/widgets/refactoring.dart';
import 'package:tournament_creator/screens/create_tounament/reuse_widgets/reuse_widgets.dart';
import 'package:tournament_creator/screens/list_Tournament/widgets/datePicker.dart';
import 'package:tournament_creator/screens/list_Tournament/widgets/reuse.dart';
import 'package:tournament_creator/screens/other/sample.dart';
import 'package:tournament_creator/screens/select_tournament/first_page.dart';
import 'package:tournament_creator/screens/select_tournament/widgets/reusable.dart';
import 'package:tournament_creator/screens/view_details/reuse/reuse.dart';
import 'package:tournament_creator/screens/view_details/view_details.dart';

// ignore: must_be_immutable
class TournmentList extends StatefulWidget {
  TournmentList({super.key, this.uniqueId});
  String? uniqueId;
  @override
  State<TournmentList> createState() => _TournmentListState();
}

class _TournmentListState extends State<TournmentList> {
  final GlobalKey<ScaffoldMessengerState> scaffoldkey = GlobalKey();
  String? selectedImage;
  List categories = ['7s', '9s', '11s'];
  List<String> limitOfTeams = ['8 teams', '16 teams', '32 teams'];
  final user = FirebaseAuth.instance.currentUser!;
  //----
  XFile? imageSelected;
  String? uniquenumber;
  String? urlImage;
  String? alreadySelectedImage;
  // String newImage = '';

  //---
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldkey,
        appBar: appbardecorations(name: "Tournament List "),
        backgroundColor: Colors.yellow[100],
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('tournament')
              .where('userID', isEqualTo: user.uid)
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
                  String limits1 = docs['LimitOfTeam'];
                  String filename = docs['UniqueFileName'];
                  alreadySelectedImage = image;
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
                                      limits: limits1,
                                      limitOfTeams: limitOfTeams,
                                    )));
                      },
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.teal,
                        child: ClipOval(
                            child: Image.network(
                          image,
                          //error builder
                          errorBuilder: ((context, error, stackTrace) =>
                              const Text('😢')),
                          //loading builder
                          loadingBuilder: (context, child, loadingProgress) {
                            final totalBytes =
                                loadingProgress?.expectedTotalBytes;
                            final bytesLoaded =
                                loadingProgress?.cumulativeBytesLoaded;
                            if (totalBytes != null && bytesLoaded != null) {
                              return CircularProgressIndicator(
                                backgroundColor: Colors.white70,
                                value: bytesLoaded / totalBytes,
                                color: Colors.teal[900],
                                strokeWidth: 5.0,
                              );
                            } else {
                              return child;
                            }
                          },
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
                                    // barrierDismissible: true,
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
                                              GestureDetector(
                                                onTap: () async {
                                                  // await imagePicking();
                                                  await obj.imagePicking();
                                                  setState(
                                                    () {},
                                                  );
                                                },
                                                child: CircleAvatar(
                                                  backgroundImage: obj
                                                          .imageLink.isEmpty
                                                      ? NetworkImage(image)
                                                      : Image.file(File(
                                                              obj.imageLink))
                                                          .image,
                                                  maxRadius: 70,
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

                                                  editingtextform(
                                                      labeltxt: "Place",
                                                      controller:
                                                          placeController),
                                                  sizedbox10(),
                                                  const Text('Category'),
                                                  sizedbox10(),
                                                  // Text(categoryy,style: font17(),),
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

                                                  sizedbox10(),
                                                  InkWell(
                                                    onTap: () =>
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                      SnackbarDecoraction()
                                                          .kSnakbar(
                                                        text:
                                                            "You Can't Edit this option after Creating",
                                                        col: Colors.red[300],
                                                      ),
                                                    ),
                                                    child: Text(
                                                      limits,
                                                      style: font17(),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ]),
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();

                                                obj.imageLink = '';
                                              },
                                              child: const Text('Cancel')),
                                          TextButton(
                                              onPressed: () async {
                                                obj.imageLink.isEmpty
                                                    ? DatabaseFunctions.edittournament1(
                                                        document1: docs.id,
                                                        image: image,
                                                        tournamentNameController:
                                                            tournamentNameController,
                                                        dateController:
                                                            dateController,
                                                        placeController:
                                                            placeController,
                                                        categoryy: categoryy,
                                                        uniquefileName:
                                                            filename,
                                                        limits: limits)
                                                    : uniquenumber = DateTime
                                                            .now()
                                                        .millisecondsSinceEpoch
                                                        .toString();
                                                dialogShowing(ctx: context);
                                                await FirebaseStorage.instance
                                                    .ref()
                                                    .child('TournamentImages')
                                                    .child(uniquenumber!)
                                                    .putFile(
                                                        File(obj.imageLink));
                                                urlImage = await FirebaseStorage
                                                    .instance
                                                    .ref()
                                                    .child('TournamentImages')
                                                    .child(uniquenumber!)
                                                    .getDownloadURL();
                                                try {
                                                  DatabaseFunctions
                                                      .deleteFiletournament(
                                                          unique: filename);
                                                  DatabaseFunctions.edittournament1(
                                                      document1: docs.id,
                                                      image: urlImage,
                                                      tournamentNameController:
                                                          tournamentNameController,
                                                      dateController:
                                                          dateController,
                                                      placeController:
                                                          placeController,
                                                      categoryy: categoryy,
                                                      uniquefileName:
                                                          uniquenumber,
                                                      limits: limits);

                                                  tournamentNameController
                                                      .clear();
                                                  obj.imageLink = '';
                                                  dateController.clear();
                                                  // ignore: use_build_context_synchronously
                                                  navigatorPOP(context);
                                                  dataSucessSnackbar();
                                                  // ignore: use_build_context_synchronously
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    //updateSucessSnackbar(),
                                                    SnackbarDecoraction()
                                                        .kSnakbar(
                                                      text:
                                                          'Update data Successfully ',
                                                      col: Colors.green[300],
                                                    ),
                                                  );
                                                } catch (e) {
                                                  log('gott error');
                                                }
                                                // ignore: use_build_context_synchronously
                                                navigatorPOP(context);
                                              },
                                              child: const Text('Save')),
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
                                            ctx: context,
                                            docss: docs.id,
                                            filename: filename)));
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
