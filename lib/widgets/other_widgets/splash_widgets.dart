
import 'package:corpo/widgets/other_widgets/text_widgets.dart';
import 'package:flutter/material.dart';

import '../../models/themes/theme.dart';
import 'misc_widgets.dart';

Widget locationPin({
  required double? top, required double? left,
  required IconData icon, required Color color, required double lineHeight, required int threshold,
  required String text, required bool isTextLeft, required int duration, required int uniqueNumbers
}){
  return Positioned(
      top: top, left: left, bottom: null, right: null,
      child: centerColumn(true,
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(isTextLeft)...{
                  pinText(lineHeight: lineHeight, threshold: threshold, text: text, isTextLeft: isTextLeft, duration: duration, color: color,
                      uniqueNumbers: uniqueNumbers)
                },
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AnimatedContainer(
                        duration: Duration(milliseconds: duration),
                        padding: EdgeInsets.only(top: uniqueNumbers > threshold ? 0 : lineHeight),
                        child: Icon(icon, size: 20, color: color.withOpacity(0.85))
                    ),
                    AnimatedContainer(
                      width: 1,
                      height: uniqueNumbers > threshold ? lineHeight : 0,
                      color: color.withOpacity(0.7),
                      duration: Duration(milliseconds: duration),
                    ),
                  ],
                ),
                if(!isTextLeft)...{
                  pinText(lineHeight: lineHeight, threshold: threshold, text: text, isTextLeft: isTextLeft, duration: duration, color: color,
                      uniqueNumbers: uniqueNumbers)
                }
              ]
          )
      )
  );
}

pinText({required double lineHeight, required int threshold, required String text, required bool isTextLeft, required Color color,
  required int duration, required int uniqueNumbers}){
  return AnimatedContainer(
    duration: Duration(milliseconds: duration),
    padding: EdgeInsets.only(
        left: isTextLeft ? 0 : 5,
        right: isTextLeft ? 5 : 0,
        top: uniqueNumbers > threshold ? 3 : lineHeight
    ),
    child: mini(false, title: text.toString(), textAlign: isTextLeft ? TextAlign.right : TextAlign.left, color: color.withOpacity(0.85)),
  );
}
