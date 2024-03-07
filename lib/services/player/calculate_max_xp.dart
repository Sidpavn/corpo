import 'package:corpo/models/player/player.dart';

int calculateMaxXPForLevel(){
  int maxXp = 0, baseXP = 500;
  double growthFactor = 1.5;
  maxXp = (baseXP * (growthFactor * playerInfo().accountLvl!)).ceil();
  return maxXp;
}
