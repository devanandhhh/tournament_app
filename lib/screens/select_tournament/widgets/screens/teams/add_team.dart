import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tournament_creator/database/dbfuntions.dart';
import 'package:tournament_creator/screens/addNotes/widgets/refactoring.dart';
import 'package:tournament_creator/screens/create_tounament/reuse_widgets/reuse_widgets.dart';
import 'package:tournament_creator/screens/home/reuse_widgets/refactoring.dart';
import 'package:tournament_creator/screens/select_tournament/widgets/reusable.dart';

// ignore: must_be_immutable
class AddTeam extends StatefulWidget {
  AddTeam({super.key, this.docss});
  // ignore: prefer_typing_uninitialized_variables
  var docss;

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
                  await DatabaseFunctions.addTeam(
                      document1: widget.docss,
                      teamNameController: teamNameController,
                      managerNameController: managerNameController,
                      phoneNumberController: phoneNumberController,
                      placeController: placeController,
                      imageSeleted: seletedImage);
                 
                  teamNameController.clear();
                  managerNameController.clear();
                  phoneNumberController.clear();
                  placeController.clear();
                  seletedImage = null;

                  // ignore: use_build_context_synchronously
                  scaffoldmessAdded(context);
                  setState(() {});
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
