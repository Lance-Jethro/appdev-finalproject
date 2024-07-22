// ignore_for_file: library_private_types_in_public_api

import 'package:pizza_app/barrel.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<Map<String, dynamic>> _favoritePizzas = [];

  @override
  void initState() {
    super.initState();
    _loadFavoritePizzas();
  }

  _loadFavoritePizzas() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favoritePizzasData = prefs.getStringList('favoritePizzas');
    if (favoritePizzasData != null) {
      setState(() {
        _favoritePizzas = favoritePizzasData
            .map((pizza) => Map<String, dynamic>.from(json.decode(pizza)))
            .toList();
      });
    }
  }

  void _removeFromFavorites(String title) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final favoritePizzasData = prefs.getStringList('favoritePizzas') ?? [];
    favoritePizzasData
        .removeWhere((item) => json.decode(item)['title'] == title);
    prefs.setStringList('favoritePizzas', favoritePizzasData);
    setState(() {
      _favoritePizzas.removeWhere((pizza) => pizza['title'] == title);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Pizzas'),
      ),
      body: ListView.builder(
        itemCount: _favoritePizzas.length,
        itemBuilder: (context, index) {
          final pizza = _favoritePizzas[index];
          return PizzaTiles(
            leading: pizza['leading'],
            title: pizza['title'],
            subtitle: pizza['subtitle'],
            price: Map<String, double>.from(pizza['price']),
            isFavorite: true,
            showFave: false,
            removeFave: () => _removeFromFavorites(pizza['title']),
            key: ValueKey(pizza['title']),
          );
        },
      ),
    );
  }
}
