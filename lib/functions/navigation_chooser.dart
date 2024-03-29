
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../screens/game/game_screen.dart';
import '../screens/homepage/homepage.dart';

navigationChooser(String name, BuildContext context){
  switch(name){

    case "go back": {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => Homepage(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
      break;
    }
    default: break;
  }
}
