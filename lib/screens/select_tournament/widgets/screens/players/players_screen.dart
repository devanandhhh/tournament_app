
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';

// ignore: must_be_immutable
class PlayerScreen extends StatefulWidget {
  PlayerScreen({super.key, required this.doc1, required this.uniqueId});
  var doc1;
String? uniqueId;
  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.yellow[100],
        body: StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('players')
          .where('tournamentID', isEqualTo:widget.doc1)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text('No PLayers available'),
          );
        }
        return ListView.separated(
          
            itemBuilder: (context, index) {
              var docz = snapshot.data!.docs[index];
              String playerphoto=docz['PlayerPhoto']??'';
              String playerName = docz['PlayerName'];
              String dateOfBirth = docz['DateOfBirth'];

              return ListTile(
                leading: InstaImageViewer(
                  child: CircleAvatar(
                    backgroundColor: Colors.teal,
                   radius:  30,child: ClipOval(child: Image.file(File(playerphoto,),fit: BoxFit.cover,width: 50,height: 50 ,)),
                  ),
                ),
                title: Text(playerName),
                subtitle: Text(dateOfBirth),
              );
            },
            separatorBuilder: (context, index) => Divider(),
            itemCount:
             snapshot.data!.docs.length
             );
      },
    ));
  }
}
