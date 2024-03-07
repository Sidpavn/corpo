import 'package:corpo/models/player/inventory.dart';
import 'package:corpo/models/player/player.dart'; 
import 'package:corpo/widgets/other_widgets/button_widgets.dart';
import 'package:corpo/widgets/other_widgets/text_widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';
import '../../common/statics.dart';
import '../../functions/navigation_chooser.dart';
import '../../services/player/calculate_max_xp.dart'; 
import '../homepage/homepage_widgets.dart';
import 'misc_widgets.dart';
import '../../../models/themes/theme.dart';

LocalStorage storage = LocalStorage('corpo');
NumberFormat myFormat = NumberFormat.decimalPattern('en_us');

playerHeader(){
  return Column(
    children: [
      Expanded(
        flex: 1,
        child: Row(
          children: [
            flexBox(true, flex: 2, color: ColorTheme.black, border: [0,1,0,0],
              widget: SizedBox(
                child: centerColumn(false,
                  child: headline3(true, title: playerInfo().username!.titleCase(), textAlign: TextAlign.left, color: ColorTheme.white),
                )
              )
            ),
            flexBox(false, flex: 1, color: ColorTheme.black, border: [0,0,1,0],
                widget: Container(
                  child: CarouselSlider(
                    options: CarouselOptions(
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 1),
                      autoPlayAnimationDuration: const Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      pauseAutoPlayOnTouch: true,
                      enlargeCenterPage: false,
                      scrollDirection: Axis.vertical,
                      viewportFraction: 1,
                      aspectRatio: 1.5,
                    ),
                    items: [
                      playerDetailInfo(false, "Account Level", myFormat.format(playerInfo().accountLvl!).toString().padLeft(3, "0"), color: ColorTheme.black, textColor: ColorTheme.white),
                      playerDetailInfo(false, "Creds", playerInfo().cash!.toString(), color: ColorTheme.black, textColor: ColorTheme.white),
                    ],
                  ),
                )
            ),
          ],
        ),
      ),
      xpBar(),
    ],
  );
}

Widget xpBar(){
  return Container(
    decoration: BoxDecoration(
      border: Border(
        top: BorderSide(color: ColorTheme.black,width: 1.5,),
        bottom: BorderSide(color: ColorTheme.black,width: 1.5,),
      ),
    ),
    child: Stack(
      children: [
        LinearProgressIndicator(
          minHeight: 15,
          value: playerInfo().xp! / calculateMaxXPForLevel(),
          backgroundColor: ColorTheme.white,
          color: ColorTheme.common,
        ),
        Positioned(
          top: 1, right: 20,
          child: info(false, title: "${formatInt(playerInfo().xp!).toString()}/${formatInt(calculateMaxXPForLevel()).toString()}", textAlign: TextAlign.left, color: ColorTheme.black)
        ),
      ],
    ),
  );
}
 
