import 'package:pizza_app/barrel.dart';

class MySplashScreen extends StatelessWidget {
  const MySplashScreen({super.key});

  get splash => null;

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Center(
        child: Lottie.asset('../Animation1721295704296.json'),
      ),
      splashIconSize: 200,
      nextScreen: const MyLoginPage(),
      backgroundColor: Colors.blueAccent,
      splashTransition: SplashTransition.fadeTransition,
      animationDuration: const Duration(seconds: 2),
    );
  }
}
