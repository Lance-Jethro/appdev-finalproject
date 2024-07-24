import 'package:pizza_app/barrel.dart';

class orderBody extends StatelessWidget {
  const orderBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Pizza pizza = Pizza();

    return Scaffold(
      body: ListView.builder(
        itemCount: pizza.pizzaNames.length,
        itemBuilder: (context, index) {
          return PizzaTiles(
            title: pizza.pizzaNames[index],
            leading: pizza.images[index],
            subtitle: pizza.info[index],
            price: pizza.price[index],
            addToCart: () {
              // Implement addToCart functionality here if needed
            },
          );
        },
      ),
    );
  }
}
