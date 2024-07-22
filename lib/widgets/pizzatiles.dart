// ignore_for_file: use_build_context_synchronously

import 'package:pizza_app/barrel.dart';

class PizzaTiles extends StatefulWidget {
  const PizzaTiles({
    super.key,
    required this.title,
    required this.leading,
    required this.subtitle,
    required this.price,
    this.isFavorite = false,
    this.showFave = true,
    this.removeFave,
  });

  final String title;
  final String leading;
  final String subtitle;
  final Map<String, double> price;
  final bool isFavorite;
  final bool showFave;
  final VoidCallback? removeFave;

  @override
  State<PizzaTiles> createState() => _PizzaTilesState();
}

class _PizzaTilesState extends State<PizzaTiles> {
  String _selectedSize = 'S';
  late double _currentPrice;
  late bool _isFavorited;

  @override
  void initState() {
    super.initState();
    _currentPrice = widget.price[_selectedSize]!;
    _isFavorited = widget.isFavorite;
    if (!widget.isFavorite) {
      _loadFavoriteStatus();
    }
  }

  void _updateSize(String size) {
    setState(() {
      _selectedSize = size;
      _currentPrice = widget.price[size]!;
    });
  }

  void _toggleFavorite() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final pizza = {
      'title': widget.title,
      'leading': widget.leading,
      'subtitle': widget.subtitle,
      'price': widget.price,
    };

    setState(() {
      _isFavorited = !_isFavorited;
    });

    if (_isFavorited) {
      final favoritePizzas = prefs.getStringList('favoritePizzas') ?? [];
      favoritePizzas.add(json.encode(pizza));
      prefs.setStringList('favoritePizzas', favoritePizzas);
    } else {
      final favoritePizzas = prefs.getStringList('favoritePizzas') ?? [];
      favoritePizzas
          .removeWhere((item) => json.decode(item)['title'] == widget.title);
      prefs.setStringList('favoritePizzas', favoritePizzas);
    }
  }

  void _loadFavoriteStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final favoritePizzas = prefs.getStringList('favoritePizzas') ?? [];
    setState(() {
      _isFavorited = favoritePizzas
          .any((item) => json.decode(item)['title'] == widget.title);
    });
  }

  void _removeFromFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final favoritePizzas = prefs.getStringList('favoritePizzas') ?? [];
    favoritePizzas
        .removeWhere((item) => json.decode(item)['title'] == widget.title);
    prefs.setStringList('favoritePizzas', favoritePizzas);

    setState(() {
      _isFavorited = false;
    });

    if (widget.removeFave != null) {
      widget.removeFave!();
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${widget.title} removed from favorites.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(8.0),
          leading: CircleAvatar(
            backgroundImage: AssetImage(widget.leading),
            radius: 30,
          ),
          title: Text(
            widget.title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.subtitle,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                '₱${_currentPrice.toStringAsFixed(2)}',
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: widget.price.keys.map(
                    (size) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: ElevatedButton(
                          onPressed: () => _updateSize(size),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _selectedSize == size
                                ? const Color.fromARGB(255, 255, 205, 39)
                                : const Color.fromARGB(255, 233, 231, 231),
                          ),
                          child: Text(size),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
            ],
          ),
          trailing: SizedBox(
            width: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!widget.showFave)
                  IconButton(
                    onPressed: _removeFromFavorites,
                    icon: const Icon(Icons.delete),
                  ),
                if (widget.showFave)
                  IconButton(
                    icon: Icon(
                      _isFavorited ? Icons.star : Icons.star_border,
                      color: _isFavorited ? Colors.yellow : Colors.grey,
                    ),
                    onPressed: _toggleFavorite,
                  ),
                IconButton(
                  icon: const Icon(Icons.shopping_cart),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
