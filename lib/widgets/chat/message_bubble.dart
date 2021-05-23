import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import"package:flutter/material.dart";
import"dart:io";
class MessageBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  final String username;
  final String   userimageurl;
  final Key key;

  MessageBubble(this.message,this.isMe,this.username,this.userimageurl,{this.key});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children:[
        Row(
        mainAxisAlignment: isMe?MainAxisAlignment.end:MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
                bottomLeft: !isMe?Radius.circular(0):Radius.circular(16),
                bottomRight: isMe?Radius.circular(0):Radius.circular(16)

              ),
              color: isMe?Colors.deepPurple:Colors.pink

            ),
            width: 140,
            padding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical:10
            ),
            margin: EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 8
            ),
            child: Column(
              crossAxisAlignment: isMe?CrossAxisAlignment.end:CrossAxisAlignment.start,
              children: [
                Text(
                       username,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      ),

                ),
                Text(
                  message,
                  style: TextStyle(
                    color: Colors.white,

                  ),
                  textAlign: isMe?TextAlign.end:TextAlign.start,
                ),
              ],
            ),
          ),

        ],
      ),

        Positioned(
          top:0 ,
            left: isMe?200:118,
            child: CircleAvatar(
              backgroundImage: NetworkImage(userimageurl),
            )
        ),
      ],
      overflow: Overflow.visible,
    );
  }
}
