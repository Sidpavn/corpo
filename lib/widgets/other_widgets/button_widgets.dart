

import 'package:corpo/widgets/other_widgets/misc_widgets.dart';
import 'package:corpo/widgets/other_widgets/text_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localstorage/localstorage.dart';

import '../../common/statics.dart';
import '../../models/themes/theme.dart';

enum typeOfQuantityFunction { ammo, item, craft }
LocalStorage storage = LocalStorage('corpo');


Widget actionButton(String text, Color? color, Color textColor){
  return Container(
    color: color ?? Colors.transparent,
    width: double.infinity, height: 60,
    child: Center(
        child: title(true,
            title: text,
            textAlign: TextAlign.center, color: textColor
        )
    ),
  );
}

Widget moveToButton(BuildContext context, String text){
  return Row(
    children: [
      flexBox(true, flex: 1, color: ColorTheme.white, border: [0,0,0,0],
          widget: Container(
              height: 60,
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
              child: centerColumn(true,
                child: title(true, title: text.titleCase(), textAlign: TextAlign.left, color: ColorTheme.black),
              )
          )
      )
    ],
  );
}

Widget tab(BuildContext context, String text, Color color){
  return Container(
    height: 80,
    padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
    child: centerColumn(true,
      child: title(true, title: text.titleCase(), textAlign: TextAlign.left, color: ColorTheme.black),
    )
  );
}

Widget goBackButton(BuildContext context, String text){
  return Row(
    children: [
      flexBox(true, flex: 1, color: ColorTheme.darkRed, border: [0,0,0,0],
          widget: Container(
              height: 50,
              child: centerColumn(false,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.arrow_back, size: 16, color: ColorTheme.white),
                          const SizedBox(width: 10),
                          subtitle(false, title: "Go back", textAlign: TextAlign.left, color: ColorTheme.white),
                        ],
                      ),
                      headline3(true, title: text.titleCase(), textAlign: TextAlign.left, color: ColorTheme.white),
                    ],
                  )
              )
          )
      )
    ],
  );
}

Widget tabButton(String title, int index, int tabIndex){
  bool isCurrent = (tabIndex == index);
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      border: Border(
        right: BorderSide(color: ColorTheme.black,width: 1.5,),
      ),
    ),
    child: buttonWidget(
        padding: const EdgeInsets.all(10),
        color: isCurrent ? ColorTheme.black : ColorTheme.white,
        child: Center(
          child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(children: [
                TextSpan(
                    text: title.titleCase(),
                    style: GoogleFonts.epilogue(
                        fontSize: FontSize.title,
                        fontWeight: FontWeight.w700,
                        color: isCurrent ? ColorTheme.white : ColorTheme.black,
                        height: 1.1
                    )
                ),
              ]
              )
          ),
        )
    ),
  );
}

Widget buttonWidget({required EdgeInsetsGeometry padding, required Color color, required Widget child}){
  return AnimatedContainer(
    width: double.infinity,
    padding: padding,
    decoration: BoxDecoration(
      color: color,
    ),
    duration: const Duration(milliseconds: 100),
    child: child
  );
}

Widget outlinedButton({required EdgeInsetsGeometry padding, required Color? color, required Color outlineColor, required Widget child}){
  return AnimatedContainer(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: color ?? Colors.transparent,
        border: Border.all(
            color: outlineColor,
            width: 1.5
        )
      ),
      duration: const Duration(milliseconds: 100),
      child: child
  );
}