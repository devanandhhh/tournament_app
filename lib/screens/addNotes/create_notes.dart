import 'package:flutter/material.dart';
import 'package:tournament_creator/screens/create_tounament/reuse_widgets/reuse_widgets.dart';

class CreateNotes extends StatelessWidget {
  CreateNotes({super.key});
  String? title;
  String? note;
  final titleController = TextEditingController();
  final noteController = TextEditingController();
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
          child: Column(children: [
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
                        style: TextStyle(fontSize: 30),
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
                        style: TextStyle(fontSize: 20),
                        maxLines: null,
                        decoration: InputDecoration(
                            hintText: 'Add Notes Here.....',
                            hintStyle: TextStyle(fontSize: 20),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none)),
                      ),
                    ],
                  ),
                )),
            SizedBox(
              height: 40,
            ),
            InkWell(
              onTap: (){

              },
              child: Container(
                height: 70,
                width: 330,
                decoration: BoxDecoration(
                    color: Colors.teal, borderRadius: BorderRadius.circular(35)),
                child: Center(child: Text('Save',style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold ),)),
              ),
            )
          ]),
        ),
      ),
    );
  }
  savedata(){
  
  }
}
