import 'package:flutter/material.dart';
import 'package:tournament_creator/screens/home/home_screen.dart';

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
      backgroundColor: Colors.yellow[100],
      body: Center(
          child: Container(height: 100, width: 100,decoration: BoxDecoration(color: Colors.teal[400],borderRadius: BorderRadius.circular(5)),)),
    );
  }
  gotoHomescreen()async{
    await Future.delayed(const Duration(seconds: 3));
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>const HomeScreen()));
  }

}
