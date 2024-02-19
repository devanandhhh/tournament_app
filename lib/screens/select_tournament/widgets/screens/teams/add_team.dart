import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tournament_creator/database/dbfuntions.dart';
import 'package:tournament_creator/screens/addNotes/widgets/refactoring.dart';
import 'package:tournament_creator/screens/create_tounament/reuse_widgets/reuse_widgets.dart';
import 'package:tournament_creator/screens/home/reuse_widgets/refactoring.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbardecorations(name: 'Add Team'),
      backgroundColor: Colors.yellow[100],
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Column(children: [
            CircleAvatar(
                backgroundImage: const AssetImage('assets/addimage.png'),
                radius: 70,
                child: GestureDetector(
                    onTap: () async {
                      String? pickImage = await pickImageFromGallery();
                      setState(() {
                        seletedImage = pickImage;
                      });
                    },
                    child: seletedImage != null
                        ? ClipOval(
                            child: Image.file(
                              File(seletedImage!),
                              fit: BoxFit.cover,
                              width: 130,
                              height: 130,
                            ),
                          )
                        : null)),
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
                  if (seletedImage == null) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
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
                    print(' Document Length :$documentlength');
                    if (seletedImage != null) {
                      //    int documentlength=   await FirebaseFirestore.instance.collection('tournament').doc(widget.docss).collection('team').snapshots().length;
                      //  int iteamCount1= iteamCount(a: widget.limit);
                      if (documentlength <= iteamCount1 - 1) {
                        // await FirebaseFirestore.instance
                        //     .collection('tournament')
                        //     .doc(widget.docss)
                        //     .collection('team')
                        //     .add({
                        //   'teamName': teamNameController.text,
                        //   'managerName': managerNameController.text,
                        //   'phoneNumber': phoneNumberController.text,
                        //   'place': placeController.text,
                        //   'teamImage': seletedImage
                        // });
                        DatabaseFunctions.addteam1(
                            document: widget.docss,
                            teamNameController: teamNameController,
                            managerNameController: managerNameController,
                            phoneNumberController: phoneNumberController,
                            placeController: placeController,
                            seletedImage: seletedImage);

                        teamNameController.clear();
                        managerNameController.clear();
                        phoneNumberController.clear();
                        placeController.clear();
                        seletedImage = null;

                        // ignore: use_build_context_synchronously
                        scaffoldmessAdded(context);
                        setState(() {});
                        navigatorPOP(context);
                        //  }
                        //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('full')));
                        // int a= iteamCount(a: widget.limit);

                        //  await DatabaseFunctions.addTeam(
                        //   document1: widget.docss,
                        //   teamNameController: teamNameController,
                        //   managerNameController: managerNameController,
                        //   phoneNumberController: phoneNumberController,
                        //   placeController: placeController,
                        //   imageSeleted: seletedImage);
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Team Already full'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      navigatorPOP(context);
                                    },
                                    child: Text('Ok'))
                              ],
                            );
                          },
                        );
                      }
                    }
                  });

                  //  await FirebaseFirestore.instance
                  //     .collection('tournament')
                  //     .doc(widget.docss)
                  //     .collection('team')
                  //     .snapshots()
                  //     .length;
                  //  print('This ${documentlength}');

                  // if (seletedImage != null && documentlength <= iteamCount1) {
                  //   //    int documentlength=   await FirebaseFirestore.instance.collection('tournament').doc(widget.docss).collection('team').snapshots().length;
                  //   //  int iteamCount1= iteamCount(a: widget.limit);
                  //   // if(documentlength<=iteamCount1){
                  //   await FirebaseFirestore.instance
                  //       .collection('tournament')
                  //       .doc(widget.docss)
                  //       .collection('team')
                  //       .add({
                  //     'teamName': teamNameController.text,
                  //     'managerName': managerNameController.text,
                  //     'phoneNumber': phoneNumberController.text,
                  //     'place': placeController.text,
                  //     'teamImage': seletedImage
                  //   });

                  //   teamNameController.clear();
                  //   managerNameController.clear();
                  //   phoneNumberController.clear();
                  //   placeController.clear();
                  //   seletedImage = null;

                  //   // ignore: use_build_context_synchronously
                  //   scaffoldmessAdded(context);
                  //   setState(() {});
                  //   navigatorPOP(context);
                  //   //  }
                  //   //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('full')));
                  //   // int a= iteamCount(a: widget.limit);

                  //   //  await DatabaseFunctions.addTeam(
                  //   //   document1: widget.docss,
                  //   //   teamNameController: teamNameController,
                  //   //   managerNameController: managerNameController,
                  //   //   phoneNumberController: phoneNumberController,
                  //   //   placeController: placeController,
                  //   //   imageSeleted: seletedImage);
                  // } else {
                  //   showDialog(context: context, builder: (context) {
                  //     return AlertDialog(
                  //     title:  Text('Team Already full'),
                  //     actions: [TextButton(onPressed: (){
                  //       navigatorPOP(context);
                  //     }, child: Text('Ok'))],
                  //     );
                  //   },);
                  // }
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
