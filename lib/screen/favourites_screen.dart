import 'package:flutter/material.dart';
import 'package:pokedex/model/favourite_lists.dart';
import 'package:provider/provider.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FavouriteLists favouriteLists = Provider.of<FavouriteLists>(context);

    if (favouriteLists.favouritePokemonList.isEmpty) {
      return const Scaffold(body: Center(child: Text('no favourties')));
    }

    return Scaffold(
      body: Center(
        child: Text(favouriteLists.favouritePokemonList.length.toString()),
      ),
    );
  }
}
