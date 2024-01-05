import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tournament_creator/screens/create_tournament/reuse_widgets/reuse_widgets.dart';
import 'package:tournament_creator/screens/list_Tournament/widgets/reuse.dart';

class TournmentList extends StatefulWidget {
  const TournmentList({super.key});

  @override
  State<TournmentList> createState() => _TournmentListState();
}

class _TournmentListState extends State<TournmentList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbardecorations(name: "Tournament List "),
        backgroundColor: Colors.yellow[100],
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('tournament_details')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text('no data available'),
              );
            }
            return ListView.separated(
                itemBuilder: (context, index) {
                  var docs = snapshot.data!.docs[index];
                  String tournamentName = docs['TournamentName'] ?? "";
                  String date = docs['Date'] ?? "";
                  //add category and limits
                  TextEditingController tournamentNameController =
                      TextEditingController(text: docs['TournamentName']);
                  TextEditingController dateController =
                      TextEditingController(text: docs['Date']);
                  //add category and limits
                  return ListTile(
                    onTap: () {},
                    title: Text(tournamentName),
                    subtitle: Text(date),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Edit Data'),
                                      content: Column(children: [
                                        editingtextform(
                                            labeltxt: 'Tournament Name',
                                            controller: tournamentNameController),
                                        editingtextform(
                                            labeltxt: 'Date',
                                            controller: dateController)
                                      ]),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Cancel')),
                                        TextButton(
                                            onPressed: () async {
                                              await FirebaseFirestore.instance
                                                  .collection(
                                                      'tournament_details')
                                                  .doc()
                                                  .update({
                                                'TournamentName':
                                                    tournamentNameController
                                                        .text,
                                                'Date': dateController.text
                                              });
                                              tournamentNameController.clear();
                                              dateController.clear();

                                              Navigator.of(context).pop(); 
                                              print( 'data edited sucessfully ');
                                            },
                                            child: const Text('Save'))
                                      ],
                                    );
                                  });
                            },
                            icon: Icon(Icons.edit)),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () async {
                            await FirebaseFirestore.instance
                                .collection('tournament_details')
                                .doc(docs.id)
                                .delete();
                          },
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: snapshot.data!.docs.length);
          },
        ));
  }
}
