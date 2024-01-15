import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tournament_creator/firebase_options.dart';
import 'package:tournament_creator/screens/splash_Screen/splash_screen.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(theme: ThemeData(primaryColor: Colors.teal,primarySwatch: Colors.amber),
      title: 'tournament app',
      home:const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
