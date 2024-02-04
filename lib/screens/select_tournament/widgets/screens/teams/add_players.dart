import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tournament_creator/database/dbfuntions.dart';
import 'package:tournament_creator/screens/addNotes/widgets/refactoring.dart';
import 'package:tournament_creator/screens/create_tounament/reuse_widgets/reuse_widgets.dart';
import 'package:tournament_creator/screens/home/reuse_widgets/refactoring.dart';
import 'package:tournament_creator/screens/list_Tournament/widgets/reuse.dart';
import 'package:tournament_creator/screens/select_tournament/widgets/reusable.dart';
import 'package:tournament_creator/screens/select_tournament/widgets/screens/teams/view_player_details.dart';

// ignore: must_be_immutable
class Addplayers extends StatefulWidget {
  Addplayers({super.key, required this.title, this.doc1, this.doc2});
  String title;
// ignore: prefer_typing_uninitialized_variables
  var doc1;
// ignore: prefer_typing_uninitialized_variables
  var doc2;
  
  @override
  State<Addplayers> createState() => _AddplayersState();
}

class _AddplayersState extends State<Addplayers> {
  final formKey = GlobalKey<FormState>();
  TextEditingController playerNameController = TextEditingController();
  TextEditingController playerAgeController = TextEditingController();
  String? playerImage;
  String? playerID;
    String? seletedImage;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbardecorations(name: widget.title),
      backgroundColor: Colors.yellow[100],
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () async {
                        String? pickPlayerImage = await pickImageFromGallery();
                        setState(() {
                          playerImage = pickPlayerImage;
                        });
                      },
                      child: Container(
                        height: 170,
                        width: 150,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: FileImage(File(playerImage ?? "")),
                                fit: BoxFit.cover),
                            color: Colors.green[100],
                            borderRadius: BorderRadius.circular(10)),
                        child: const Center(child: Icon(Icons.add_a_photo)),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Player Name',
                          style: font17(),
                        ),
                        sizedbox10(),
                        Container(
                            height: 50,
                            width: 190,
                            decoration: BoxDecoration(
                                color: Colors.green[100],
                                borderRadius: BorderRadius.circular(10)),
                            child: TextFormField(
                                controller: playerNameController,
                                validator: (value) =>
                                    value!.isEmpty ? 'Name is Required' : null,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                ))),
                        sizedbox10(),
                        Text(
                          'Date of Birth',
                          style: font17(),
                        ),
                        sizedbox10(),
                        Container(
                          height: 50,
                          width: 190,
                          decoration: BoxDecoration(
                              color: Colors.green[100],
                              borderRadius: BorderRadius.circular(10)),
                          child: TextFormField(
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1999),
                                    lastDate: DateTime(2100));
                                if (pickedDate != null) {
                                  final formatDate =
                                   DateFormat.yMMMMd('en_US').format(pickedDate);
                                  //  DateFormat('dd-MM-yyyy')
                                  //     .format(pickedDate);
                                  setState(() {
                                    playerAgeController.text =
                                        formatDate.toString();
                                  });
                                }
                              },
                              readOnly: true,
                              controller: playerAgeController,
                              validator: (value) => value!.isEmpty
                                  ? 'Date of Birth is Required'
                                  : null,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none),
                              )),
                        )
                      ],
                    )
                  ],
                ),
                sizedbox10(),
                Text('Aadhar Photo / ID Proof', style: font17()),
                sizedbox10(),
                InkWell(
                  onTap: () async {
                    String? idProof = await pickImageFromGallery();
                    setState(() {
                      playerID = idProof;
                    });
                  },
                  child: Container(
                    height: 180,
                    width: 370,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: FileImage(File(playerID ?? '')),
                            fit: BoxFit.cover),
                        color: Colors.green[100],
                        borderRadius: BorderRadius.circular(10)),
                    child: const Center(child: Icon(Icons.add_card)),
                  ),
                ),
                sizedbox10(),
                sizedbox10(),
                InkWell(
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      if (playerImage != null || playerID != null) {
                        await FirebaseFirestore.instance
                            .collection('tournament_details')
                            .doc(widget.doc1)
                            .collection('team_details')
                            .doc(widget.doc2)
                            .collection('player_details')
                            .add({
                          'PlayerPhoto': playerImage,
                          'PlayerName': playerNameController.text,
                          'DateOfBirth': playerAgeController.text,
                          'PlayerId': playerID
                        });
                        playerAgeController.clear();
                        playerNameController.clear();
                        setState(() {
                          playerImage = null;
                          playerID = null;
                        });
                        // ignore: use_build_context_synchronously
                        scaffoldmessAdded(context);
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Photos is reqired'),
                          backgroundColor: Colors.red,
                        ));
                      }
                    }
                  },
                  child: Container(
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Center(
                        child: Text(
                      'Add',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
                sizedbox10(),
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('tournament_details')
                      .doc(widget.doc1)
                      .collection('team_details')
                      .doc(widget.doc2)
                      .collection('player_details')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(
                        child: Text('No Data Available'),
                      );
                    }
                    return ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          var doc3 = snapshot.data!.docs[index];
                          String playerphoto = doc3['PlayerPhoto'] ?? '';
                          String playerName = doc3['PlayerName'];
                          String dateOfBirth = doc3['DateOfBirth'];
                          String playerid = doc3['PlayerId'];

                          TextEditingController playerNameEditController =
                              TextEditingController(text: playerName);
                          TextEditingController playerAgeEditController =
                              TextEditingController(text: dateOfBirth);

                          return ListTile(
                            tileColor: Colors.amber[100],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            leading: CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.teal,
                              child: ClipOval(
                                  child: Image.file(
                                File(playerphoto),
                                fit: BoxFit.cover,
                                height: 35,
                                width: 35,
                              )),
                            ),
                            title: Text(playerName),
                            subtitle: Text('DOB :  $dateOfBirth'),
                            trailing: PopupMenuButton(
                              icon: const Icon(Icons.more_vert),
                              itemBuilder: (context) {
                                return [
                                  PopupMenuItem(
                                    child: const Text('View'),
                                    onTap: () {
                                      navigatorPush(
                                          ctx: context,
                                          screen: View_player_details(
                                              teamName: widget.title,
                                              playerphoto: playerphoto,
                                              playerName: playerName,
                                              playerDoB: dateOfBirth,
                                              playerProff: playerid));
                                    },
                                  ),
                                  PopupMenuItem(
                                    child: const Text('Edit'),
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: const Text('Edit Data'),
                                              content: StatefulBuilder(
                                                builder: (context, setState) {
                                                  return SingleChildScrollView(
                                                    child: Column(children: [
                                                      CircleAvatar(
                                                        backgroundImage:
                                                            FileImage(File(
                                                                playerphoto)),
                                                        radius: 70,
                                                        child: InkWell(
                                                          onTap: () async {
                                                            String?
                                                                editdetails =
                                                                await pickImageFromGallery();
                                                            setState(
                                                              () {
                                                                playerphoto =
                                                                    editdetails!;
                                                              },
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                      sizedbox10(),
                                                      TextFormField(
                                                        controller:
                                                            playerNameEditController,
                                                        decoration:
                                                            const InputDecoration(
                                                                border:
                                                                    OutlineInputBorder(),
                                                                labelText:
                                                                    'Player Name'),
                                                      ),
                                                      sizedbox10(),
                                                      DatePickerForAge(controller: playerAgeEditController, labeltxt: 'Date Of Birth'),
                                                      // TextFormField(
                                                      //   controller:
                                                      //       playerAgeEditController,
                                                      //   decoration: const InputDecoration(
                                                      //       border:
                                                      //           OutlineInputBorder(),
                                                      //       labelText:
                                                      //           'Date of birth'),
                                                      // ),
                                                      sizedbox10(),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          const Text(
                                                              'Player proof'),
                                                          sizedbox10(),
                                                          SizedBox(
                                                            width: 300,
                                                            height: 200,
                                                            child:
                                                                GestureDetector(
                                                              onTap: () async {
                                                                String?
                                                                    editproof =
                                                                    await pickImageFromGallery();
                                                                setState(
                                                                  () {
                                                                    playerid =
                                                                        editproof!;
                                                                  },
                                                                );
                                                              },
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                child: Image
                                                                    .file(File(
                                                                        playerid)),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      )
                                                    ]),
                                                  );
                                                },
                                              ),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      navigatorPOP(context);
                                                      setState(() {
                                                      seletedImage=playerphoto;
                                                      });

                                                    },
                                                    child:
                                                        const Text('Cancel')),                                       
                                                TextButton(
                                                    onPressed: () async {
                                                      await DatabaseFunctions.editPlayer(
                                                          document1:
                                                              widget.doc1,
                                                          document2:
                                                              widget.doc2,
                                                          document3ID: doc3.id,
                                                          playerphoto:
                                                              playerphoto,
                                                          playerNameEditController:
                                                              playerNameEditController,
                                                          playerAgeEditController:
                                                              playerAgeEditController,
                                                          playerid: playerid,
                                                          ctx: context);
                                                    },
                                                    child: const Text('Save'))
                                              ],
                                            );
                                          });
                                    },
                                  ),
                                  PopupMenuItem(
                                    child: const Text('Delete'),
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: ((context) {
                                            return AlertDialog(
                                              title:
                                                  const Text('Delete Player'),
                                              content: const Text(
                                                  'Are you sure you want to delete?'),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      navigatorPOP(context);
                                                    },
                                                    child: Text('Cancel')),
                                                TextButton(
                                                    onPressed: () async {
                                                      await DatabaseFunctions
                                                          .deletePlayer(
                                                              document1:
                                                                  widget.doc1,
                                                              document2:
                                                                  widget.doc2,
                                                              documentID:
                                                                  doc3.id,
                                                              ctx: context);
                                                    
                                                    },
                                                    child: const Text('Ok'))
                                              ],
                                            );
                                          }));
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
