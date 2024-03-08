import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:tournament_creator/hive_model/notes.dart';
import 'package:tournament_creator/main.dart';
//import 'package:hive/hive.dart';
//import 'package:tournament_creator/hive_model/notes.dart';
import 'package:tournament_creator/screens/addNotes/create_notes.dart';
import 'package:tournament_creator/screens/addNotes/view_notes.dart';
import 'package:tournament_creator/screens/addNotes/widgets/refactoring.dart';
import 'package:tournament_creator/screens/create_tounament/reuse_widgets/reuse_widgets.dart';
import 'package:tournament_creator/screens/home/reuse_widgets/refactoring.dart';

// ignore: must_be_immutable
class AddNotes extends StatefulWidget {
  const AddNotes({super.key});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  Box databox = Hive.box(hivekey);
  // Future<void> createNote(Map<String, dynamic> newNote) async {}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbardecorations(name: 'Notes '),
        backgroundColor: Colors.yellow[100],
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FloatingActionButton(
              backgroundColor: Colors.teal,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CreateNotes()));
                    
                    
              },
              child: const Icon(Icons.add)),
        ),
        body: databox.isEmpty
            ? Center(
                child: Text(
                  'No data available',
                  style: fontW17(),
                ),
              )
            : GridView.builder(
                itemCount: databox.length,
                gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: ((context, index) {
                  String key = databox.keyAt(index).toString();
                  Notes? notes = databox.get(key);
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      onTap: () {
                        navigatorPush(
                            ctx: context,
                            screen: ViewScreen(
                              notes: notes,
                            ));
                      },
                      title: Text(
                        notes!.title!,
                        style: fontW17(),
                      ),
                      trailing: PopupMenuButton(
                        icon: const Icon(Icons.more_vert),
                        itemBuilder: (context) {
                          return [
                            PopupMenuItem(
                              child: const Text('View'),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ViewScreen(
                                              notes: notes,
                                            )));
                              },
                            ),
                            PopupMenuItem(
                              child: const Text('Edit'),
                              onTap: () {
                                editbuttonClick(key, notes);
                              },
                            ),
                            PopupMenuItem(
                              child: const Text('Delete'),
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: ((context) => AlertDialog(
                                          title: const Text('Delete Note'),
                                          content: const Text(
                                              'Are you sure you want to delete?'),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  navigatorPOP(context);
                                                },
                                                child: const Text('Cancel')),
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                  databox.deleteAt(index);
                                                  setState(() {});
                                                  scaffoldmessenger(context);
                                                },
                                                child: const Text('Ok '))
                                          ],
                                        )));
                              },
                            ),
                          ];
                        },
                      ),
                      tileColor: Colors.amber[100],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  );
                }),
              )
        // : ListView.separated(
        //     itemCount: databox.length,
        //     itemBuilder: ((context, index) {
        //       String key = databox.keyAt(index).toString();
        //       Notes? notes = databox.get(key);
        //       return Padding(
        //         padding: const EdgeInsets.all(8.0),
        //         child: ListTile(
        //           title: Text(
        //             notes!.title!,
        //             style: fontW17(),
        //           ),
        //           trailing: PopupMenuButton(
        //             icon: const Icon(Icons.more_vert),
        //             itemBuilder: (context) {
        //               return [
        //                 PopupMenuItem(
        //                   child: const Text('View'),
        //                   onTap: () {
        //                     Navigator.push(
        //                         context,
        //                         MaterialPageRoute(
        //                             builder: (context) => ViewScreen(
        //                                   notes: notes,
        //                                 )));
        //                   },
        //                 ),
        //                 PopupMenuItem(
        //                   child: const Text('Edit'),
        //                   onTap: () {
        //                     editbuttonClick(key, notes);
        //                   },
        //                 ),
        //                 PopupMenuItem(
        //                   child: const Text('Delete'),
        //                   onTap: () {
        //                     showDialog(
        //                         context: context,
        //                         builder: ((context) => AlertDialog(
        //                               title: const Text('Delete Note'),
        //                               content: const Text(
        //                                   'Are you sure you want to delete?'),
        //                               actions: [
        //                                 TextButton(
        //                                     onPressed: () {
        //                                       navigatorPOP(context);
        //                                     },
        //                                     child: const Text('Cancel')),
        //                                 TextButton(
        //                                     onPressed: () {
        //                                       Navigator.of(context).pop();
        //                                       databox.deleteAt(index);
        //                                       setState(() {});
        //                                       scaffoldmessenger(context);
        //                                     },
        //                                     child: const Text('Ok '))
        //                               ],
        //                             )));
        //                   },
        //                 ),
        //               ];
        //             },
        //           ),
        //           tileColor: Colors.amber[100],
        //           shape: RoundedRectangleBorder(
        //               borderRadius: BorderRadius.circular(10)),
        //         ),
        //       );
        //     }),
        //     separatorBuilder: (context, index) => const SizedBox(),
        //   ),
        );
  }

  editbuttonClick(String key, Notes? notes) {
    titleController.text = notes!.title!;
    contentController.text = notes.content!;

    // alertdialogEdit(titleController, contentController, context, key);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Notes'),
        content: SingleChildScrollView(
          child: Column(children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Title'),
            ),
            sizedbox10(),
            TextField(
              maxLines: null,
              controller: contentController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Content'),
            ),
            // )
          ]),
        ),
        actions: [
          TextButton(
              onPressed: () {
                navigatorPOP(context);
              },
              child: const Text('Cancel')),
          TextButton(
              onPressed: () {
                navigatorPOP(context);
                setState(() {});
                updateToDataBase(
                  key,
                  titleController.text,
                  contentController.text,
                );
              },
              child: const Text('Save')),
        ],
      ),
    );
  }

  textbutton1(ctx) {
    TextButton(
        onPressed: () {
          navigatorPOP(ctx);
        },
        child: const Text('Cancel'));
  }
}
