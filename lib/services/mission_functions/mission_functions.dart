
import 'dart:math';

import 'package:corpo/common/mission_data_sets/mission_stages.dart';
import 'package:flutter/material.dart';

import '../../common/mission_data_sets/mission_events.dart';
import '../../common/mission_data_sets/mission_type.dart';
import '../../models/mission/mission_models.dart';

Map<String, dynamic> getMission(){

  // Get the mission type
  int missionIndex = Random().nextInt(missionTypes.length);
  Map<String, dynamic> mission = missionTypes[missionIndex];

  // Get mission stages
  List<Map<String, dynamic>> stages = [];
  for(int i=0; i < missionStages.length; i++){
    Map<String, dynamic> stage = {};
    if(missionStages[i]["mission"].contains(mission["name"])){
      stage = missionStages[i];
      for(int j=0; i < missionEvents.length; i++){
        if(missionEvents[j]["stage"].contains(missionStages[j]["name"])){
          stage["events"] = missionEvents[j];
        }
      }
      stages.add(stage);
    }
  }

  // Mission
  Map<String, dynamic> missionData = {};
  missionData["name"]           = mission;
  missionData["stages"]         = stages;

  debugPrint("missionData :: " + missionData.toString());

  return missionData;
}
