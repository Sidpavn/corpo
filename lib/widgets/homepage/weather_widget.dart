

import 'package:carousel_slider/carousel_slider.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';
import 'package:flutter/material.dart';

import '../../models/themes/theme.dart';
import '../other_widgets/misc_widgets.dart';
import '../other_widgets/text_widgets.dart';

Widget weatherInfo(){
  return Row(
    children: [
      flexBox(false, flex: 1, color: ColorTheme.black, border: [0,0,0,1],
          widget: FutureBuilder<Weather> (
            future: fetchWeather(),
            builder: (BuildContext context, AsyncSnapshot<Weather>  snapshot) {
              return Stack(
                children: [
                  AnimatedContainer(
                    width: double.infinity,
                    duration: const Duration(milliseconds: 600),
                    height: 250,
                    decoration: BoxDecoration(
                      color: ColorTheme.black,
                    ),
                    child: Image.asset(
                      "assets/images/gear loadout.jpeg",
                      color: ColorTheme.yellow,
                      colorBlendMode: BlendMode.colorBurn,
                      fit: BoxFit.fitWidth,
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
                  ),
                  AnimatedSize(
                    curve: Curves.easeIn,
                    duration: const Duration(milliseconds: 600),
                    child: Container(
                      color: ColorTheme.black,
                      height: snapshot.connectionState == ConnectionState.waiting ? 0 : 25,
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: snapshot.connectionState == ConnectionState.waiting ? Container() :
                        ClipRRect(
                            child: CarouselSlider(
                              options: CarouselOptions(
                                autoPlay: true,
                                autoPlayInterval: const Duration(seconds: 3),
                                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                                scrollPhysics: const NeverScrollableScrollPhysics(),
                                autoPlayCurve: Curves.fastOutSlowIn,
                                pauseAutoPlayOnTouch: false,
                                enlargeCenterPage: false,
                                scrollDirection: Axis.horizontal,
                                viewportFraction: 0.4,
                              ),
                              items: [
                                info(false, title: DateFormat.yMMMEd().format(DateTime.now().add(const Duration(days: 50 * 365))).toString(), textAlign: TextAlign.left, color: ColorTheme.neonGreen),
                                info(false, title: snapshot.data!.temperature.toString(), textAlign: TextAlign.left, color: ColorTheme.neonGreen),
                                info(false, title: snapshot.data!.weatherMain.toString() + '. ' +
                                    snapshot.data!.weatherDescription.toString(), textAlign: TextAlign.left, color: ColorTheme.neonGreen),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    centerRow(true,
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          RotationTransition(
                                            turns: AlwaysStoppedAnimation(snapshot.data!.windDegree! / 360),
                                            child: Icon(Icons.arrow_forward, size: 15, color: ColorTheme.neonGreen),
                                          ),
                                          const SizedBox(width: 5),
                                          info(false, title: snapshot.data!.windSpeed.toString() + "m/s WSW", textAlign: TextAlign.left, color: ColorTheme.neonGreen),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(),
                                  ],
                                ),
                                info(false, title: "Humidity: " + snapshot.data!.humidity!.toStringAsFixed(0) + "%", textAlign: TextAlign.left, color: ColorTheme.neonGreen),
                                info(false, title: snapshot.data!.pressure!.toStringAsFixed(0) + "hPa", textAlign: TextAlign.left, color: ColorTheme.neonGreen),
                              ],
                            )
                        )
                    ),
                  )
                ],
              );
            },
          )
      )
    ],
  );
}

Future<Weather> fetchWeather() async {
  late WeatherFactory ws;
  double lat = 40.7128, lon = 74.0060;
  String key = 'cf549bc1955066909594dac411a2f278';
  ws = WeatherFactory(key);
  Weather weather = await ws.currentWeatherByLocation(lat, lon);
  return weather;
}