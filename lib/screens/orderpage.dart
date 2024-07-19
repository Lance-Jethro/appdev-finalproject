import 'package:pizza_app/barrel.dart';

class PizzaOrderPage extends StatelessWidget {
  const PizzaOrderPage({
    super.key,
    required this.pizza,
  });

  final Pizza pizza;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Pizza'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: pizza.pizzaNames.length,
                itemBuilder: (context, index) {
                  return PizzaTiles(
                    leading: pizza.images[index],
                    title: pizza.pizzaNames[index],
                    subtitle: pizza.info[index],
                    price: pizza.price[index],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.local_pizza), label: 'Order'),
          NavigationDestination(icon: Icon(Icons.favorite), label: 'Favorites'),
        ],
      ),
    );
  }
}
