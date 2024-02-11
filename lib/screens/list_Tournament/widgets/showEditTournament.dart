import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tournament_creator/screens/create_tounament/reuse_widgets/reuse_widgets.dart';
import 'package:tournament_creator/screens/list_Tournament/widgets/datePicker.dart';
import 'package:tournament_creator/screens/list_Tournament/widgets/reuse.dart';
import 'package:tournament_creator/screens/view_details/reuse/reuse.dart';

class ShowEditTournament extends StatefulWidget {
  const ShowEditTournament({
    super.key,
    required context,
    required image,
    required tournamentNameController,
    required dateController,
    required placeController,
    required categoryy,
   // required categories,
    required limits,
    required limitOfTeams,
    required docs,
    //required selectedImage
  });

  @override
  State<ShowEditTournament> createState() => _ShowEditTournamentState();
}

class _ShowEditTournamentState extends State<ShowEditTournament> {
  String? image;
  TextEditingController? tournamentNameController;
  TextEditingController? dateController;
  late TextEditingController placeController;
  String? categoryy;
  late List categories;
  String? limits;
  List? limitOfTeams;
  String? selectedImage;
  var docs;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Text(
        'Edit Data',
        style: stylefont(),
      ),
      content: StatefulBuilder(
        builder: (context, setState) => SingleChildScrollView(
          child: Column(children: [
            CircleAvatar(
              backgroundImage: FileImage(File(image ?? '')),
              maxRadius: 70,
              child: GestureDetector(
                onTap: () async {
                  String? pickimage = await pickImageFromGallery();
                  setState(() {
                    image = pickimage!;
                  });
                },
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                editingtextform(
                    labeltxt: 'Tournament Name',
                    controller: tournamentNameController),
                DatePicker(controller: dateController!, labeltxt: 'Date'),
                // editingtextformOntap(
                //     labeltxt: 'Date',
                //     controller:
                //         dateController,context: context),

                editingtextform(labeltxt: "Place", controller: placeController),
                sizedbox10(),
                const Text('Category'),
                DropdownButtonFormField(
                    hint: Text(categoryy!),
                    items: categories.map((e) {
                      return DropdownMenuItem(value: e, child: Text(e));
                    }).toList(),
                    onChanged: (value) {
                      if (categoryy != value) {
                        categoryy = value.toString();
                      }
                    }),
                sizedbox10(),
                const Text('Limit of Team'),
                DropdownButtonFormField(
                    hint: Text(limits!),
                    items: limitOfTeams?.map((e) {
                      return DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (limits != value) {
                        limits = value.toString();
                      }
                    })
              ],
            ),
          ]),
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                selectedImage = image;
              });
            },
            child: const Text('Cancel')),
        TextButton(
            onPressed: () async {
              // await DatabaseFunctions.editTournament(
              //     documentId: docs.id,
              //     tournamentImage: image,
              //     tournamentNameController: tournamentNameController,
              //     dateController: dateController,
              //     placeController: placeController,
              //     category: categoryy,
              //     limits: limits);
              // await FirebaseFirestore.instance
              //     .collection('tournament')
              //     .doc(docs.id)
              //     .update({
              //   'TournamentImage': selectedImage,
              //   'TournamentName': tournamentNameController?.text,
              //   'Date': dateController?.text,
              //   "Place": placeController.text,
              //   'Category': categoryy,
              //   'LimitOfTeam': limits,
              // });
              tournamentNameController?.clear();
              dateController?.clear();
              // ignore: use_build_context_synchronously
              Navigator.of(context).pop();
              dataSucessSnackbar();
              // ignore: use_build_context_synchronously
              ScaffoldMessenger.of(context)
                  .showSnackBar(updateSucessSnackbar());
            },
            child: const Text('Save'))
      ],
    );
  }
}
