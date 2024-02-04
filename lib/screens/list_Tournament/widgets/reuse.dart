import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

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

alertDialog1({required ctx, required docss}) {
  return AlertDialog(
    title: const Text('Delete Tournament'),
    content: const Text('Are you sure you want to delete?'),
    actions: [
      TextButton(
          onPressed: () {
            Navigator.of(ctx).pop();
          },
          child: const Text('Cancel')),
      TextButton(
          onPressed: () async {
            await FirebaseFirestore.instance
                .collection('tournament_details')
                .doc(docss)
                .delete();
            Navigator.of(ctx).pop();

            ScaffoldMessenger.of(ctx).showSnackBar(
                const SnackBar(content: Text('Delete Successfully')));
            //  Navigator.of(ctx).pop();
          },
          child: const Text('Ok'))
    ],
  );
}

dataSucessSnackbar() => print('Data edited sucessfully ');
updateSucessSnackbar() {
  return const SnackBar(
    content: Text('Updated data Sucessfully '),
    backgroundColor: Colors.green,
  );
}

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
class DatePicker extends StatefulWidget {
  DatePicker({super.key, required this.controller, required this.labeltxt});

  // ignore: prefer_typing_uninitialized_variables
  TextEditingController controller;
  String labeltxt;

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: widget.controller,
        readOnly: true,
        decoration: InputDecoration(labelText: widget.labeltxt),
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
            setState(() {
              widget.controller.text = formatDate.toString();
            });
          }
        });
  }
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
