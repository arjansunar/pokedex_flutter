import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return    Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column( 
          children: [
        SizedBox(height: MediaQuery.of(context).viewPadding.top,),
        const SizedBox(height: 20,),
        Row(
          children: [
            Text('Pokédex', style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.values[8],
              letterSpacing: 4.0,
              fontFamily: GoogleFonts.openSans(fontWeight: FontWeight.bold).fontFamily
            ),),
          ],
        ),
        const SizedBox(height: 8,),
        Row(
          children: [
            Text('Search for a pokemon by name', 
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.values[4],
                fontFamily: GoogleFonts.openSans(fontWeight: FontWeight.bold).fontFamily
              ),),
          ],
        ),
        const SizedBox(height: 8,),

        const TextField(
          decoration: InputDecoration(
            labelText: 'Search',
            prefixIcon: Icon(Icons.search),
          ),
        ),
        const SizedBox(height: 20,),
        // grid of pokemon

            
        Expanded(
          child: GridView.count( 
            padding: const EdgeInsets.all(10),
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            children: [
            for (int i = 0; i < 10; i++)
            const Card(child: Center(child: Text('Poke')),)
          ],),
        ),
        ],),
      ),
    );
  }
}
