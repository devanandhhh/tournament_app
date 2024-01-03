import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class CreateTournament extends StatefulWidget {
  CreateTournament({super.key});

  @override
  State<CreateTournament> createState() => _CreateTournamentState();
}

class _CreateTournamentState extends State<CreateTournament> {
  final formkey = GlobalKey<FormState>();
  final category = ['7s', '9s', '11s'];
  final limitsOfTeams = ['8 teams', '16 teams', '32 teams'];
  final tournamentNameController = TextEditingController();
  var categoryController = TextEditingController();
  final dateController = TextEditingController();
  var limitController = TextEditingController();
  File? selectImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[100],
      appBar: AppBar(
        backgroundColor: Colors.yellow[100],
        title: Text(
          'Create Tournament', 
          style: TextStyle(
              color: Colors.teal, fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.all(15.0), 
            child: Column(children: [
              CircleAvatar(
                backgroundColor: Colors.teal,
                maxRadius: 81,
                backgroundImage: AssetImage('assets/addimage2.png'),
                child: GestureDetector(
                  onTap: () async {
                    File? pickImage = await pickImageFromGallery();
                    setState(() {
                      selectImage = pickImage;
                    });
                  },
                  child: selectImage != null
                      ? ClipOval(
                          child: Image.file(
                            selectImage!,
                            fit: BoxFit.cover,
                            width: 150,
                            height: 150,
                          ),
                        )
                      : null,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Enter Tournament Name',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: tournamentNameController,
                    decoration: InputDecoration(
                        //  hintText: 'Tournament Name ',
                        filled: true,
                        fillColor: Color.fromARGB(255, 216, 214, 198),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none)),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Tournament Name Required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                    Text(
                    'Select Date ',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: dateController,
                    onTap: () async {
                      DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2024),
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
                      fillColor: Color.fromARGB(255, 216, 214, 198),
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
                  const Text(
                    'Select Category ',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  DropdownButtonFormField(
                    //value:,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Color.fromARGB(255, 216, 214, 198),
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
                        print(categoryController);
                      }
                    },
                    hint: Text('Select category'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Select a Category';
                      }
                      return null;
                    },
                  ),
               
                
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Select Limit of Teams',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                  ),SizedBox(height: 10,),
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Color.fromARGB(255, 216, 214, 198),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none)),
                    onChanged: (newValue) {
                      print(newValue);
                      if (newValue != null) {
                        limitController = TextEditingController(text: newValue);
                      }
                    },
                    items: limitsOfTeams.map((e) {
                      return DropdownMenuItem(
                        child: Text(e),
                        value: e,
                      );
                    }).toList(),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Container(
                          child: Center(
                              child: Text(
                            'Clear',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold),
                          )),
                          height: 60,
                          width: 150,
                          decoration: BoxDecoration(
                              color: Colors.teal,
                              borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          if (formkey.currentState!.validate()) {
                            if (selectImage == null) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                  'You Must Select an Image',
                                  style: TextStyle(color: Colors.white),
                                ),
                                backgroundColor: Colors.red,
                              ));
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                      backgroundColor: Colors.green,
                                      content: Text(
                                        'Successfully Created ',
                                        style: TextStyle(color: Colors.white),
                                      )));
                            }
                            // tournamentNameController.clear();
                            // categoryController.clear();
                            // dateController.clear();
                            // limitController.clear();
                          }
                        },
                        child: Container(
                          child: Center(
                              child: Text(
                            'Create',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold),
                          )),
                          height: 60,
                          width: 150,
                          decoration: BoxDecoration(
                              color: Colors.teal,
                              borderRadius: BorderRadius.circular(8)),
                        ),
                      )
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

  Future<File?> pickImageFromGallery() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      return File(pickedImage.path);
    }
    return null;
  }
}
