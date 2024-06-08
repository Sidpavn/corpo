import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:corpo/widgets/other_widgets/misc_widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../common/statics.dart';
import '../../models/themes/theme.dart';
import '../../services/splash/splash_service.dart';

class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  SplashServices splashServices = SplashServices();
  double height = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashServices.checkAuthentication(context);
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
                            decoration: BoxDecoration(
                              color: ColorTheme.black,
                            ),
                            duration: const Duration(milliseconds: 200),
                            child: Center(
                              child: AnimationConfiguration.staggeredList(
                                position: 0,
                                child: FadeInAnimation(
                                    duration: const Duration(milliseconds: 2000),
                                    child: RichText(
                                        textAlign: TextAlign.left,
                                        text: TextSpan(children: [
                                          TextSpan(
                                              text: "NICHE\nMARABU",
                                              style: GoogleFonts.spaceMono(
                                                  fontSize: FontSize.headline0,
                                                  fontWeight: FontWeight.w700,
                                                  color: ColorTheme.yellow,
                                                  height: 0.9
                                              )
                                          ),
                                        ])
                                    )
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
}
