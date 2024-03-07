
import 'package:corpo/widgets/other_widgets/button_widgets.dart';
import 'package:corpo/widgets/other_widgets/misc_widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:expandable/expandable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/marquee.dart';

import '../../common/statics.dart';
import '../../models/themes/theme.dart';
import '../other_widgets/bottom_model_sheet.dart';
import '../other_widgets/text_widgets.dart';


Widget resetPasswordSent(){
  return subtitle(false, title: "An email containing instructions to reset your password has been successfully sent to your email address.\n\n"
      "Once you've reset your password following the instructions provided, you can log in using your updated credentials.", textAlign: TextAlign.left, color: ColorTheme.grey);
}

Widget disclaimer(String text){
  return Row(
    children: [
      flexBox(true, flex: 1, color: ColorTheme.black, border: [0,1,0,0],
        widget: Padding(
          padding: const EdgeInsets.fromLTRB(0,10,0,20),
          child: centerColumn(true,
            child: info(false,
                title: text,
                textAlign: TextAlign.center, color: ColorTheme.white
            ),
          ),
        ),
      ),
    ],
  );
}


Widget signUpButton(Color color){
  return Container(
    width: double.infinity, height: 140,
    padding: const EdgeInsets.all(20),
    color: color,
    child: centerColumn(false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          subtitle(false, title: 'New to Corpo Overlords?', textAlign: TextAlign.left, color: ColorTheme.black),
          headline3(true, title: 'Create new account', textAlign: TextAlign.left, color: ColorTheme.black)
        ],
      ),
    ),
  );
}

Widget signInWithEmailButton(Color color){
  return Container(
    width: double.infinity, height: 140,
    padding: const EdgeInsets.all(20),
    color: color,
    child: centerColumn(false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          subtitle(false, title: 'Already have an account?', textAlign: TextAlign.left, color: ColorTheme.black),
          headline3(true, title: 'Re-join using your account', textAlign: TextAlign.left, color: ColorTheme.black)
        ],
      ),
    ),
  );
}

Widget googleButton(Color color){
  return Container(
    width: double.infinity, height: 100,
    padding: const EdgeInsets.all(20),
    color: color,
    child: centerColumn(false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          subtitle(false, title: 'Or', textAlign: TextAlign.left, color: ColorTheme.black),
          headline3(true, title: 'Sign in with Google', textAlign: TextAlign.left, color: ColorTheme.black)
        ],
      )
    ),
  );
}

Widget termsAndConditions(){
  return Row(
    children: [
      flexBox(false, flex: 1, color: ColorTheme.black, border: [0,1,0,1],
        widget: ExpandablePanel(
            expanded: Column(
              children: [
                Row(
                  children: [
                    flexBox(true, flex: 1, color: ColorTheme.black, border: [0,1,0,0],
                      widget: Padding(
                        padding: const EdgeInsets.fromLTRB(0,0,0,40),
                        child: centerColumn(false,
                          child: info(false,
                              title: "By continuing, you agree to understand that your personal information will be securely stored and processed in accordance with applicable laws and regulations.\n\n"
                                  "We reserve the right to suspend or terminate your account "
                                  "if we detect any fraudulent activity or violation of our terms.\n\n"
                                  "You agree not to share your login information with anyone else and to notify us immediately if you suspect any unauthorized access to your account.\n\n"
                                  "We are not liable for any unauthorized access or misuse of your account due to your failure to secure your login credentials.",
                              textAlign: TextAlign.left, color: ColorTheme.white
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            collapsed: Container(),
            theme: ExpandableThemeData(
                iconColor: ColorTheme.white,
                tapHeaderToExpand: true,
                tapBodyToCollapse: true,
                iconSize: 30,
                collapseIcon: Icons.keyboard_arrow_down,
                expandIcon: Icons.keyboard_arrow_up,
                animationDuration: const Duration(milliseconds: 400),
                headerAlignment: ExpandablePanelHeaderAlignment.center
            ),
            header: Row(
              children: [
                flexBox(true, flex: 1, color: ColorTheme.black, border: [0,0,0,0],
                    widget: Container(
                        padding: const EdgeInsets.fromLTRB(0,20,0,20),
                        child: centerColumn(false,
                            child: Row(
                              children: [
                                title(false, title: "Terms and conditions", textAlign: TextAlign.left, color: ColorTheme.white),
                              ],
                            )
                        )
                    )
                ),
              ],
            )
        ),
      )
    ],
  );
}

Widget nkcImage(){
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: ColorTheme.black,
      image: DecorationImage(
        image: const AssetImage("assets/images/nkc.jpeg"),
        colorFilter: ColorFilter.mode(ColorTheme.yellow, BlendMode.colorBurn),
        fit: BoxFit.fitWidth,
      ),
    ),
  );
}

Widget nicheMarabu(){
  return Row(
    children: [
      flexBox(true, flex: 1, color: null, border: [0,0,0,0],
          widget: Container(
              height: 30,
              child: centerColumn(false,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      title(true, title: "Niche Marabu", textAlign: TextAlign.left, color: ColorTheme.yellow),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0,0,5,0),
                            child: CircleAvatar(
                              backgroundColor: ColorTheme.yellow,
                              radius: 6,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0,0,0,0),
                            child: CircleAvatar(
                              backgroundColor: ColorTheme.yellow,
                              radius: 6,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0,0,0,0),
                            child: Icon(
                              Icons.clear, color: ColorTheme.yellow, size: 20
                            )
                          ),
                        ],
                      )
                    ],
                  )
              )
          )
      ),
    ],
  );
}

Widget projectKaldor(){
  return Row(
    children: [
      flexBox(false, flex: 1, color: ColorTheme.black, border: [0,1,0,1],
        widget: Container(
          height: 160,
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: Marquee(
            text: "CORPO OVER  ",
            style: GoogleFonts.spaceMono(
              fontSize: 150,
              fontWeight:FontWeight.w900,
              color: ColorTheme.lightGrey,
              height: 1
            ),
            scrollAxis: Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.start,
            blankSpace: 0,
            velocity: 60.0,
          ),
        )
      ),
    ],
  );
}

Widget urbanOversight(){
  return flexBox(true, flex: 2, color: ColorTheme.black, border: [0,1,0,0],
    widget: Container(
      height: 130,
      child: centerColumn(false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            subtitle(false, title: "New Kaldor City", textAlign: TextAlign.left, color: ColorTheme.yellow),
            headline2(true, title: "The Directorate of\nUrban Oversight", textAlign: TextAlign.left, color: ColorTheme.yellow),
          ],
        )
      )
    )
  );
}

Widget sectorInfo(){
  return flexBox(true, flex: 1, color: ColorTheme.lightGrey, border: [0,1,0,0],
    widget: Container(
      height: 130,
      child: centerColumn(false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            info(false, title: "Serial No", textAlign: TextAlign.left, color: ColorTheme.black),
            title(true, title: "NKCR-9843-B", textAlign: TextAlign.left, color: ColorTheme.black),
            const SizedBox(height: 10),
            info(false, title: "Sector Index", textAlign: TextAlign.left, color: ColorTheme.black),
            title(true, title: "Sector 7A", textAlign: TextAlign.left, color: ColorTheme.black),
            const SizedBox(height: 10),
            info(false, title: "Population", textAlign: TextAlign.left, color: ColorTheme.black),
            title(true, title: "1,030,009", textAlign: TextAlign.left, color: ColorTheme.black),
          ],
        )
      )
    )
  );
}

Widget authenticationIndicator(){
  return Container(
      height: 400,
      color: ColorTheme.creme,
      padding: const EdgeInsets.all(20),
      child: Center(
        child: centerColumn(true,
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
                subtitle(false, title: 'Authenticating..', textAlign: TextAlign.center, color: ColorTheme.black),
              ],
            )
        ),
      )
  );
}

bool isValidEmail(String email) {
  final emailRegex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  return emailRegex.hasMatch(email.trim());
}

Future<bool> checkIfEmailInUse(String emailAddress) async {
  try {
    final list = await FirebaseAuth.instance.fetchSignInMethodsForEmail(emailAddress);
    if (list.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  } catch (error) {
    return true;
  }
}

resetPasswordModal(BuildContext context, {required Widget widget}) async {
  modalSheet(
      context,
      top: Padding(
        padding: const EdgeInsets.fromLTRB(20,20,20,20),
        child: headline2(true, title: "Reset your password", textAlign: TextAlign.left, color: ColorTheme.black),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20,20,20,20),
        child: subtitle(false, title: "To reset your password, please provide the email address associated with your account.\n\n"
            "Upon submission, we will send a password reset link to the provided email address. "
            "This link will allow you to create a new password and regain access to your account.", textAlign: TextAlign.left, color: ColorTheme.black),
      ),
      bottom: Row(
        children: [
          flexBox(false, flex: 1, color: ColorTheme.white, border: [0,1,0,0],
            widget: widget,
          ),
        ],
      ),
  );
}

otherDeviceLoggedIn(BuildContext context) async {
  modalSheet(
      context,
      top: Padding(
        padding: const EdgeInsets.fromLTRB(20,20,20,20),
        child: headline3(true, title: "Another device is currently connected to this device", textAlign: TextAlign.left, color: ColorTheme.black),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20,20,20,40),
        child: subtitle(false, title: "To ensure a secure login, please terminate the active session on the other device before accessing this one. Employing multi-device security protocols for your protection.\n\n"
            "Thank you for your cooperation.", textAlign: TextAlign.left, color: ColorTheme.black),
      ),
      bottom: null
  );
}

