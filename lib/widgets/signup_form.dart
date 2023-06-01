import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    Key? key,
    required this.nameController,
    required this.surnameController,
    required this.emailController,
    required this.phoneController,
    required this.passwordController,
    required this.confirmPasswordController,
  }) : super(key: key);

  final TextEditingController nameController;
  final TextEditingController surnameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool _isObscure = true;

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildInputForm('Nome', widget.nameController, false),
        buildInputForm('Sobrenome', widget.surnameController, false),
        buildInputForm('E-mail', widget.emailController, false),
        buildInputForm('Telefone', widget.phoneController, false),
        buildInputForm('Senha', widget.passwordController, true),
        buildInputForm(
            'Confirmar senha', widget.confirmPasswordController, true),
      ],
    );
  }

  Padding buildInputForm(
      String label, TextEditingController controller, bool pass) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        controller: controller,
        obscureText: pass ? _isObscure : false,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            color: Color(0xFF979797),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          suffixIcon: pass
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                  icon: _isObscure
                      ? const Icon(
                          Icons.visibility_off,
                          color: Color(0xFF979797),
                        )
                      : const Icon(
                          Icons.visibility,
                          color: Colors.red,
                        ),
                )
              : null,
        ),
      ),
    );
  }
}
