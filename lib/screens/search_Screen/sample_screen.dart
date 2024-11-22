import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tournament_creator/screens/create_tounament/reuse_widgets/reuse_widgets.dart';
import 'package:tournament_creator/screens/home_Screen/reuse_widgets/refactoring.dart';
import 'package:tournament_creator/screens/search_Screen/user_view.dart';

class SampleScreen extends StatefulWidget {
  const SampleScreen({super.key});

  @override
  State<SampleScreen> createState() => _SampleScreenState();
}

class _SampleScreenState extends State<SampleScreen> {
  TextEditingController searchController = TextEditingController();
  QuerySnapshot? querySnapshot;
  //List<DocumentSnapshot>alldata=[];
  late List<DocumentSnapshot> filteredData = [];

  fetchData() async {
    final data =
        await FirebaseFirestore.instance.collection('tournament').get();
    setState(
      () {
        querySnapshot = data;
        filteredData = data.docs;
        // alldata=data.docs;
      },
    );
  }

  filtedData(String query) {
    List<DocumentSnapshot> filterd = [];
    querySnapshot?.docs.forEach(
      (element) {
        if (element['TournamentName']
            .toString()
            .toLowerCase()
            .contains(query.toLowerCase())) {
          filterd.add(element);
        }
        setState(() {
          filteredData = filterd;
        });
      },
    );
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[100],
      appBar: AppBar(
        backgroundColor: Colors.yellow[100],
        title: TextField(
          controller: searchController,
          decoration: const InputDecoration(
              border: OutlineInputBorder(borderSide: BorderSide.none),
              hintText: 'Search Tournament'),
          onChanged: (value) {
            filtedData(value);
          },
        ),
      ),
      body: querySnapshot == null || filteredData.isEmpty
          ? const Center(child: CircularProgressIndicator()
              //   Text('No tournament Available'),
              )
          : ListView.separated(
              itemBuilder: (context, index) {
                var iteam = filteredData[index];
                String dprofile = iteam['TournamentImage'];
                String tournamentName = iteam['TournamentName'];
                String date = iteam['Date'];
                return ListTile(
                  onTap: () {
                    // print('pa ${iteam.id}');
                    navigatorPush(
                      ctx: context,
                      screen: UserView(
                        tournamentname: tournamentName,
                        doc1: iteam.id,
                      ),
                    );
                  },
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.teal,
                    child: ClipOval(
                      child: Image.network(
                        dprofile,
                        fit: BoxFit.cover,
                        width: 50,
                        height: 50,
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
                      ),
                    ),
                  ),
                  title: Text(tournamentName),
                  subtitle: Text(date),
                );
              },
              separatorBuilder: (context, index) => sizedbox10(),
              itemCount: filteredData.length),
    );
  }
}