import 'package:flutter/cupertino.dart';

class FavouriteLists extends ChangeNotifier {
  final Map<String, bool> favouritePokemon = {};
  FavouriteLists({Key? key}) : super();

  void addToFavourite(String pokemonId) {
    try {
      favouritePokemon.addEntries([MapEntry(pokemonId, true)]);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  void removeFromFavourite(String pokemonId) {
    favouritePokemon.remove(pokemonId);
    notifyListeners();
  }

  bool isFavourite(String pokemonId) {
    return favouritePokemon.containsKey(pokemonId);
  }

  get favouritePokemonList => favouritePokemon.keys.toList();
}
