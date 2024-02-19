// ignore_for_file: must_be_immutable

// import 'package:cloud_firestore/cloud_firestore.dart';

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tournament_creator/screens/home/reuse_widgets/refactoring.dart';
import 'package:tournament_creator/screens/select_tournament/widgets/screens/teams/view_details.dart';
// import 'package:tournament_creator/screens/create_tounament/reuse_widgets/reuse_widgets.dart';

class TeamScreenView extends StatelessWidget {
  TeamScreenView({super.key, required this.doc1});
  // ignore: prefer_typing_uninitialized_variables
  var doc1;
  printThat() {
    print("This is :$doc1");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('tournament')
                .doc(doc1)
                .collection('team')
                .snapshots(),
            builder: (context, snapshot) {
              // print('ivide ethi');
              printThat();
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.teal),
                );
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Text('No data available'),
                );
              }

              return ListView.separated(
                  itemBuilder: (context, index) {
                    var doc2 = snapshot.data!.docs[index];
                    String teamImage = doc2['teamImage'];
                    String teamName = doc2['teamName'];
                    String managerName = doc2['managerName'];
                    String phoneNumber = doc2['phoneNumber'];
                    String place = doc2['place'];

                    return ListTile(
                      onTap: () => navigatorPush(
                          ctx: context,
                          screen: ViewTeamDetails(
                              imageview: teamImage,
                              teamName: teamName,
                              managerName: managerName,
                              phoneNumber: phoneNumber,
                              placeName: place)),
                      title: Text(teamName),
                      subtitle: Text(managerName),
                      leading: CircleAvatar(
                        child: ClipOval(
                            child: Image.file(
                          File(teamImage),
                          fit: BoxFit.cover,
                          width: 50,
                          height: 50,
                        )),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: snapshot.data!.docs.length);
            }));
  }
}
