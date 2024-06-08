
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

import '../../models/themes/theme.dart';
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

Widget nicheMarabu(){
  return Row(
    children: [
      flexBox(true, flex: 1, color: null, border: [0,0,0,0],
          widget: Container(
              height: 30,
              child: centerColumn(false,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      title(true, title: "Niche Marabu", textAlign: TextAlign.left, color: ColorTheme.yellow),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0,0,5,0),
                            child: CircleAvatar(
                              backgroundColor: ColorTheme.yellow,
                              radius: 6,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0,0,0,0),
                            child: CircleAvatar(
                              backgroundColor: ColorTheme.yellow,
                              radius: 6,
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(0,0,0,0),
                              child: Icon(
                                  Icons.clear, color: ColorTheme.yellow, size: 20
                              )
                          ),
                        ],
                      )
                    ],
                  )
              )
          )
      ),
    ],
  );
}

Widget button({required Color titleColor, required Color color, required String title, required String headline}){
  return Container(
    width: double.infinity, height: 120,
    padding: const EdgeInsets.fromLTRB(20,10,20,10),
    color: color,
    child: centerColumn(false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          subtitle(false, title: title, textAlign: TextAlign.left, color: titleColor),
          headline3(true, title: headline, textAlign: TextAlign.left, color: titleColor)
        ],
      ),
    ),
  );
}

Widget loadingButton({required Color color}){
  return Container(
    width: double.infinity, height: 120,
    padding: const EdgeInsets.fromLTRB(20,10,20,10),
    color: color,
    child: centerColumn(true,
      child: CircularProgressIndicator(
        color: ColorTheme.black,
        backgroundColor: ColorTheme.black.withOpacity(0.3),
        strokeWidth: 3,
      )
    ),
  );
}

Widget howToPlay(){
  return Row(
    children: [
      flexBox(false, flex: 1, color: ColorTheme.black, border: [0,1,0,1],
        widget: ExpandablePanel(
            expanded: Column(
              children: [
                Row(
                  children: [
                    flexBox(true, flex: 1, color: ColorTheme.black, border: [0,1,0,0],
                      widget: Padding(
                        padding: const EdgeInsets.fromLTRB(0,0,0,40),
                        child: centerColumn(false,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                subtitle(false,
                                    title: "Welcome to Corpo Overlords, a unique deck-building game designed for two players to battle head-to-head using a single device!",
                                    textAlign: TextAlign.left, color: ColorTheme.white
                                ),
                                const SizedBox(height: 15),
                                subtitle(true,
                                    title: "Objective:",
                                    textAlign: TextAlign.left, color: ColorTheme.white
                                ),
                                const SizedBox(height: 5),
                                subtitle(false,
                                    title: "The objective is to reduce your opponent's health to zero by strategically playing cards from "
                                        "your deck and using their abilities to deal damage and defend against attacks.",
                                    textAlign: TextAlign.left, color: ColorTheme.white
                                ),
                                const SizedBox(height: 15),
                                subtitle(true,
                                    title: "Setup:",
                                    textAlign: TextAlign.left, color: ColorTheme.white
                                ),
                                const SizedBox(height: 5),
                                bulletPoint(
                                    color: ColorTheme.white,
                                    title: "Device Orientation: ",
                                    subtitle: "Place the device vertically, with each player sitting on opposite ends, facing each other."
                                ),
                                const SizedBox(height: 15),
                                subtitle(true,
                                    title: "Gameplay:",
                                    textAlign: TextAlign.left, color: ColorTheme.white
                                ),
                                const SizedBox(height: 5),
                                bulletPoint(
                                    color: ColorTheme.white,
                                    title: "Turn structure: ",
                                    subtitle: "Players take turns performing actions. Playing an attack card will end a turn."
                                ),
                                const SizedBox(height: 5),
                                bulletPoint(
                                    color: ColorTheme.white,
                                    title: "Draw phase: ",
                                    subtitle: "At the beginning of your turn, draw a predetermined number of cards from your deck. "
                                        "This replenishes your hand for the upcoming turn."
                                ),
                                const SizedBox(height: 5),
                                bulletPoint(
                                    color: ColorTheme.white,
                                    title: "Play phase: ",
                                    subtitle: ""
                                ),
                                const SizedBox(height: 5),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: bulletPoint(
                                      color: ColorTheme.white,
                                      title: "",
                                      subtitle: "During this phase, you can play cards from your hand to perform actions such as attacking your opponent, "
                                          "defending yourself, or deploying special abilities."
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: bulletPoint(
                                      color: ColorTheme.white,
                                      title: "",
                                      subtitle: "Each card has a cost associated with it, which may require you to spend resources or meet certain conditions to play it."
                                  ),
                                ),
                                const SizedBox(height: 5),
                                bulletPoint(
                                    color: ColorTheme.white,
                                    title: "End Phase: ",
                                    subtitle: "After taking your actions for the turn, the phase ends and play passes to your opponent."
                                ),
                              ],
                            )
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            collapsed: Container(),
            theme: ExpandableThemeData(
                iconColor: ColorTheme.yellow,
                tapHeaderToExpand: true,
                tapBodyToCollapse: true,
                iconSize: 30,
                collapseIcon: Icons.keyboard_arrow_down,
                expandIcon: Icons.keyboard_arrow_up,
                animationDuration: const Duration(milliseconds: 400),
                headerAlignment: ExpandablePanelHeaderAlignment.center
            ),
            header: Row(
              children: [
                flexBox(true, flex: 1, color: ColorTheme.black, border: [0,0,0,0],
                    widget: Container(
                        padding: const EdgeInsets.fromLTRB(0,20,0,20),
                        child: centerColumn(false,
                            child: Row(
                              children: [
                                headline3(true, title: "How to play", textAlign: TextAlign.left, color: ColorTheme.yellow),
                              ],
                            )
                        )
                    )
                ),
              ],
            )
        ),
      )
    ],
  );
}
