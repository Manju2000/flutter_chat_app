import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import"package:flutter/material.dart";
import"package:cloud_firestore/cloud_firestore.dart";
import"package:firebase_core/firebase_core.dart";
import 'package:flutter_chatapp/widgets/chat/messages.dart';
import 'package:flutter_chatapp/widgets/chat/new_message.dart';
import"package:firebase_cloud_messaging/firebase_cloud_messaging.dart";

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
    final fcm=FirebaseMessaging();
    fcm.requestNotificationPermissions();
    fcm.configure(
      onMessage: (msg){
        print(msg);
        return;
      },
      onResume: (msg){
        print(msg);
        return;
      },
      onLaunch: (msg){
        print(msg);
        return;
      }
    );
    fcm.subscribeToTopic("chat");

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat App"),
        actions: [
          DropdownButton(
            underline: Container(),
            icon: Icon(Icons.more_vert,color:Colors.white),
            items: [
              DropdownMenuItem(
                child: Container(
                  child: Row(
                    children:[
                      Icon(Icons.exit_to_app),
                      SizedBox(width: 10,),
                      Text("Logout")
                    ],
                  ),
                ),
                value: "logout",

              )
            ],
            onChanged: (itemidentifier){
              if(itemidentifier=="logout"){
                FirebaseAuth.instance.signOut();
              }
            },

          )
        ],
      ),
      body:Container(
        child: Column(
          children: [
            Expanded(child:Messages()),
            NewMessage(),

          ],
        ),
      ),
    );
  }
}
