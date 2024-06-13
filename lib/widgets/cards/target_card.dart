import 'package:corpo/widgets/other_widgets/text_widgets.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:spring/spring.dart';
import '../../models/hitmen/hitman_model.dart';
import '../../models/themes/theme.dart';
import '../other_widgets/misc_widgets.dart';

Widget targetCard({
  required Hitman hitman,
  required bool isCard
}){
  return Container(
      width: double.infinity,
      height: 250,
      decoration: BoxDecoration(
          color: ColorTheme.white,
          border: Border.all(color: ColorTheme.black, width: 1.5)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              box(true, flex: 1, color: ColorTheme.white, border: [0,0,0,0],
                widget: Padding(
                    padding: const EdgeInsets.fromLTRB(0,0,0,10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if(hitman.skills.isNotEmpty)...{
                          const SizedBox(height: 10),
                          info(
                              true,
                              title: "Skills",
                              textAlign: TextAlign.left,
                              color: ColorTheme.black
                          ),
                          info(
                              false,
                              title: formatList(hitman.skills),
                              textAlign: TextAlign.left,
                              color: ColorTheme.black
                          ),
                        },
                        if(hitman.quirks.isNotEmpty)...{
                          const SizedBox(height: 10),
                          info(
                              true,
                              title: "Quirks",
                              textAlign: TextAlign.left,
                              color: ColorTheme.black
                          ),
                          info(
                              false,
                              title: formatList(hitman.quirks),
                              textAlign: TextAlign.left,
                              color: ColorTheme.black
                          ),
                        },
                      ],
                    )
                ),
              ),
            ],
          ),
          box(true, flex: 1, color: ColorTheme.black, border: [0,0,0,0],
            widget: Padding(
                padding: const EdgeInsets.fromLTRB(0,0,0,0),
                child: Column(
                  children: [
                    mini(
                        false,
                        title: "Tap to flip the card",
                        textAlign: TextAlign.left,
                        color: ColorTheme.white
                    ),
                  ],
                )
            ),
          ),
        ],
      )
  );
}