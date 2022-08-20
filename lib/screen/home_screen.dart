import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex/api_service/http_service.dart';
import 'package:pokedex/model/pokemon_model.dart';
import 'package:pokedex/screen/pokemon_detail_screen.dart';
import 'package:pokedex/theme/TextStyle.dart';
import 'package:pokedex/theme/colors.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HttpService httpService = HttpService();

  List<Pokemon> _pokemonList = [];

  List<Pokemon> _filteredPokemonList = [];

  @override
  void initState() {
    super.initState();
    initValues();
  }

  void initValues() async {
    var res = await httpService.getPokemon();
    setState(() {
      _pokemonList = res;
      _filteredPokemonList = res;
    });
  }

  void handleSearchPokemon(String searchName) {
    var searchRes = getPokemonByName(searchName);

    setState(() {
      _filteredPokemonList = searchRes;
    });
  }

  List<Pokemon> getPokemonByName(String name) {
    return _pokemonList
        .where(
          (pokemon) => pokemon.name.toLowerCase().contains(name.toLowerCase()),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text('Pokédex', style: ThemeTextStyles.mainTextStyle),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Text(
                  'Search for a pokemon by name',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.values[4],
                      fontFamily:
                          GoogleFonts.openSans(fontWeight: FontWeight.bold)
                              .fontFamily),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),

            TextField(
              decoration: const InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (String value) {
                handleSearchPokemon(value);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            // grid of pokemon
            _pokemonList.isEmpty
                ? const CircularProgressIndicator()
                : Expanded(
                    child: GridView.count(
                      padding: const EdgeInsets.all(10),
                      mainAxisSpacing: 10,
                      crossAxisCount: 2,
                      children: [
                        for (var pokemon in _filteredPokemonList)
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => PokemonDetailScreen(
                                          pokemon: pokemon,
                                        )),
                              );
                            },
                            child: Card(
                              color: PokeColors.getColor(pokemon),
                              child: Image.network(
                                pokemon.img,
                                height: 20,
                                alignment: Alignment.center,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
