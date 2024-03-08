import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:tournament_creator/database/dbfuntions.dart';
import 'package:tournament_creator/sample.dart';
import 'package:tournament_creator/screens/addNotes/widgets/refactoring.dart';
import 'package:tournament_creator/screens/create_tounament/reuse_widgets/reuse_widgets.dart';
import 'package:tournament_creator/screens/home/reuse_widgets/refactoring.dart';
import 'package:tournament_creator/screens/list_Tournament/widgets/reuse.dart';
import 'package:tournament_creator/screens/select_tournament/widgets/reusable.dart';
import 'package:tournament_creator/screens/select_tournament/widgets/screens/teams/view_player_details.dart';

// ignore: must_be_immutable
class Addplayers extends StatefulWidget {
  Addplayers(
      {super.key, required this.title, this.doc1, this.doc2, this.uniqueId});
  String title;
// ignore: prefer_typing_uninitialized_variables
  var doc1;
// ignore: prefer_typing_uninitialized_variables
  var doc2;
  String? uniqueId;
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
  String? selectedId;
  String? idProof;
  String? uniquenumber1;
  String? uniquenumber2;
  String? urlImage1;
  String? urlImage2;

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
                      // onTap: () async {
                      //   String? pickPlayerImage = await pickImageFromGallery();
                      //   setState(() {
                      //     playerImage = pickPlayerImage;
                      //   });
                      // },
                      onTap: () async {
                        await obj.imagePicking();
                        setState(() {});
                      },
                      child: Container(
                        height: 170,
                        width: 150,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: obj.imageLink.isNotEmpty
                                    ? FileImage(File(obj.imageLink))
                                    : Image.asset('assets/person1.jpg').image,
                                //FileImage(File(playerImage ?? "")),
                                fit: BoxFit.cover),
                            color: Colors.green[100],
                            borderRadius: BorderRadius.circular(10)),
                        //  child: const Center(child: Icon(Icons.add_a_photo)),
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
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                controller: playerNameController,
                                validator: (value) => value!.trim().isEmpty
                                    ? 'Name is Required'
                                    : null,
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
                                    //   initialDate: DateTime.now(),
                                    firstDate: DateTime(1999),
                                    lastDate: DateTime.now());
                                if (pickedDate != null) {
                                  final formatDate = DateFormat.yMMMMd('en_US')
                                      .format(pickedDate);
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
                    await obj2.imagePicking2();
                    setState(() {});
                    // idProof = await imageFromGallery();
                    // setState(() {});
                    // setState(() {
                    //   playerID = idProof;
                    // });
                  },
                  child: Container(
                    height: 180,
                    width: 370,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: obj2.imagelink2.isNotEmpty
                                ? FileImage(File(obj2.imagelink2))
                                : Image.asset('assets/documentmodel.jpg').image,
                            // FileImage(File(playerID ?? '')),
                            fit: BoxFit.fill),
                        color: Colors.green[100],
                        borderRadius: BorderRadius.circular(10)),
                    //child: const Center(child: Icon(Icons.add_card)),
                  ),
                ),
                sizedbox10(),
                sizedbox10(),
                InkWell(
                  onTap: () async {
                    int count = await getPlayerCount(widget.doc2);
                    if (count <= 12) {
                      if (formKey.currentState!.validate()) {
                        if (obj.imageLink.isNotEmpty &&
                            obj2.imagelink2.isNotEmpty) {
                          dialogShowing(ctx: context);

                          uniquenumber1 =
                              DateTime.now().millisecondsSinceEpoch.toString();

                          await FirebaseStorage.instance
                              .ref()
                              .child('PlayerProfile')
                              .child(uniquenumber1!)
                              .putFile(File(obj.imageLink));
                          urlImage1 = await FirebaseStorage.instance
                              .ref()
                              .child('PlayerProfile')
                              .child(uniquenumber1!)
                              .getDownloadURL();

                          uniquenumber2 =
                              DateTime.now().millisecondsSinceEpoch.toString();

                          await FirebaseStorage.instance
                              .ref()
                              .child('PlayerDoc')
                              .child(uniquenumber2!)
                              .putFile(File(obj2.imagelink2));
                          urlImage2 = await FirebaseStorage.instance
                              .ref()
                              .child('PlayerDoc')
                              .child(uniquenumber2!)
                              .getDownloadURL();

                          DatabaseFunctions.addplayer1(
                              playerImage: urlImage1,
                              playerNameController: playerNameController,
                              playerAgeController: playerAgeController,
                              playerID: urlImage2,
                              document1: widget.doc1,
                              document2: widget.doc2,
                              uniquenumber1: uniquenumber1,
                              uniquenumber2: uniquenumber2);
                          playerAgeController.clear();
                          playerNameController.clear();
                          setState(() {
                            // playerImage = null;
                            // playerID = null;
                            obj.imageLink = '';
                            // idProof = null;
                            obj2.imagelink2 = '';
                          });

                          // ignore: use_build_context_synchronously
                          scaffoldmessAdded(context);
                          navigatorPOP(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content:
                                const Text('Player photo &proof is reqired'),
                            backgroundColor: Colors.red[400],
                          ));
                        }
                      }
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('You can Only add 13 Players in a Team'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  navigatorPOP(context);
                                },
                                child: const Text('OK'))
                          ],
                        ),
                      );
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
                      .collection('players')
                      .where('teamID', isEqualTo: widget.doc2)
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
                          String playerid = doc3['PlayerId'] ?? '';
                          String filename1 = doc3['uniqueFileName1'];
                          String filename2 = doc3['uniqueFileName2'];

                          TextEditingController playerNameEditController =
                              TextEditingController(text: playerName);
                          TextEditingController playerAgeEditController =
                              TextEditingController(text: dateOfBirth);

                          return ListTile(
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
                            tileColor: Colors.amber[100],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            leading: CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.teal,
                              child: ClipOval(
                                  child: Image.network(
                                playerphoto,
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
                                                      GestureDetector(
                                                        onTap: () async {
                                                          await obj
                                                              .imagePicking();
                                                          setState(
                                                            () {},
                                                          );
                                                        },
                                                        child: CircleAvatar(
                                                          backgroundImage: obj
                                                                  .imageLink
                                                                  .isEmpty
                                                              ? Image.network(
                                                                      playerphoto)
                                                                  .image
                                                              : FileImage(File(
                                                                  obj.imageLink)),

                                                          // FileImage(File(
                                                          //     playerphoto)),
                                                          radius: 70,
                                                          // child: InkWell(
                                                          //   onTap: () async {
                                                          //     String?
                                                          //         editdetails =
                                                          //         await pickImageFromGallery();
                                                          //     setState(
                                                          //       () {
                                                          //         playerphoto =
                                                          //             editdetails!;
                                                          //       },
                                                          //     );
                                                          //   },
                                                          // ),
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
                                                      DatePickerForAge(
                                                          controller:
                                                              playerAgeEditController,
                                                          labeltxt:
                                                              'Date Of Birth'),
                                                      sizedbox10(),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          const Text(
                                                              'Player proof'),
                                                          sizedbox10(),
                                                          Container(
                                                            width: 300,
                                                            height: 200,
                                                            decoration: BoxDecoration(
                                                                image: DecorationImage(
                                                                    image: obj2
                                                                            .imagelink2
                                                                            .isEmpty
                                                                        ? Image.network(playerid)
                                                                            .image
                                                                        : FileImage(
                                                                            File(obj2.imagelink2)))),
                                                            child:
                                                                GestureDetector(
                                                              onTap: () async {
                                                                await obj2
                                                                    .imagePicking2();
                                                                setState(
                                                                  () {},
                                                                );
                                                              },
                                                            ),
                                                            // child:
                                                            //     GestureDetector(
                                                            //   onTap: () async {

                                                            // String?
                                                            //     editproof =
                                                            //     await pickImageFromGallery();
                                                            // setState(
                                                            //   () {
                                                            //     playerid =
                                                            //         editproof!;
                                                            //   },
                                                            // );
                                                            //  },

                                                            // child: ClipRRect(
                                                            //   borderRadius:
                                                            //       BorderRadius
                                                            //           .circular(
                                                            //               10),
                                                            // //  child:
                                                            //   // Image
                                                            //   //     .file(File(
                                                            //   //         playerid)),
                                                            // ),
                                                            // ),
                                                          ),
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
                                                      // setState(() {
                                                      //   seletedImage =
                                                      //       playerphoto;
                                                      //   selectedId = playerid;
                                                      // });
                                                      obj.imageLink = '';
                                                      obj2.imagelink2 = '';
                                                    },
                                                    child:
                                                        const Text('Cancel')),
                                                TextButton(
                                                    onPressed: () async {
                                                      dialogShowing(
                                                          ctx: context);
                                                      // uniquenumber = DateTime.now().millisecondsSinceEpoch.toString();
                                                      if (obj.imageLink
                                                              .isEmpty &&
                                                          obj2.imagelink2
                                                              .isEmpty) {
                                                        DatabaseFunctions.editplayer1(
                                                            document3: doc3.id,
                                                            playerphoto:
                                                                playerphoto,
                                                            playerNameEditController:
                                                                playerNameEditController,
                                                            playerAgeEditController:
                                                                playerAgeEditController,
                                                            playerid: playerid,
                                                            uniquenumber1:
                                                                filename1,
                                                            uniquenumber2:
                                                                filename2);
                                                      } else if (obj.imageLink
                                                              .isNotEmpty &&
                                                          obj2.imagelink2
                                                              .isEmpty) {
                                                        await DatabaseFunctions
                                                            .deleteFile(
                                                                fileName:
                                                                    filename1,
                                                                foldername:
                                                                    'PlayerProfile');
                                                        uniquenumber1 = DateTime
                                                                .now()
                                                            .millisecondsSinceEpoch
                                                            .toString();
                                                        await FirebaseStorage
                                                            .instance
                                                            .ref()
                                                            .child(
                                                                'PlayerProfile')
                                                            .child(
                                                                uniquenumber1!)
                                                            .putFile(File(
                                                                obj.imageLink));
                                                        urlImage1 = await FirebaseStorage
                                                            .instance
                                                            .ref()
                                                            .child(
                                                                'PlayerProfile')
                                                            .child(
                                                                uniquenumber1!)
                                                            .getDownloadURL();
                                                        DatabaseFunctions.editplayer1(
                                                            document3: doc3.id,
                                                            playerphoto:
                                                                urlImage1,
                                                            playerNameEditController:
                                                                playerNameEditController,
                                                            playerAgeEditController:
                                                                playerAgeEditController,
                                                            playerid: playerid,
                                                            uniquenumber1:
                                                                uniquenumber1,
                                                            uniquenumber2:
                                                                filename2);
                                                      } else if (obj.imageLink
                                                              .isEmpty &&
                                                          obj2.imagelink2
                                                              .isNotEmpty) {
                                                        await DatabaseFunctions
                                                            .deleteFile(
                                                                fileName:
                                                                    filename2,
                                                                foldername:
                                                                    'PlayerDoc');
                                                        uniquenumber2 = DateTime
                                                                .now()
                                                            .millisecondsSinceEpoch
                                                            .toString();
                                                        await FirebaseStorage
                                                            .instance
                                                            .ref()
                                                            .child('PlayerDoc')
                                                            .child(
                                                                uniquenumber2!)
                                                            .putFile(File(obj2
                                                                .imagelink2));
                                                        urlImage2 =
                                                            await FirebaseStorage
                                                                .instance
                                                                .ref()
                                                                .child(
                                                                    'PlayerDoc')
                                                                .child(
                                                                    uniquenumber2!)
                                                                .getDownloadURL();
                                                        DatabaseFunctions.editplayer1(
                                                            document3: doc3.id,
                                                            playerphoto:
                                                                playerphoto,
                                                            playerNameEditController:
                                                                playerNameEditController,
                                                            playerAgeEditController:
                                                                playerAgeEditController,
                                                            playerid: urlImage2,
                                                            uniquenumber1:
                                                                filename1,
                                                            uniquenumber2:
                                                                uniquenumber2);
                                                      } else if (obj.imageLink
                                                              .isNotEmpty &&
                                                          obj2.imagelink2
                                                              .isNotEmpty) {
                                                        try {
                                                          await DatabaseFunctions
                                                              .deleteFile(
                                                                  fileName:
                                                                      filename1,
                                                                  foldername:
                                                                      'PlayerProfile');
                                                          await DatabaseFunctions
                                                              .deleteFile(
                                                                  fileName:
                                                                      filename2,
                                                                  foldername:
                                                                      'PlayerDoc');
                                                          uniquenumber1 = DateTime
                                                                  .now()
                                                              .millisecondsSinceEpoch
                                                              .toString();

                                                          uniquenumber2 = DateTime
                                                                  .now()
                                                              .millisecondsSinceEpoch
                                                              .toString();

                                                          await FirebaseStorage
                                                              .instance
                                                              .ref()
                                                              .child(
                                                                  'PlayerProfile')
                                                              .child(
                                                                  uniquenumber1!)
                                                              .putFile(File(obj
                                                                  .imageLink));
                                                          urlImage1 = await FirebaseStorage
                                                              .instance
                                                              .ref()
                                                              .child(
                                                                  'PlayerProfile')
                                                              .child(
                                                                  uniquenumber1!)
                                                              .getDownloadURL();
                                                          await FirebaseStorage
                                                              .instance
                                                              .ref()
                                                              .child(
                                                                  'PlayerDoc')
                                                              .child(
                                                                  uniquenumber2!)
                                                              .putFile(File(obj2
                                                                  .imagelink2));
                                                          urlImage2 = await FirebaseStorage
                                                              .instance
                                                              .ref()
                                                              .child(
                                                                  'PlayerDoc')
                                                              .child(
                                                                  uniquenumber2!)
                                                              .getDownloadURL();
                                                          DatabaseFunctions.editplayer1(
                                                              document3:
                                                                  doc3.id,
                                                              playerphoto:
                                                                  urlImage1,
                                                              playerNameEditController:
                                                                  playerNameEditController,
                                                              playerAgeEditController:
                                                                  playerAgeEditController,
                                                              playerid:
                                                                  urlImage2,
                                                              uniquenumber1:
                                                                  uniquenumber1,
                                                              uniquenumber2:
                                                                  uniquenumber2);
                                                        } catch (e) {
                                                          print(e);
                                                        }
                                                      }

                                                      playerNameEditController
                                                          .clear();
                                                      playerAgeEditController
                                                          .clear();
                                                      obj.imageLink = '';
                                                      obj2.imagelink2 = '';
                                                      // ignore: use_build_context_synchronously
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              updateSucessSnackbar());

                                                      // ignore: use_build_context_synchronously
                                                      navigatorPOP(context);
                                                      navigatorPOP(context);
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
                                                      print('here');
                                                      try {
                                                        DatabaseFunctions
                                                            .deleteFile(
                                                                fileName:
                                                                    filename1,
                                                                foldername:
                                                                    'PlayerProfile');
                                                        DatabaseFunctions
                                                            .deleteFile(
                                                                fileName:
                                                                    filename2,
                                                                foldername:
                                                                    'PlayerDoc');
                                                      } catch (e) {
                                                        print(
                                                            ' error    $e error on delete player');
                                                      }
                                                      print('skip');

                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection('players')
                                                          .doc(doc3.id)
                                                          .delete();
                                                      navigatorPOP(context);
                                                      scaffoldmessenger(
                                                          context);
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
