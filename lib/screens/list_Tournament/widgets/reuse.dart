// import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:tournament_creator/database/firebase_model/dbfuntions.dart';
// import 'package:tournament_creator/database/dbfuntions.dart';
// import 'package:tournament_creator/screens/create_tounament/reuse_widgets/reuse_widgets.dart';
// import 'package:tournament_creator/screens/list_Tournament/widgets/datePicker.dart';
// import 'package:tournament_creator/screens/view_details/reuse/reuse.dart';

editingtextform({
  required String labeltxt,
  required controller,
}) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(labelText: labeltxt),
  );
}

editingtextformOntap({
  required String labeltxt,
  required controller,
  required context,
}) {
  return TextFormField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(labelText: labeltxt),
      onTap: () async {
        DateTime? picked = await showDatePicker(
            context: context,
            //  initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2100));
        if (picked != null) {
          final formatDate =
              //DateFormat('dd-MM-yyyy').format(picked);
              DateFormat.yMMMMd('en_US').format(picked);
          controller = formatDate;
        }
      });
}

alertDialog1({required ctx, required docss,String? filename,}) {
  return AlertDialog(
    title: const Text('Delete Tournament'),
    content: const Text('Are you sure you want to delete?'),
    actions: [
      TextButton(
          onPressed: () {
           // DatabaseFunctions.deleteFiletournament(unique: filename);
            Navigator.of(ctx).pop();
          },
          child: const Text('Cancel')),
      TextButton(
          onPressed: () async {
            try {
              DatabaseFunctions.deleteFiletournament(unique: filename);
              await FirebaseFirestore.instance
                  .collection('tournament')
                  .doc(docss)
                  .delete();
              Navigator.of(ctx).pop();

              ScaffoldMessenger.of(ctx).showSnackBar(
                  const SnackBar(content: Text('Delete Successfully')));
            } catch (e) {
              print(e);
            }

            // await FirebaseFirestore.instance
            //     .collection('tournament_details')
            //     .doc(docss)
            //     .delete();

            //  Navigator.of(ctx).pop();
          },
          child: const Text('Ok'))
    ],
  );
}

// dataSucessSnackbar() => print('Data edited sucessfully ');
// updateSucessSnackbar() {
//   return  SnackBar(
//     content:const Text('Updated data Sucessfully '),
//     backgroundColor: Colors.green[400],
//   );
// }

Future<String?> pickImageFromGallery() async {
  final pickedImage =
      await ImagePicker().pickImage(source: ImageSource.gallery); 
  if (pickedImage != null) {
    return pickedImage.path;
  }
  return null;
}

editingtextformDecorated({required controller}) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
        border: OutlineInputBorder(),
        fillColor: Colors.yellow[100],
        filled: true),
  );
}

// ignore: must_be_immutable
class DatePickerForAge extends StatefulWidget {
  DatePickerForAge(
      {super.key, required this.controller, required this.labeltxt});

  // ignore: prefer_typing_uninitialized_variables
  TextEditingController controller;
  String labeltxt;

  @override
  State<DatePickerForAge> createState() => _DatePickerForAgeState();
}

class _DatePickerForAgeState extends State<DatePickerForAge> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: widget.controller,
        readOnly: true,
        decoration: InputDecoration(
            border: const OutlineInputBorder(), labelText: widget.labeltxt),
        onTap: () async {
          DateTime? picked = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1950),
              lastDate: DateTime(2100));
          if (picked != null) {
            final formatDate =
                //DateFormat('dd-MM-yyyy').format(picked);
                DateFormat.yMMMMd('en_US').format(picked);
            setState(() {
              widget.controller.text = formatDate.toString();
            });
          }
        });
  }
}

// // for sample not using
// showDialog1(
//     {required context,
//     required image,
//     required tournamentNameController,
//     required dateController,
//     required placeController,
//     required categoryy,
//     required categories,
//     required limits,
//     required limitOfTeams,
//     required docs,
//     required selectedImage}) {
//   return showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           scrollable: true,
//           title: Text(
//             'Edit Data',
//             style: stylefont(),
//           ),
//           content: StatefulBuilder(
//             builder: (context, setState) => SingleChildScrollView(
//               child: Column(children: [
//                 CircleAvatar(
//                   backgroundImage: FileImage(File(image)),
//                   maxRadius: 70,
//                   child: GestureDetector(
//                     onTap: () async {
//                       String? pickimage = await pickImageFromGallery();
//                       setState(() {
//                         image = pickimage!;
//                       });
//                     },
//                   ),
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     editingtextform(
//                         labeltxt: 'Tournament Name',
//                         controller: tournamentNameController),
//                     DatePicker(controller: dateController, labeltxt: 'Date'),
//                     // editingtextformOntap(
//                     //     labeltxt: 'Date',
//                     //     controller:
//                     //         dateController,context: context),

//                     editingtextform(
//                         labeltxt: "Place", controller: placeController),
//                     sizedbox10(),
//                     const Text('Category'),
//                     DropdownButtonFormField(
//                         hint: Text(categoryy),
//                         items: categories.map((e) {
//                           return DropdownMenuItem(value: e, child: Text(e));
//                         }).toList(),
//                         onChanged: (value) {
//                           if (categoryy != value) {
//                             categoryy = value.toString();
//                           }
//                         }),
//                     sizedbox10(),
//                     const Text('Limit of Team'),
//                     DropdownButtonFormField(
//                         hint: Text(limits),
//                         items: limitOfTeams.map((e) {
//                           return DropdownMenuItem(
//                             value: e,
//                             child: Text(e),
//                           );
//                         }).toList(),
//                         onChanged: (value) {
//                           if (limits != value) {
//                             limits = value.toString();
//                           }
//                         })
//                   ],
//                 ),
//               ]),
//             ),
//           ),
//           actions: [
//             TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                   // setState(() {
//                   //   selectedImage = image;
//                   // });
//                 },
//                 child: const Text('Cancel')),
//             TextButton(
//                 onPressed: () async {
//                   await DatabaseFunctions.editTournament(
//                       documentId: docs.id,
//                       tournamentImage: image,
//                       tournamentNameController: tournamentNameController,
//                       dateController: dateController,
//                       placeController: placeController,
//                       category: categoryy,
//                       limits: limits);
//                   tournamentNameController.clear();
//                   dateController.clear();
//                   // ignore: use_build_context_synchronously
//                   Navigator.of(context).pop();
//                   dataSucessSnackbar();
//                   // ignore: use_build_context_synchronously
//                   ScaffoldMessenger.of(context)
//                       .showSnackBar(updateSucessSnackbar());
//                 },
//                 child: const Text('Save'))
//           ],
//         );
//       });
// }
