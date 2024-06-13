import 'dart:math';
import 'package:corpo/common/enums/enums.dart';
import 'package:corpo/common/hitman_data_sets/hitman_attributes.dart';
import 'package:corpo/common/hitman_data_sets/hitman_first_names.dart';
import 'package:corpo/models/hitmen/hitman_model.dart';
import 'package:corpo/common/hitman_data_sets/hitman_positive_quirks.dart';
import 'package:flutter/cupertino.dart';
import '../../common/hitman_data_sets/hitman_last_names.dart';
import '../../common/hitman_data_sets/hitman_negative_quirks.dart';
import '../../common/hitman_data_sets/hitman_skills.dart';

Map<String, dynamic> getHitmanData({required typeOfTier tier}){

  // Get the first name
  int fNameIndex = Random().nextInt(hitmanFirstNames.length);
  String firstName = hitmanFirstNames[fNameIndex];

  // Get the last name
  int lNameIndex = Random().nextInt(hitmanLastNames.length);
  String lastName = hitmanLastNames[lNameIndex];

  // Get the architype
  int skillIndex = Random().nextInt(hitmanSkills.length);
  Map<String, dynamic> skill = hitmanSkills[skillIndex];
  HitmanSkills skills = HitmanSkills.fromJson(skill);

  // Get the hitman data
  Map<String, dynamic> hitmanData = {};
  hitmanData["name"]        = firstName + " " + lastName;
  hitmanData["architype"]   = skills.archetype;
  hitmanData["skills"]      = getSkillsBasedOnTier(tier: tier, skill: skills.name);
  hitmanData["quirks"]      = getQuirksBasedOnTier(tier: tier);
  hitmanData["rank"]        = tier.name[0];
  hitmanData["attributes"]  = assignAttributes(tier: tier, list: skills.attributes!);

  debugPrint("hitmanData :: " + hitmanData.toString());

  return hitmanData;
}

Map<String, dynamic> assignAttributes({required typeOfTier tier, required List<Attributes> list}){

  int min = 0, max = 0;
  int noOfWeakAttributes = 0, weakAttribute = 0;

  switch(tier){
    case typeOfTier.STier: {
      min = 20;  max = 35;
      noOfWeakAttributes = 0;
      break;
    }
    case typeOfTier.ATier: {
      min = 16;  max = 25;
      noOfWeakAttributes = 1; weakAttribute = 4;
      break;
    }
    case typeOfTier.BTier: {
      min = 10;  max = 20;
      noOfWeakAttributes = 1; weakAttribute = 4;
      break;
    }
    case typeOfTier.CTier: {
      min = 7;  max = 15;
      noOfWeakAttributes = 2; weakAttribute = 4;
      break;
    }
    case typeOfTier.DTier: {
      min = 3;  max = 8;
      noOfWeakAttributes = 3; weakAttribute = 6;
      break;
    }
  }

  var random = Random();
  Map<String, dynamic> attributes = {};

  int index = 0;
  List<String> tempAttributes = [];

  tempAttributes.addAll(hitmanAttributes);
  tempAttributes.shuffle();
  tempAttributes.sublist(0, noOfWeakAttributes);

  debugPrint("unlucky attribute :: " + hitmanAttributes[index]);

  for (var attribute in hitmanAttributes) {
    int value = 0;
    if(attribute == "STR"){value = value + (list.map((e) => e.STR).first ?? 0);}
    if(attribute == "STL"){value = value + (list.map((e) => e.STL).first ?? 0);}
    if(attribute == "HCK"){value = value + (list.map((e) => e.HCK).first ?? 0);}
    if(attribute == "INT"){value = value + (list.map((e) => e.INT).first ?? 0);}
    if(attribute == "CMB"){value = value + (list.map((e) => e.CMB).first ?? 0);}
    if(attribute == "AGI"){value = value + (list.map((e) => e.AGI).first ?? 0);}
    if(attribute == "PER"){value = value + (list.map((e) => e.PER).first ?? 0);}
    if(attribute == "END"){value = value + (list.map((e) => e.END).first ?? 0);}

    bool isStrongAttribute = false;
    if(list.map((e) => e.STR).first != null){isStrongAttribute = true;}
    if(list.map((e) => e.STL).first != null){isStrongAttribute = true;}
    if(list.map((e) => e.HCK).first != null){isStrongAttribute = true;}
    if(list.map((e) => e.INT).first != null){isStrongAttribute = true;}
    if(list.map((e) => e.CMB).first != null){isStrongAttribute = true;}
    if(list.map((e) => e.PER).first != null){isStrongAttribute = true;}
    if(list.map((e) => e.END).first != null){isStrongAttribute = true;}

    if(!isStrongAttribute){if(tempAttributes.contains(attribute)){value = value - random.nextInt(weakAttribute);}}

    int finalValue = min + random.nextInt(max - min + 1) + value;
    if(finalValue >= 0){ attributes[attribute] = finalValue;}
    else {attributes[attribute] = 1;}
  }

  return attributes;

}

List getSkillsBasedOnTier({required typeOfTier tier, required String? skill}){
  int noOfSkills = 0, skillIndex = 0;
  List skills = [], tempSkills = [];
  tempSkills.addAll(hitmanSkills.map((e) => e["name"]).toList());
  skills.add(skill);

  tempSkills.removeWhere((item) => skill!.contains(item));

  switch(tier){
    case typeOfTier.STier:  noOfSkills = 2; break;
    case typeOfTier.ATier:  noOfSkills = 2; break;
    case typeOfTier.BTier:  noOfSkills = 2; break;
    case typeOfTier.CTier:  noOfSkills = 1; break;
    case typeOfTier.DTier:  noOfSkills = 1; break;
  }

  for(int i=0; i < noOfSkills; i++){
    skillIndex = Random().nextInt(tempSkills.length);
    skills.add(tempSkills[skillIndex]);
    tempSkills.removeAt(skillIndex);
  }

  return skills;
}

List<String> getQuirksBasedOnTier({required typeOfTier tier}){
  int noOfQuirks = 0;
  Random random = Random();
  int min = 0, max = 0;

  switch(tier){
    case typeOfTier.STier:  {
      min = 5; max = 5;
      break;
    }
    case typeOfTier.ATier:  {
      min = 4; max = 6;
      break;
    }
    case typeOfTier.BTier:  {
      min = 3; max = 5;
      break;
    }
    case typeOfTier.CTier:  {
      min = 2; max = 4;
      break;
    }
    case typeOfTier.DTier:  {
      min = 2; max = 3;
      break;
    }
  }

  noOfQuirks = min + random.nextInt(max - min + 1);

  List<String> quirks = [];
  int index = 0;

  List<Map<String, dynamic>> allQuirks = [];
  allQuirks.addAll(hitmanPositiveQuirks + hitmanNegativeQuirks);
  allQuirks.shuffle();

  for(int i=0; i < noOfQuirks; i++){
    index = Random().nextInt(allQuirks.length);
    quirks.add(allQuirks[index]["name"]);
    allQuirks.removeAt(index);
  }

  return quirks;
}