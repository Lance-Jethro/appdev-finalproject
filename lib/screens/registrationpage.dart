// ignore_for_file: use_build_context_synchronously

import 'package:pizza_app/barrel.dart';

class MyRegistrationPage extends StatefulWidget {
  const MyRegistrationPage({super.key});

  @override
  State<MyRegistrationPage> createState() => _MyRegistrationPageState();
}

class _MyRegistrationPageState extends State<MyRegistrationPage> {
  final _signupKey = GlobalKey<FormState>();
  bool _obscureText = true;
  bool _isChecked = false;

  final TextEditingController _emailSignupController = TextEditingController();
  final TextEditingController _pwSignupController = TextEditingController();
  final TextEditingController _pwConfirmController = TextEditingController();
  String? emailSignupErrorText;
  String? pwSignupErrorText;
  String? pwConfirmErrorText;

  String? errorMessage;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _register(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Sign Up Successful!'),
          duration: Duration(seconds: 1),
        ),
      );
      Future.delayed(
        const Duration(seconds: 1),
        () async {
          Navigator.pop(
            context,
            MaterialPageRoute(
              builder: (context) => const MyLoginPage(),
            ),
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'weak-password':
          errorMessage = 'The password provided is too weak.';
          break;
        case 'email-already-in-use':
          errorMessage = 'The account already exists for that email.';
          break;
        case 'invalid-email':
          errorMessage = 'The email address is not valid.';
          break;
        case 'operation-not-allowed':
          errorMessage = 'Email/password accounts are not enabled.';
          break;
        default:
          errorMessage = 'An undefined error occurred: ${e.message}';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $errorMessage'),
          duration: const Duration(seconds: 4),
        ),
      );
    } catch (e) {
      errorMessage = 'An error occurred: $e';
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred. Please try again.'),
          duration: Duration(seconds: 4),
        ),
      );
    }
  }

  String? _emailSignupValidator(String? emailSignup) {
    if (emailSignup == null || emailSignup.isEmpty) {
      return 'Do not leave this field blank.';
    } else if (!RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(emailSignup)) {
      return 'Please enter a valid email.';
    }
    return null;
  }

  String? _pwSignUpValidator(String? pwSignup) {
    if (pwSignup == null || pwSignup.isEmpty) {
      return 'Please enter your password.';
    } else if (!RegExp(
            r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$')
        .hasMatch(pwSignup)) {
      return 'Please enter at least 8 characters, containing 1 special character, 1 uppercase letter, and 1 number.';
    }
    return null;
  }

  String? _pwConfirmValidator(String? pwConfirm) {
    if (pwConfirm == null || pwConfirm.isEmpty) {
      return 'Please enter confirmation password.';
    } else if (pwConfirm != _pwSignupController.text) {
      return 'Passwords do not match!';
    }
    return null;
  }

  @override
  void dispose() {
    _emailSignupController.dispose();
    _pwSignupController.dispose();
    _pwConfirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration Page'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: 500,
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
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: Form(
                      key: _signupKey,
                      child: Column(
                        children: [
                          RegistrationTextFields(
                            emailController: _emailSignupController,
                            passwordController: _pwSignupController,
                            confirmPasswordController: _pwConfirmController,
                            emailValidator: _emailSignupValidator,
                            passwordValidator: _pwSignUpValidator,
                            confirmPasswordValidator: _pwConfirmValidator,
                            obscureText: _obscureText,
                            toggleObscureText: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            isChecked: _isChecked,
                            onCheckBoxChanged: (value) {
                              setState(() {
                                _isChecked = value!;
                              });
                            },
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: 800,
                            height: 40,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.white,
                                shadowColor: Colors.green,
                                animationDuration:
                                    const Duration(milliseconds: 10000),
                                elevation: 10.0,
                                textStyle: const TextStyle(fontSize: 20),
                                shape: const BeveledRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.zero),
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  String? emailError = _emailSignupValidator(
                                      _emailSignupController.text);
                                  String? pwError = _pwSignUpValidator(
                                      _pwSignupController.text);
                                  String? pwConfirmError = _pwConfirmValidator(
                                      _pwConfirmController.text);
                                  emailSignupErrorText = emailError;
                                  pwSignupErrorText = pwError;
                                  pwConfirmErrorText = pwConfirmError;
                                });
                                if (_signupKey.currentState!.validate()) {
                                  _register(_emailSignupController.text,
                                      _pwSignupController.text);
                                }
                              },
                              child: const Text('Register'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Already have an account? ',
                        style: TextStyle(color: Colors.black),
                      ),
                      TextSpan(
                        text: 'Sign in.',
                        style: const TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pop(context);
                          },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
