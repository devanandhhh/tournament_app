import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tournament_creator/database/firebase_model/dbfuntions.dart';
import 'package:tournament_creator/screens/other/sample.dart';
import 'package:tournament_creator/screens/addNotes/widgets/refactoring.dart';
import 'package:tournament_creator/screens/create_tounament/reuse_widgets/reuse_widgets.dart';
import 'package:tournament_creator/screens/home_Screen/reuse_widgets/refactoring.dart';
import 'package:tournament_creator/screens/select_tournament/widgets/reusable.dart';
import 'package:tournament_creator/screens/select_tournament/widgets/screens/teams/team_screen.dart';

// ignore: must_be_immutable
class AddTeam extends StatefulWidget {
  AddTeam({
    super.key,
    this.docss,
    this.limit,
  });
  // ignore: prefer_typing_uninitialized_variables
  var docss;
  String? limit;
  @override
  State<AddTeam> createState() => _AddTeamState();
}

class _AddTeamState extends State<AddTeam> {
  final teamNameController = TextEditingController();
  final managerNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final placeController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? seletedImage;

  // XFile? image;
  String? imageUrl;
  String? uniquefileName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbardecorations(name: 'Add Team'),
      backgroundColor: Colors.yellow[100],
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Column(children: [
            GestureDetector(
              onTap: () async{
               await obj.imagePicking();
                setState(() {}); 
              },
              child: CircleAvatar(backgroundColor: Colors.teal,
                backgroundImage: obj.imageLink.isEmpty
                    ? Image.asset('assets/addimage.png').image
                    : Image.file(File(obj.imageLink)).image, 
             
                radius: 70,
               
              ),
            ),
           
            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sizedbox30(),
                  textfontsize17(text: "Team Name"),
                  sizedbox10(),
                  addTeamtxtController(
                      teamNameController, "Team Name is Required"),
                  sizedbox10(),
                  textfontsize17(text: 'Manager Name'),
                  sizedbox10(),
                  addTeamtxtController(
                      managerNameController, 'Manager Name is Required'),
                  sizedbox10(),
                  textfontsize17(text: "Phone Number"),
                  sizedbox10(),
                  addTeamPhoneController(
                      numbercontroller: phoneNumberController,
                      hintText: 'Phone Number is Required'),
                  sizedbox10(),
                  textfontsize17(text: 'Place'),
                  sizedbox10(),
                  addTeamtxtController(placeController, 'Place is Required')
                ],
              ),
            ),
            sizedbox70(),
            GestureDetector(
              child: containerButtonCR(txt: 'Add Team'),
              onTap: () async {
                if (formKey.currentState!.validate()) {
                  if ( obj.imageLink.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                      'You Must Select an Image',
                      style: TextStyle(color: Colors.red),
                    )));
                  }
                  await FirebaseFirestore.instance
                      .collection('tournament')
                      .doc(widget.docss)
                      .collection('team')
                      .get()
                      .then((QuerySnapshot querySnapshot) async {
                    int documentlength = querySnapshot.size;
                    int iteamCount1 = iteamCount(a: widget.limit);
                    print(' Document Length : $documentlength');
                    if (obj.imageLink .isNotEmpty) {
                      if (documentlength <= iteamCount1 - 1) {
                        //adding image
                        dialogShowing(ctx: context);
                             uniquefileName =
                        DateTime.now().microsecondsSinceEpoch.toString();
                        
                        await FirebaseStorage.instance
                            .ref()
                            .child('TeamImages')
                            .child(uniquefileName!)
                            .putFile(File(obj.imageLink));

                        imageUrl = await FirebaseStorage.instance
                            .ref()
                            .child('TeamImages')
                            .child(uniquefileName!)
                            .getDownloadURL();

                        DatabaseFunctions.addteam1(
                            document: widget.docss,
                            teamNameController: teamNameController,
                            managerNameController: managerNameController,
                            phoneNumberController: phoneNumberController,
                            placeController: placeController,
                            seletedImage: imageUrl,
                            uniquenumber: uniquefileName);

                        teamNameController.clear();
                        managerNameController.clear();
                        phoneNumberController.clear();
                        placeController.clear();
                        // seletedImage = null;

                        // ignore: use_build_context_synchronously
                        scaffoldmessAdded(context);
                        // setState(() {
                        //   image = null;
                        // });
                        obj.imageLink=''; 
                        navigatorPOP(context);
                        navigatorPOP(context);
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Team Already full'),
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
                    }
                  });
                }
              },
            )
          ]),
        ),
      ),
    );
  }

  Future<String?> pickImageFromGallery() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      return pickedImage.path;
    }
    return null;
  }
}
