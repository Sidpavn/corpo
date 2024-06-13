import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../common/statics.dart';
import 'button_widgets.dart';
import '../../../models/themes/theme.dart';
import 'misc_widgets.dart';

modalSheet(BuildContext context, {required bool isDismissible, required Widget top, required Widget body, required Widget? bottom}){
  return showModalBottomSheet(
      context: context,
      isScrollControlled: isDismissible,
      isDismissible: isDismissible,
      enableDrag: isDismissible,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) => WillPopScope(
        onWillPop: () async => isDismissible,
        child: SingleChildScrollView(
          child: Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Column(
              children: [
                Row(
                  children: [
                    flexBox(false, flex: 1, color: ColorTheme.white, border: [0,0,1,0],
                      widget: top,
                    )
                  ],
                ),
                Row(
                  children: [
                    flexBox(false, flex: 1, color: ColorTheme.white, border: [0,0,0,0],
                      widget: body
                    ),
                  ],
                ),
                if(bottom != null)...{
                  Row(
                    children: [
                      flexBox(false, flex: 1, color: ColorTheme.white, border: [0,0,0,0],
                        widget: bottom
                      ),
                    ],
                  ),
                }
              ],
            ),
          )
        ),
      )
  );
}

Widget closeModalButton(BuildContext context, ){
  return Container(
    height: 45,
    width: 45,
    child: GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: outlinedButton(
          
          color: ColorTheme.red,
          outlineColor: ColorTheme.black,
          padding: const EdgeInsets.all(5),
          child: Icon(Icons.close, size: 25, color: ColorTheme.white)
      ),
    ),
  );
}