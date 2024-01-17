import 'package:flutter/material.dart';
import 'package:tournament_creator/screens/select_tournament/widgets/screens/teams/add_team.dart';

class Teamscreen extends StatelessWidget {
  const Teamscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.push(context,MaterialPageRoute(builder: (context)=>AddTeam()));
       },
       backgroundColor: Colors.teal,
       child: Icon(Icons.add),),backgroundColor: Colors.yellow[100],
       
    );
  }
}
