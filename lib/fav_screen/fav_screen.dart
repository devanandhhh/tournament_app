import 'package:flutter/material.dart';
import 'package:tournament_creator/screens/create_tounament/reuse_widgets/reuse_widgets.dart';

class FavouiteScreen extends StatelessWidget {
  const FavouiteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: appbardecorations(name: "Favourites "),
    backgroundColor: Colors.yellow[100],);
  }
}