import 'package:pizza_app/barrel.dart';

class PizzaOrderPage extends StatelessWidget {
  const PizzaOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Pizza pizza = Pizza();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Pizza'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FavoritesPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: pizza.pizzaNames.length,
        itemBuilder: (context, index) {
          return PizzaTiles(
            title: pizza.pizzaNames[index],
            leading: pizza.images[index],
            subtitle: pizza.info[index],
            price: pizza.price[index],
          );
        },
      ),
    );
  }
}
