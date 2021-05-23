import"package:flutter/material.dart";
import 'package:flutter_chatapp/widgets/pickers/user_image_picker.dart';
import"package:image_picker/image_picker.dart";
import"dart:io";

class AuthForm extends StatefulWidget {
  final  void Function(
      String email,String username,File userImageFile,String password,bool islogin,BuildContext cxt) submitfn;
  final bool isloading;
  AuthForm(this.submitfn,this.isloading);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey=GlobalKey<FormState>();

  bool _islogin=true;
  var _userEmail="";
  var  _userName="";
  var  _userpassword="";
  File _userImageFile;

  void _pickedImage(File image){
    _userImageFile=image;
  }

  void _trysubmit(){
    final isvalid=_formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if(_userImageFile==null&& !_islogin){
      Scaffold.of(context).showSnackBar(SnackBar(content: Text("Please pick an Image"),));
      return;
    }
    if(isvalid){
      _formKey.currentState.save();
     widget.submitfn(
       _userEmail.trim(),
       _userName.trim(),
       _userImageFile,
       _userpassword.trim(),
       _islogin,
       context
     );
    }
  }
  @override
  Widget build(BuildContext context) {

    return Center(
      child: Card(
        margin: EdgeInsets.all(15),
        elevation: 3,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if(!_islogin)
                     UserImagePicker(_pickedImage ),
                  TextFormField(
                    key: ValueKey("email"),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Email address",
                    ),
                    validator: (value){
                      if(value.isEmpty || !value.contains("@")) {
                        return "Please return a valid Email address.";
                      }
                      return null;

                    },
                    onSaved: (value){
                      _userEmail=value;
                    },

                  ),
                  if(!_islogin)
                    TextFormField(
                      key: ValueKey("username"),
                    decoration: InputDecoration(
                      labelText: "User Name"
                    ),
                    validator:(value){
                      if(value.isEmpty || value.length <4){
                        return "Please enter a valid Username";
                      }
                      return null;
                    },
                    onSaved: (value){
                      _userName=value;
                    },
                  ),
                  TextFormField(
                    key:ValueKey("passowod"),
                    decoration: InputDecoration(
                      labelText: "Password",
                    ),
                    obscureText: true,
                    validator: (value){
                      if(value.isEmpty || value.length<7){
                        return "Weak password";
                        }
                      return null;
                      },
                    onSaved: (value){
                      _userpassword=value;
                    },
                  ),
                  SizedBox(height: 10,),
                  if(widget.isloading)
                    CircularProgressIndicator(),
                  if(!widget.isloading)
                     RaisedButton(
                    child: Text(_islogin?"Login":"SignUp"),
                    onPressed:_trysubmit,
                  ),
                  if(!widget.isloading)
                    FlatButton(
                    child: Text(_islogin?"Create a new account":"I already have an account",style: TextStyle(
                      color: Colors.deepPurple,
                    ),),
                    onPressed: (){
                      setState(() {
                        _islogin=!_islogin;
                      });
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
