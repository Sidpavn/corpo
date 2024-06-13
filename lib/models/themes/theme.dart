
import 'dart:ui';

class ColorTheme {
  // Accent
  static Color white        = const Color(0xffEFE8E8);
  static Color creme        = const Color(0xffDDD5C9);
  static Color black        = const Color(0xff060606);
  static Color grey         = const Color(0xff3D3B3B);
  static Color lightGrey    = const Color(0xffC2C2C2);
  static Color red          = const Color(0xffF35454);
  static Color darkRed      = const Color(0xffD1351F);
  static Color amber        = const Color(0xffF1AE87);
  static Color brown        = const Color(0xffC3B8A1);
  static Color yellow       = const Color(0xfff2e152);
  static Color sky          = const Color(0xffE4EBEC);
  static Color blue         = const Color(0xff81BAEE);
  static Color mutedAmber   = const Color(0xffF19753);
  static Color neonGreen    = const Color(0xff6ee833);
  static Color green        = const Color(0xff8DEE81);
  static Color camo         = const Color(0xff578053);
  static Color purple       = const Color(0xff9351E8);
  static Color pink         = const Color(0xffDD5CE1);
  static Color darkAmber    = const Color(0xffFA7D21);
  // Rarity
  static Color common       = const Color(0xff929797);
  static Color uncommon     = const Color(0xff6CA977);
  static Color rare         = const Color(0xff54A2A4);
  static Color epic         = const Color(0xff9771B9);
  static Color legendary    = const Color(0xffD18E34);
  static Color mystic       = const Color(0xffC1C14F);
  static Color exotic       = const Color(0xffCB4F4F);

  static Color material     = const Color(0xffC2DEE2);
}

Color getColor(String rarity){
  Color color = const Color(0xff929797);
  switch(rarity){
    // Rarity
    case "common":        {  color = ColorTheme.common;       break; }
    case "uncommon":      {  color = ColorTheme.uncommon;     break; }
    case "rare":          {  color = ColorTheme.rare;         break; }
    case "epic":          {  color = ColorTheme.epic;         break; }
    case "legendary":     {  color = ColorTheme.legendary;    break; }
    case "mystic":        {  color = ColorTheme.mystic;       break; }
    case "exotic":        {  color = ColorTheme.exotic;       break; }
  }
  return color;
}