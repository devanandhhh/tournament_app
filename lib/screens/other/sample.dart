import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

ImagePickers obj=ImagePickers();
ImagePicker2 obj2=ImagePicker2();

class ImagePickers {
  String imageLink = '';
  
  Future<void> imagePicking() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      imageLink = image.path.toString();
      print(imageLink);
    }
  }
}

class ImagePicker2 {
  String imagelink2= ''; 
  Future<void>imagePicking2()async{
    final image=await ImagePicker().pickImage(source: ImageSource.gallery);
    if(image !=null){
      imagelink2=image.path.toString();
      print( imagelink2);
    }
  }
}
class SnackbarDecoraction{
SnackBar kSnakbar({required String text, Color? col = Colors.grey}) {
  return SnackBar(
    duration: const Duration(seconds: 3),
    content: Text(text,
        style: GoogleFonts.mukta(textStyle: const TextStyle(fontSize: 17))
        ),
    behavior: SnackBarBehavior.floating,
    backgroundColor: col,
  );
}
}
