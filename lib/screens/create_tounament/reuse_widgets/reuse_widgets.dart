import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

appbardecorations({required String name}) {
  return AppBar(
    backgroundColor: Colors.yellow[100],
    title: Text(
      name,
      style:GoogleFonts.oswald(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.teal)
      //  const TextStyle(
      //     color: Colors.teal, fontSize: 30, fontWeight: FontWeight.bold),
    ),
  );
}

searchbarContainer({required String searchIteam}) {
  return Container(
    child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Icon(Icons.search),
        ),
        Text(
          searchIteam,
          style:GoogleFonts.oswald(fontSize: 18)
          //  TextStyle(
          //     color: Colors.blueGrey,
          //     fontWeight: FontWeight.bold,
          //     fontSize: 18),
        )
      ],
    ),
    height: 60,
    width: 350,
    decoration: BoxDecoration(
        color: Color.fromARGB(255, 216, 214, 198),
        borderRadius: BorderRadius.circular(48)),
  );
}

messengerScaffold({required String text, required BuildContext ctx}) {
  return ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
    content: Text(
      text,
      style: const TextStyle(color: Colors.white),
    ),
    backgroundColor: Colors.red,
  ));
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
        child: Text(
      txt,
      style:GoogleFonts.oswald(color: Colors.white,fontSize: 28,fontWeight: FontWeight.bold) 
      // const TextStyle(
      //     color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
    )),
  );
}

hintText({required String hintTxt}) {
  return Text(
    hintTxt,
    style: GoogleFonts.oswald(fontSize: 20,fontWeight: FontWeight.w400)
    //const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
  );
}

inputdecorationtxtFormField() {
  return InputDecoration(
      filled: true,
      fillColor: const Color.fromARGB(255, 216, 214, 198),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none));
}
