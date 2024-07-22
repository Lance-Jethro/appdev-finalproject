import 'package:pizza_app/barrel.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Map<String, dynamic>> _cartPizzas = [];
  List<bool> _selected = [];

  @override
  void initState() {
    super.initState();
    _loadCartedPizzas();
  }

  _loadCartedPizzas() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? addedCartPizzasData = prefs.getStringList('cartedPizzas');
    if (addedCartPizzasData != null) {
      setState(() {
        _cartPizzas = addedCartPizzasData
            .map((pizza) => Map<String, dynamic>.from(json.decode(pizza)))
            .toList();
        _selected = List<bool>.filled(_cartPizzas.length, false);
      });
    }
  }

  void _removeFromCart(String title) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final addedCartPizzasData = prefs.getStringList('cartedPizzas') ?? [];
    addedCartPizzasData
        .removeWhere((item) => json.decode(item)['title'] == title);
    prefs.setStringList('cartedPizzas', addedCartPizzasData);
    setState(() {
      _cartPizzas.removeWhere((pizza) => pizza['title'] == title);
      _selected = List<bool>.filled(_cartPizzas.length, false);
    });
  }

  double _calculateTotalPrice() {
    double total = 0.0;
    for (int i = 0; i < _cartPizzas.length; i++) {
      if (_selected[i]) {
        final price = _cartPizzas[i]['price'] as Map<String, dynamic>;
        total += price['S']; // Assuming default size 'S'. Adjust as needed.
      }
    }
    return total;
  }

  void _orderPizzas() {
    // Handle order logic here
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Order placed successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _cartPizzas.length,
              itemBuilder: (context, index) {
                final pizza = _cartPizzas[index];
                return Row(
                  children: [
                    Checkbox(
                      value: _selected[index],
                      onChanged: (bool? value) {
                        setState(() {
                          _selected[index] = value!;
                        });
                      },
                    ),
                    Expanded(
                      child: PizzaTiles(
                        leading: pizza['leading'],
                        title: pizza['title'],
                        subtitle: pizza['subtitle'],
                        price: Map<String, double>.from(pizza['price']),
                        isFavorite: true,
                        showFave: false,
                        removeFave: () => _removeFromCart(pizza['title']),
                        key: ValueKey(pizza['title']),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Total: ₱${_calculateTotalPrice().toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: _orderPizzas,
                  child: const Text('Order Now'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
