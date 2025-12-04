import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key}); // Constructor

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Iniciar Sesión'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Campo de correo electrónico
            TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Correo electrónico',
                hintText: 'usuario@ejemplo.com',
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            
            // Campo de contraseña
            TextField(
              obscureText: true,  // Oculta el texto (para passwords)
              decoration: InputDecoration(
                labelText: 'Contraseña',
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 24),
            
            // Botón
            SizedBox(
              width: double.infinity,  // Ancho completo
              child: ElevatedButton(
                onPressed: () {
                  // Navegar al dashboard después del login
                  Navigator.pushReplacementNamed(context, '/dashboard');
                },
                child: const Text('Iniciar Sesión'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}