import 'package:corpo/models/items/basic_cards/basic_cards.dart';

List<Map<String, dynamic>> getAllCards(){
  List<Map<String, dynamic>> allCards = [];
  allCards.addAll(basicCards);

  return allCards;
}
