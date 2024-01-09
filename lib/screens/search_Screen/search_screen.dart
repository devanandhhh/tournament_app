import 'package:flutter/material.dart';
import 'package:tournament_creator/screens/create_tounament/reuse_widgets/reuse_widgets.dart';
import 'package:tournament_creator/screens/search_Screen/widgets/reuse_widgets.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbardecorations(name: "Search Here"),
      backgroundColor: Colors.yellow[100],
      body: Column(children: [
        Padding(
          padding: EdgeInsets.all(22),
          child: searchbarEditContainer(searchIteam: "Search Tournaments ")
        )
      ]),
    );
  }
}
