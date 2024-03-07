
import 'package:flutter/material.dart';

import '../other_widgets/misc_widgets.dart';
import '../other_widgets/text_widgets.dart';

Widget expandableBox(String text, IconData? icon, Color? color, Color textColor, bool isTitle){
  return flexBox(true, flex: 1, color: color, border: [0,0,0,0],
      widget: Container(
          height: 35,
          child: centerColumn(false,
              child: Row(
                children: [
                  if(icon != null)...{
                    Icon(icon, size: 20, color: textColor),
                    const SizedBox(width: 10),
                  },
                  Padding(
                    padding: const EdgeInsets.only(top: 3),
                    child: isTitle? title(true, title: text, textAlign: TextAlign.left, color: textColor) :
                    subtitle(true, title: text, textAlign: TextAlign.left, color: textColor),
                  )
                ],
              )
          )
      )
  );
}
