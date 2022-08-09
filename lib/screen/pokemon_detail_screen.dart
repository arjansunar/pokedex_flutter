import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex/api_service/http_service.dart';

import 'package:pokedex/model/pokemon_model.dart';
import 'package:pokedex/theme/colors.dart';

class PokemonDetailScreen extends StatefulWidget {
  final Pokemon pokemon;

  const PokemonDetailScreen({Key? key, required this.pokemon})
      : super(key: key);

  @override
  State<PokemonDetailScreen> createState() => _PokemonDetailScreenState();
}

class _PokemonDetailScreenState extends State<PokemonDetailScreen> {
  final HttpService httpService = HttpService();

  String pokemonDesc = "";

  void initValues() async {
    var res = await httpService.getPokemonDescription(widget.pokemon.id);

    setState(() {
      pokemonDesc = res;
    });
  }

  @override
  void initState() {
    super.initState();
    initValues();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).viewPadding.top,
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: (() => Navigator.pop(context)),
                  icon: const Icon(Icons.arrow_back),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.2),
                  child: Column(
                    children: [
                      Text(
                        widget.pokemon.name,
                        style: TextStyle(
                          fontSize: 28,
                          color: Colors.black87,
                          fontWeight: FontWeight.values[6],
                          fontFamily:
                              GoogleFonts.openSans(fontWeight: FontWeight.bold)
                                  .fontFamily,
                        ),
                      ),
                      Text(
                        widget.pokemon.num,
                        style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 60.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: widget.pokemon.type.contains('Fire')
                      ? PokeColors.pokeColors['red']
                      : widget.pokemon.type.contains('Water')
                          ? PokeColors.pokeColors['blue']
                          : widget.pokemon.type.contains('Grass')
                              ? PokeColors.pokeColors['green']
                              : PokeColors.pokeColors['yellow']),
              child: Center(
                child: Image.network(
                  height: 260,
                  widget.pokemon.img,
                  alignment: Alignment.center,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                Text("Type:",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black87,
                      fontWeight: FontWeight.values[6],
                      fontFamily:
                          GoogleFonts.openSans(fontWeight: FontWeight.bold)
                              .fontFamily,
                    )),
                const SizedBox(
                  width: 20,
                ),
                Text(widget.pokemon.type.join(", "),
                    style: TextStyle(
                      fontSize: 20,
                      color: const Color.fromARGB(179, 0, 0, 0),
                      fontWeight: FontWeight.values[6],
                      fontFamily:
                          GoogleFonts.openSans(fontWeight: FontWeight.bold)
                              .fontFamily,
                    )),
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                Text("Description:",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black87,
                      fontWeight: FontWeight.values[6],
                      fontFamily:
                          GoogleFonts.openSans(fontWeight: FontWeight.bold)
                              .fontFamily,
                    )),
                const SizedBox(
                  width: 20,
                ),
                Text(pokemonDesc,
                    style: TextStyle(
                      fontSize: 20,
                      color: const Color.fromARGB(179, 0, 0, 0),
                      fontWeight: FontWeight.values[6],
                      fontFamily:
                          GoogleFonts.openSans(fontWeight: FontWeight.bold)
                              .fontFamily,
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
