import 'package:corpo/models/themes/theme.dart';
import 'package:corpo/widgets/other_widgets/misc_widgets.dart';
import 'package:fl_toast/fl_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../widgets/other_widgets/text_widgets.dart';

callSnackBar(BuildContext context, int milliseconds,
    {required String headline, required String content, required bool isError, required Color color}){
  showToast(
    padding: EdgeInsets.zero,
    alignment: const Alignment(0, -1),
    duration: Duration(milliseconds: milliseconds),
    animationDuration: const Duration(milliseconds: 200),
    animationBuilder: (context, animation, child) {
      return SlideTransition(
        position: CurvedAnimation(
          parent: animation,
          curve: Curves.easeOut,
        ).drive(Tween<Offset>(
          begin: const Offset(0, -1.0),
          end: Offset.zero,
        )),
        child: child,
      );
    },
    child: Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.up,
      child: Container(
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
          color: isError ? ColorTheme.darkRed : ColorTheme.green,
          border: Border(
            bottom: BorderSide(color: ColorTheme.black,width: 1.5,),
          ),
        ),
        child: AnimationConfiguration.staggeredList(
            position: 0,
            duration: const Duration(milliseconds: 1000),
            child: SlideAnimation(
              horizontalOffset: -100.0,
              child: FadeInAnimation(
                child: centerColumn(true,
                  child: centerRow(true,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: CircleAvatar(
                              radius: 25,
                              backgroundColor: color,
                              child: SlideAnimation(
                                  duration: const Duration(milliseconds: 1500),
                                  verticalOffset: 250.0,
                                  child: FadeInAnimation(
                                      child: Padding(
                                        padding: const EdgeInsets.only(bottom: 0),
                                        child: Icon(
                                          isError ? Icons.warning : Icons.check,
                                          size: isError ? 30 : 35,
                                          color: isError ? ColorTheme.darkRed : ColorTheme.green,
                                        ),
                                      )
                                  )
                              )
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            subtitle(false, title: headline.toUpperCase(), textAlign: TextAlign.left, color: color,),
                            title(true, title: content, textAlign: TextAlign.left, color: color),
                          ],
                        )
                      ],
                    ),
                  )
                )
              ),
            )
        )
      ),
    ),
    context: context,
  );
}
