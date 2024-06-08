import 'dart:io';

import 'package:corpo/common/statics.dart';
import 'package:corpo/firebase_options.dart';
import 'package:corpo/providers/network_connectivity.dart';
import 'package:corpo/screens/authentication/splash.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localstorage/localstorage.dart' as st;
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'common/connection_class.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<InternetConnection>(create: (context) => InternetConnection()),
      ],
      child: const MyApp(),
    )
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final MyConnectivity _connectivity = MyConnectivity.instance;

  @override
  void initState() {
    super.initState();
    checkInternetConnection();
  }

  @override
  void dispose() {
    _connectivity.disposeStream();
    super.dispose();
  }

  void checkInternetConnection(){
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      InternetConnection provider =Provider.of<InternetConnection>(context,listen: false);
      MyConnectivity.instance.myStream.listen((source) {
        if(source.keys.toList()[0]==ConnectivityResult.none){
          provider.setconnection(false);
        }else{
          provider.setconnection(true);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final storage = st.LocalStorage('corpo');
    return FutureBuilder(
      future: storage.ready,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return MaterialApp(
            builder: (context, widget) => ResponsiveWrapper.builder(
                ClampingScrollWrapper.builder(context, widget!),
                maxWidth: 500,
                minWidth: 500,
                defaultScale: true,
                breakpoints: [
                  const ResponsiveBreakpoint.resize(500, name: MOBILE),
                ],
                background: Container(color: Colors.black)),
            title: '',
            home: SplashView(true),
            debugShowCheckedModeBanner: false,
          );
        } else {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              backgroundColor: Colors.black,
              body: Center(
                child: SizedBox(
                  child: Column(
                    children: [
                      const SizedBox(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          backgroundColor: Colors.black,
                          strokeWidth: 1.5,
                        ),
                        width: 25,
                        height: 25,
                      ),
                      const SizedBox(height: 15),
                      RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(children: [
                            TextSpan(
                              text: 'Initializing storage...',
                              style: GoogleFonts.epilogue(
                                fontSize: FontSize.info,
                                fontWeight: FontWeight.w600,
                                color: Colors.white54,
                                height: 1.5,
                              ),
                            ),
                          ])
                      ),
                    ],
                  ),
                  width: 300,
                  height: 100,
                ),
              ),
            ),
          );
        }
      },
    );
  }
}