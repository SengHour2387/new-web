import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:game_talk/home.dart';

void main()  async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(apiKey: "AIzaSyBWq4DqXpOSgsFxL8T71vMbauQ-Nvf_LMk", appId: "1:936769146805:web:eb95960e852d73d91253fc", messagingSenderId: "936769146805", projectId: "communityweb-9e1fd")
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Game talk',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: Home(),
    );
  }
}
