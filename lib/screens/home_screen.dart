import 'package:chef_recipes/screens/categories.dart';
import 'package:chef_recipes/screens/countries.dart';
import 'package:chef_recipes/screens/home_page.dart';
import 'package:chef_recipes/screens/meals.dart';
import 'package:chef_recipes/screens/profile.dart';
import 'package:chef_recipes/services/themeProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _selectedScreen = [
    const HomePage(),
    Categories(),
    Countries(),
    profile(),
  ];

  int selectedIndex = 0;
  bool _isLoading = true;
  @override
  Widget build(BuildContext context) {
    bool _isdark = Provider.of<ThemeProvider>(context).getDarkmode;

    final size = MediaQuery.of(context).size;

    return Scaffold(
      bottomNavigationBar: BottomNaviBar(),
      body: _selectedScreen[selectedIndex],
    );
  }

  // ignore: non_constant_identifier_names
  BottomNavigationBar BottomNaviBar() {
    return BottomNavigationBar(
      fixedColor: Color(0xFF4caf53),
      elevation: 0,
      onTap: (value) {
        setState(() {
          selectedIndex = value;
          // print(value);
        });
      },
      type: BottomNavigationBarType.fixed,
      currentIndex: selectedIndex,
      iconSize: 30,
      showUnselectedLabels: false,
      showSelectedLabels: true,
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
            backgroundColor: Color(0xFF4caf53)),
        BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: "Categories",
            backgroundColor: Color(0xFF4caf53)),
        BottomNavigationBarItem(
            icon: Icon(Icons.flag),
            label: "Countries",
            backgroundColor: Color(0xFF4caf53)),
        BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Setting",
            backgroundColor: Color(0xFF4caf53)),
      ],
    );
  }
}
