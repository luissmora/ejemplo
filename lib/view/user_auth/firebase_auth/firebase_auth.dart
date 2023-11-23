import 'package:firebase_auth/firebase_auth.dart';
import 'package:login/global/common/toast.dart';

class FirebaseAuthManager {
  final FirebaseAuth _authmanager = FirebaseAuth.instance;

//Metodo para Registrar usuario
  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _authmanager
          .createUserWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        showToast(message: 'Su correo ya esta creado');
      } else {
        showToast(message: 'Ocurrio un error: ${e.code}');
      }
    }
    return null;
  }

// Metodo para Iniciar sesion
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _authmanager.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        showToast(message: 'Usuario o contraseña: fail');
      } else {
        showToast(message: 'Ocurrio un error: ${e.code}');
      }
    }
    return null;
  }

  signInWithCredential(AuthCredential credential) {}
}
