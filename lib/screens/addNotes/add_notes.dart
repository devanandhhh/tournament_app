import 'package:flutter/material.dart';
import 'package:tournament_creator/screens/addNotes/create_notes.dart';
//import 'package:tournament_creator/screens/addNotes/create_notes.dart';
import 'package:tournament_creator/screens/create_tounament/reuse_widgets/reuse_widgets.dart';

// ignore: must_be_immutable
class AddNotes extends StatefulWidget {
  AddNotes({super.key});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  TextEditingController titleController = TextEditingController();

  TextEditingController contentController = TextEditingController();
Future <void>createNote(Map<String,dynamic>newNote)async{
 
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbardecorations(name: 'Notes '),
      backgroundColor: Colors.yellow[100],
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
            child: Icon(Icons.add),
            backgroundColor: Colors.teal,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CreateNotes()));
            }),
      ),
    );
  }

  // showForm(BuildContext ctx, int? iteamkey) async {
  //   showModalBottomSheet(
  //       context: ctx,
  //       builder: (_) {
  //         return Container(
  //           padding: EdgeInsets.only(
  //               bottom: MediaQuery.of(ctx).viewInsets.bottom,
  //               top: 15,
  //               left: 15,
  //               right: 15),
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             crossAxisAlignment: CrossAxisAlignment.end,
  //             children: [
  //               TextField(
  //                 controller: titleController,
  //                 decoration: InputDecoration(hintText: 'Title'),
  //               ),
  //               sizedbox10(),
  //               TextField(
  //                 controller: contentController,
  //                 decoration: InputDecoration(hintText: 'Type here....'),
  //               ),sizedbox10(),
  //               ElevatedButton(onPressed: ()async{
  //                 createNote({'title':titleController,'content':contentController});
  //                 titleController.clear();
  //                 contentController.clear();
  //                 Navigator.of(ctx).pop();
  //               }, 
  //               child: Text('Save'))
  //             ],
  //           ),
  //         );
  //       });
  // }
}
