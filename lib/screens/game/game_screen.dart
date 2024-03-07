
import 'dart:async';

import 'package:corpo/models/items/card.dart';
import 'package:corpo/widgets/other_widgets/button_widgets.dart';
import 'package:corpo/widgets/other_widgets/misc_widgets.dart';
import 'package:corpo/widgets/other_widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import '../../providers/network_connectivity.dart';
import '../../../models/themes/theme.dart';
import '../../widgets/other_widgets/network_error.dart';

class GameScreen extends StatefulWidget {

  List<Map<String, dynamic>> playerCards;
  List<Map<String, dynamic>> enemyCards;

  GameScreen(this.playerCards, this.enemyCards);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {

  List playerCards = [];
  List enemyCards = [];
  ScrollController playerDeckController = ScrollController();
  ScrollController enemyDeckController = ScrollController();

  bool isDragged = false;
  bool isPlayerTurn = true;

  @override
  void initState() {
    super.initState();
    playerCards = widget.playerCards;
    enemyCards = widget.enemyCards;


    debugPrint("playerCards : " + playerCards.toString());
    debugPrint("enemyCards : " + enemyCards.toString());
  }


  @override
  void dispose() {
    super.dispose();
    playerDeckController.dispose();
    enemyDeckController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(Provider.of<InternetConnection>(context).connection){
      return WillPopScope(
        child: SafeArea(
          child: GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: Scaffold(
                backgroundColor: ColorTheme.creme,
                body: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: Column(
                        children: [
                          enemySection(),
                          playerSection(),
                        ],
                      )
                    );
                  },
                ),
              )
          ),
        ),
        onWillPop: () async => true,
      );
    }
    return networkError();
  }

  Widget playerSection(){
    return Expanded(
      child: Container(
          color: ColorTheme.creme,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 20),
              deckWidget(player: true),
            ],
          )
      )
    );
  }

  Widget enemySection(){
    return Expanded(
      child: RotatedBox(
        quarterTurns: 2,
        child: Container(
            color: ColorTheme.creme,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: 20),
                deckWidget(player: false),
              ],
            )
        ),
      ),
    );
  }

  Widget deckWidget({required bool player}){
    bool enabled = checkEnabledStatus(player);
    return animated(
      horizontalOffset: 0, verticalOffset: 100, duration: 1000,
      widget: Container(
        height: 300,
        margin: const EdgeInsets.only(bottom: 40),
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(left: 20, right: 10, bottom: 10),
          controller: player ? playerDeckController : enemyDeckController,
          itemCount: enemyCards.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: (){
                if(enabled){
                  setState(() {
                    isPlayerTurn = !isPlayerTurn;
                  });
                }
              },
              child: cardWidget(index, enabled: enabled, player: player)
            );
          },
        ),
      ),
    );
  }
  
  Widget cardWidget(int index, {required bool enabled, required bool player}){
    Color cardColor = enabled ? ColorTheme.white : ColorTheme.lightGrey;

    Map<String,dynamic> cardMap = player ? playerCards[index] : enemyCards[index];
    CardItem card = CardItem.fromJson(cardMap);

    return AnimatedContainer(
        width: 220,
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: ColorTheme.black,
              width: 2
          ),
          boxShadow: [
            BoxShadow(
              color: ColorTheme.black.withOpacity(0.4),
              spreadRadius: 0,
              blurRadius: 0,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        duration: const Duration(milliseconds: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            headline2(true, title: card.name!, textAlign: TextAlign.left, color: ColorTheme.black),
            subtitle(false, title: card.desc!, textAlign: TextAlign.left, color: ColorTheme.grey),

          ],
        )
    );
  }

  bool checkEnabledStatus(bool player){
    bool enabled = false;
    if(player && isPlayerTurn){enabled = true;}
    else if(player && !isPlayerTurn){enabled = false;}
    else if(!player && isPlayerTurn){enabled = false;}
    else if(!player && !isPlayerTurn){enabled = true;}
    return enabled;
  }

}