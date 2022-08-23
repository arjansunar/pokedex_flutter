import 'package:flutter/material.dart';
import 'package:pokedex/database/favourite_list_db.dart';
import 'package:pokedex/database/model/favourites.dart';
import 'package:pokedex/model/favourite_lists.dart';
import 'package:pokedex/model/pokemon_model.dart';
import 'package:pokedex/theme/TextStyle.dart';
import 'package:provider/provider.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  final FavouriteListDb favouriteDb = FavouriteListDb.instance;
  List<Favourite> favouritesPokemon = [];
  String nickName = '';
  final TextEditingController _nickname = TextEditingController();

  void _getFavouriteListFromDb() async {
    var favourites = await favouriteDb.readFavourites();
    setState(() {
      favouritesPokemon = favourites;
    });
  }

  Future _openEditView(Favourite pokemon) async {
    _nickname.text = pokemon.nickname;

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _nickname,
                  decoration: const InputDecoration(labelText: 'Nickname'),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    _editNickName(pokemon, _nickname.text);
                    Navigator.pop(ctx);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.redAccent,
                  ),
                  child: const Text('Update'),
                )
              ],
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    _getFavouriteListFromDb();
  }

  void _editNickName(Favourite favourite, String newNickName) async {
    await favouriteDb.updateFavourites(favourite, newNickName);
    _getFavouriteListFromDb();
  }

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

  Widget _pokemonListItem(BuildContext context, Favourite pokemon) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      leading: Image.network(pokemon.img),
      title: Text(pokemon.name),
      subtitle: Text(pokemon.nickname),
      trailing: Wrap(children: [
        IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () {
            _openEditView(pokemon);
          },
        ),
        IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            Provider.of<FavouriteLists>(context, listen: false)
                .removeFromFavourite(pokemon.id.toString());
          },
        ),
      ]),
    );
  }

  Widget _getBody(
      BuildContext context, Map<String, Pokemon> favouritePokemonMap) {
    if (favouritesPokemon.isEmpty) {
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
                itemBuilder: ((context, index) =>
                    _pokemonListItem(context, favouritesPokemon[index])),
                itemCount: favouritePokemonMap.length),
          ),
        ],
      ),
    );
  }
}
