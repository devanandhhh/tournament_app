import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tournament_creator/screens/home/reuse_widgets/refactoring.dart';
import 'package:tournament_creator/screens/select_tournament/widgets/screens/teams/view_player_details.dart';

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
    return Scaffold(
        backgroundColor: Colors.yellow[100],
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('players')
              .where('tournamentID', isEqualTo: widget.doc1)
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
                  String playerphoto = docz['PlayerPhoto'] ?? '';
                  String playerName = docz['PlayerName'];
                  String dateOfBirth = docz['DateOfBirth'];
                  String playerId = docz['PlayerId'];
                  String teamId = docz['teamID'];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.teal,
                      radius: 30,
                      child: ClipOval(
                        child: Image.network(
                          playerphoto,
                          //error builder
                          errorBuilder: ((context, error, stackTrace) =>
                              const Text('😢')),
                          //loading builder
                          loadingBuilder: (context, child, loadingProgress) {
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
                          },
                          fit: BoxFit.cover, width: 50, height: 50,
                        ),
                      ),
                    ),
                    title: Text(playerName),
                    subtitle: Text(dateOfBirth),
                    onTap: () async {
                      try {
                        DocumentSnapshot<Map<String, dynamic>>
                            documentSnapshot = await FirebaseFirestore.instance
                                .collection('tournament')
                                .doc(widget.doc1)
                                .collection('team')
                                .doc(teamId)
                                .get();
                        print(widget.doc1);
                        print(teamId);
                        String name = documentSnapshot.get('teamName');

                        // ignore: use_build_context_synchronously
                        navigatorPush(
                            ctx: context,
                            screen: View_player_details(
                                teamName: name,
                                playerphoto: playerphoto,
                                playerName: playerName,
                                playerDoB: dateOfBirth,
                                playerProff: playerId));
                      } catch (e) {
                        print('thsi $e');
                      }
                    },
                  );
                },
                separatorBuilder: (context, index) => Divider(),
                itemCount: snapshot.data!.docs.length);
          },
        ));
  }
}
