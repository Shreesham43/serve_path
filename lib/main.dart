import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:serve_path/home.dart';
import 'package:serve_path/home.dart';
import 'package:serve_path/info.dart';
import 'package:serve_path/login_form.dart';
import 'constant.dart';
import 'SplashScreen.dart';
import 'package:serve_path/Display.dart';

Future<void>  main() async{
WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(

    MaterialApp(

      debugShowCheckedModeBanner: false,
      title:'ServePath',
      home: SplashScreen(),
      theme: ThemeData(
        primaryColor: Color.fromRGBO(16, 5, 61, 1.0),
        accentColor: Color.fromRGBO(16, 5, 61, 1.0),
      ),
      routes: <String,WidgetBuilder>{
        SPLASH_SCREEN:(BuildContext context)=>SplashScreen(),
        HOME_SCREEN:(BuildContext context)=>Home(uid:"Guest"),
        "login" :(context)=>const MyApp(),
         "home":(context)=>Home(uid: '',)
      },
    )
  );

}