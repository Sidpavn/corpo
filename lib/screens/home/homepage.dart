import 'dart:async';
import 'dart:ui';
import 'package:corpo/common/enums/enums.dart';
import 'package:corpo/screens/game/gamepage.dart';
import 'package:corpo/screens/home/agency_page.dart';
import 'package:corpo/services/hitmen_functions/hitmen_functions.dart';
import 'package:corpo/services/storage/storage_functions.dart';
import 'package:corpo/widgets/other_widgets/misc_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../common/statics.dart';
import '../../models/themes/theme.dart';
import '../../services/splash/splash_service.dart';
import '../../widgets/other_widgets/text_widgets.dart';

class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  SplashServices splashServices = SplashServices();
  double height = 0;
  List<Map<String, dynamic>> hitmanCards = [];
  bool isTutorialEnabled = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(getItem(key: storageItem.tutorialCompleted.name) == null){
      setItem(key: storageItem.tutorialCompleted.name, value: false);
    }

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
                            padding: const EdgeInsets.fromLTRB(20,0,20,0),
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
                                    const SizedBox(),
                                    Column(
                                      children: [
                                        SlideAnimation(
                                          verticalOffset: 100,
                                          duration: const Duration(milliseconds: 600),
                                          child: Column(
                                            children: [
                                              instructionContainer(),
                                              bewareContainer(),
                                              const SizedBox(height: 20),
                                              GestureDetector(
                                                onTap: () async {
                                                  await getHitmanCards().then((value) {
                                                    Navigator.of(context).push(
                                                      PageRouteBuilder(
                                                        // pageBuilder: (context, animation1, animation2) => AgencyPage(),
                                                        pageBuilder: (context, animation1, animation2) => Gamepage(initialCards: value),
                                                        transitionDuration: Duration.zero,
                                                        reverseTransitionDuration: Duration.zero,
                                                      ),
                                                    );
                                                  });
                                                },
                                                child: button(title: "Start your agency", primary: true),
                                              ),
                                              const SizedBox(height: 20),
                                              if(getItem(key: storageItem.tutorialCompleted.name) ?? false)...{
                                                skipTutorial()
                                              }
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(),
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
      onWillPop: () async => false,
    );
  }

  Widget skipTutorial(){
    return centerRow(true,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Checkbox(
                value: isTutorialEnabled,
                checkColor: ColorTheme.white,
                activeColor: ColorTheme.black,
                splashRadius: 0,
                onChanged:(val){
                  setState(() {
                    isTutorialEnabled = val!;
                    setItem(key: storageItem.tutorialCompleted.name, value: isTutorialEnabled);
                  });
                  FocusManager.instance.primaryFocus?.unfocus();
                }
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  isTutorialEnabled = !isTutorialEnabled;
                  setItem(key: storageItem.tutorialCompleted.name, value: isTutorialEnabled);
                });
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8,20,20,20),
                child: subtitle(
                  false,
                  title: "Skip tutorial",
                  color: ColorTheme.black,
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          ],
        )
    );
  }

  Future<List<Map<String, dynamic>>> getHitmanCards() async {
    setState(() {
      hitmanCards.clear(); 
      for(int i=0; i < 3; i++){
        hitmanCards.add(getHitmanData(tier: typeOfTier.DTier));
        setItem(key: storageItem.hitmanCards.name, value: hitmanCards);
      } 
    }); 
    return hitmanCards;
  }

  Widget button({required String title, required bool primary}){
    return box(true, flex: 1, color: primary ? ColorTheme.yellow : ColorTheme.black, border: [1,1,1,1],
      widget: Padding(
        padding: const EdgeInsets.fromLTRB(0,10,0,10),
        child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(children: [
              TextSpan(
                  text: title,
                  style: GoogleFonts.epilogue(
                    fontSize: FontSize.headline3,
                    fontWeight: FontWeight.w700,
                    color: primary ? ColorTheme.black : ColorTheme.yellow
                  )
              ),
            ])
        ),
      ),
    );
  }

  Widget instructionContainer(){
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
                  text: "Exits HQ\n".toUpperCase(),
                  style: GoogleFonts.epilogue(
                    fontSize: FontSize.headline0,
                    fontWeight: FontWeight.w900,
                    color: ColorTheme.black,
                  )
              ),
              TextSpan(
                  text: "\nAs the mastermind behind a dubious assassination agency, you’ll juggle a cast of quirky killers, each with their own unique set of skills and maddening quirks.\n\n"
                      "Keep the missions rolling and the money flowing, all while navigating the hilariously frustrating antics of your employees.\n\n"
                      "Can you keep the agency from going belly-up?",
                  style: GoogleFonts.epilogue(
                    fontSize: FontSize.info,
                    fontWeight: FontWeight.w500,
                    color: ColorTheme.black,
                  )
              ),
            ])
        ),
      ),
    );
  }

  Widget bewareContainer(){
    return box(true, flex: 1, color: ColorTheme.black, border: [1,0,1,1],
      widget: Padding(
        padding: const EdgeInsets.fromLTRB(0,10,0,10),
        child: RichText(
            textAlign: TextAlign.left,
            text: TextSpan(children: [
              TextSpan(
                  text: "Beware:\n".toUpperCase(),
                  style: GoogleFonts.epilogue(
                    fontSize: FontSize.title,
                    fontWeight: FontWeight.w900,
                    color: ColorTheme.red,
                  )
              ),
              TextSpan(
                  text: "You can only fail the missions three times.\n\nMess up more than that, and the higher-ups will deal with you in the same way you deal with your targets.",
                  style: GoogleFonts.epilogue(
                    fontSize: FontSize.info,
                    fontWeight: FontWeight.w500,
                    color: ColorTheme.white,
                  )
              ),
            ])
        ),
      ),
    );
  }



}
