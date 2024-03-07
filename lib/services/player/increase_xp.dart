import 'package:corpo/models/player/player.dart';
import 'package:corpo/services/snackbar/call_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

import '../../models/themes/theme.dart';
import 'calculate_max_xp.dart';

LocalStorage storage = LocalStorage('corpo');

List<int> increaseXp(int points, BuildContext context){

  double growthFactor = 0.9;
  Player player = playerInfo();

  int xp = player.xp!, maxXp = calculateMaxXPForLevel(), accountLevel = player.accountLvl!;
  int value = (growthFactor * accountLevel * points).ceil();
  int xpGain = xp + value;

  debugPrint(xp.toString() + '/' + maxXp.toString());
  debugPrint('Xp Gain: ' + points.toString());

  if(maxXp > xpGain){
    xp = xpGain;
    maxXp = calculateMaxXPForLevel();
  } else if(maxXp == xpGain){
    xp = 0;
    accountLevel = accountLevel + 1;
    maxXp = calculateMaxXPForLevel();
    callSnackBar(context, 4000, headline: 'Leveled Up', content: 'New items unlocked', isError: false, color: ColorTheme.black);
  } else if(maxXp < xpGain) {
    xp = xpGain - maxXp;
    accountLevel = accountLevel + 1;
    maxXp = calculateMaxXPForLevel();
    callSnackBar(context, 4000, headline: 'Leveled Up', content: 'New items unlocked', isError: false, color: ColorTheme.black);
  }

  playerMap().update('xp', (value) => xp);
  playerMap().update('account_lvl', (value) => accountLevel);

  storage.setItem('player', playerMap());

  return [xp, maxXp, accountLevel, value];
}