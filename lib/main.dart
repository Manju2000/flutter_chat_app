import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatapp/screens/auth_screen.dart';
import 'package:flutter_chatapp/screens/chat_screen.dart';
import"package:firebase_core/firebase_core.dart";
import"package:firebase_auth/firebase_auth.dart";

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        buttonTheme: ButtonTheme.of(context).copyWith(
          buttonColor: Colors.deepPurple,
          textTheme: ButtonTextTheme.primary,
          shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)
          )
        )
      ),
      home: StreamBuilder(
        stream:FirebaseAuth.instance.authStateChanges(),
        builder:(cxt,usersnapshot){
          if(usersnapshot.hasData){
            return ChatScreen();
          }
          return AuthScreen();
        }
      )
    );
  }
}

