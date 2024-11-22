

import 'package:flutter/material.dart';

class SearchBarEditWidget extends StatefulWidget {
  const SearchBarEditWidget({super.key});

  @override
  State<SearchBarEditWidget> createState() => _SearchBarEditWidgetState();
}

class _SearchBarEditWidgetState extends State<SearchBarEditWidget> {
  @override
  Widget build(BuildContext context) {
    return  Container(
    child: TextFormField(
      decoration: InputDecoration(
          border: OutlineInputBorder(borderSide: BorderSide.none),
          hintText: "Search item",
          prefixIcon: Icon(Icons.search)),
    ),
    height: 60,
    width: 350,
    decoration: BoxDecoration(
        color: Color.fromARGB(255, 216, 214, 198),
        borderRadius: BorderRadius.circular(48)),
  );
  }
}
