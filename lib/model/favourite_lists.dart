import 'package:flutter/cupertino.dart';
import 'package:pokedex/database/favourite_list_db.dart';
import 'package:pokedex/database/model/favourites.dart';
import 'package:pokedex/model/pokemon_model.dart';

class FavouriteLists extends ChangeNotifier {
  final favouriteDb = FavouriteListDb.instance;

  final Map<String, Pokemon> favouritePokemon = {};
  FavouriteLists({Key? key}) : super();

  void addToFavourite(String pokemonId, Pokemon pokemon) {
    try {
      favouritePokemon.addEntries([MapEntry(pokemonId, pokemon)]);
      favouriteDb.create(Favourite(
          id: pokemon.id,
          img: pokemon.img,
          name: pokemon.name,
          num: pokemon.num,
          nickname: '???'));
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  void removeFromFavourite(String pokemonId) {
    favouritePokemon.remove(pokemonId);
    favouriteDb.deleteFavorite(int.parse(pokemonId));
    notifyListeners();
  }

  bool isFavourite(String pokemonId) {
    return favouritePokemon.containsKey(pokemonId);
  }

  get favouritePokemonList => favouritePokemon.keys.toList();
}
