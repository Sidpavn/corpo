import 'package:corpo/screens/authentication/login.dart';
import 'package:corpo/screens/homepage/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../screens/game/game_screen.dart';

class SplashServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void checkAuthentication(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 2000));

    // Firebase user exists
    if (_auth.currentUser != null) {
      if (_auth.currentUser!.emailVerified == true) {
        // Navigate to homepage :: Authenticated
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => Homepage(),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
      } else {
        // Navigate to login page :: Authenticated, Not verified
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => LoginPage(isReload: true),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
      }
    }
    else{
      // Navigate to login page :: Not Authenticated, Verified
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => LoginPage(isReload: false),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    }
  }
}