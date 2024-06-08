
import 'dart:math';

import 'package:corpo/widgets/other_widgets/misc_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../common/enums/enums.dart';
import '../../common/statics.dart';
import '../../../models/themes/theme.dart';


List<String> convertStringToList(String inputString) {
  return inputString.split(''); // Splitting based on space character
}

String generateString(String endLetter) {
  final random = Random();
  return generateCharacters()[random.nextInt(generateCharacters().length)];
}

List<String> generateCharacters() {
  List<String> letters = List.generate(26, (index) => String.fromCharCode('A'.codeUnitAt(0) + index));
  List<String> symbols = ['!', '@', '#', '\$', '%', '^', '&', '*', '(', ')', '-', '+', '=', '[', ']', '{', '}', '|', '\\', ';', ':', ',', '.', '/', '<', '>'];

  List<String> allCharacters = [...letters, ...symbols];
  return allCharacters;
}

String formatInt(int number){
  if (number >= 1000000000000) {
    return '${formatFloatNumber((number / 1000000000000))}T';
  } else if (number >= 1000000000) {
    return '${formatFloatNumber((number / 1000000000))}B';
  } else if (number >= 1000000) {
    return '${formatFloatNumber((number / 1000000))}M';
  } else if (number >= 1000) {
    return '${formatFloatNumber((number / 1000))}K';
  } else {
    return number.toString();
  }
}

String formatFloatNumber(double number) {
  String formattedNumber = number.toStringAsFixed(3); // Always format to 3 decimal places
  if (formattedNumber.contains('.')) {
    // Remove trailing zeros after the decimal point
    formattedNumber = formattedNumber.replaceAll(RegExp(r'0*$'), '');
    // Remove the decimal point if it's the last character
    if (formattedNumber.endsWith('.')) {
      formattedNumber = formattedNumber.substring(0, formattedNumber.length - 1);
    }
  }
  return formattedNumber;
}

Widget bulletPoint({required Color color, required String title, required String subtitle}){
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(0,5,10,0),
        child: CircleAvatar(
          backgroundColor: color,
          radius: 3,
        ),
      ),
      Flexible(
        flex: 1,
        child: RichText(
            textAlign: TextAlign.left,
            text: TextSpan(children: [
              TextSpan(
                text: title,
                style: GoogleFonts.epilogue(
                  fontSize: FontSize.subtitle,
                  fontWeight: FontWeight.w700,
                  color: color,
                  height: 1.1
                ),
              ),
              TextSpan(
                  text: subtitle,
                  style: GoogleFonts.epilogue(
                      fontSize: FontSize.subtitle,
                      fontWeight: FontWeight.w500,
                      color: color,
                      height: 1.1
                  )
              ),
            ])
        ),
      ),

    ],
  );
}

Widget info(bool isBold, {required String title, required TextAlign textAlign, required Color color}){
  return RichText(
      textAlign: textAlign,
      text: TextSpan(children: [
        TextSpan(
            text: title.titleCase(),
            style: GoogleFonts.epilogue(
              fontSize: FontSize.info,
              fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
              color: color,
              height: 1.1
            )
        ),
      ])
  );
}

Widget mini(bool isBold, {required String title, required TextAlign textAlign, required Color color}){
  return RichText(
      textAlign: textAlign,
      text: TextSpan(children: [
        TextSpan(
            text: title.titleCase(),
            style: GoogleFonts.spaceMono(
              fontSize: FontSize.mini,
              fontWeight: isBold ? FontWeight.w700 : FontWeight.w600,
              color: color,
              height: 1.1
            )
        ),
      ])
  );
}

Widget subtitle(bool isBold, {required String title, required TextAlign textAlign, required Color color}){
  return RichText(
      textAlign: textAlign,
      text: TextSpan(children: [
        TextSpan(
            text: title.titleCase(),
            style: GoogleFonts.epilogue(
              fontSize: FontSize.subtitle,
              fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
              color: color,
              height: 1.1
            )
        ),
      ])
  );
}

Widget title(bool isBold, {required String title, required TextAlign textAlign, required Color color}){
  return RichText(
      textAlign: textAlign,
      text: TextSpan(children: [
        TextSpan(
            text: title.titleCase(),
            style: GoogleFonts.epilogue(
              fontSize: FontSize.title,
              fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
              color: color,
              height: 1.1
            )
        ),
      ])
  );
}

Widget headline3(bool isBold, {required String title, required TextAlign textAlign, required Color color}){
  return RichText(
      textAlign: textAlign,
      text: TextSpan(children: [
        TextSpan(
            text: title.titleCase(),
            style: GoogleFonts.epilogue(
              fontSize: FontSize.headline3,
              fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
              color: color,
              height: 1.1
            )
        ),
      ])
  );
}

Widget headline2(bool isBold, {required String title, required TextAlign textAlign, required Color color}){
  return RichText(
      textAlign: textAlign,
      text: TextSpan(children: [
        TextSpan(
            text: title.titleCase(),
            style: GoogleFonts.epilogue(
              fontSize: FontSize.headline2,
              fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
              color: color,
              height: 1.1
            )
        ),
      ])
  );
}

Widget headline1(bool isBold, {required String title, required TextAlign textAlign, required Color color}){
  return RichText(
      textAlign: textAlign,
      text: TextSpan(children: [
        TextSpan(
            text: title.titleCase(),
            style: GoogleFonts.epilogue(
              fontSize: FontSize.headline1,
              fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
              color: color,
              height: 1.1
            )
        ),
      ])
  );
}

Widget headline0(bool isBold, {required String title, required TextAlign textAlign, required Color color}){
  return RichText(
      textAlign: textAlign,
      text: TextSpan(children: [
        TextSpan(
            text: title.titleCase(),
            style: GoogleFonts.epilogue(
              // fontSize: FontSize.headline0,
              fontSize: 65,
              fontWeight: isBold ? FontWeight.w900 : FontWeight.w500,
              color: color,
              height: 0.9
            )
        ),
      ])
  );
}