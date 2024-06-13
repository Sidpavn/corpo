import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:corpo/models/hitmen/hitman_model.dart';
import 'package:corpo/services/storage/storage_functions.dart';
import 'package:corpo/widgets/gamepage_widgets.dart';
import 'package:corpo/widgets/other_widgets/misc_widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../common/statics.dart';
import '../../models/themes/theme.dart';
import '../../services/splash/splash_service.dart';
import '../../widgets/cards/hitman_cards.dart';
import '../../widgets/cards/target_card.dart';
import '../../widgets/other_widgets/text_widgets.dart';

class Gamepage extends StatefulWidget {

  final List<Map<String, dynamic>> initialCards;
  Gamepage({required this.initialCards});

  @override
  State<Gamepage> createState() => _GamepageState();
}

class _GamepageState extends State<Gamepage> {
  SplashServices splashServices = SplashServices();
  double height = 0;
  bool isDragged = false;

  List<Map<String, dynamic>> hitmanCards = [];
  List<Map<String, dynamic>> selectedHitmanCards = [];

  @override
  void initState() {
    super.initState();
    hitmanCards.addAll(widget.initialCards);
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      showTutorialModal(context);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    return WillPopScope(
      child: SafeArea(
        child: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
              SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
            },
            child: Scaffold(
              extendBody: false,
              body: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: AnimatedContainer(
                            width: double.infinity,
                            height: height,
                            padding: const EdgeInsets.fromLTRB(0,20,0,20),
                            decoration: BoxDecoration(
                              color: ColorTheme.lightGrey,
                            ),
                            duration: const Duration(milliseconds: 200),
                            child: Center(
                              child: AnimationConfiguration.staggeredList(
                                position: 0,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(20,0,20,20),
                                      child: targetCard(
                                        hitman: Hitman.fromJson(hitmanCards[0]),
                                        isCard: true,
                                      ),
                                    ),
                                    assignmentDesk(),
                                    hitmanCardDeck(),
                                  ],
                                ),
                              ),
                            )
                        ),
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

  Widget hitmanCardDeck(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          height: 340,
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: hitmanCards.length,
              padding: const EdgeInsets.fromLTRB(20,20,20,20),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    if(selectedHitmanCards.length == 1){
                      selectedHitmanCards.add(hitmanCards[index]);
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0,0,index==(hitmanCards.length - 1)?0:10,0),
                    child: AbsorbPointer(
                      absorbing: isDragged,
                      child: LongPressDraggable<String>(
                        data: 'data',
                        delay: const Duration(milliseconds: 300),
                        child: flipHitmanCard(
                          hitman: Hitman.fromJson(hitmanCards[index]),
                          isCard: true,
                        ),
                        feedback: flipHitmanCard(
                          hitman: Hitman.fromJson(hitmanCards[index]),
                          isCard: true,
                        ),
                        childWhenDragging: Opacity(
                          opacity: 0.2,
                          child: flipHitmanCard(
                            hitman: Hitman.fromJson(hitmanCards[index]),
                            isCard: true,
                          ),
                        ),
                        maxSimultaneousDrags: 1,
                        dragAnchorStrategy: (Draggable<Object> _, BuildContext __, Offset ___) => const Offset(100, 100),
                        onDraggableCanceled: (velocity, offset){

                        },
                        onDragEnd: (details){
                          setState(() {
                            isDragged = false;
                          });
                        },
                        onDragStarted: () {
                          setState(() {
                            isDragged = true;
                          });
                        },
                      ),
                    ),
                  ),
                );
              }
          ),
        ),
        Padding(
            padding: const EdgeInsets.fromLTRB(20,0,20,0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                subtitle(
                    false,
                    title: "Drag the card to play",
                    textAlign: TextAlign.left,
                    color: ColorTheme.black
                ),
                subtitle(
                    false,
                    title: "3/3",
                    textAlign: TextAlign.left,
                    color: ColorTheme.black
                ),
              ],
            )
        ),
      ],
    );
  }

  Widget assignmentDesk(){
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20,0,20,0),
        child: DottedBorder(
          color: ColorTheme.grey,
          strokeWidth: 1.5,
          dashPattern: const [5,5],
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            width: double.infinity,
            height: 250,
          ),
        ),
      ),
    );
  }

  Widget button(){
    return box(true, flex: 1, color: ColorTheme.yellow, border: [1,1,1,1],
      widget: Padding(
        padding: const EdgeInsets.fromLTRB(0,10,0,10),
        child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(children: [
              TextSpan(
                  text: "Start your agency".toUpperCase(),
                  style: GoogleFonts.epilogue(
                    fontSize: FontSize.headline3,
                    fontWeight: FontWeight.w900,
                    color: ColorTheme.black,
                  )
              ),
            ])
        ),
      ),
    );
  }

  Widget welcomeMessage(){
    return box(true, flex: 1, color: ColorTheme.white, border: [1,1,1,1],
      widget: Padding(
        padding: const EdgeInsets.fromLTRB(0,10,0,10),
        child: RichText(
            textAlign: TextAlign.left,
            text: TextSpan(children: [
              TextSpan(
                  text: "Welcome to\n".toUpperCase(),
                  style: GoogleFonts.epilogue(
                    fontSize: FontSize.headline3,
                    fontWeight: FontWeight.w700,
                    color: ColorTheme.black,
                  )
              ),
              TextSpan(
                  text: "Exits HQ".toUpperCase(),
                  style: GoogleFonts.epilogue(
                    fontSize: FontSize.headline0,
                    fontWeight: FontWeight.w900,
                    color: ColorTheme.black,
                  )
              ),
            ])
        ),
      ),
    );
  }

}
