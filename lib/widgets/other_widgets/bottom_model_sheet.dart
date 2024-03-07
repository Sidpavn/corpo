import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../common/statics.dart';
import 'button_widgets.dart';
import '../../../models/themes/theme.dart';
import 'misc_widgets.dart';

modalSheet(BuildContext context, {required Widget top, required Widget body, required Widget? bottom}){
  return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Column(
            children: [
              Row(
                children: [
                  flexBox(false, flex: 1, color: ColorTheme.red, border: [0,1,0,1],
                    widget: Row(
                      children: [
                        flexBox(false, flex: 5, color: ColorTheme.white, border: [0,0,1,0],
                          widget: Padding(
                            padding: const EdgeInsets.fromLTRB(0,0,0,0),
                            child: top,
                          ),
                        ),
                        flexBox(true, flex: 1, color: null, border: [0,0,0,0],
                            widget: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                width: double.infinity,
                                color: ColorTheme.red,
                                child: Center(
                                  child: Icon(Icons.close, size: 35, color: ColorTheme.white),
                                ),
                              ),
                            )
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  flexBox(false, flex: 1, color: ColorTheme.creme, border: [0,0,0,0],
                    widget: body,
                  ),
                ],
              ),
              if(bottom != null)...{
                Row(
                  children: [
                    flexBox(false, flex: 1, color: ColorTheme.lightGrey, border: [0,0,0,0],
                      widget: Padding(
                        padding: const EdgeInsets.fromLTRB(0,0,0,0),
                        child:  bottom,
                      ),
                    ),
                  ],
                ),
              }
            ],
          ),
        )
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