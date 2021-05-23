import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import"package:flutter/material.dart";

class NewMessage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<NewMessage> {
  final _controller= new TextEditingController();
  var _enteredmessage="";
  void _sendmessage() async{
    FocusScope.of(context).unfocus();
    final user=await FirebaseAuth.instance.currentUser;
    final userdata=await FirebaseFirestore.instance.collection("users").doc(user.uid).get();
    FirebaseFirestore.instance.collection("chat").add({
      "text":_enteredmessage,
      "createdat":Timestamp.now(),
      "userId":user.uid,
      "username":userdata["username"],
      "Image_Url":userdata["Image_Url"],
    });
    _controller.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(8),
      child:Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              autocorrect: true,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(labelText: "Type a message", ),
              onChanged: (value){
                setState(() {
                  _enteredmessage=value;
                });
              },

            ),
          ),
          IconButton(
            icon: Icon
              (Icons.send),
            color: Colors.deepPurple,
            onPressed: _enteredmessage.trim().isEmpty?null:_sendmessage,
          )
        ],
      )
    );
  }
}

