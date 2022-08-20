import 'package:flutter/material.dart';
import 'package:pokedex/model/favourite_lists.dart';
import 'package:pokedex/model/pokemon_model.dart';
import 'package:pokedex/theme/TextStyle.dart';
import 'package:pokedex/theme/colors.dart';
import 'package:provider/provider.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FavouriteLists favouriteLists = Provider.of<FavouriteLists>(context);

    return Scaffold(body: _getBody(context, favouriteLists.favouritePokemon));
  }

  Widget _titleText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'Favourite',
          style: ThemeTextStyles.mainTextStyle,
        )
      ],
    );
  }

  Widget _pokemonListItem(BuildContext context, Pokemon pokemon) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      leading: Image.network(pokemon.img),
      title: Text(pokemon.name),
      subtitle: Text(pokemon.type.join(', ')),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          Provider.of<FavouriteLists>(context, listen: false)
              .removeFromFavourite(pokemon.id.toString());
        },
      ),
    );
  }

  Widget _getBody(
      BuildContext context, Map<String, Pokemon> favouritePokemonMap) {
    if (favouritePokemonMap.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            _titleText(),
            const Expanded(child: Center(child: Text('no favourites'))),
          ],
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          const SizedBox(height: 20),
          _titleText(),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
                itemBuilder: ((context, index) => _pokemonListItem(
                    context, favouritePokemonMap.values.toList()[index])),
                itemCount: favouritePokemonMap.length),
          ),
        ],
      ),
    );
  }
}
