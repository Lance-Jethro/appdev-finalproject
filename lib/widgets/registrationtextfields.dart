import 'package:flutter/material.dart';
import 'package:pizza_app/barrel.dart';

class RegistrationTextFields extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final String? Function(String?) emailValidator;
  final String? Function(String?) passwordValidator;
  final String? Function(String?) confirmPasswordValidator;
  final bool obscureText;
  final VoidCallback toggleObscureText;
  final bool isChecked;
  final ValueChanged<bool?> onCheckBoxChanged;

  const RegistrationTextFields({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.emailValidator,
    required this.passwordValidator,
    required this.confirmPasswordValidator,
    required this.obscureText,
    required this.toggleObscureText,
    required this.isChecked,
    required this.onCheckBoxChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Enter your Email Address',
            prefixIcon: Icon(Icons.alternate_email),
          ),
          keyboardType: TextInputType.emailAddress,
          controller: emailController,
          validator: emailValidator,
        ),
        const SizedBox(height: 15),
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Enter your Password',
            prefixIcon: const Icon(Icons.lock),
            suffixIcon: IconButton(
              icon: Icon(obscureText ? Icons.visibility : Icons.visibility_off),
              onPressed: toggleObscureText,
            ),
          ),
          obscureText: obscureText,
          controller: passwordController,
          validator: passwordValidator,
        ),
        const SizedBox(height: 15),
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Confirm password',
            prefixIcon: const Icon(Icons.lock),
            suffixIcon: IconButton(
              icon: Icon(obscureText ? Icons.visibility : Icons.visibility_off),
              onPressed: toggleObscureText,
            ),
          ),
          obscureText: obscureText,
          controller: confirmPasswordController,
          validator: confirmPasswordValidator,
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Checkbox(
              value: isChecked,
              onChanged: onCheckBoxChanged,
            ),
            const Text("I have agreed to the terms and conditions."),
          ],
        ),
      ],
    );
  }
}
