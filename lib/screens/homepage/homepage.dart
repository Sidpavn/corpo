
import 'dart:math';

import 'package:corpo/models/player/player.dart';
import 'package:corpo/screens/authentication/login.dart';
import 'package:corpo/services/get_all_items.dart';
import 'package:corpo/widgets/other_widgets/button_widgets.dart';
import 'package:corpo/widgets/other_widgets/misc_widgets.dart';
import 'package:cache_manager/core/delete_cache_service.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';
import '../../functions/navigation_chooser.dart';
import '../../models/themes/theme.dart';
import '../../providers/network_connectivity.dart';
import '../../services/cache/initialize_cache.dart';
import '../../services/cache/upload_backup.dart';
import '../../widgets/other_widgets/header_widgets.dart';
import '../../widgets/homepage/homepage_widgets.dart';
import '../../widgets/homepage/weather_widget.dart';
import '../../widgets/other_widgets/text_widgets.dart';
import '../../widgets/other_widgets/network_error.dart';
import '../game/game_screen.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage>  with SingleTickerProviderStateMixin {
  ScrollController scrollController = ScrollController();
  LocalStorage storage = LocalStorage('corpo');
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = false, isReady = false;
  int homepageIndex = 0, filterIndex = 0;
  double height = 0;
  @override
  void initState() {
    super.initState();
    InitializeCache().initiateCache();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    if(Provider.of<InternetConnection>(context).connection){
      return WillPopScope(
        child: SafeArea(
          child: GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
                SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
              },
              child: Scaffold(
                backgroundColor: isLoading ? ColorTheme.creme : ColorTheme.black,
                appBar: AppBar(
                  backgroundColor: isLoading ? ColorTheme.creme : ColorTheme.lightGrey,
                  toolbarHeight: 95,
                  elevation: 0,
                  automaticallyImplyLeading: false,
                  flexibleSpace: !isLoading ? GestureDetector(
                    onTap: () {
                      logoutFunction();
                    },
                    child: playerHeader()
                  ) : Container(height: 95,
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    decoration: BoxDecoration(
                      color: ColorTheme.creme,
                    ),
                  )
                ),
                body: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return !isLoading ? homePage() : SizedBox(
                      width: double.infinity,
                      height: height,
                      child: centerColumn(true, child: loadingWidget()),
                    );
                  },
                ),
              )
          ),
        ),
        onWillPop: () async => false,
      );
    }
    return networkError();
  }

  Widget homePage(){
    return Container(
        width: double.infinity,
        height: height - 90,
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            crossAxisAlignment: isLoading ? CrossAxisAlignment.center : CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              gameModes(),
            ],
          ),
        )
    );
  }

  Widget gameModes(){
    return Column(
      children: [
        Row(
          children: [
            flexBox(false, flex: 1, color: ColorTheme.lightGrey, border: [0,1,0,1],
                widget: GestureDetector(
                  onTap: () {

                    setupCampaign().then((cardSet) {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) => GameScreen(cardSet[0], cardSet[1]),
                          transitionDuration: Duration.zero,
                          reverseTransitionDuration: Duration.zero,
                        ),
                      );
                    });



                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            flexBox(false, flex: 1, color: ColorTheme.white, border: [1,1,1,0],
                              widget: assetImageContainer(height: 180, asset: "assets/images/failed_expedition.jpeg"),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            flexBox(true, flex: 4, color: ColorTheme.white, border: [1,1,0,1],
                                widget: SizedBox(
                                    height: 50,
                                    child: centerColumn(false,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            title(true, title: "Campaign", textAlign: TextAlign.left, color: ColorTheme.black),
                                            info(false, title: "Battle with AI", textAlign: TextAlign.left, color: ColorTheme.black),
                                          ],
                                        )
                                    )
                                )
                            ),
                            flexBox(true, flex: 1, color: ColorTheme.yellow, border: [1,1,1,1],
                              widget: SizedBox(
                                height: 50,
                                child: button(
                                    color: ColorTheme.yellow,
                                    padding: const EdgeInsets.all(0),
                                    child: Icon(Icons.arrow_forward, size: 30, color: ColorTheme.black)
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
            )
          ],
        )
      ],
    );
  }

  Future<dynamic> setupCampaign() async {

    List<Map<String, dynamic>> playerCards = [];
    List<Map<String, dynamic>> enemyCards = [];

    Random random = Random();

    for (int i = 0; i < 10; i++) {
      int randomIndex = random.nextInt(getAllCards().length);
      playerCards.add(getAllCards()[randomIndex]);
    }

    for (int i = 0; i < 10; i++) {
      int randomIndex = random.nextInt(getAllCards().length);
      enemyCards.add(getAllCards()[randomIndex]);
    }

    return [playerCards, enemyCards];

  }

  logoutFunction(){
    playerMap().update('device_id', (value) => '');
    setState(() {
      isLoading = true;
    });
    UploadBackup().uploadBackup().then((value) async {
      await DeleteCache.deleteKey("news_cache");
      await DeleteCache.deleteKey("cached_time");
      await DeleteCache.deleteKey("cached_leaderboard_time");
      _signOut();
    });
    // _signOut();
  }

  Future<void> _signOut() async {
    await _auth.signOut();
    if(playerInfo().authType == "google"){
      await GoogleSignIn().signOut();
    }
    storage.clear();
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => LoginPage(isReload: false),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
    );
  }

}