import 'dart:io';

import"package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:flutter_chatapp/widgets/auth/auth_form.dart';
import"package:firebase_auth/firebase_auth.dart";
import"package:cloud_firestore/cloud_firestore.dart";
import"package:firebase_core/firebase_core.dart";
import"package:firebase_storage/firebase_storage.dart";

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth=FirebaseAuth.instance;
  bool _isloading=false;

  void _submitAuthForm(
      String email,String username,File userImage,String password,bool islogin,BuildContext cxt) async{

     UserCredential authresult;
     try{
    if(islogin){
      setState(() {
        _isloading= true;
      });
     authresult= await _auth.signInWithEmailAndPassword(email: email, password: password);
    }


    else{
      authresult=await _auth.createUserWithEmailAndPassword(email: email, password: password);
      final ref=FirebaseStorage.instance.ref().child("userImage").child(authresult.user.uid+".jpg");
      await ref.putFile(userImage).onComplete;
      final url=await ref.getDownloadURL();
      await  FirebaseFirestore.instance.collection("users").doc(authresult.user.uid).set({
        "username":username,
        "email":email,
        "Image_Url":url,
      });
    }
     } on FirebaseAuthException catch(err){
       var message='An error occured,Please check your credentials';
       if(err.message!=null){
         message=err.message;
       }
       Scaffold.of(cxt).showSnackBar(SnackBar(content: Text(message),backgroundColor: Theme.of(cxt).errorColor,));
       setState(() {
         _isloading=false;
       });

    } catch(error){
       print(error);
       setState(() {
         _isloading=false;
       });


     }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body:AuthForm(_submitAuthForm,_isloading),
    );
  }
}

