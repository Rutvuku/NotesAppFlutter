import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasetutorials/UI/auth/login_screen.dart';
import 'package:firebasetutorials/UI/posts/post_screen.dart';
import 'package:firebasetutorials/UI/upload_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashSevices{
   void islogin(BuildContext context){
        final _auth = FirebaseAuth.instance;
        final user = _auth.currentUser;
        if(user != null){
          Timer(const Duration(seconds: 3) , ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> PostScreen())));
        }
        else{
          Timer(const Duration(seconds: 3) , ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen())));
        }

    }
}