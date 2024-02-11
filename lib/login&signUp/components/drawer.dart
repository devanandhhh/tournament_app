import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tournament_creator/login&signUp/components/my_list_tile.dart';
import 'package:tournament_creator/screens/addNotes/widgets/refactoring.dart';

// ignore: must_be_immutable
class MyDrawer extends StatelessWidget {
  MyDrawer({super.key, this.ontap});
  Function? ontap;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[900],
      child: ListView(children: [
        //Drawer head
        const DrawerHeader(
            child: Icon(
          Icons.person,
          size: 70,
          color: Colors.white,
        )),
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
          onTap: () {},
        ),
        MyListTile(
          icon: Icons.logout,
          text: 'L O G O U T',
          onTap: () {
            navigatorPOP(context);
            signUserOut(context);
          },
        ),
      ]),
    );
  }

  signUserOut(ctx) {
    return showDialog(
      context: ctx,
      builder: (context) {
        return AlertDialog(
          title: Text('Do You Want to LogOut'),
          actions: [
            TextButton(
                onPressed: () {
                  navigatorPOP(context);
                },
                child: Text('No')),
            TextButton(
                onPressed: () {
                  signout();
                  navigatorPOP(context);
                  scaffoldmessenger(context);
                },
                child: Text('Yes'))
          ],
        );
      },
    );
    //
  }

  signout() {
    return FirebaseAuth.instance.signOut();
  }
}
