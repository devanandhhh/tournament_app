

import 'package:flutter/material.dart';
import 'package:tournament_creator/screens/create_tournament.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[100],
      body:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(38.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tournament Creator',
                      style: TextStyle(
                          color: Colors.teal,
                          fontWeight: FontWeight.bold,
                          fontSize: 27),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Icon(
                        Icons.favorite_border,
                        size: 30,
                      ),
                    )
                  ]),
            ),
            Padding(
              padding: EdgeInsets.all(30.0),
          
              child: Container(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Icon(Icons.search),
                    ),Text('Search ',style: TextStyle(color: Colors.blueGrey,fontWeight: FontWeight.bold,fontSize: 18),)
                  ],
                ),
                height: 60,
                width: 350,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 216, 214, 198),
                    borderRadius: BorderRadius.circular(48)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(34.0),
              child: Text(
                'Hello!',
                style: TextStyle(
                  color: Colors.teal,
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
                child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(58),
                      topRight: Radius.circular(58))),
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 70,
                      ),
                      Text(
                        'All out',
                        style: TextStyle(fontSize: 37, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'All game',
                        style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'All Season',
                        style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 80,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) => CreateTournament()));
                        },
                        child: Container(
                            child: Center(
                                child: Text(
                              'Create Tournament',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 21,
                              ),
                            )),
                            width: 300,
                            height: 58,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 216, 214, 198),
                                borderRadius: BorderRadius.circular(5))),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      InkWell(splashColor:   Colors.blue,
                      highlightColor: Colors.amber,
                        onTap: () {},
                        child: Container(
                            child: Center(
                                child: Text(
                              'Tournament List',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 21,
                              ),
                            )),
                            width: 300,
                            height: 58,
                            decoration: BoxDecoration(
                                color:
                                 Color.fromARGB(255, 216, 214, 198),
                                borderRadius: BorderRadius.circular(5))),
                      ),
                    ]),
              ),
            ))
        
            //Stack( children: [Container(width: 400,height: 400 ,decoration: BoxDecoration(color: Colors.teal,borderRadius: BorderRadius.circular(65)),)],)
          ],
        ),
      );
   
  }
}
