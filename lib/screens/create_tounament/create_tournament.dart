import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:tournament_creator/database/dbfuntions.dart';
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
  final limitsOfTeams = ['8 teams', '16 teams', '32 teams'];
  final tournamentNameController = TextEditingController();
  var categoryController = TextEditingController();
  final dateController = TextEditingController();
  var limitController = TextEditingController();
  final placeController = TextEditingController();
  String? selectImage;
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
              CircleAvatar(
                backgroundColor: Colors.teal,
                maxRadius: 51,
                backgroundImage: const AssetImage('assets/addimage2.png'),
                child: GestureDetector(
                  onTap: () async {
                    String? pickImage = await pickImageFromGallery();
                    setState(() {
                      selectImage = pickImage;
                    });
                  },
                  child: selectImage != null
                      ? ClipOval(
                          child: Image.file(
                            File(selectImage!),
                            fit: BoxFit.cover,
                            width: 150,
                            height: 150,
                          ),
                        )
                      : null,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  hintText(hintTxt: 'Enter Tournament Name'),
                  sizedbox10(),
                  TextFormField(
                    controller: tournamentNameController,
                    decoration: inputdecorationtxtFormField(),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Tournament Name Required';
                      }
                      return null;
                    },
                  ),
                  sizedbox10(),
                  hintText(hintTxt: 'Enter Your Place '),
                  sizedbox10(),
                  TextFormField(
                    controller: placeController,
                    decoration: inputdecorationtxtFormField(),
                    validator: (value) {
                      if (value!.isEmpty) {
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
                    onTap: () async {
                      DateTime? picked = await showDatePicker(
                          context: context,
                          //  initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100));
                      if (picked != null) {
                        final formatDate =
                            DateFormat('dd-MM-yyyy').format(picked);

                        setState(() {
                          dateController.text = formatDate.toString();
                        });
                      }
                    },
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: 'DD-MM-YYYY',
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
                      print(value);
                      if (value != null) {
                        categoryController = TextEditingController(text: value);
                        categoryCN = categoryController.text;
                        print(categoryController);
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
                      print(newValue);
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
                          },
                          child: containerButtonCR(txt: 'Clear')),
                      InkWell(
                          onTap: () async {
                            if (formkey.currentState!.validate()) {
                              if (selectImage == null) {
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
                                  selectImage != null) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                        backgroundColor: Colors.green,
                                        content: Text(
                                          'Successfully Created ',
                                          style: TextStyle(color: Colors.white),
                                        )));
                      
                                await DatabaseFunctions.addTournament(
                                    selectImage: selectImage,
                                    tournamentNameController:
                                        tournamentNameController,
                                    placeController: placeController,
                                    dateController: dateController,
                                    category: categoryCN,
                                    limits: limitsCN);

                                tournamentNameController.clear();
                                dateController.clear();
                                placeController.clear();
                                categoryController.clear();
                                limitController.clear();
                                // ignore: use_build_context_synchronously
                                Navigator.of(context).pop();
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

  Future<String?> pickImageFromGallery() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      return pickedImage.path;
    }
    return null;
  }
}
