import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final _auth = FirebaseAuth.instance;

  signUp(String email, String password) async {
    final AuthResult = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
  return AuthResult ;
  }
  signIn(String email, String password) async {
    final AuthResult = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
  return AuthResult ;
  }
 Future<void> signOUt () async {
   await _auth.signOut() ;
  }

}
