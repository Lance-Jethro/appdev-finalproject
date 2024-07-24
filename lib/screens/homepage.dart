import 'package:pizza_app/barrel.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0;

  final List<Widget> _screen = [
    Homebody(),
    orderBody(),
    favoriteBody(),
  ];

  void onDrawerItemTap(int index) {
    setState(() {
      currentIndex = index;
    });
    Navigator.pop(context); // Close the drawer after navigation
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: Text(
          "DoughDash",
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "/cartpage");
            },
            icon: Icon(Icons.shopping_cart_checkout),
          )
        ],
      ),
      drawer: DrawerWidget(
        currentIndex: currentIndex,
        onDrawerItemTap: onDrawerItemTap,
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.red,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.local_pizza),
            label: 'Menu',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
        ],
        onDestinationSelected: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
        selectedIndex: currentIndex,
      ),
      body: _screen[currentIndex],
    );
  }
}
