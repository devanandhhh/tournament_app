import 'package:flutter/material.dart';
import 'package:tournament_creator/screens/create_tounament/reuse_widgets/reuse_widgets.dart';
import 'package:tournament_creator/screens/home/reuse_widgets/refactoring.dart';
import 'package:tournament_creator/screens/select_tournament/widgets/reusable.dart';

class AddTeam extends StatelessWidget {
  const AddTeam({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbardecorations(name: 'Add Team'),
      backgroundColor: Colors.yellow[100],
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Column(children: [
            const CircleAvatar(backgroundImage: AssetImage('assets/addimage.png'),
              radius: 70,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sizedbox30(),
                Text(
                  "Team Name",
                  style: font17(),
                ),
                sizedbox10(),
                TextFormField(
                  decoration: InputDecoration(border: OutlineInputBorder()),
                ),
                sizedbox10(), 
                Text(
                  "Manger Name",
                  style: font17(),
                ),
                sizedbox10(),
                TextFormField(
                  decoration: InputDecoration(border: OutlineInputBorder()),
                ),
                sizedbox10(),
                Text(
                  "Phone Number",
                  style: font17(),
                ),
                sizedbox10(),
                TextFormField(
                  decoration: InputDecoration(border: OutlineInputBorder()),
                ),
                sizedbox10(),
                Text(
                  "Place",
                  style: font17(),
                ),
                sizedbox10(),
                TextFormField(
                  decoration: InputDecoration(border: OutlineInputBorder()),
                ),
              ],
            ),sizedbox70(),
                containerButtonCR(txt: 'Add Team')
          ]),
        ),
      ),
    );
  }
}
