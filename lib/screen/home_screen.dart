import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex/api_service/http_service.dart';
import 'package:pokedex/model/pokemon_model.dart';
import 'package:pokedex/screen/pokemon_detail_screen.dart';
import 'package:pokedex/theme/colors.dart';

class HomeScreen extends StatelessWidget {
  final List<Pokemon> _pokemonList = HttpService.getPokemon();

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).viewPadding.top,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  'Pokédex',
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.values[8],
                      letterSpacing: 4.0,
                      fontFamily:
                          GoogleFonts.openSans(fontWeight: FontWeight.bold)
                              .fontFamily),
                ),
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

            const TextField(
              decoration: InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            // grid of pokemon

            Expanded(
              child: GridView.count(
                padding: const EdgeInsets.all(10),
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                children: [
                  for (var pokemon in _pokemonList)
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
                        color: pokemon.type.contains('Fire')
                            ? PokeColors.pokeColors['red']
                            : pokemon.type.contains('Water')
                                ? PokeColors.pokeColors['blue']
                                : pokemon.type.contains('Grass')
                                    ? PokeColors.pokeColors['green']
                                    : PokeColors.pokeColors['yellow'],
                        child: Image.network(
                          height: 20,
                          pokemon.img,
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
