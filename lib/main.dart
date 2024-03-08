import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:tournament_creator/firebase_options.dart';
import 'package:tournament_creator/hive_model/notes.dart';
import 'package:tournament_creator/screens/splash_Screen/splash_screen.dart';

const hivekey = "notesbox";

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Hive.initFlutter();
  Hive.registerAdapter(NotesAdapter());
  await Hive.openBox(hivekey); 

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      //darkTheme: ThemeData.dark(),
      //theme: ThemeData(primaryColor: Colors.teal,primarySwatch: Colors.amber),
      title: 'Tournify',

      home:
       SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
