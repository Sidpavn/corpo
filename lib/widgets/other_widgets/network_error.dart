import 'package:corpo/common/statics.dart';
import 'package:corpo/models/themes/theme.dart';
import 'package:corpo/widgets/login/login_widgets.dart';
import 'package:corpo/widgets/other_widgets/misc_widgets.dart';
import 'package:corpo/widgets/other_widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget networkError(){
  return WillPopScope(
    child: SafeArea(
        child: Scaffold(
          backgroundColor: ColorTheme.creme,
          body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(0),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget> [
                        Column(
                          children: [
                            nicheMarabu(),
                            projectKaldor(),
                          ],
                        ),
                        loadingWidget(),
                        Column(
                          children: [
                            Row(
                              children: [
                                flexBox(true, flex: 1, color: ColorTheme.black, border: [0,1,0,0],
                                  widget: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.fromLTRB(0,10,0,40),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          headline3(true, title: "Unable to connect with the servers", textAlign: TextAlign.left, color: ColorTheme.red),
                                          const SizedBox(height: 5),
                                          info(false, title: 'Corpo Overlords is currently unable to establish a connection to the internet. '
                                              'This may be due to a problem with your network configuration, a temporary outage, '
                                              'or a connectivity issue with your internet service provider. '
                                              'Please ensure that your device is connected to a reliable network and try again.'
                                              'If the problem persists, please contact your network administrator or '
                                              'internet service provider for assistance.', textAlign: TextAlign.justify, color: ColorTheme.creme)
                                        ],
                                      )
                                  ),
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        )
    ),
    onWillPop: () async => false,
  );
}