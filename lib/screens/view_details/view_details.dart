
import 'package:flutter/material.dart';
import 'package:tournament_creator/screens/create_tounament/reuse_widgets/reuse_widgets.dart';

import 'package:tournament_creator/screens/view_details/reuse/reuse.dart';

// ignore: must_be_immutable
class ViewTournamentDetails extends StatelessWidget {
  ViewTournamentDetails(
      {super.key,
      required this.imageView,
      required this.name,
      required this.place,
      required this.date,
      required this.category,
      required this.limit});
  String imageView;
  String name;
  String place;
  String date;
  String category;
  String limit;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbardecorations(name: "View details"),
      backgroundColor: Colors.yellow[100],
      body: Center(
          child: Container(
        height: 600,
        width: 300,
        decoration: BoxDecoration(
          color: Colors.amber[100],
          borderRadius: BorderRadius.circular(18),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(children: [
            CircleAvatar(
              backgroundColor: Colors.teal,
              maxRadius: 90,
              child: ClipOval(
                child: Image.network(
                  imageView,
                  fit: BoxFit.cover,
                  height: 170,
                  width: 170,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sizedbox10(),
                SizedBox(
                  height: 350,
                  width: 380,
                  
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      sizedbox10(),
                      Text('Tournament Name',style:stylefont()),
                      sizedbox10(),
                      Text(name,style:styleTeal()), sizedbox10(),
                      Text('Date',style: stylefont(),),sizedbox10(),
                      Text(date,style: styleTeal(),),sizedbox10(),
                      Text('Place',style: stylefont(),),sizedbox10(),
                      Text(place,style: styleTeal(),),sizedbox10(),
                      Text('Category',style: stylefont(),),sizedbox10(),
                      Text(category,style: styleTeal(),),sizedbox10(),
                      Text("Limit Of Teams",style: stylefont(),),sizedbox10(),
                      Text(limit,style: styleTeal(),),sizedbox10(),
                      
                    ],
                  ),
                )
              ],
            ),
          ]),
        ),
      )),
    );
  }
}
