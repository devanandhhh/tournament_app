import 'package:flutter/material.dart';
import 'package:tournament_creator/login&signUp/auth_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    gotoHomescreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/appSplashSreen.png'), 
              fit: BoxFit.cover)), )
      // child:const Center(
      //     child: Text(
      //   'Tournament Creator',
      //   style: TextStyle(
      //     color: Colors.white,
      //     fontSize: 20,
      //   ),
      // )),
      //child: Text('Tournament Creator',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
   
        //  backgroundColor: Colors.yellow[100],
        //   body: Center(
        //       child: Container(height: 100, width: 100,decoration: BoxDecoration(color: Colors.teal[400],borderRadius: BorderRadius.circular(5)),)),
        );
  }

  gotoHomescreen() async {
    await Future.delayed(const Duration(seconds: 3));
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) =>  AuthPage()));
  }
}
