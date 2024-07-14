import 'package:flutter/material.dart';
import '../controllers/login_controller.dart';
import '../models/user_model.dart'; // Importa el modelo User
import 'home_page.dart';
import 'report_page.dart'; // Importa ReportPage

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String error = '';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      bool success = await LoginController.login(User(
        email: _emailController.text,
        password: _passwordController.text,
      ));

      if (!mounted) return; // Verifica si el widget está montado antes de usar `BuildContext`

      if (success) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } else {
        setState(() {
          error = 'Correo o contraseña incorrectos';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: "Correo"),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Este campo es obligatorio";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: "Contraseña"),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Este campo es obligatorio";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                Offstage(
                  offstage: error.isEmpty,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(error, style: const TextStyle(color: Colors.red)),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: 0.6,
                  child: ElevatedButton(
                    onPressed: _login,
                    child: const Text("Iniciar Sesión"),
                  ),
                ),
                const SizedBox(height: 20),
                FractionallySizedBox(
                  widthFactor: 0.6,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ReportPage()),
                      );
                    },
                    child: const Text("Generar Reporte PDF"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}