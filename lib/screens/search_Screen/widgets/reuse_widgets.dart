import 'package:flutter/material.dart';

searchbarEditContainer({required String searchIteam}) {
  return Container(
    child: TextFormField(
      decoration: InputDecoration(
          border: OutlineInputBorder(borderSide: BorderSide.none),
          hintText: searchIteam,
          prefixIcon: Icon(Icons.search)),
    ),
    height: 60,
    width: 350,
    decoration: BoxDecoration(
        color: Color.fromARGB(255, 216, 214, 198),
        borderRadius: BorderRadius.circular(48)),
  );
}
