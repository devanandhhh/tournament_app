import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:tournament_creator/database/firebase_model/dbfuntions.dart';
import 'package:tournament_creator/screens/other/sample.dart';
import 'package:tournament_creator/screens/addNotes/widgets/refactoring.dart';
import 'package:tournament_creator/screens/create_tounament/reuse_widgets/reuse_widgets.dart';

class CreateTournament extends StatefulWidget {
  const CreateTournament({super.key});

  @override
  State<CreateTournament> createState() => _CreateTournamentState();
}

class _CreateTournamentState extends State<CreateTournament> {
  final formkey = GlobalKey<FormState>();
  String? categoryCN;
  String? limitsCN;
  final category = ['7s', '9s', '11s'];
  final limitsOfTeams = [
    '8 teams',
  ];
  final tournamentNameController = TextEditingController();
  var categoryController = TextEditingController();
  final dateController = TextEditingController();
  var limitController = TextEditingController();
  final placeController = TextEditingController();
  String? selectImage;
  String? uniquefileName;

  String? imageUrl = '';

  //add user
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[100],
      appBar: appbardecorations(name: "Create Tournament"),
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.all(13.0),
            child: Column(children: [
              GestureDetector(
                onTap: () async {
                  await obj.imagePicking();
                  setState(() {});
                },
                child: CircleAvatar(
                    backgroundColor: Colors.teal,
                    maxRadius: 51,
                    backgroundImage: obj.imageLink.isEmpty
                        ? Image.asset('assets/addimage2.png').image
                        : Image.file(File(obj.imageLink)).image),
              ),
              sizedbox10(),
              sizedbox10(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  hintText(hintTxt: 'Enter Tournament Name'),
                  sizedbox10(),
                  TextFormField(
                    textCapitalization: TextCapitalization.words,
                    controller: tournamentNameController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: inputdecorationtxtFormField(),
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'Tournament Name Required';
                      }
                      return null;
                    },
                  ),
                  sizedbox10(),
                  hintText(hintTxt: 'Enter Your Place '),
                  sizedbox10(),
                  TextFormField(
                    textCapitalization: TextCapitalization.words,
                    controller: placeController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: inputdecorationtxtFormField(),
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'Place is Required';
                      }
                      return null;
                    },
                  ),
                  sizedbox10(),
                  hintText(hintTxt: 'Select Date'),
                  sizedbox10(),
                  TextFormField(
                    controller: dateController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onTap: () async {
                      DateTime? picked = await showDatePicker(
                          context: context,
                          //  initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100));
                      if (picked != null) {
                        final formatDate =
                            //DateFormat('dd-MM-yyyy').format(picked);
                            DateFormat.yMMMMd('en_US').format(picked);

                        setState(() {
                          dateController.text = formatDate.toString();
                        });
                      }
                    },
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: 'MM-DD-YYYY',
                      filled: true,
                      fillColor: const Color.fromARGB(255, 216, 214, 198),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Date is Required';
                      }
                      return null;
                    },
                  ),
                  sizedbox10(),
                  hintText(hintTxt: 'Select Category'),
                  sizedbox10(),
                  DropdownButtonFormField(
                    //value:,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color.fromARGB(255, 216, 214, 198),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none)),
                    items: category.map((e) {
                      return DropdownMenuItem(value: e, child: Text(e));
                    }).toList(),
                    onChanged: (value) {
                      // print(value);

                      if (value != null) {
                        categoryController = TextEditingController(text: value);
                        categoryCN = categoryController.text;
                        log(categoryController.text);
                      }
                    },
                    hint: const Text('Select category'),
                  ),
                  sizedbox10(),
                  hintText(hintTxt: 'Select Limit of Teams'),
                  sizedbox10(),
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color.fromARGB(255, 216, 214, 198),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none)),
                    onChanged: (newValue) {
                      // print(newValue);
                      if (newValue != null) {
                        limitController = TextEditingController(text: newValue);
                        limitsCN = limitController.text;
                      }
                    },
                    items: limitsOfTeams.map((e) {
                      return DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      );
                    }).toList(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          onTap: () {
                            tournamentNameController.clear();
                            dateController.clear();
                            placeController.clear();
                            categoryController.clear();
                            limitController.clear();
                            obj.imageLink = '';
                          },
                          child: containerButtonCR(txt: 'Clear')),
                      InkWell(
                          onTap: () async {
                            if (formkey.currentState!.validate()) {
                              if (obj.imageLink.isEmpty) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text(
                                    'You Must Select an Image',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor: Colors.red,
                                ));
                              }
                              if (categoryCN == null) {
                                messengerScaffold(
                                    text: "Please Select Category",
                                    ctx: context);
                              }
                              if (limitsCN == null) {
                                messengerScaffold(
                                    text: "Please Select Limit of team",
                                    ctx: context);
                              }
                              if (limitsCN != null &&
                                  categoryCN != null &&
                                  //image != null
                                  obj.imageLink.isNotEmpty) {
                                //print('halo');

                                dialogShowing(ctx: context);

                                uniquefileName = DateTime.now()
                                    .microsecondsSinceEpoch
                                    .toString();
                                log('the num : $uniquefileName');

                                await FirebaseStorage.instance
                                    .ref()
                                    .child('TournamentImages')
                                    .child(uniquefileName!)
                                    .putFile(File(obj.imageLink));

                                imageUrl = await FirebaseStorage.instance
                                    .ref()
                                    .child('TournamentImages')
                                    .child(uniquefileName!)
                                    .getDownloadURL();

                                DatabaseFunctions.addTournament1(
                                    selectImage: imageUrl,
                                    uniquefileName: uniquefileName,
                                    tournamentNameController:
                                        tournamentNameController,
                                    placeController: placeController,
                                    dateController: dateController,
                                    categoryCN: categoryCN,
                                    limitsCN: limitsCN,
                                    user: user.uid);

                                messengerScaffold1(
                                    // ignore: use_build_context_synchronously
                                    ctx: context,
                                    text: 'Sucessfully Added');

                                tournamentNameController.clear();
                                dateController.clear();
                                placeController.clear();
                                categoryController.clear();
                                limitController.clear();
                                // setState(() {
                                // image=null;
                                obj.imageLink = '';
                                //  });
                                // ignore: use_build_context_synchronously
                                Navigator.pop(context);
                                // ignore: use_build_context_synchronously
                                navigatorPOP(context);
                              }
                            }
                          },
                          child: containerButtonCR(txt: 'Create'))
                    ],
                  )
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }

  // Future<String?> pickImageFromGallery() async {
  //   final pickedImage =
  //       await ImagePicker().pickImage(source: ImageSource.gallery);
  //   if (pickedImage != null) {
  //     return pickedImage.path;
  //   }
  //   return null;
  // }
}
