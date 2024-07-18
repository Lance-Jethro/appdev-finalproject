import 'package:pizza_app/barrel.dart';

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({super.key});

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  final _key = GlobalKey<FormState>();
  bool _isChecked = false;
  bool _obscureText = true;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();

  final FirebaseAuth _authentication = FirebaseAuth.instance;

  String? errorMessage;

  Future<void> _login(String email, String password) async {
    try {
      await _authentication.signInWithEmailAndPassword(
          email: email, password: password);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login Successful!'),
          duration: Duration(seconds: 2),
        ),
      );
      Future.delayed(const Duration(seconds: 2), () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const MyHomePage(),
          ),
        );
      });
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException: ${e.code}'); // log error code

      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'No user found for that email.';
          break;
        case 'invalid-credential':
          errorMessage = 'Invalid credentials.';
          break;
        case 'user-disabled':
          errorMessage = 'User disabled.';
          break;
        case 'too-many-requests':
          errorMessage = 'Too many requests. Try again later.';
          break;
        default:
          errorMessage = 'An error occurred. Please try again.';
          break;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage!),
          duration: const Duration(seconds: 4),
        ),
      );
    } catch (e) {
      print('Exception: $e'); // log other exceptison
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred. Please try again.'),
          duration: Duration(seconds: 4),
        ),
      );
    }
  }

  String? _emailValidator(String? email) {
    if (email == null || email.isEmpty) {
      return 'Please enter your email.';
    } else if (!RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(email)) {
      return 'Please enter a valid email.';
    }
    return null;
  }

  String? _pwValidator(String? password) {
    if (password == null || password.isEmpty) {
      return 'Please enter your password.';
    } else if (!RegExp(
            r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$')
        .hasMatch(password)) {
      return 'Please enter at least 8 characters, containing 1 special character, 1 uppercase letter, and 1 number.';
    }
    return null;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _pwController.dispose();
    super.dispose();
  }

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _onCheckBoxChanged(bool? value) {
    setState(() {
      _isChecked = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Log In Page'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Container(
            height: 490,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.grey,
                width: 0.1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 7,
                  blurRadius: 10,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Form(
                key: _key,
                child: Column(
                  children: [
                    LoginTextFields(
                      emailController: _emailController,
                      passwordController: _pwController,
                      emailValidator: _emailValidator,
                      passwordValidator: _pwValidator,
                      obscureText: _obscureText,
                      toggleObscureText: _toggleObscureText,
                      isChecked: _isChecked,
                      onCheckBoxChanged: _onCheckBoxChanged,
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 800,
                      height: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          elevation: 5.0,
                          textStyle: const TextStyle(fontSize: 20),
                          shape: const BeveledRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.zero),
                          ),
                        ),
                        onPressed: () {
                          if (_key.currentState!.validate()) {
                            _login(_emailController.text, _pwController.text);
                          }
                        },
                        child: const Text('Log In'),
                      ),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: 800,
                      height: 40,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.mail),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          elevation: 5.0,
                          textStyle: const TextStyle(fontSize: 20),
                          shape: const BeveledRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.zero),
                          ),
                        ),
                        onPressed: () {
                          // Google sign in logic
                        },
                        label: const Text('Sign In with Google'),
                      ),
                    ),
                    const SizedBox(height: 40),
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Don\'t have an account? ',
                            style: TextStyle(color: Colors.black),
                          ),
                          TextSpan(
                            text: 'Register.',
                            style: const TextStyle(color: Colors.blue),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const MyRegistrationPage(),
                                  ),
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
