import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tournament_creator/database/dbfuntions.dart';
import 'package:tournament_creator/screens/addNotes/widgets/refactoring.dart';
import 'package:tournament_creator/screens/home/reuse_widgets/refactoring.dart';
import 'package:tournament_creator/screens/list_Tournament/widgets/reuse.dart';
import 'package:tournament_creator/screens/select_tournament/widgets/reusable.dart';
import 'package:tournament_creator/screens/select_tournament/widgets/screens/teams/add_players.dart';
import 'package:tournament_creator/screens/select_tournament/widgets/screens/teams/add_team.dart';
import 'package:tournament_creator/screens/select_tournament/widgets/screens/teams/view_details.dart';

// ignore: must_be_immutable
class Teamscreen extends StatefulWidget {
  Teamscreen({super.key, this.doc1});
// ignore: prefer_typing_uninitialized_variables
  var doc1;

  @override
  State<Teamscreen> createState() => _TeamscreenState();
}

class _TeamscreenState extends State<Teamscreen> {
String? seletedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddTeam(
                        docss: widget.doc1,
                      )));
        },
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add),
      ),
      backgroundColor: Colors.yellow[100],
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('tournament_details')
            .doc(widget.doc1)
            .collection('team_details')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('No data available'),
            );
          }
          return ListView.separated(
              itemBuilder: (context, index) {
                var doc2 = snapshot.data!.docs[index];
                String teamImage = doc2['teamImage'] ;
                String teamName = doc2['teamName'];
                String managerName = doc2['managerName'];
                String phoneNumber = doc2['phoneNumber'];
                String place = doc2['place'];

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
                        ));
                  },
                  leading: CircleAvatar(
                    backgroundColor: Colors.teal,
                    radius: 30,
                    child: ClipOval(
                        child: teamImage.isEmpty
                            ? null
                            : Image.file(
                                File(teamImage),
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
                          child: const Text('Edit'),
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Edit Team Data'),
                                    content: StatefulBuilder(
                                      builder: (context, setState) =>
                                          SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            CircleAvatar(
                                                backgroundColor: Colors.teal,
                                                radius: 55,
                                                backgroundImage:
                                                    FileImage(File(teamImage)),
                                                child: InkWell(
                                                  onTap: () async {
                                                    String? pickImage =
                                                        await pickImageFromGallery();
                                                    setState(
                                                      () {
                                                        teamImage = pickImage!;
                                                      },
                                                    );
                                                  },
                                                )

                                                
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
                                            setState(() {
                                              
                                              seletedImage=teamImage;
                                            });
                                          },
                                          child: const Text('Cancel')),
                                      TextButton(
                                          onPressed: () async {
                                            await DatabaseFunctions.editTeam(
                                                document1: widget.doc1,
                                                document2ID: doc2.id,
                                                teamImage: teamImage,
                                                teamNameController:
                                                    teamNameController,
                                                managerNameController:
                                                    managerNameController,
                                                phoneNumberController:
                                                    phoneNumberController,
                                                placeController:
                                                    placeController);
                                          

                                            teamNameController.clear();
                                            managerNameController.clear();
                                            phoneNumberController.clear();
                                            placeController.clear();
                                            // ignore: use_build_context_synchronously
                                            navigatorPOP(context);
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
                          child: const Text('Delete'),
                          onTap: () async {
                            alertdialog2(context, widget.doc1, doc2);
                          },
                        )
                      ];
                    },
                  ),
                );
              },
              separatorBuilder: (context, index) => const Divider(),
              itemCount: snapshot.data!.docs.length);
        },
      ),
    );
  }
}
