import 'dart:convert';

import 'package:http/http.dart';
import 'package:pokedex/model/pokemon_model.dart';

class HttpService {
  HttpService();
  final pokemonListUrl = Uri.https('raw.githubusercontent.com',
      '/Biuni/PokemonGO-Pokedex/master/pokedex.json');
  final pokeDescUrl =
      Uri(scheme: 'https', host: 'pokeapi.co', path: '/api/v2/characteristic/');

  Future<List<Pokemon>> getPokemon() async {
    Response res = await get(pokemonListUrl);
    if (res.statusCode == 200) {
      final body = json.decode(res.body);
      final pokemonList = body['pokemon'];
      return List<Pokemon>.from(
          pokemonList.map((pokemon) => Pokemon.fromJson(pokemon)).toList());
    } else {
      throw 'Failed to load pokemon list';
    }
  }

  Future<String> getPokemonDescription(int id) async {
    Response res =
        await get(Uri.https('pokeapi.co', '/api/v2/characteristic/$id'));

    if (res.statusCode == 200) {
      var body = json.decode(res.body);
      var desc = PokemonCharsDesc.fromJson(body);

      return desc.descriptions
          .firstWhere((element) => element.language.name == 'en')
          .description;
    } else {
      // show error
      return 'No description';
    }
  }
}
