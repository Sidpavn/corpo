import 'package:corpo/widgets/other_widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import '../../models/mission/mission_models.dart';
import '../../models/themes/theme.dart';
import '../other_widgets/misc_widgets.dart';

Widget targetCard({
  required Mission mission,
  required bool isCard
}){
  return Container(
      width: double.infinity,
      height: 400,
      decoration: BoxDecoration(
          color: ColorTheme.white,
          border: Border.all(color: ColorTheme.black, width: 1.5)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          box(true, flex: 1, color: ColorTheme.white, border: [0,0,0,0],
            widget: Padding(
                padding: const EdgeInsets.fromLTRB(0,10,0,10),
                child: headline1(
                    true,
                    title: mission.name!.name!,
                    textAlign: TextAlign.left,
                    color: ColorTheme.black
                )
            ),
          ),
          box(true, flex: 1, color: ColorTheme.white, border: [0,0,0,0],
            widget: Padding(
                padding: const EdgeInsets.fromLTRB(0,10,0,10),
                child: centerColumn(true,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: mission.stages!.length,
                            itemBuilder: (context, index) {
                              return title(
                                  true,
                                  title: mission.stages![index].name!,
                                  textAlign: TextAlign.left,
                                  color: ColorTheme.black
                              );
                            }
                        ),
                      ],
                    )
                )
            ),
          ),
        ],
      )
  );
}