import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LogInForm extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LogInForm({
    Key? key,
    required this.emailController,
    required this.passwordController,
  }) : super(key: key);

  @override
  _LogInFormState createState() => _LogInFormState();
}

class _LogInFormState extends State<LogInForm> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildInputForm('E-mail', false, widget.emailController),
        buildInputForm('Senha', true, widget.passwordController),
      ],
    );
  }

  Padding buildInputForm(
      String label, bool pass, TextEditingController controller) {
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
