import 'package:flutter/material.dart';
import 'package:tournament_creator/fav_screen/fav_screen.dart';
import 'package:tournament_creator/screens/list_Tournament/list_tournify.dart';
import 'package:tournament_creator/screens/create_tournament/create_tournament.dart';
import 'package:tournament_creator/screens/create_tournament/reuse_widgets/reuse_widgets.dart';
import 'package:tournament_creator/screens/home/reuse_widgets/refactoring.dart';
import 'package:tournament_creator/screens/search_Screen/search_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[100],
      body: Column(
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
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => FavouiteScreen()));
                    },
                    child: Icon(
                      Icons.favorite_border,
                      size: 30,
                    ),
                  )
                ]),
          ),
          Padding(
              padding: EdgeInsets.all(30.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (ctx) => SearchScreen()));
                },
                child: searchbarContainer(searchIteam: "Search"),
              )),
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
                    bgblacktext(text1: 'All out'),
                    bgblacktext(text1: 'All game'),
                    bgblacktext(text1: 'All Season'),
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
                      child: containerButtons(name: "Create Tournament"),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (ctx) => TournmentList()));
                      },
                      child: containerButtons(name: 'Tournament List'),
                    )
                  ]),
            ),
          ))

          //Stack( children: [Container(width: 400,height: 400 ,decoration: BoxDecoration(color: Colors.teal,borderRadius: BorderRadius.circular(65)),)],)
        ],
      ),
    );
  }
}
