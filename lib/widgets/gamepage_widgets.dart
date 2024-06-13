
import 'package:corpo/widgets/other_widgets/bottom_model_sheet.dart';
import 'package:corpo/widgets/tutorial_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/themes/theme.dart';
import '../../widgets/other_widgets/text_widgets.dart';
import '../common/misc/tutorial.dart';
import '../common/statics.dart';
import 'other_widgets/misc_widgets.dart';

showTutorialModal(BuildContext context){
  return modalSheet(context,
      isDismissible: false,
      top: Container(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20,20,20,20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            headline(
                true,
                title: "Congrats on your new agency!!",
                textAlign: TextAlign.left,
                color: ColorTheme.black
            ),
            const SizedBox(height: 20),
            info(
                false,
                title: "So, here's the deal: We've hired three top-notch hitmen at your disposal, ready to handle the dirty work.\n\n"
                    "But here’s the kicker: you only get three strikes—mess up three times, and, well, let's just say you'll be the one getting a permanent vacation.\n\n"
                    "Now, for your first mission, it's a bit of a family tradition. You need to take care of the previous manager. "
                    "Think of it as cleaning up after the last guy. "
                    "Show us you’ve got what it takes, and you'll do just fine.\n\n"
                    "Ready to get started?",
                textAlign: TextAlign.left,
                color: ColorTheme.black
            ),
          ],
        ),
      ),
      bottom: Padding(
        padding: const EdgeInsets.fromLTRB(20,0,20,40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                showQuestionModal(context);
              },
              child: questionsButton(question: "I have some questions"),
            )
          ],
        ),
      )
  );
}

showQuestionModal(BuildContext context){
  return modalSheet(context,
      isDismissible: true,
      top: Container(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20,30,20,10),
            child: headline(
                true,
                title: "What do you wanna know?",
                textAlign: TextAlign.left,
                color: ColorTheme.black
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            height: 320,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: tutorials.length,
                padding: const EdgeInsets.fromLTRB(20,0,20,20),
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {
                      },
                      child: tutorialBox(
                        question: tutorials[index]["question"],
                        answer: tutorials[index]["answer"],
                      )
                  );
                }
            ),
          )
        ],
      ),
      bottom: Padding(
        padding: const EdgeInsets.fromLTRB(20,0,20,40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: questionsButton(question: "I am ready"),
            )
          ],
        ),
      )
  );
}

Widget questionsButton({required String question}){
  return box(true, flex: 1, color: ColorTheme.yellow, border: [1,1,1,1],
    widget: Padding(
      padding: const EdgeInsets.fromLTRB(0,10,0,10),
      child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(children: [
            TextSpan(
                text: question,
                style: GoogleFonts.epilogue(
                  fontSize: FontSize.headline3,
                  fontWeight: FontWeight.w700,
                  color: ColorTheme.black,
                )
            ),
          ])
      ),
    ),
  );
}

