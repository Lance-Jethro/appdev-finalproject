import 'package:pizza_app/barrel.dart';

class MySplashScreen extends StatelessWidget {
  const MySplashScreen({super.key});

  get splash => null;

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Center(
        // child: Lottie.asset('assets/lottie/Animation1721295704296.json'),
        child: Image.asset('assets/images/doughdash_logo.png'),
      ),
      splashIconSize: 200,
      nextScreen: const MyLoginPage(),
      backgroundColor: Colors.orange,
      splashTransition: SplashTransition.fadeTransition,
      animationDuration: const Duration(seconds: 2),
    );
  }
}
