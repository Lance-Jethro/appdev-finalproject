// login_text_fields.dart
import 'package:flutter/material.dart';
import 'package:pizza_app/barrel.dart';

class LoginTextFields extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final String? Function(String?) emailValidator;
  final String? Function(String?) passwordValidator;
  final bool obscureText;
  final void Function() toggleObscureText;
  final bool isChecked;
  final void Function(bool?) onCheckBoxChanged;

  const LoginTextFields({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.emailValidator,
    required this.passwordValidator,
    required this.obscureText,
    required this.toggleObscureText,
    required this.isChecked,
    required this.onCheckBoxChanged,
  });

  @override
  State<LoginTextFields> createState() => _LoginTextFieldsState();
}

class _LoginTextFieldsState extends State<LoginTextFields> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Email Address',
            prefixIcon: Icon(Icons.alternate_email),
          ),
          keyboardType: TextInputType.emailAddress,
          controller: widget.emailController,
          validator: widget.emailValidator,
        ),
        const SizedBox(height: 15),
        TextFormField(
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: 'Password',
            prefixIcon: const Icon(Icons.lock),
            suffixIcon: IconButton(
              icon: Icon(
                widget.obscureText ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: widget.toggleObscureText,
            ),
          ),
          obscureText: widget.obscureText,
          controller: widget.passwordController,
          validator: widget.passwordValidator,
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Checkbox(
              value: widget.isChecked,
              onChanged: widget.onCheckBoxChanged,
            ),
            const Text("Keep me signed in."),
          ],
        ),
      ],
    );
  }
}
