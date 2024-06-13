

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:spring/spring.dart';
import 'package:swipe_cards/swipe_cards.dart';

import '../../models/themes/theme.dart';
import '../../widgets/other_widgets/text_widgets.dart';

showHitmanCard(BuildContext context, {required List<Map<String, dynamic>> data}){
  List<SwipeItem> _swipeItems = <SwipeItem>[];
  MatchEngine? _matchEngine;

  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext sheetContext){
        return AlertDialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actionsAlignment: MainAxisAlignment.center,
          content: AnimationConfiguration.staggeredList(
              position: 0,
              child: SlideAnimation(
                  verticalOffset: 200,
                  duration: const Duration(milliseconds: 1000),
                  child: SwipeCards(
                    matchEngine: _matchEngine!,
                    itemBuilder: (BuildContext context, int index) {
                      SpringController springController = SpringController(initialAnim: index != 0 ? Motion.pause : Motion.play);
                      return Spring.shake(
                        springController: springController,
                        child: _swipeItems[index].content,
                        animDuration: const Duration(milliseconds: 600),
                        curve: Curves.easeIn,
                        start: 100,
                        end: 40,
                      );
                    },
                    onStackFinished: () {
                      Navigator.of(context).pop();
                    },
                    itemChanged: (SwipeItem item, int index) {
                    },
                    upSwipeAllowed: true,
                    fillSpace: false,
                  )
              )
          ),
          title: AnimationConfiguration.staggeredList(
              position: 0,
              child: SlideAnimation(
                  verticalOffset: 200,
                  duration: const Duration(milliseconds: 1000),
                  child: Container(
                    width: 250,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        headline1(
                            true,
                            title: "Congrats on\nyour new agency!!",
                            textAlign: TextAlign.center,
                            color: ColorTheme.white
                        ),
                        subtitle(
                            false,
                            title: "Let's get you started with your\nfirst mission",
                            textAlign: TextAlign.center,
                            color: ColorTheme.white
                        )
                      ],
                    ),
                  )
              )
          ),
        );
      }
  );
}


// for(int i=0; i < 3; i++){
// hitmanCardPack.add(getHitmanData(tier: typeOfTier.DTier));
// _swipeItems.add(
// SwipeItem(
// content: hitmanCard(hitman: Hitman.fromJson(hitmanCardPack[i]), isCard: true),
// likeAction: () {
// },
// nopeAction: () {
// },
// superlikeAction: () {
// },
// onSlideUpdate: (SlideRegion? region) async {
// }
// )
// );
// }
