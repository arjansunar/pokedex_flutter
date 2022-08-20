import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokedex/screen/favourites_screen.dart';
import 'package:pokedex/screen/home_screen.dart';

class AppRouter extends StatefulWidget {
  const AppRouter({Key? key}) : super(key: key);

  @override
  State<AppRouter> createState() => _AppRouterState();
}

class _AppRouterState extends State<AppRouter> {
  int _currentScreen = 0;
  static final List<Widget> _screens = [HomeScreen(), const FavouriteScreen()];
  void _updateScreen(int val) {
    setState(() {
      _currentScreen = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          systemOverlayStyle:
              const SystemUiOverlayStyle(statusBarColor: Colors.redAccent),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      body: _screens[_currentScreen],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentScreen,
          onTap: _updateScreen,
          elevation: 0,
          selectedItemColor: const Color.fromARGB(255, 199, 23, 23),
          selectedFontSize: 13,
          unselectedFontSize: 13,
          iconSize: 30,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: 'favorite')
          ]),
    );
  }
}
