import 'package:flutter/material.dart';

bgblacktext({required String text1}) {
  return Text(
    text1,
    style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold),
  );
}

containerButtons({required String name}) {
  return Container(
      child: Center(
          child: Text(
        name,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 21,
        ),
      )),
      width: 300,
      height: 58,
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 216, 214, 198),
          borderRadius: BorderRadius.circular(5)));
}
