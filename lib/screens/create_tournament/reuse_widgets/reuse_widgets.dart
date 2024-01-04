

import 'package:flutter/material.dart';

appbardecorations({required String name}) {
  return AppBar(
    backgroundColor: Colors.yellow[100],
    title: Text(
      name,
      style: TextStyle(
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
