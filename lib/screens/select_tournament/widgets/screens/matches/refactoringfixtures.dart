

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tournament_creator/screens/create_tounament/reuse_widgets/reuse_widgets.dart';
import 'package:tournament_creator/screens/home/reuse_widgets/refactoring.dart';
import 'package:tournament_creator/screens/select_tournament/widgets/reusable.dart';
import 'package:tournament_creator/screens/select_tournament/widgets/screens/matches/add_score.dart';

fixtures(
    {required String? team1,
    required String? team2,
    required image1,
    required image2,
    required doc1,
    required scoreA,
    required scoreB,
    required fixtureName,
    
    ctx}) {
     
  return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 5),
      // EdgeInsets.symmetric(horizontal: 30),
      child: InkWell(
          onTap: () { 
           
            navigatorPush(
                ctx: ctx,
                screen: AddScore(
                  team1: team1,
                  team2: team2,
                  image1: image1,
                  image2: image2,
                  doc1: doc1,
                  scoreA: scoreA,
                  scoreB: scoreB,
                  fixtureName: fixtureName,
                 
                ));
          },
          child: Container(
              height: 130,
              width: 500,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.amber[100]),
              child: Column(children: [
                const SizedBox(
                  height: 3,
                ),
                Text(scoreA == '' && scoreB == '' ? 'Pending...' : 'Finished',
                    style: GoogleFonts.oswald(color: Colors.teal)
                    //TextStyle(color: Colors.teal, fontWeight: FontWeight.w500),
                    ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              color: Colors.teal,
                              borderRadius: BorderRadius.circular(10)),
                          height: 80,
                          width: 80,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child:
                              //edited 
                              Image.network(image1,
                               //error builder
                          errorBuilder: ((context, error, stackTrace) =>
                              Center(child: const Text('😢'))),
                          //loading builder
                          loadingBuilder: (context, child, loadingProgress) {
                            final totalBytes =
                                loadingProgress?.expectedTotalBytes;
                            final bytesLoaded =
                                loadingProgress?.cumulativeBytesLoaded;
                            if (totalBytes != null && bytesLoaded != null) {
                              return Center(
                                child: CircularProgressIndicator(
                                  backgroundColor: Colors.white70,
                                  value: bytesLoaded / totalBytes,
                                  color: Colors.teal[900],
                                  strokeWidth: 5.0,
                                ),
                              );
                            } else {
                              return child;
                            }},
                              fit: BoxFit.cover,)
                              //  Image.file(
                              //   File(image1),
                              //   fit: BoxFit.cover,
                              // )
                              )),
                      SizedBox(
                          height: 40,
                          width: 5,
                          //color: Colors.red,
                          child: Center(
                              child: Text(
                            scoreA ?? ' ',
                            style: tealcolor(),
                          ))),
                      Text(
                        ' VS',
                        style: font17(),
                      ),
                      SizedBox(
                          height: 40,
                          width: 5,
                          //color: Colors.red,
                          child: Center(
                              child: Text(
                            scoreB ?? ' ',
                            style: tealcolor(),
                          ))),
                      Container(
                          decoration: BoxDecoration(
                              color: Colors.teal,
                              borderRadius: BorderRadius.circular(10)),
                          height: 80,
                          width: 80,
                          //for image
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child:
                              Image.network(image2,
                               //error builder
                          errorBuilder: ((context, error, stackTrace) =>
                              Center(child: const Text('😢'))),
                          //loading builder
                          loadingBuilder: (context, child, loadingProgress) {
                            final totalBytes =
                                loadingProgress?.expectedTotalBytes;
                            final bytesLoaded =
                                loadingProgress?.cumulativeBytesLoaded;
                            if (totalBytes != null && bytesLoaded != null) {
                              return Center(
                                child: CircularProgressIndicator(
                                  backgroundColor: Colors.white70,
                                  value: bytesLoaded / totalBytes,
                                  color: Colors.teal[900],
                                  strokeWidth: 5.0,
                                ),
                              );
                            } else {
                              return child;
                            }},
                              fit: BoxFit.cover,)
                              // Image.file(
                              //   File(image2),
                              //   fit: BoxFit.cover,
                              // )
                              ))
                    ]),
                sizedbox10(),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(team1!,
                          style: const TextStyle(
                            fontSize: 15,
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(team2!,
                          style: const TextStyle(
                            fontSize: 15,
                          ))
                    ])
              ]))));
}

fixtureForUser(
    {required String? team1,
    required String? team2,
    required image1,
    required image2,
    required scoreA,
    required scoreB}) {
  return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 5),
      // EdgeInsets.symmetric(horizontal: 30),
      child: Container(
          height: 130,
          width: 500,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.amber[100]),
          child: Column(children: [
            const SizedBox(
              height: 3,
            ),
            Text(scoreA == '' && scoreB == '' ? 'Pending...' : 'Finished',
                style: GoogleFonts.oswald(color: Colors.teal)
                //TextStyle(color: Colors.teal, fontWeight: FontWeight.w500),
                ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Container(
                  decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(10)),
                  height: 80,
                  width: 80,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: 
                      Image.network(image1,
                        //-----------------------------
                          //error builder
                          errorBuilder: ((context, error, stackTrace) =>
                              Center(child: const Text('😢',),)),
                          //loading builder
                          loadingBuilder: (context, child, loadingProgress) {
                            final totalBytes =
                                loadingProgress?.expectedTotalBytes;
                            final bytesLoaded =
                                loadingProgress?.cumulativeBytesLoaded;
                            if (totalBytes != null && bytesLoaded != null) {
                              return Center(
                                child: CircularProgressIndicator(
                                  backgroundColor: Colors.white70,
                                  value: bytesLoaded / totalBytes,
                                  color: Colors.teal[900],
                                  strokeWidth: 5.0,
                                ),
                              );
                            } else {
                              return child;
                            }},
                            //----------------------------
                      fit: BoxFit.cover,)
                      // Image.file(
                      //   File(image1),
                      //   fit: BoxFit.cover,
                      // ),
                      )),
              SizedBox(
                  height: 40,
                  width: 5,
                  //color: Colors.red,
                  child: Center(
                      child: Text(
                    scoreA ?? '',
                    style: tealcolor(),
                  ))),
              Text(
                ' VS',
                style: font17(),
              ),
              Center(
                  child: Text(
                scoreB ?? '',
                style: tealcolor(),
              )),
              Container(
                  decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(10)),
                  height: 80,
                  width: 80,
                  //for image
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child:Image.network(image2,
                        //-----------------------------
                          //error builder
                          errorBuilder: ((context, error, stackTrace) =>
                              Center(child: const Text('😢'))),
                          //loading builder
                          loadingBuilder: (context, child, loadingProgress) {
                            final totalBytes =
                                loadingProgress?.expectedTotalBytes;
                            final bytesLoaded =
                                loadingProgress?.cumulativeBytesLoaded;
                            if (totalBytes != null && bytesLoaded != null) {
                              return Center(
                                child: CircularProgressIndicator(
                                  backgroundColor: Colors.white70,
                                  value: bytesLoaded / totalBytes,
                                  color: Colors.teal[900],
                                  strokeWidth: 5.0,
                                ),
                              );
                            } else {
                              return child;
                            }},
                            //----------------------------
                      fit: BoxFit.cover,)
                      //  Image.file(
                      //   File(image2),
                      //   fit: BoxFit.cover,
                      // )
                      ))
            ]),
            sizedbox10(),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Text(
                team1!,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(team2!,
                  style: const TextStyle(
                    fontSize: 15,
                  ))
            ])
          ])));
}
