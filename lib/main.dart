import 'package:pizza_app/screens/orderpage.dart';
import 'package:pizza_app/screens/splashscreen.dart';

import 'barrel.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => PizzaOrderPage(pizza: Pizza()),
        '/login': (context) => const MyLoginPage(),
        '/register': (context) => const MyRegistrationPage(),
        '/homepage': (context) => const MyHomePage(),
        // '/orderpage': (context) => PizzaOrderPage(
        //       pizza: Pizza(),
        //     ),
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const PizzaOrderPage(),
    );
  }
}
