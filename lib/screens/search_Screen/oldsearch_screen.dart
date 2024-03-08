import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tournament_creator/screens/create_tounament/reuse_widgets/reuse_widgets.dart';
import 'package:tournament_creator/screens/home/reuse_widgets/refactoring.dart';
import 'package:tournament_creator/screens/search_Screen/user_view.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  late List<DocumentSnapshot> searchResults = [];
  // @override
  // void initState() {
  //   _searchResults.length;
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appbardecorations(name: "Search Here"),
      backgroundColor: Colors.yellow[100],
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: EdgeInsets.all(22),
            child: buildSearchBar(),
          ),
          Container(
              height: size.height - 60,
              width: double.infinity,
              // color: Colors.red,
              // child: _buildSearchResults(),
              child: ListView.separated(
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  final document = searchResults[index];
                  String dprofile = document['TournamentImage'];
                  String tournamentName = document['TournamentName'];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ListTile(
                       shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      tileColor: Colors.amber[100],
                      onTap: () => navigatorPush(
                          ctx: context,
                          screen: UserView(
                            tournamentname: tournamentName,doc1: document,
                          )),
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.teal,
                        child: ClipOval(
                          child: Image.file(
                            File(dprofile),
                            fit: BoxFit.cover,
                            width: 50,
                            height: 50,
                          ),
                        ),
                      ),
                      title: Text(tournamentName),
                      subtitle: Text(document['Date']),
                    ),
                  );
                },
                separatorBuilder: (context, index) => sizedbox10(),
              ))
        ]),
      ),
    );
  }

  Widget buildSearchBar() {
    return Container(
      height: 60,
      width: 350,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 216, 214, 198),
        borderRadius: BorderRadius.circular(48),
      ),
      child: TextFormField(
        controller: searchController,
        onChanged: performSearch,
        decoration: const InputDecoration(
          border: OutlineInputBorder(borderSide: BorderSide.none),
          hintText: "Search item",
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }

  void performSearch(String query) {
    FirebaseFirestore.instance
        .collection('tournament')
        .where('TournamentName', isGreaterThanOrEqualTo: query)
        .where('TournamentName', isLessThan: query + 'z')
        .get()
        .then((QuerySnapshot querySnapshot) {
      setState(() {
        searchResults = querySnapshot.docs;
      });
    });
  }
}
