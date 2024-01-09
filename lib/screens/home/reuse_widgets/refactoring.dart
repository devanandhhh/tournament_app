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
          color:const Color.fromARGB(255, 216, 214, 198),
          borderRadius: BorderRadius.circular(5)));
}

headingtext({required String text}) {
  return Text(
    text,
    style:const TextStyle(
        color: Colors.teal, fontWeight: FontWeight.bold, fontSize: 27),
  );
}

iconSize30({required IconData icondata}) {
  return Icon(
    icondata,
    size: 30,
  );
}

navigatorPush({required BuildContext ctx, required screen}) {
  return Navigator.push(ctx, MaterialPageRoute(builder: (ctx) => screen));
}

sizedbox70() {
  return const SizedBox(
    height: 70,
  );
}
sizedbox30(){
  return const SizedBox(height: 30,);
}

tealclrbox() {
  return const BoxDecoration(
      color: Colors.teal,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(58), topRight: Radius.circular(58)));
}
