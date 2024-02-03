import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tournament_creator/screens/create_tounament/reuse_widgets/reuse_widgets.dart';
import 'package:tournament_creator/screens/list_Tournament/widgets/reuse.dart';
import 'package:tournament_creator/screens/select_tournament/widgets/reusable.dart';

// ignore: must_be_immutable
class EditTournament extends StatefulWidget {
  EditTournament({super.key});
// String image;
  @override
  State<EditTournament> createState() => _EditTournamentState();
}

class _EditTournamentState extends State<EditTournament> {
  String? tournamentImage;

  TextEditingController tournamentNameController = TextEditingController( );

  TextEditingController dateController = TextEditingController();

  TextEditingController placeController = TextEditingController();

  TextEditingController categoryController = TextEditingController();

  TextEditingController limitController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbardecorations(name: 'Edit Tournament'),
      backgroundColor: Colors.yellow[100],
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          
            InkWell(
              onTap: () async{
                String? editImage=await pickImageFromGallery();
                setState(() {
                  tournamentImage=editImage;
                });
              },
              child: Container(
                height: 150,
                width: 400,
                decoration: BoxDecoration(
                  image: DecorationImage(image: FileImage(File(tournamentImage??'')),fit: BoxFit.cover),
                    color: Colors.green[100],
                    borderRadius: BorderRadius.circular(20)),
                    child: Icon(Icons.add_a_photo),
              ),
            ),
          
          
            sizedbox10(),
              Text('Tournament Name',style: font17(),) , 
            editingtextformDecorated(
              
                controller: tournamentNameController),
            sizedbox10(),
            Text(' Date',style: font17(),),
            sizedbox10(),
            editingtextformDecorated(
                  controller: dateController),
            sizedbox10(),
            Text('Place',style: font17(),),
            sizedbox10(),
            editingtextformDecorated(
                 controller: placeController),
            sizedbox10(),
            Text( 'Category',style: font17(),),
            sizedbox10(),
            editingtextformDecorated(
               controller: categoryController),
            sizedbox10(),
            Text(  'Limit of team',style: font17(),),
            sizedbox10(),
            editingtextformDecorated(
                controller: limitController),
                sizedbox10(),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [containerButtonCR(txt: 'Cancel'),containerButtonCR(txt: 'Save')],)
          ],),
        ),
      ),
    );
  }
}
