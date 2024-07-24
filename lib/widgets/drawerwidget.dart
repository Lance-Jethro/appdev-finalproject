import 'package:pizza_app/barrel.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    super.key,
    required this.currentIndex,
    required this.onDrawerItemTap,
  });

  final int currentIndex;
  final Function(int) onDrawerItemTap;

  Future<void> _logout(BuildContext context) async {
    // Show confirmation dialog
    bool confirmLogout = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Logout"),
          content: const Text("Are you sure you want to logout?"),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop(false); // Return false on cancel
              },
            ),
            TextButton(
              child: const Text("Logout"),
              onPressed: () {
                Navigator.of(context).pop(true); // Return true on confirm
              },
            ),
          ],
        );
      },
    );

    // Proceed with logout if confirmed
    if (confirmLogout) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear(); // Clear all stored preferences (like isLoggedIn)

      Navigator.pushReplacementNamed(context, "/");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.red,
      child: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          Column(
            children: [
              Container(
                height: 70,
                child: const DrawerHeader(
                  child: Text("Welcome!"), // Replace with actual user name
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                color: Colors.white,
                child: Column(
                  children: [
                    MyDrawerListTile(
                      leading: Icons.home,
                      text: "Home",
                      color: Colors.white,
                      onTapCallback: () {
                        onDrawerItemTap(0); // Navigate to Home screen
                      },
                    ),
                    MyDrawerListTile(
                      leading: Icons.local_pizza,
                      text: "Order",
                      color: Colors.white,
                      onTapCallback: () {
                        onDrawerItemTap(1); // Navigate to Order screen
                      },
                    ),
                    MyDrawerListTile(
                      leading: Icons.favorite,
                      text: "Favorite",
                      color: Colors.white,
                      onTapCallback: () {
                        onDrawerItemTap(2); // Navigate to Favorite screen
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .35,
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      color: Colors.red,
                      child: MyDrawerListTile(
                        leading: Icons.logout,
                        text: "Logout",
                        color: Colors.red,
                        onTapCallback: () {
                          _logout(context); // Call logout function
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
