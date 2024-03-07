import 'package:corpo/common/enums/enums.dart';
import 'package:corpo/widgets/other_widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../common/statics.dart';
import '../../models/themes/theme.dart';


Widget assetImageContainer({required double? height, required String asset}){
  return Container(
    width: double.infinity,
    height: height,
    decoration: BoxDecoration(
      color: ColorTheme.black,
    ),
    child: Image.asset(
      asset,
      color: ColorTheme.yellow,
      colorBlendMode: BlendMode.colorBurn,
      fit: BoxFit.cover,
      frameBuilder: (context, Widget child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) return child;
        return AnimatedOpacity(
          opacity: frame == null ? 0 : 1,
          duration: const Duration(seconds: 1),
          curve: Curves.easeIn,
          child: child,
        );
      },

    ),
  );
}

Widget flexBox(bool isPad, {required int flex, required Color? color, required List<int> border, required Widget widget}){
  return Flexible(
    flex: flex,
    child: Container(
        width: double.infinity,
        padding: isPad ? const EdgeInsets.fromLTRB(20,10,20,10) : const EdgeInsets.fromLTRB(0,0,0,0),
        decoration: BoxDecoration(
          color: color ?? Colors.transparent,
          border: Border(
            left: border[0] == 1 ? BorderSide(color: ColorTheme.black,width: 1.5,) : BorderSide.none,
            top: border[1] == 1 ? BorderSide(color: ColorTheme.black,width: 1.5,) : BorderSide.none,
            right: border[2] == 1 ? BorderSide(color: ColorTheme.black,width: 1.5,) : BorderSide.none,
            bottom: border[3] == 1 ? BorderSide(color: ColorTheme.black,width: 1.5,) : BorderSide.none,
          ),
        ),
        child: widget
    ),
  );
}

Widget weatherTextInfo(bool isTop, String text, String description, {required Color color, required Color textColor}){
  return Row(
    children: [
      flexBox(true, flex: 1, color: color, border: [0,0,0,0],
          widget: Container(
              child: centerColumn(true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      isTop ? title(true, title: text, textAlign: TextAlign.center, color: textColor) :
                      info(false, title: text, textAlign: TextAlign.center, color: textColor),
                      if(description != '')...{
                        isTop ? info(false, title: description, textAlign: TextAlign.center, color: textColor) :
                        title(true, title: description, textAlign: TextAlign.center, color:textColor),
                      },
                    ],
                  )
              )
          )
      )
    ],
  );
}

Widget playerDetailInfo(bool isTop, String text, String description, {required Color color, required Color textColor}){
  return Row(
    children: [
      flexBox(true, flex: 1, color: color, border: [0,0,0,0],
          widget: Container(
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                centerColumn(false, child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    isTop ? title(true, title: text, textAlign: TextAlign.right, color: textColor) :
                    info(false, title: text, textAlign: TextAlign.right, color: textColor),
                    if(description != '')...{
                      isTop ? info(false, title: description, textAlign: TextAlign.right, color: textColor) :
                      title(true, title: description, textAlign: TextAlign.right, color:textColor),
                    },
                  ],
                ))
              ],
            )
          )
      )
    ],
  );
}

Widget columnInfo(bool isTop, String text, String description, {required Color? color, required Color textColor}){
  return Row(
    children: [
      flexBox(true, flex: 1, color: color ?? Colors.transparent, border: [0,0,0,0],
          widget: Container(
              child: centerColumn(false,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      isTop ? title(true, title: text, textAlign: TextAlign.left, color: textColor) :
                      info(false, title: text, textAlign: TextAlign.left, color: textColor),
                      if(description != '')...{
                        isTop ? info(false, title: description, textAlign: TextAlign.left, color: textColor) :
                        title(true, title: description, textAlign: TextAlign.left, color:textColor),
                      },
                    ],
                  )
              )
          )
      )
    ],
  );
}

Widget centerColumn(bool isCenter, {required Widget child}){
  return Column(
    crossAxisAlignment: isCenter ? CrossAxisAlignment.center : CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      const SizedBox(),
      child,
      const SizedBox(),
    ],
  );
}
Widget centerRow(bool isCenter, {required Widget child}){
  return Row(
    crossAxisAlignment: isCenter ? CrossAxisAlignment.center : CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      const SizedBox(),
      child,
      const SizedBox(),
    ],
  );
}

Widget rarityBar(typeOfRarity rarityType){
  String rarity = rarityType.name;
  double count = 0;

  switch(rarityType){
    case typeOfRarity.common:     {count = 1; break;}
    case typeOfRarity.uncommon:   {count = 2; break;}
    case typeOfRarity.rare:       {count = 3; break;}
    case typeOfRarity.epic:       {count = 4; break;}
    case typeOfRarity.legendary:  {count = 5; break;}
    case typeOfRarity.mystic:     {count = 6; break;}
    case typeOfRarity.exotic:     {count = 7; break;}
    case typeOfRarity.legacy:     {count = 8; break;}
  }

  return RatingBar.builder(
    initialRating: count,
    minRating: 0,
    direction: Axis.horizontal,
    updateOnDrag: false,
    tapOnlyMode: false,
    allowHalfRating: false,
    itemCount: 8,
    itemSize: 15,
    itemPadding: const EdgeInsets.symmetric(horizontal: 1),
    itemBuilder: (context, _) => Container(
      width: 15,  height: 15,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.5,
          color: ColorTheme.black,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(500)),
        color: getColor(rarity),
      ),
    ),
    ignoreGestures: true,
    onRatingUpdate: (double value) {  },
  );
}

extension StringExtension on String {
  String titleCase() {
    if (this == null || this.isEmpty) {
      return '';
    }

    return replaceAll('_', ' ')[0].toUpperCase() + this.replaceAll('_', ' ').substring(1);
  }
}

List<dynamic> getScreenDetails(String facility){
  String subtitle = '';
  if(facility == 'game'){
    subtitle = 'Battle with AI';
  }
  return [subtitle];
}

Widget loadingWidget() {
  return centerColumn(true,
    child: Column(
      children: [
        Container(
          child: CircularProgressIndicator(
            color: ColorTheme.black,
            backgroundColor: ColorTheme.black.withOpacity(0.0),
            strokeWidth: 3,
          ),
          width: 100,
          height: 100,
        ),
        const SizedBox(height: 20),
        info(false, title: 'Please wait..', textAlign: TextAlign.center, color: ColorTheme.black),
      ],
    )
  );
}

Widget animated({required Widget widget, required int duration, required double horizontalOffset, required double verticalOffset}){
  return AnimationLimiter(
      child: AnimationConfiguration.staggeredList(
          position: 0,
          duration: Duration(milliseconds: duration),
          child: SlideAnimation(
            horizontalOffset: horizontalOffset,
            verticalOffset: verticalOffset,
            child: widget
          )
      )
  );
}

Widget scaleAnimated({required Widget widget, required int duration, required double scale}){
  return AnimationLimiter(
      child: AnimationConfiguration.staggeredList(
          position: 0,
          duration: Duration(milliseconds: duration),
          child: ScaleAnimation(
            scale: scale,
            child: widget
          )
      )
  );
}