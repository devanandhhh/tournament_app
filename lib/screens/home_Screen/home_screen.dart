import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tournament_creator/auth/components/drawer.dart';
import 'package:tournament_creator/screens/addNotes/home_notes.dart';
import 'package:tournament_creator/screens/create_tounament/create_tournament.dart';
import 'package:tournament_creator/screens/create_tounament/reuse_widgets/reuse_widgets.dart';
import 'package:tournament_creator/screens/home_Screen/reuse_widgets/refactoring.dart';
import 'package:tournament_creator/screens/list_Tournament/list_tournify.dart';
import 'package:tournament_creator/screens/search_Screen/sample_screen.dart';
// import 'package:tournament_creator/screens/search_Screen/search_screen.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key,this.uniqueId});

  final user = FirebaseAuth.instance.currentUser!;
String ?uniqueId;
   signUserOut() {
    FirebaseAuth.instance.signOut();
  }

// @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( backgroundColor:Colors.yellow[100], 
        title: headingtext(text: 'Tournament Creator '),   
        actions: 
         [
   
          const SizedBox(
            width: 10,
          ),
          IconButton(onPressed: (){
            navigatorPush(ctx: context, screen:const AddNotes());
          }, icon:const Icon(Icons.edit_square,size: 30,)),
            const SizedBox(
            width: 15,
          ),
        ],
      ),
      drawer: MyDrawer(),
      backgroundColor: Colors.yellow[100],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.all(30.0),
              child: InkWell(
                onTap: () {
                 // navigatorPush(ctx: context, screen: const SearchScreen());
                 navigatorPush(ctx: context, screen: const SampleScreen());
                },
                child: searchbarContainer(searchIteam: "Search "),
              )),
          Padding(
              padding: const EdgeInsets.all(34.0),
              child: Text(' Hello!',
                  style: GoogleFonts.oswald(fontSize: 50, color: Colors.teal)
          
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
                          navigatorPush(ctx: context, screen:const CreateTournament());
                      },
                      child: containerButtons(name: "Create Tournament"),
                    ),
                    sizedbox30(),
                    InkWell(
                      onTap: () {
                        navigatorPush(
                            ctx: context, screen:  TournmentList(uniqueId: uniqueId,));
                      },
                      child: containerButtons(name: 'My Tournaments '),
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