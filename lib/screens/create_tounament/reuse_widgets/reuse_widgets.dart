import 'package:flutter/material.dart';

appbardecorations({required String name}) {
  return AppBar(
    backgroundColor: Colors.yellow[100],
    title: Text(
      name,
      style: const TextStyle(
          color: Colors.teal, fontSize: 30, fontWeight: FontWeight.bold),
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
          style: TextStyle(
              color: Colors.blueGrey,
              fontWeight: FontWeight.bold,
              fontSize: 18),
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
      style: const TextStyle(
          color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
    )),
  );
}

hintText({required String hintTxt}) {
  return Text(
    hintTxt,
    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
  );
}

inputdecorationtxtFormField() {
  return InputDecoration(
      filled: true,
      fillColor: const Color.fromARGB(255, 216, 214, 198),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none));
}
