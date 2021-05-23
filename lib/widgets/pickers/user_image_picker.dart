import"package:flutter/material.dart";
import 'package:image_picker/image_picker.dart';
import "dart:io";

class  UserImagePicker extends StatefulWidget {
  final Function(File pickedimage) imagepickedfn;
  UserImagePicker(this.imagepickedfn);
  @override
  _State createState() => _State();
}

class _State extends State<UserImagePicker> {
  File _image;
  void _pickImage() async{
    final picker=ImagePicker();
    final pickedfile= await picker.getImage(
        source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150
    );
    setState(() {
      _image=File(pickedfile.path);
    });

    widget.imagepickedfn(_image);
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 35,
          backgroundImage:_image!=null? FileImage(_image):null ,
        ),
        FlatButton.icon(
            onPressed:_pickImage,
            icon: Icon(Icons.image,color: Colors.deepPurple,),
            label: Text("Add Image",style: TextStyle(color: Colors.deepPurple),)),
      ],
    );
  }
}
