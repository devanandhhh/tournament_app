import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

editingtextform({required String labeltxt, required controller}) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(labelText: labeltxt),
  );
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
          child:const Text('Cancel')),
      TextButton(
          onPressed: () async {
            Navigator.of(ctx).pop();
            await FirebaseFirestore.instance
                .collection('tournament_details')
                .doc(docss.id)
                .delete();

            ScaffoldMessenger.of(ctx).showSnackBar(
                const SnackBar(content: Text('Delete Successfully')));
          },
          child:const Text('Ok'))
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