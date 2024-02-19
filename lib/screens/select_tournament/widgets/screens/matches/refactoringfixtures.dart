import 'package:flutter/material.dart';
import 'package:tournament_creator/screens/create_tounament/reuse_widgets/reuse_widgets.dart';
import 'package:tournament_creator/screens/select_tournament/widgets/reusable.dart';

fixtures({required String? team1,required String? team2}){
  return  Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child:  Container(
              height: 130,
              width: 500,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.amber[100]),
              child: Column(
                children: [
                  SizedBox(height: 15,),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(10)),
                      height: 80,
                      width: 80,
                    ),Text('VS',style: font17() ,),
                     Container(
                      decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(10)),
                      height: 80,
                      width: 80,
                    ),
                  ]),sizedbox10(),Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                    Text(team1!,style: TextStyle(fontSize: 15 ,) ,),
                    SizedBox(width: 10,),
                    Text(team2!,style:TextStyle(fontSize: 15 ,))
                  ],)

                ],
              ),
            )
          );
  
}