import 'package:corpo/widgets/other_widgets/text_widgets.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:spring/spring.dart';
import '../../models/hitmen/hitman_model.dart';
import '../../models/themes/theme.dart';
import '../other_widgets/misc_widgets.dart';

Widget hitmanCard({
  required Hitman hitman,
  required bool isCard
}){
  double width = 260;
  double height = 360;

  SpringController springController = SpringController(initialAnim: isCard ? Motion.pause : Motion.play);
  return Spring.shake(
    springController: springController,
    child: hitmanFrontCard(
      hitman: hitman,
      isCard: isCard,
      width: width,
      height: height,
    ),
  );
}

Widget hitmanFrontCard({
  required Hitman hitman,
  required bool isCard,
  required double width,
  required double height,
}){
  return Container(
      width: width,
      height: height,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    info(
                        false,
                        title: hitman.rank + " Tier",
                        textAlign: TextAlign.left,
                        color: ColorTheme.black
                    ),
                    const SizedBox(height: 5),
                    headline(
                        true,
                        title: hitman.name,
                        textAlign: TextAlign.left,
                        color: ColorTheme.black
                    ),
                    const SizedBox(height: 5),
                    subtitle(
                        false,
                        title: "\"${hitman.architype}\"",
                        textAlign: TextAlign.left,
                        color: ColorTheme.black
                    ),
                  ],
                )
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  attributeInfo(attribute: "STR", hitman: hitman),
                  attributeInfo(attribute: "STL", hitman: hitman),
                  attributeInfo(attribute: "HCK", hitman: hitman),
                  attributeInfo(attribute: "INT", hitman: hitman),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  attributeInfo(attribute: "CMB", hitman: hitman),
                  attributeInfo(attribute: "AGI", hitman: hitman),
                  attributeInfo(attribute: "PER", hitman: hitman),
                  attributeInfo(attribute: "END", hitman: hitman),
                ],
              ),
              const SizedBox(height: 10),
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
        ],
      )
  );
}

Widget hitmanBackCard({
  required Hitman hitman,
  required bool isCard,
  required double width,
  required double height,
}){
  return Container(
      width: width,
      height: height,
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

Widget flipHitmanCard({
  required Hitman hitman,
  required bool isCard
}){
  double width = 260;
  double height = 360;
  FlipCardController controller = FlipCardController();
  SpringController springController = SpringController(initialAnim: isCard ? Motion.pause : Motion.play);
  return Spring.shake(
    springController: springController,
    child: FlipCard(
      controller: controller,
      direction: FlipDirection.HORIZONTAL,
      side: CardSide.FRONT,
      speed: 550,
      onFlipDone: (status) {},
      front: hitmanFrontCard(
        hitman: hitman,
        isCard: isCard,
        width: width,
        height: height,
      ),
      back: hitmanBackCard(
        hitman: hitman,
        isCard: isCard,
        width: width,
        height: height,
      ),
    ),
    animDuration: const Duration(milliseconds: 600),
    curve: Curves.easeIn,
    start: 100,
    end: 40,
  );
}

Widget attributeInfo({required String attribute, required Hitman hitman}){
  return flexBox(false, flex: 1, color: ColorTheme.white, border: [0,0,0,0],
    widget: Padding(
        padding: const EdgeInsets.fromLTRB(0,0,0,0),
        child: Column(
          children: [
            mini(
                false,
                title: attribute,
                textAlign: TextAlign.center,
                color: ColorTheme.black
            ),
            subtitle(
                true,
                title: hitman.attributes[attribute].toString(),
                textAlign: TextAlign.center,
                color: ColorTheme.black
            ),
          ],
        )
    ),
  );
}

