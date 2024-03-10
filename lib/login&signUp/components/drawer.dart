// import 'dart:html';

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tournament_creator/login&signUp/components/my_list_tile.dart';
import 'package:tournament_creator/screens/addNotes/widgets/refactoring.dart';
import 'package:tournament_creator/screens/create_tounament/reuse_widgets/reuse_widgets.dart';
import 'package:tournament_creator/screens/home/reuse_widgets/refactoring.dart';
import 'package:tournament_creator/screens/list_Tournament/widgets/reuse.dart';
// import 'package:tournament_creator/screens/list_Tournament/widgets/reuse.dart';

// ignore: must_be_immutable
class MyDrawer extends StatefulWidget {
  MyDrawer({super.key, this.ontap});
  Function? ontap;

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final user = FirebaseAuth.instance.currentUser;
  final firestore1 = FirebaseFirestore.instance;
  TextEditingController userNameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  // String? image
  String? selectedImage;
//first view method

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.teal,
      child: ListView(children: [
        //Drawer head
        const DrawerHeader(
            child: Icon(Icons.person, size: 70, color: Colors.white)),
        //list tile
        MyListTile(
            icon: Icons.home,
            text: 'H O M E ',
            onTap: () {
              navigatorPOP(context);
            }),
        MyListTile(
          icon: Icons.person,
          text: 'P R O F I L E',
          onTap: () async {
            if (user != null) {
              String email = user!.email ?? '';
              QuerySnapshot<Map<String, dynamic>> querySnapshot =
                  await firestore1
                      .collection('users')
                      .where('email', isEqualTo: email)
                      .get();

              if (querySnapshot.docs.isNotEmpty) {
                DocumentSnapshot<Map<String, dynamic>> snapshot =
                    querySnapshot.docs.first;
                String name = snapshot.get('userName');
                String? image = snapshot.get('profile');
                userNameController.text = name;
                emailController.text = email;
                String documentId = snapshot.id;
                selectedImage = image;
                // ignore: use_build_context_synchronously
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('User Profile'),
                    scrollable: true,
                    content: StatefulBuilder(
                      builder: (context, setState) => SingleChildScrollView(
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 70,
                              backgroundColor: Colors.teal,
                              backgroundImage: image != null
                                  ? FileImage(File(
                                      image!,
                                    ))
                                  : null,
                              // const AssetImage('assets/addimage2.png'),
                              child: InkWell(
                                  onTap: () async {
                                    String? pickimage =
                                        await pickImageFromGallery();

                                    setState(() {
                                      image = pickimage;
                                    });
                                  },
                                  child: image != null
                                      ? ClipOval(
                                          child: Image.file(
                                            File(image!),
                                            fit: BoxFit.cover,
                                            height: 150,
                                            width: 150,
                                          ),
                                        )
                                      : null),
                            ),
                            sizedbox30(),
                            TextFormField(
                              controller: userNameController,
                              decoration:
                                  InputDecoration(labelText: 'User name'),
                            ),
                            sizedbox10(),
                            TextFormField(
                              controller: emailController,
                              readOnly: true,
                              decoration:
                                  const InputDecoration(labelText: 'Email '),
                            )
                          ],
                        ),
                      ),
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            navigatorPOP(context);
                            selectedImage = image;
                          },
                          child: const Text('Cancel')),
                      TextButton(
                          onPressed: () async {
                            firestore1
                                .collection('users')
                                .doc(documentId)
                                .update({
                              'userName': userNameController.text,
                              'profile': image
                            });

                            messengerScaffold1(
                                text: 'Edited Successfully', ctx: context);
                            navigatorPOP(context);
                          },
                          child: const Text('Save'))
                    ],
                  ),
                );
              }
            }

            // navigatorPush(ctx: context, screen: ProfilePage());
          },
        ),
         MyListTile(
            icon: Icons.security ,
            text: 'A B O U T ',
            onTap: () {
              navigatorPOP(context);
            }),
        MyListTile(
            icon: Icons.privacy_tip ,
            text:  'P R I V A C Y   P O L I C Y',
            onTap: () {
              navigatorPOP(context);
            }),
       
        MyListTile(
          icon: Icons.logout,
          text: 'L O G O U T',
          onTap: () {
            navigatorPOP(context);
            signUserOut(context);
          },
        ),
        const SizedBox(
          height: 210,
        ),
        const Padding(
          padding: EdgeInsets.all(18.0),
          child: Divider(),
        ),
        Row(
          children: [
            const SizedBox(
              width: 30,
            ),
            Text(
              'Login With : ${user!.email!}',
              style: const TextStyle(color: Colors.white),
            )
          ],
        ),
        const Padding(
          padding: EdgeInsets.all(18.0),
          child: Divider(),
        )
      ]),
    );
  }

  signUserOut(ctx) {
    return showDialog(
      context: ctx,
      builder: (context) {
        return AlertDialog(
          title: const Text('Do You Want to LogOut'),
          actions: [
            TextButton(
                onPressed: () {
                  signout();
                  navigatorPOP(context);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: const Text('LogOut SucessFully'),
                    backgroundColor: Colors.green[400],
                  ));
                  //scaffoldmessenger(context);
                },
                child: const Text('Yes')),
            TextButton(
                onPressed: () {
                  navigatorPOP(context);
                },
                child: const Text('No'))
          ],
        );
      },
    );
    //
  }

  // userget()async{
  signout() {
    return FirebaseAuth.instance.signOut();
  }
}
