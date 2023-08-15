import 'package:college_page/screens/auth/login_screen.dart';
import 'package:college_page/screens/auth/services/functions/authFunctions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class logOutService {
  static userLogOut(BuildContext context) async {
    
    String userId = FirebaseAuth.instance.currentUser!.uid;
    try {
      await FirebaseAuth.instance
          .signOut()
          .then((value) => updateUserStatus(userId, {
                'status': false,
              }))
          .then((value) => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              ));
    } catch (e) {
      print("Error signing out: ${e.toString()}");
    }
  }
}
