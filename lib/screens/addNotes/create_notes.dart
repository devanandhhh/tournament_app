import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:tournament_creator/hive_model/notes.dart';
import 'package:tournament_creator/main.dart';

import 'package:tournament_creator/screens/addNotes/widgets/dbfunctions.dart';
import 'package:tournament_creator/screens/addNotes/widgets/refactoring.dart';
import 'package:tournament_creator/screens/create_tounament/reuse_widgets/reuse_widgets.dart';

// ignore: must_be_immutable
class CreateNotes extends StatefulWidget {
  CreateNotes({super.key});

  @override
  State<CreateNotes> createState() => _CreateNotesState();
}

class _CreateNotesState extends State<CreateNotes> {
  final titleController = TextEditingController();

  final noteController = TextEditingController();

  Box databox = Hive.box(hivekey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbardecorations(
        name: "Create Notes",
      ),
      backgroundColor: Colors.yellow[100],
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(children: [
                sizedbox10(),
                Container(
                    height: 620,
                    width: 380,
                    decoration: BoxDecoration(
                        // color: Colors.amber[100],
                        border: Border.all(width: 3, color: Colors.grey),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          TextField(
                            controller: titleController,
                            style: const TextStyle(fontSize: 30),
                            maxLines: null,
                            decoration: InputDecoration(
                                hintText: 'Title',
                                hintStyle: const TextStyle(fontSize: 30),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none)),
                          ),
                          TextField(
                            controller: noteController,
                            style: const TextStyle(fontSize: 20),
                            maxLines: null,
                            decoration: const InputDecoration(
                                hintText: 'Add Notes Here.....',
                                hintStyle: TextStyle(fontSize: 20),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none)),
                          ),
                        ],
                      ),
                    )),
                const SizedBox(
                  height: 40,
                ),
              ]),
              InkWell(
                onTap: () {
                  savedata(Notes(
                      title: titleController.text,
                      content: noteController.text));
                  scaffoldmessAdded(context);
                  //  setState(() {});

                  Navigator.of(context).pop();
                },
                child: Container(
                  height: 70,
                  width: 330,
                  decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(35)),
                  child: const Center(
                      child: Text(
                    'Save',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
