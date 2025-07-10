import 'package:flutter/material.dart';
import 'package:technical_test/data/datasource/auth_service.dart';
import 'package:technical_test/presentation/home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _username = "";
  String _password = "";
  final bool _isLoading = false;

  void _submit() {
    if (_username == "admin" && _password == "1234") {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Login exitoso")));
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Credenciales incorrectas")));
    }
  }

  void _loginGoogle() async {
    final loginGoogleStatus = await AuthService().signInWithGoogle();
    if (!mounted) return;
    if (loginGoogleStatus != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      print('Login cancelado o falló');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "Usuario"),
                validator: (value) => value == null || value.isEmpty
                    ? "Ingrese su usuario"
                    : null,
                onChanged: (text) {
                  setState(() {
                    _username = text;
                  });
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: "Contraseña"),
                obscureText: true,
                validator: (value) => value == null || value.isEmpty
                    ? "Ingrese su contraseña"
                    : null,
                onChanged: (text) {
                  setState(() {
                    _password = text;
                  });
                },
              ),
              SizedBox(height: 32),
              _isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _submit,
                      child: Text("Iniciar Sesión"),
                    ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: _loginGoogle,
                child: Text("Login Google"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
