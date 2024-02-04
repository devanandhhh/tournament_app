import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tournament_creator/fav_screen/fav_screen.dart';
import 'package:tournament_creator/screens/addNotes/add_notes.dart';
import 'package:tournament_creator/screens/create_tounament/create_tournament.dart';
import 'package:tournament_creator/screens/create_tounament/reuse_widgets/reuse_widgets.dart';
import 'package:tournament_creator/screens/list_Tournament/list_tournify.dart';
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
            padding: const EdgeInsets.all(38.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  headingtext(text: 'Tournament Creator'),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          navigatorPush(
                              ctx: context, screen: const FavouiteScreen());
                        },
                        child: iconSize30(icondata: Icons.favorite_border),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      InkWell(
                        onTap: () {
                          navigatorPush(ctx: context, screen:  AddNotes());
                        },
                        child: iconSize30(icondata: Icons.edit),
                      )
                    ],
                  )
                ]),
          ),
          Padding(
              padding: const EdgeInsets.all(30.0),
              child: InkWell(
                onTap: () {
                  navigatorPush(ctx: context, screen: const SearchScreen());
                },
                child: searchbarContainer(searchIteam: "Search"),
              )),
           Padding(
              padding:const EdgeInsets.all(34.0),
              child: Text(
                ' Hello!',
                style:GoogleFonts.oswald(fontSize: 50,color: Colors.teal)
                //  TextStyle(
                //   color: Colors.teal,
                //   fontSize: 50,
                //   fontWeight: FontWeight.bold,
                // ),
              )),
          Expanded(
              child: Container(
            width: 400,
            height: 400,
            decoration: tealclrbox(),
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    sizedbox70(),
                    bgblacktext(text1: 'All out'),
                    bgblacktext(text1: 'All game'),
                    bgblacktext(text1: 'All Season'),
                    sizedbox70(),
                    InkWell(
                      onTap: () {
                        navigatorPush(ctx: context, screen: CreateTournament());
                      },
                      child: containerButtons(name: "Create Tournament"),
                    ),
                    sizedbox30(),
                    InkWell(
                      onTap: () {
                        navigatorPush(
                            ctx: context, screen: const TournmentList());
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
