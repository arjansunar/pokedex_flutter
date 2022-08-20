import 'package:flutter/cupertino.dart';
import 'package:pokedex/model/pokemon_model.dart';

class FavouriteLists extends ChangeNotifier {
  final Map<String, Pokemon> favouritePokemon = {};
  FavouriteLists({Key? key}) : super();

  void addToFavourite(String pokemonId, Pokemon pokemon) {
    try {
      favouritePokemon.addEntries([MapEntry(pokemonId, pokemon)]);
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
