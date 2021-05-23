import 'package:firebase_auth/firebase_auth.dart';
import"package:flutter/material.dart";
import"package:cloud_firestore/cloud_firestore.dart";
import 'package:flutter_chatapp/widgets/chat/message_bubble.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<dynamic> _getcurrentuser() async{
      final currentuser=await FirebaseAuth.instance.currentUser;
      return currentuser;
    }
    return FutureBuilder(
      future: _getcurrentuser(),
      builder:(cxt,AsyncSnapshot<dynamic> futuresnapshot) {
        if(futuresnapshot.connectionState==ConnectionState.waiting){
          return Center(child:CircularProgressIndicator());
        }
        return StreamBuilder(
      stream:FirebaseFirestore.instance.collection("chat").orderBy("createdat",descending: true).snapshots(),
      builder: (cxt,AsyncSnapshot<QuerySnapshot> chatsnapshot){
        if(chatsnapshot.connectionState==ConnectionState.waiting){
          return Center(child:CircularProgressIndicator());
        }
        var chatDocs=chatsnapshot.data.docs;
        return ListView.builder(
            reverse: true,
            itemCount: chatDocs.length ,
              itemBuilder: (cxt,index) =>MessageBubble(chatDocs[index]["text"],
                  chatDocs[index]["userId"]==futuresnapshot.data.uid,
                chatDocs[index]["username"],
                chatDocs[index]["Image_Url"],
                key: ValueKey(chatDocs[index].id),
              ),
          );
            },
        );
      },

    );
  }
}
