import 'package:flutter/material.dart';
import 'package:tournament_creator/screens/select_tournament/widgets/reusable.dart';

class Matchscreen extends StatelessWidget {
  const Matchscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[100],
      body: Center(
          child: Container(
              height: 50,
              width: 150,
              decoration: BoxDecoration(
                  color: Colors.teal, borderRadius: BorderRadius.circular(8)),
              child: Center(
                  child: Text(
                'Generate Matches',
                style: boxteal(),
              )))),
    );
  }
}
