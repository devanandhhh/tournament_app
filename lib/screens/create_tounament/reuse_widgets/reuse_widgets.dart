import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

appbardecorations({required String name}) {
  return AppBar(
    backgroundColor: Colors.yellow[100],
    title: Text(name,
        style: GoogleFonts.oswald(
            fontSize: 30, fontWeight: FontWeight.bold, color: Colors.teal)),
  );
}

searchbarContainer({required String searchIteam}) {
  return Container(
    height: 60,
    width: 350,
    decoration: BoxDecoration(
        color: const Color.fromARGB(255, 216, 214, 198),
        borderRadius: BorderRadius.circular(48)),
    child: Row(
      children: [
        const Padding(
          padding: EdgeInsets.all(18.0),
          child: Icon(Icons.search),
        ),
        Text(searchIteam, style: GoogleFonts.oswald(fontSize: 18))
      ],
    ),
  );
}

messengerScaffold({required String text, required BuildContext ctx}) {
  return ScaffoldMessenger.of(ctx).showSnackBar(
    SnackBar(
      content: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red[400],
    ),
  );
}

sizedbox10() {
  return const SizedBox(
    height: 10,
  );
}

containerButtonCR({required String txt}) {
  return Container(
    height: 60,
    width: 150,
    decoration: BoxDecoration(
        color: Colors.teal, borderRadius: BorderRadius.circular(8)),
    child: Center(
      child: Text(txt,
          style: GoogleFonts.oswald(
              color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
    ),
  );
}

hintText({required String hintTxt}) {
  return Text(hintTxt,
      style: GoogleFonts.oswald(fontSize: 20, fontWeight: FontWeight.w400));
}

inputdecorationtxtFormField() {
  return InputDecoration(
    filled: true,
    fillColor: const Color.fromARGB(255, 216, 214, 198),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
  );
}

addTeamButton({required String txt, color}) {
  return Container(
    height: 60,
    width: 150,
    decoration:
        BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
    child: Center(
      child: Text(txt,
          style: GoogleFonts.oswald(
              color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
    ),
  );
}

dialogShowing({required ctx}) {
  return showDialog(
      context: ctx,
      builder: (context) {
        return const Center(child: CircularProgressIndicator());
      });
}

Future imageFromGallery() async {
  return ImagePicker().pickImage(source: ImageSource.gallery).toString();
}
