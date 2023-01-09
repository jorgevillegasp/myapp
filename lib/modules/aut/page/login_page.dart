// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:myapp/modules/aut/models/usuario.dart';
import 'package:myapp/modules/product/page/home_screen1.dart';
import 'package:myapp/modules/aut/services/login_provider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  //Controladores par ls Inputs
  final nombreController = TextEditingController();
  final contraseniaController = TextEditingController();

  // Crea una clave global que identificará de manera única el widget Form
  // y nos permita validar el formulario
  //
  // Nota: Esto es un `GlobalKey<FormState>`, no un GlobalKey<MyCustomFormState>!
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              SizedBox(
                height: 300,
                child: Image.asset('assets/login.png'),
              ),
              const Center(
                child: Text(
                  "LOGIN",
                  style: TextStyle(
                    color: Color.fromARGB(255, 56, 47, 109),
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: nombreController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Usuario',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El usuario es requerido';
                  }
                  return null;
                },
                //onChanged: null,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: contraseniaController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Contraseña',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'La contraseña es requerida';
                  }
                  return null;
                },
                //onChanged: null,
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () async {
                  final user = Usuario(
                    usuario: nombreController.text.trim(),
                    contrasenia: contraseniaController.text.trim(),
                  );
                  if (await loginProvider.iniciarSesion(user)) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen1(),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: const Duration(milliseconds: 1500),
                        content: Container(
                          padding: const EdgeInsets.all(16),
                          height: 50,
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 231, 136, 136),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          child: Row(
                            children: const [
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Text("Usuario y contraseña incorrecto"),
                              ),
                            ],
                          ),
                        ),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                      ),
                    );
                  }
                },
                style: TextButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 95, 76, 179),
                  foregroundColor: Colors.white,
                ),
                child: const Text('Inisiar sesion'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
