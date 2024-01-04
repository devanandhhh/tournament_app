import 'package:flutter/material.dart';
import 'package:tournament_creator/screens/create_tournament/reuse_widgets/reuse_widgets.dart';

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
    );
  }
}
