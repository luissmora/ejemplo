import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login/global/common/toast.dart';
import 'package:login/view/user_auth/firebase_auth/firebase_auth.dart';
import 'package:login/view/user_auth/view_pages/InicioPagina.dart';
import 'package:login/view/user_auth/view_pages/LoginPage.dart';
import 'package:login/view/user_auth/view_pages/widget/form_container.dart';

class RegistroPage extends StatefulWidget {
  const RegistroPage({super.key});

  @override
  State<RegistroPage> createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  bool _registrado = false;
  final FirebaseAuthManager _authmanager = FirebaseAuthManager();
  TextEditingController _usuarioNameController = TextEditingController();
  TextEditingController _usuarioEmailController = TextEditingController();
  TextEditingController _usuarioPassController = TextEditingController();

  @override
  void dispose() {
    _usuarioNameController.dispose();
    _usuarioEmailController.dispose();
    _usuarioPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registro - Hola"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Registrate es facil",
                style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              FormContainerWidget(
                controller: _usuarioNameController,
                hintText: "Usuario",
                isPasswordField: false,
              ),
              const SizedBox(
                height: 10,
              ),
              FormContainerWidget(
                controller: _usuarioEmailController,
                hintText: "Correo",
                isPasswordField: false,
              ),
              const SizedBox(
                height: 10,
              ),
              FormContainerWidget(
                controller: _usuarioPassController,
                hintText: "Contraseña",
                isPasswordField: true,
              ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  _registroUser();
                  showToast(message: "Bienvenido!! Usuario creado!");
                },
                child: Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 145, 87, 0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: _registrado
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text(
                            "Registrarme",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.bold),
                          ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Ya tienes cuenta?"),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                      );
                    },
                    child: const Text("Iniciar sesión",
                        style: TextStyle(
                            color: Color.fromARGB(255, 145, 87, 0),
                            fontWeight: FontWeight.bold)),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _registroUser() async {
    setState(() {
      _registrado = false;
    });
    String username = _usuarioNameController.text;
    String email = _usuarioEmailController.text;
    String password = _usuarioPassController.text;

    User? user = await _authmanager.signUpWithEmailAndPassword(email, password);
    if (user != null) {
      // ignore: use_build_context_synchronously
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const InicioPagina()));
    } else {
      showToast(message: "Erro al crear usuario");
    }
  }
}
