import 'package:flutter/material.dart';

import 'Login_Main_Page.dart';


void main() {
  runApp(const MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
    title: '',
  )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HELLO ',
      theme: ThemeData(
          primarySwatch: Colors.green
      ),
     // home: SecondPageState(),
      home:const LoginPage(),
    );
  }
}
