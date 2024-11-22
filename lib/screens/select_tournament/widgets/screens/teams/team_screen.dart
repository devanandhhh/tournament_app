import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:tournament_creator/database/firebase_model/dbfuntions.dart';
import 'package:tournament_creator/screens/other/sample.dart';
import 'package:tournament_creator/screens/addNotes/widgets/refactoring.dart';
import 'package:tournament_creator/screens/create_tounament/reuse_widgets/reuse_widgets.dart';
import 'package:tournament_creator/screens/home_Screen/reuse_widgets/refactoring.dart';
import 'package:tournament_creator/screens/select_tournament/widgets/reusable.dart';
import 'package:tournament_creator/screens/select_tournament/widgets/screens/teams/add_players.dart';
import 'package:tournament_creator/screens/select_tournament/widgets/screens/teams/add_team.dart';
import 'package:tournament_creator/screens/select_tournament/widgets/screens/teams/view_details.dart';
import 'package:tournament_creator/screens/view_details/reuse/reuse.dart';

// ignore: must_be_immutable
class Teamscreen extends StatefulWidget {
  Teamscreen({super.key, this.doc1, this.limit, this.uniqueId});
  // ignore: prefer_typing_uninitialized_variables
  var doc1;
  String? limit;
  String? uniqueId;

  @override
  State<Teamscreen> createState() => _TeamscreenState();
}

class _TeamscreenState extends State<Teamscreen> {
  final user = FirebaseAuth.instance.currentUser!;
  String? seletedImage;
  List<String> teamNames = [];
  bool? value;
  String? uniquenumber;
  String? imageurl;

  Future<bool?> flagFunction() async {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await FirebaseFirestore.instance
            .collection('tournament')
            .doc(widget.doc1)
            .get();
    value = documentSnapshot.get('flag');
    return value;
    //print( 'true or false $value');
  }

  @override
  void initState() {
    super.initState();
    flagFunction();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[100],
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('tournament')
            .doc(widget.doc1)
            .collection('team')
            .snapshots(),
        builder: (context, snapshot) {
          //print(widget.doc1);
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('No data available'),
            );
          }
          return ListView.separated(
              itemBuilder: (context, index) {
                var doc2 = snapshot.data!.docs[index];

                String teamImage = doc2['teamImage'] ?? '';
                String teamName = doc2['teamName'];
                String managerName = doc2['managerName'];
                String phoneNumber = doc2['phoneNumber'];
                String place = doc2['place'];
                String fileName = doc2['uniqueFileName'] ?? '';
                seletedImage = teamImage;
                TextEditingController teamNameController =
                    TextEditingController(text: teamName);
                TextEditingController managerNameController =
                    TextEditingController(text: managerName);
                TextEditingController phoneNumberController =
                    TextEditingController(text: phoneNumber);
                TextEditingController placeController =
                    TextEditingController(text: place);

                return ListTile(
                  onTap: () {
                    navigatorPush(
                        ctx: context,
                        screen: Addplayers(
                          title: teamName,
                          doc1: widget.doc1,
                          doc2: doc2.id,
                          uniqueId: widget.uniqueId,
                        ));
                  },
                  leading: CircleAvatar(
                    backgroundColor: Colors.teal,
                    radius: 30,
                    child: ClipOval(
                        child: teamImage.isEmpty
                            ? null
                            : Image.network(
                                teamImage,
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
                  title: Text(teamName),
                  subtitle: Text(managerName),
                  trailing: PopupMenuButton(
                    icon: const Icon(Icons.more_vert),
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                          child: const Text('View'),
                          onTap: () {
                            navigatorPush(
                                ctx: context,
                                screen: ViewTeamDetails(
                                    imageview: teamImage,
                                    teamName: teamName,
                                    managerName: managerName,
                                    phoneNumber: phoneNumber,
                                    placeName: place));
                          },
                        ),
                        PopupMenuItem(
                          enabled: value!,
                          child: const Text('Edit'),
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(
                                      'Edit Team Data',
                                      style: stylefont(),
                                    ),
                                    content: StatefulBuilder(
                                      builder: (context, setState) =>
                                          SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            GestureDetector(
                                              onTap: () async {
                                                await obj.imagePicking();
                                                setState(
                                                  () {},
                                                );
                                              },
                                              child: CircleAvatar(
                                                backgroundColor: Colors.teal,
                                                radius: 55,
                                                backgroundImage: obj
                                                        .imageLink.isEmpty
                                                    ? NetworkImage(teamImage)
                                                    : Image.file(
                                                            File(obj.imageLink))
                                                        .image,
                                              ),
                                            ),
                                            sizedbox30(),
                                            TextFormField(
                                              controller: teamNameController,
                                              decoration: decorationshowdiag(
                                                  'Team Name'),
                                            ),
                                            sizedbox30(),
                                            TextFormField(
                                              controller: managerNameController,
                                              decoration: decorationshowdiag(
                                                  'Manager Name'),
                                            ),
                                            sizedbox30(),
                                            TextFormField(
                                              controller: phoneNumberController,
                                              decoration: decorationshowdiag(
                                                  'Phone number'),
                                            ),
                                            sizedbox30(),
                                            TextFormField(
                                              controller: placeController,
                                              decoration:
                                                  decorationshowdiag('Place'),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            navigatorPOP(context);
                                            //delete image form storage
                                            DatabaseFunctions.deleteFileteam(
                                              fileName: fileName,
                                            );

                                            obj.imageLink = '';
                                            // });
                                          },
                                          child: const Text('Cancel')),
                                      TextButton(
                                          onPressed: () async {
                                            if (obj.imageLink.isEmpty) {
                                              DatabaseFunctions.editteam1(
                                                  document1: widget.doc1,
                                                  document2: doc2.id,
                                                  teamImage: teamImage,
                                                  teamNameController:
                                                      teamNameController,
                                                  managerNameController:
                                                      managerNameController,
                                                  phoneNumberController:
                                                      phoneNumberController,
                                                  placeController:
                                                      placeController,
                                                  uniquenumber: fileName);
                                                  navigatorPOP(context);

                                              //showing snakbar
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                      SnackbarDecoraction()
                                                          .kSnakbar(
                                                              text:
                                                                  'Data Updated Successfully',
                                                              col: Colors
                                                                  .green[300]));
                                            } else {
                                              dialogShowing(ctx: context);
                                              uniquenumber = DateTime.now()
                                                  .millisecondsSinceEpoch
                                                  .toString();
                                              await FirebaseStorage.instance
                                                  .ref()
                                                  .child('TeamImages')
                                                  .child(uniquenumber!)
                                                  .putFile(File(obj.imageLink));
                                              imageurl = await FirebaseStorage
                                                  .instance
                                                  .ref()
                                                  .child('TeamImages')
                                                  .child(uniquenumber!)
                                                  .getDownloadURL();

                                              try {
                                                DatabaseFunctions
                                                    .deleteFileteam(
                                                        fileName: fileName);
                                                DatabaseFunctions.editteam1(
                                                    document1: widget.doc1,
                                                    document2: doc2.id,
                                                    teamImage: imageurl,
                                                    teamNameController:
                                                        teamNameController,
                                                    managerNameController:
                                                        managerNameController,
                                                    phoneNumberController:
                                                        phoneNumberController,
                                                    placeController:
                                                        placeController,
                                                    uniquenumber: uniquenumber);

                                                teamNameController.clear();
                                                managerNameController.clear();
                                                phoneNumberController.clear();
                                                placeController.clear();
                                                // ignore: use_build_context_synchronously
                                                navigatorPOP(context);
                                                obj.imageLink = '';

                                                log('Data edited sucessfully ');
                                                // ignore: use_build_context_synchronously
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                        //updateSucessSnackbar()
                                                        SnackbarDecoraction()
                                                            .kSnakbar(
                                                  text:
                                                      'Update Data Successfully',
                                                  col: Colors.green[300],
                                                ));
                                              } catch (e) {
                                                print('gott error $e');
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackbarDecoraction()
                                                      .kSnakbar(
                                                    text:
                                                        'Please try again ,After some times',
                                                    col: Colors.red[300],
                                                  ),
                                                );
                                              }
                                              navigatorPOP(context);
                                            }
                                          },
                                          child: const Text('Save'))
                                    ],
                                  );
                                });
                          },
                        ),
                        PopupMenuItem(
                          enabled: value!,
                          child: const Text('Delete'),
                          onTap: () async {
                            //delete from storage

                            alertdialog2(
                                ctx: context,
                                doc1: widget.doc1,
                                doc2: doc2.id,
                                fileName: fileName,
                                foldername: 'TeamImages');
                          },
                        )
                      ];
                    },
                  ),
                );
              },
              separatorBuilder: (context, index) => const Divider(),
              itemCount:
                  // iteamCount(a: widget.limit)
                  snapshot.data!.docs.length
                          //);
                          <=
                          iteamCount(a: widget.limit)
                      ? snapshot.data!.docs.length
                      : iteamCount(a: widget.limit));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await FirebaseFirestore.instance
              .collection('tournament')
              .doc(widget.doc1)
              .collection('team')
              .get()
              .then((QuerySnapshot querySnapshot) async {
            int documentlength = querySnapshot.size;
            int iteamCount1 = iteamCount(a: widget.limit);
            print(' Document Length :$documentlength');
            if (documentlength <= iteamCount1 - 1) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddTeam(
                            docss: widget.doc1,
                            limit: widget.limit,
                          )));
            } else {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Teams Limit is Full'),
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
            }
          });
        },
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add),
      ),
    );
  }
}

int iteamCount({required String? a}) {
  if (a == '8 teams') {
    print('8');
    return 8;
  } else if (a == '16 teams') {
    print('16');
    return 16;
  } else if (a == '32 teams') {
    print('32');
    return 32;
  }
  return 0;
}
