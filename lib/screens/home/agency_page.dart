import 'package:corpo/services/storage/storage_functions.dart';
import 'package:corpo/widgets/other_widgets/misc_widgets.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../models/themes/theme.dart';
import '../../services/splash/splash_service.dart';
import '../../widgets/gamepage_widgets.dart';
import '../../widgets/other_widgets/text_widgets.dart';

class AgencyPage extends StatefulWidget {
  @override
  State<AgencyPage> createState() => _AgencyPageState();
}

class _AgencyPageState extends State<AgencyPage> {
  SplashServices splashServices = SplashServices();
  double height = 0;
  List<Map<String, dynamic>> hitmanCards = [];
  bool isTutorialEnabled = true;
  int tabIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(getItem(key: storageItem.tutorialCompleted.name) == null){
      setItem(key: storageItem.tutorialCompleted.name, value: false);
    }
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
                            padding: const EdgeInsets.fromLTRB(20,20,20,40),
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
                                    tabBar(),
                                    Expanded(
                                      flex: 1,
                                      child: box(true, flex: 1, color: Colors.transparent, border: [1,1,1,1],
                                        widget: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [

                                          ],
                                        )
                                      )
                                    ),
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

  Widget tabBar(){
    return Row(
      children: [
        flexBox(true, flex: 1, color: tabIndex == 0 ? ColorTheme.black : ColorTheme.white, border: [1,1,0,0],
          widget: GestureDetector(
            onTap: () {
              setState(() { tabIndex = 0;});
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0,10,0,10),
              child: headline3(
                  true,
                  title: "Mission\nboard",
                  textAlign: TextAlign.left,
                  color: tabIndex == 0 ? ColorTheme.white : ColorTheme.black
              ),
            ),
          ),
        ),
        flexBox(true, flex: 1, color: tabIndex == 1 ? ColorTheme.black : ColorTheme.white, border: [1,1,1,0],
          widget: GestureDetector(
            onTap: () {
              setState(() { tabIndex = 1;});
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0,10,0,10),
              child: headline3(
                  true,
                  title: "Hitman\npool",
                  textAlign: TextAlign.left,
                  color: tabIndex == 1 ? ColorTheme.white : ColorTheme.black
              ),
            ),
          ),
        ),
      ],
    );
  }

}
