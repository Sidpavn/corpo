
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/themes/theme.dart';
import 'misc_widgets.dart';


Widget grid(){
  List count = [0,0,0,0,0,0,0,0,0,0,0,0,0,0];
  return Row(
    children: [
      gridColumn(0, count),
      gridColumn(1, count),
      gridColumn(2, count),
      gridColumn(3, count),
      gridColumn(4, count),
      gridColumn(5, count),
      gridColumn(6, count),
      gridColumn(7, count),
    ],
  );
}

Widget gridColumn(int columnIndex, List count){
  int i = 0 + (15 * columnIndex);
  return flexBox(false, flex: 1, color: Colors.transparent, border: [0, 0, 0, 0],
    widget: Column(
        children: count.map((e) {
          i++;
          return gridSlot(i, columnIndex);
        }).toList()
    ),
  );
}

Widget gridSlot(int index, int columnIndex){
  return flexBox(false, flex: 1, color: null, border: [0, 0, 0, 0],
    widget: Container(
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: centerColumn(true,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.add, size: 18, color: ColorTheme.neonGreen.withOpacity(0.5)),
            ]
        ),
      ),
    ),
  );
}
