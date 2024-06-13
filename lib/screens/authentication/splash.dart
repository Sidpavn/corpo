
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../common/statics.dart';
import '../../models/themes/theme.dart';
import '../../services/splash/splash_service.dart';

class SplashView extends StatefulWidget {

  final bool isSplash;
  SplashView(this.isSplash);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
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
                              color: ColorTheme.lightGrey,
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
                                              text: " a game by\n\n",
                                              style: GoogleFonts.epilogue(
                                                fontSize: FontSize.info,
                                                fontWeight: FontWeight.w500,
                                                color: ColorTheme.black,
                                                height: 0.1
                                              )
                                          ),
                                          TextSpan(
                                              text: "NICHE\nMARABU",
                                              style: GoogleFonts.epilogue(
                                                fontSize: FontSize.headline0,
                                                fontWeight: FontWeight.w900,
                                                color: ColorTheme.black,
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
