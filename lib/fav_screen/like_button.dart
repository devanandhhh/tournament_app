// import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Likebutton extends StatefulWidget {
  // final bool isLiked;
  // Function()? onTap;
  Likebutton({super.key, required this.doc1});
  var doc1;
  @override
  State<Likebutton> createState() => _LikebuttonState();
}

final user = FirebaseAuth.instance.currentUser!;

class _LikebuttonState extends State<Likebutton> {
  bool liked = false;
  void toggleButton() async {
    setState(() {
      liked = !liked;
    });
    if (liked == true) {
      print('The doc1 is ${widget.doc1}');
      print('user id is ${user.uid} ');
      //just try
// await FirebaseFirestore.instance.collection('favourite').add({
//   'user':user.uid,
//   'tournamentDoc':widget.doc1
// });
      // var docs=widget.doc1;
      //  String tournamentName = widget.doc1['TournamentName'];
      //             String date = widget.doc1['Date'];
      //             String image = widget.doc1['TournamentImage'];
      //             String place = widget.doc1['Place'];
      //             String categoryy = widget.doc1['Category'];
      //             String limits = widget.doc1['LimitOfTeam'];
                
      // try {
      //   String? userEmail =user.email;
      //   var getUser=getUserDocumentId(userEmail!);

      //  await addToFavorites(tournamentId:  );
      //   print('Added sucessfully');
      // } catch (e) {
      //   print('error is $e');
      // }
      //FirebaseFirestore.instance.collection('user').doc(user)
      // FirebaseFirestore.instance.collection('favourite').add({'userID':user.uid,'tournamentID':widget.doc1});

    }
    // else{
    //   print(widget.doc1);
    //   await FirebaseFirestore.instance.collection('favourite').where('user',isEqualTo: user.uid)
    // }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleButton,
      child: liked
          ? const Icon(
              Icons.favorite,
              size: 30,
              color: Colors.teal,
            )
          : const Icon(
              Icons.favorite_border_outlined,
              size: 30,
            ),
    );
  }

  // //----
  // String getCurrentUserId() {
  //   final user = FirebaseAuth.instance.currentUser!;
  //   return user.uid;
  // }

  //--
  // Future<String?>getCurrentUserDocumentId()async{
  //   String userId=getCurrentUserId();
  //   QuerySnapshot querySnapshot =await FirebaseFirestore.instance.collection('users').where('userId',isEqualTo: userId).get();
  //   if()
  // }
  //addToFavorites({required String tournamentId,var docu}) async {
    
    // // getCurrentUserId();
    // try{
  //  FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(docu)
  //       .collection('favorite')
  //      // .doc(tournamentId)
  //       .add({
  //     'tournamentId': tournamentId,
  //   });
  //   print('added');
  //   }
  // // catch(e){
  // //   print('error is $e');  }
  // }
  // Future<String?> getUserDocumentId(String userEmail) async {
  // QuerySnapshot querySnapshot = await FirebaseFirestore.instance
  //     .collection('tournament')
  //     .where('email', isEqualTo: userEmail)
  //     .limit(1) // Assuming there's only one document per user
  //     .get();

  // if (querySnapshot.docs.isNotEmpty) {
  //   return querySnapshot.docs.first.id;
  // } else {
  //   return null; // User not found in the tournament collection
  // }
}

