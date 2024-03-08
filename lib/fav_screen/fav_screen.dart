import 'package:flutter/material.dart';
import 'package:tournament_creator/screens/create_tounament/reuse_widgets/reuse_widgets.dart';

class FavouiteScreen extends StatelessWidget {
  const FavouiteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: appbardecorations(name: "Favourites "),
    backgroundColor: Colors.yellow[100],
     );
  }

}
class Fav {
  String name ;
  String place;
  String date;
  String category;
  String limit;
  
  

  Fav({required this.name,required this.place,required this.date,required this.category,required this.limit});
}        


