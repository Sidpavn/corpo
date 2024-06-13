
import 'package:corpo/widgets/other_widgets/bottom_model_sheet.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/themes/theme.dart';
import '../../widgets/other_widgets/text_widgets.dart';
import '../common/statics.dart';
import 'other_widgets/misc_widgets.dart';


Widget tutorialBox({
  required String question,
  required String answer
}){
  return Container(
      width: 400,
      decoration: BoxDecoration(
        color: ColorTheme.white,
        border: Border.all(color: ColorTheme.black, width: 1.5)
      ),
      padding: const EdgeInsets.fromLTRB(20,20,20,20),
      margin: const EdgeInsets.fromLTRB(0,0,10,0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title(
              true,
              title: question,
              textAlign: TextAlign.left,
              color: ColorTheme.black
          ),
          const SizedBox(height: 10),
          info(
              false,
              title: answer,
              textAlign: TextAlign.left,
              color: ColorTheme.black
          ),
        ],
      )
  );
}
