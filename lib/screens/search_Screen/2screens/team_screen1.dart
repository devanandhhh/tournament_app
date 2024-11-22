// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
        backgroundColor: Colors.yellow[100],
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

                    return ListTile(
                      title: Text(teamName),
                      subtitle: Text(managerName),
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.teal,
                        child: ClipOval(
                            child: Image.network(teamImage,
                                fit: BoxFit.cover,
                                width: 50,
                                height: 50,
                                //error builder
                                errorBuilder: ((context, error, stackTrace) =>
                                    const Text('😢')),
                                //loading builder
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                          final totalBytes =
                              loadingProgress?.expectedTotalBytes;
                          final bytesLoaded =
                              loadingProgress?.cumulativeBytesLoaded;
                          if (totalBytes != null && bytesLoaded != null) {
                            return CircularProgressIndicator(
                              backgroundColor: Colors.white70,
                              value: bytesLoaded / totalBytes,
                              color: Colors.teal[900],
                              strokeWidth: 5.0,
                            );
                          } else {
                            return child;
                          }
                        })),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: snapshot.data!.docs.length);
            }));
  }
}
