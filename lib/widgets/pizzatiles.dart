import 'package:flutter/material.dart';

class PizzaTiles extends StatefulWidget {
  const PizzaTiles({
    super.key,
    required this.title,
    required this.leading,
    required this.subtitle,
    required this.price,
  });

  final String title;
  final String leading;
  final String subtitle;
  final Map<String, double> price;

  @override
  State<PizzaTiles> createState() => _PizzaTilesState();
}

class _PizzaTilesState extends State<PizzaTiles> {
  String _selectedSize = 'S';
  late double _currentPrice;

  bool _favorited = false;

  @override
  void initState() {
    super.initState();
    _currentPrice = widget.price[_selectedSize]!;
  }

  void _updateSize(String size) {
    setState(() {
      _selectedSize = size;
      _currentPrice = widget.price[size]!;
    });
  }

  void _toggleFavorite() {
    setState(() {
      _favorited = !_favorited;
    });
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
                IconButton(
                  icon: Icon(_favorited ? Icons.star : Icons.star_border,
                      color: _favorited ? Colors.yellow : Colors.grey),
                  onPressed: () {
                    _toggleFavorite();
                  },
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
